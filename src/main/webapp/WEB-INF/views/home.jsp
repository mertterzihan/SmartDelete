<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The Authorization URL is  ${authorizeUrl}. </P>

<form id="authForm" action="main" method="post">
		<fieldset>
			<table cellspacing="0">
				<tr>
					<th><label for="note">Authorization Code:</label></th>
					<td><input id="authCode" name="authCode" /></td>
				</tr>
				<tr>
					<th></th>
					<td><input type="submit" value="Submit" /></td>
				</tr>
			</table>
		</fieldset>
	</form>
</body>
</html>
