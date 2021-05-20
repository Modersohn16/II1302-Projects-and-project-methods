package musicschool.integration;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import musicschool.model.InstrumentDTO;



public class RentalDAO {
	
	/*public static void main(String[] args) throws SQLException, ClassNotFoundException, RentalDBException {
		connectToRentalDB();
        prepareStatements();
        List <? extends InstrumentDTO> instruments = new ArrayList<>();
        instruments = findAllRentableInstruments();
        for (InstrumentDTO instrument : instruments) {
			System.out.println("Instrument type: " + instrument.getType() +", "
					+ "Instrument ID: " + instrument.getId() + ", "
					+ "Price: " + instrument.getPrice());
		}

	}*/
		    



    private PreparedStatement listInstrument;
    private PreparedStatement listInstrumentByType;
    private PreparedStatement checkInstrumentRentalsForStudent;
    private PreparedStatement checkIfInstrumentIsRentable;
    private PreparedStatement updateInstrumentStock; 
    private PreparedStatement rentInstrumentByStudentID; 
    private PreparedStatement terminateSpecRental;
    
    private static Connection connection;
    private static final String INSTRUMENT_STOCK = "instrument_stock";
    private static final String STUDENT_RENTAL = "student_rental";
    private static final String INSTR_ID = "instrument_id";
    private static final String INSTR_TYPE = "type";
    private static final String INSTR_PRICE = "price";

    /**
     * A data access object (DAO) with all the database calls to the Soundgood music  school database. 
     *  No code outside this class shall have any knowledge about the database.
     * @throws RentalDBException
     */
    public RentalDAO() throws RentalDBException {
        try {
        	connectToRentalDB();
            prepareStatements();
        } catch (SQLException  | ClassNotFoundException exc) {
            throw new RentalDBException("Failed to connect to database.", exc);
        }
    }

    private void connectToRentalDB() throws ClassNotFoundException, SQLException {
    	Class.forName("org.postgresql.Driver");
        connection = DriverManager.getConnection("jdbc:postgresql://postgresschool-postgresqldbserver.postgres.database.azure.com/musicschool_db",
                                                 "school@postgresschool-postgresqldbserver", "Miladd97");
        connection.setAutoCommit(false);
    }
    
