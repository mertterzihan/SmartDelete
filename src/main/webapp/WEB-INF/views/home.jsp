<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<link href="<c:url value="/resources/css/home.css" />" rel="stylesheet">
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
	<!-- <script src="<c:url value="/resources/js/main.js" />"></script> -->
</head>
<body>

<div id="whole">

<div id="bigIcon">
<div id="icon">
	<img border="0" src="<c:url value="/resources/img/dropbox-512.png" />" width="100px">
</div>
<div id="title">
	<h1>
		Dropbox Smart Delete   
	</h1>
</div>
</div>

<div id="mainbody">
<table border="0" width="300px" height="80px" align="center">
<tr>
<td>
	<!-- <div id="authostring">
		<P>  Click to authorize </P>
	</div> -->
	<div id="authobtn">
		<button type="button" class="btn btn-primary" onClick="window.open('${authorizeUrl}');">Click me to Authorize!</button>
		<%-- ${authorizeUrl} --%>
	</div>
</td>
</tr>
</table>


<table border="0" width="650px" align="center">
<tr>
<td>
<form id="authForm" action="main" method="post" class="form-horizontal" role="form">
<fieldset>	
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Auth Code</label>
    <div class="col-sm-10">
      <input class="form-control" id="authCode" name="authCode" placeholder="Authorization code">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <input type="submit" value="Submit" class="btn btn-default"/>
    </div>
  </div>
 </fieldset>
</form>
</td>
</tr>
</table>


</div>
</div>

<%-- =======
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
>>>>>>> 7d756c45c7a39575620ce0780a7fe58107b619a4 --%>

</body>
</html>
