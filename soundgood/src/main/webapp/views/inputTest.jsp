<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<%String input0 = "";%>
<body>
<div>
<form method ="post">
<input type = "text" name = "input0" value = "Search...">
<input type = "submit" value = "Submit">
<% 
	input0 = request.getParameter("input0");
	if(input0 != null && input0 != "Search...")
		out.println(input0);
	else
		out.println();
%>
</form>
</div>
</body>
</html>