    private void prepareStatements() throws SQLException{
        
    	listInstrument = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_STOCK
				 + " WHERE available_to_rent = 1");
    	listInstrumentByType = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_STOCK + 
    			" WHERE available_to_rent = 1 " + " AND " + INSTR_TYPE +" = ?");
    	checkInstrumentRentalsForStudent = connection.prepareStatement("SELECT COUNT (*) FROM " + 
    			STUDENT_RENTAL + " WHERE student_id = ? " + " AND is_terminated = 0");
    	checkIfInstrumentIsRentable = connection.prepareStatement("SELECT * FROM " + INSTRUMENT_STOCK + 
    			" WHERE " + INSTR_ID +  " = ? " + " AND available_to_rent = 1");
    	updateInstrumentStock = connection.prepareStatement("UPDATE " + INSTRUMENT_STOCK + " SET available_to_rent = ? " 
    			+ " WHERE " + INSTR_ID + " = ?" );
    	rentInstrumentByStudentID = connection.prepareStatement("INSERT INTO " + STUDENT_RENTAL + "(rental_id, date, "
    			+ "instrument_id, student_id, is_terminated)" + " VALUES(?, ?, ?, ?, ?)");
    	terminateSpecRental = connection.prepareStatement("UPDATE " + STUDENT_RENTAL + " SET is_terminated = ? " 
    			+ "WHERE student_id = ? " + " AND " + INSTR_ID + " = ? " + " AND is_terminated = 0" );
    	
    	
    	
    	
    }
    /**
	 * Terminates a rental for a specific instrument ID and student ID
	 * @param studentID The student ID who rents the instrument
	 * @param instrumentID The instrument ID for the instrument
	 * @return A string verifying that if the rentable has benn terminated. 
	 */
    
    public String terminateRentalWithInstrumentID(int studentID, int instrumentID) throws RentalDBException {
    	String failureMsg = "Student has no rentals or termination failed";
    	String upDateFailed = " No rows were updated"; 
    	try {
    		terminateSpecRental.setInt(1,1);
    		terminateSpecRental.setInt(2, studentID);
    		terminateSpecRental.setInt(3, instrumentID);
    		int checkUpdate = terminateSpecRental.executeUpdate();
    		if (checkUpdate != 1) {
				handleException(upDateFailed, null);
    		} else {
    			updateInstrumentStock.setInt(1, 1);
    			updateInstrumentStock.setInt(2,instrumentID);
    			updateInstrumentStock.executeUpdate();
				connection.commit();
    			return ("*** TERMINATION SUCCEEDED *** : The rental with instrument id: " + instrumentID + 
    					" for the student with id " + studentID + " has benn terminated");
    		}
    	}catch (Exception exc) {
    		handleException(failureMsg, exc);
    		
    	}
		return upDateFailed;
    }
    /**
	 * Rents an instrument by giving a student ID and an instrument ID
	 * @param studentID The student ID to rent the instrument
	 * @param instrumentID The instrument ID for the instrument to be rented. 
	 * @return A string verifying if the renting was successful. 
	 */
    public String rentInstrumentWithStudentID(int studentID, int instrumentID) throws RentalDBException {
    	String alreadyMax = " Student have reached max rentals";
    	String upDateFailed = " No rows were updated"; 
    	String failureString = " Not possible to rent the instrument"; 
    	ResultSet numberOfRentals = null;
    	try {
    		checkInstrumentRentalsForStudent.setInt(1, studentID);
    		numberOfRentals = checkInstrumentRentalsForStudent.executeQuery();
    		numberOfRentals.next();
    		int numberOfRentalsInt = numberOfRentals.getInt(1);
    		if (numberOfRentalsInt == 2) {
    			handleException(alreadyMax, null);
    		}
    		else {
    			checkIfInstrumentIsRentable.setInt(1, instrumentID);
    			if (checkIfInstrumentIsRentable.executeQuery().next()){
    				rentInstrumentByStudentID.setInt(1, (int)Math.floor(Math.random() * Integer.MAX_VALUE));
    				rentInstrumentByStudentID.setDate(2, Date.valueOf(LocalDate.now()));
    				rentInstrumentByStudentID.setInt(3, instrumentID);
    				rentInstrumentByStudentID.setInt(4, studentID);
    				rentInstrumentByStudentID.setInt(5, 0);
    				int checkUpdate = rentInstrumentByStudentID.executeUpdate();
    				if (checkUpdate != 1) {
    					handleException(upDateFailed, null);
    				}
    				updateInstrumentStock.setInt(1, 0);
    				updateInstrumentStock.setInt(2, instrumentID);
    				updateInstrumentStock.executeUpdate();
					connection.commit();
    				return (" **** RENT SUCCEEDED ****: Student with id " + studentID + " is renting "
    						+ "instrument with " + instrumentID);
    			}
    			else {
    				handleException(failureString, null);
    			}
    		}
    		
    	}catch (Exception exc) {
    		handleException(exc.getMessage(), exc);
    	}
		return "";
    }
    /**
	 * Gives a list with rentable instruments specified by an instrument type. 
	 * @param type The type of the instrument. 
	 * @return A list with rentable instruments of the specified type. 
	 * @throws InstrumentException
	 */
    public List<InstrumentDTO> findAllRentableInstrumentsByType(String type) throws RentalDBException{
    	String failureString = "Not possible to list rentable instruments by type";
    	ResultSet result = null; 
    	List<InstrumentDTO> instrumentsByID = new ArrayList<>();
    	try {
    		listInstrumentByType.setString(1,type);
    		result = listInstrumentByType.executeQuery();
    		while (result.next()) {
    			instrumentsByID.add(new InstrumentDTO(result.getInt(INSTR_ID),
    												  result.getInt(INSTR_PRICE),
    												  result.getString(INSTR_TYPE)));
    		}
    		connection.commit();
    	} catch (Exception exc) {
    		handleException (failureString, exc);
    	}
    	return instrumentsByID;
    }
    
    /**
	 * Gives a list with the rentable instruments. 
	 * @return A list with rentable instruments. 
	 * @throws InstrumentException
	 */
    public List<InstrumentDTO> findAllRentableInstruments() throws RentalDBException {
		String failureString = "Not possible to list any rentable instruments.";
    	ResultSet result = null;
    	List<InstrumentDTO> rentableInstruments = new ArrayList<>();
    	try {
			result = listInstrument.executeQuery();
			while (result.next()) {
				rentableInstruments.add(
					new InstrumentDTO(result.getInt(INSTR_ID),
					result.getInt(INSTR_PRICE),
					result.getString(INSTR_TYPE))); 
			}
			connection.commit();
		} catch (Exception e) {
			handleException(failureString, e);
		}
    	return rentableInstruments;
    }
   
	 
	private static void handleException(String failureMsg, Exception cause) throws RentalDBException {
	        String completeFailureMsg = failureMsg;
	        try {
	            connection.rollback();
	        } catch (SQLException rollbackExc) {
	            completeFailureMsg = completeFailureMsg + 
	            ". Also failed to rollback transaction because of: " + rollbackExc.getMessage();
	        }

	        if (cause != null) {
	            throw new RentalDBException(failureMsg, cause);
	        } else {
	            throw new RentalDBException(failureMsg);
	        }
	    }
}
