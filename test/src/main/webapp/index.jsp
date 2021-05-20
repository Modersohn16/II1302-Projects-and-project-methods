<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hello JSP!</title>
</head>
<body style="background-image: url('images/background.png'); background-attachment: fixed;">
<h2 style="color:white;">Soundgood Music School</h2>
<p style="color:white;">Today's date: <%= (new java.util.Date()).toLocaleString()%></p>
<a href="views/instrumentSearch.jsp">Instruments</a>
<br/>
<a href="views/login.jsp">Login</a>
</body>
</html>