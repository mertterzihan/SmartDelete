<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Delete a File</title>
</head>
<body>
	<h2>Delete File</h2>
  	<form method="get">
		<fieldset>
  	 		<table cellspacing="0" border="1">
  	 			<tr>
  	 			  <th>Selection</th>
				  <th>URL</th>
				  <th>Date</th>
				  <th>Size</th>
				  <th>Path</th>
				</tr>
	   			<c:forEach var="instance" items="${instances}">
	   				<tr>
			          <td><input type="radio" name="file" value="${instance.path}"></td>
			          <td>${instance.url}</td>	
			          <td>${instance.date}</td>
			          <td>${instance.size}</td>
			          <td>${instance.path}</td>
			        </tr>
			     </c:forEach>
			          
			     <tr>
	        		<td>
	            		<input type="submit" value="Submit"/>
	        		</td>
	    		</tr>
			</table> 
		</fieldset>
	</form>
</body>
</html>