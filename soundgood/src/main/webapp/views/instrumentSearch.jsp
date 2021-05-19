<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import= "musicschool.controller.Controller, java.util.List,java.util.ArrayList, musicschool.model.InstrumentDTO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>instrument list</title>
<% 
	String instrument =  request.getParameter("instrumentSearch");
	Controller contr = new Controller();
	List <? extends InstrumentDTO> instruments = new ArrayList<>();
	instruments = contr.retriveRentableInstruments();
	session.setAttribute("instruments", instruments);
	session.setAttribute("controller", contr);
%>
</head>
<body style="background-image: url('../images/background.png'); background-attachment: fixed;">
<div style="color:white;">
<a href="../index.jsp">Home</a><br/>
Here are instruments listed.<br/>
<form>
<input type ="text" name = "instrumentSearch"><br>
<input type = "submit" value = Search>
</form>
Results for <% if(instrument != null) {out.print(instrument);} %>
<table style="width:100%">
	<tr>
		<th style="text-align:left">Instrument</th>
		<th style="text-align:left">Price</th>
		<th style="text-align:left">Instrument page</th>
	</tr>
	
		<% for(InstrumentDTO instrument2 : instruments){ %>
			<% { %>
				<tr>
					<td><%=instrument2.getType()%></td>
					<td><%=instrument2.getPrice()%></td>
					<td><a href="instrumentShow.jsp?instrumentid=<%= instrument2.getId()%>"> View more</a></td>
				</tr>
			<%} %>
		<%} %>
</table>
</div>
</body>
</html>