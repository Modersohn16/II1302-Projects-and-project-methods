package musicschool.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import musicschool.integration.RentalDAO;
import musicschool.integration.RentalDBException;
import musicschool.model.InstrumentDTO;
import musicschool.model.InstrumentException;



public class Controller {
private static RentalDAO rentaldb; 
	
	
	/*public static void main(String[] args) throws SQLException, ClassNotFoundException, RentalDBException, InstrumentException {
		Controller contr = new Controller();
		List <? extends InstrumentDTO> instruments = new ArrayList<>();
	    instruments = contr.retriveRentableInstruments();
	    for (InstrumentDTO instrument : instruments) {
			System.out.println("Instrument type: " + instrument.getType() +", "
					+ "Instrument ID: " + instrument.getId() + ", "
					+ "Price: " + instrument.getPrice());
	}
	    System.out.println(System.getProperty("java.compile.version"));

}*/
		
	/**
     * Creates a new instance, and retrieves a connection to the database.
     * 
     * @throws RentalDBException If unable to connect to the database.
     */
	public Controller() throws RentalDBException {
		rentaldb = new RentalDAO();
    }
	/**
	 * Terminates a rental for a specific instrument ID and student ID
	 * @param studentID The student ID who rents the instrument
	 * @param instrumentID The instrument ID for the instrument
	 * @return A string verifying that if the rentale has benn terminated. 
	 */
	public String terminateRental(int studentID, int instrumentID) {
		try {
			return rentaldb.terminateRentalWithInstrumentID(studentID, instrumentID);
		}catch (Exception exc) {
			exc.printStackTrace();
		}
		return "";
	}
	
	/**
	 * Rents an instrument by giving a student ID and an instrument ID
	 * @param studentID The student ID to rent the instrument
	 * @param instrumentID The instrument ID for the instrument to be rented. 
	 * @return A string verifying if the renting was successful. 
	 */
	public String rentInstrumentByStudentID(int studentID, int instrumentID) {
		try {
			return rentaldb.rentInstrumentWithStudentID(studentID, instrumentID);

		} catch (Exception exc) {
			exc.printStackTrace();
		}
		return "";
	}
	
	/**
	 * Gives a list with the rentable instruments. 
	 * @return A list with rentable instruments. 
	 * @throws InstrumentException
	 */
	public List <? extends InstrumentDTO> retriveRentableInstruments() throws InstrumentException{
		try {
			return rentaldb.findAllRentableInstruments();
		} catch (Exception exc) {
			throw new InstrumentException("Unable to list the rentable instruments", exc);
		}
		
	}
	
	/**
	 * Gives a list with rentable instruments specified by an instrument type. 
	 * @param type The type of the instrument. 
	 * @return A list with rentable instruments of the specified type. 
	 * @throws InstrumentException
	 */
	
	public List<? extends InstrumentDTO> retriveRentableInstrumentsByType(String type) throws InstrumentException {
		if (type == null) {
			return new ArrayList<>();
		}
		try {
			return rentaldb.findAllRentableInstrumentsByType(type);
		}catch (Exception exc) {
			throw new InstrumentException ("Unable to list the rentable instruments by type", exc);
		}
	}
}
