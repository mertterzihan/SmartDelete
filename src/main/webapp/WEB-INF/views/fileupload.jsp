<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>HTML5 File Drag &amp; Drop API</title>
<%-- <script src="<c:url value="/resources/js/filedrag.js" />"></script> --%>
<script src="<c:url value="/resources/js/jquery.js" />"></script>
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
	<!-- <input type="file" id="fileselect" name="fileselect[]" multiple="multiple" /> -->
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


<div id="stadiv">
	<p id="statusTitle"> <span id="statustext" class="free-space">64.54 GB free out of 2.00 GB</span></p>
	<meter id="statusBar" value="180" min="0" low="100" optimum="80" high="170" max="200"></meter>
</div>


<script language="javascript"> 

	(function() {

		// getElementById
		function $id(id) {
			return document.getElementById(id);
		}


		// output information
		function Output(msg) {
			var m = $id("messages");
			m.innerHTML = msg + m.innerHTML;
			console.log(msg);
		}


		// file drag hover
		function FileDragHover(e) {
			e.stopPropagation();
			e.preventDefault();
			e.target.className = (e.type == "dragover" ? "hover" : "");
		}


		// file selection
		function FileSelectHandler(e) {

			// cancel event and hover styling
			FileDragHover(e);

			// fetch FileList object
			var files = e.target.files || e.dataTransfer.files;

			// process all File objects
			for (var i = 0, f; f = files[i]; i++) {
				ParseFile(f);
			}
			
			//$('.free-space').text("your new string");
			var statusStr = "Coool";
			$("#statustext").text(statusStr);
		}


		// output file information
		function ParseFile(file) {

			Output(
				"<p>File information: <strong>" + file.name +
				"</strong> type: <strong>" + file.type +
				"</strong> size: <strong>" + file.size +
				"</strong> bytes</p>"
			);

		}


		// initialize
		function Init() {

			var fileselect = $id("fileselect"),
				filedrag = $id("filedrag"),
				submitbutton = $id("submitbutton");

			// file select
			fileselect.addEventListener("change", FileSelectHandler, false);

			// is XHR2 available?
			var xhr = new XMLHttpRequest();
			if (xhr.upload) {

				// file drop
				filedrag.addEventListener("dragover", FileDragHover, false);
				filedrag.addEventListener("dragleave", FileDragHover, false);
				filedrag.addEventListener("drop", FileSelectHandler, false);
				filedrag.style.display = "block";

				// remove submit button
				submitbutton.style.display = "none";
			}

		}

		// call initialization file
		if (window.File && window.FileList && window.FileReader) {
			Init();
		}


	})();
	
	
	
	</script>

</body>
</html>