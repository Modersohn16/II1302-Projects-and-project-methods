<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="musicschool.model.InstrumentDTO, java.util.List,java.util.ArrayList, musicschool.controller.Controller"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<% String string = request.getParameter("instrument");%>
<title>Insert title here</title>
</head>
<body style="background-image: url('../images/background.png'); background-attachment: fixed;">
<div style="color:white;">
<a href="../index.jsp">Home</a><br/>
Here are instruments listed.<br/>
<% int id = Integer.parseInt(request.getParameter("instrumentid"));
	InstrumentDTO instrument2 = new InstrumentDTO(0,0,"");
	Controller contr = (Controller)session.getAttribute("controller");
	List <? extends InstrumentDTO> instruments = contr.retriveRentableInstruments();
	int i = 0;
	//session.setAttribute("studentid", i);
	
	for(InstrumentDTO instrument : instruments)
	{
		if(instrument.getId() == id){
			instrument2 = instrument;
			break;
		}
	}
%>
<%= instrument2.getPrice() %>
<%= instrument2.getType() %>

<form>
Submit Studentid
<input type="text" id= "id" name="studentid"><br>
<button onclick="getId(event)">Rent Instrument</button>
<script>
function getId(event){
	event.preventDefault();
	i = document.getElementById("id");
}
</script>
</form>
<%= i %>
</div>
</body>
</html>