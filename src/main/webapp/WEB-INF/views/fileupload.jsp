<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>HTML5 File Drag &amp; Drop API</title>
<%-- <script src="<c:url value="/resources/js/filedrag.js" />"></script> --%>
<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/styles.css" />" />
<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/main.css" />" />
<%-- <link href="<c:url value="/resources/css/home.css" />" rel="stylesheet"> --%>
</head>
<body>

<h1>HTML5 File Drag &amp; Drop API</h1>

<p>This is a demonstration of the HTML5 drag &amp; drop API which retrieves file information.</p>

<p>For more information, please refer to:</p>
<ul>
<li><a href="http://www.sitepoint.com/html5-file-drag-and-drop/">How to Use HTML5 File Drag &amp Drop</a></li>
<li><a href="http://www.sitepoint.com/html5-javascript-open-dropped-files">How to Open Dropped Files Using HTML5 and JavaScript</a></li>
<li><a href="http://www.sitepoint.com/html5-ajax-file-upload">How to Asynchronously Upload Files Using HTML5 and Ajax</a></li>
<li><a href="http://www.sitepoint.com/html5-javascript-file-upload-progress-bar">How to Create Graphical File Upload Progress Bars in HTML5 and JavaScript</a></li>
</ul>

<form id="upload" action="fileupload" method="POST" enctype="multipart/form-data">

<fieldset>
<legend>HTML File Upload</legend>

<input type="hidden" id="MAX_FILE_SIZE" name="MAX_FILE_SIZE" value="300000" />

<div>
	<label for="fileselect">Files to upload:</label>
	<input type="file" id="fileselect" name="fileselect[]" multiple="multiple" />
	<div id="filedrag">or drop files here</div>
</div>

<div id="submitbutton">
	<button type="submit" >Upload Files</button>
</div>

</fieldset>

</form>

<div id="messages">
<p>Status Messages</p>
</div>


<h2>Disclaimer</h2>
<p>The code was developed by <a href="http://twitter.com/craigbuckler">Craig Buckler</a> of <a href="http://optimalworks.net/">OptimalWorks.net</a> for <a href="http://sitepoint.com/">SitePoint.com</a>.</p>

<p>This code can be <a href="http://blogs.sitepointstatic.com/examples/tech/filedrag/1/filedrag1.zip">downloaded and used</a> without any restrictions but please don't expect support! A link back to SitePoint.com is appreciated.</p>

<script src="<c:url value="/resources/js/filedrag.js" />"></script>
<div id="stadiv">
	<p id="statusTitle"> <span class="free-space">64.54 GB free out of 2.00 GB</span></p>
	<meter id="statusBar" value="180" min="0" low="100" optimum="80" high="170" max="200"></meter>
</div>
</body>
</html>