<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/styles.css" />" />
<link rel="stylesheet" type="text/css" media="all" href="<c:url value="/resources/css/main.css" />" />
<script src="<c:url value="/resources/js/jquery.js" />"></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css">
<title>Delete a File</title>
</head>
<body>
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
	

	<form id="DelForm" method="get">
		<fieldset>
  	 		<table class="table table-hover">
  	 			<thead>
  	 			<tr>
  	 			  <th>File Path</th>
				  <th>Download</th>
				  <th>Date</th>
				  <th>Size</th>
				  <th></th>
				</tr>
				</thead>
				<tbody>
	   			<c:forEach var="instance" items="${instances}">			
	   				<tr>
	   				  <td>${instance.path}</td>
			          <%-- <td><input type="radio" name="file" value="${instance.path}"></td> --%>
			          <td><button type="button" class="btn btn-link" onClick="window.open('${instance.url}');">Link</button></td>
			          <td>${instance.date}</td>
			          <td>${instance.size}</td>
			          <td><button type="submit" name="file" class="btn btn-danger" value="${instance.path}" >DELETE</button></td>
			        </tr>
			   
			     </c:forEach>
			   	 </tbody>       
			</table> 
		</fieldset>
	</form>
	
	<div id="stadiv">
	<p id="statusTitle"> <span id="statustext" class="free-space">${freespace} free out of ${capacity}MB</span></p>
	<meter id="statusBar" value="${usedspace}" min="0" low="700" optimum="500" high="2000" max="${capacity}"></meter>
	</div>
	
	<form id="upload" action="index.html" method="POST" enctype="multipart/form-data">

	<fieldset>
		<legend>HTML File Upload</legend>
		
		<input type="hidden" id="MAX_FILE_SIZE" name="MAX_FILE_SIZE" value="300000" />
		
		<div>
			<label for="fileselect">Files to upload:</label>
			<input type="file" id="fileselect" name="fileselect[]" multiple="multiple" />
			<div id="filedrag">or drop files here</div>
		</div>
		
		<div id="submitbutton">
			<button type="submit">Upload Files</button>
		</div>	
	</fieldset>
	
	</form>
	
	<div id="messages">
		<p>Status Messages</p>
	</div>
	<%-- <script src="<c:url value="/resources/js/filedrag.js" />"></script>  --%>
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
			console.log
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

			var TotalFileSize = 0;
			// process all File objects
			for (var i = 0, f; f = files[i]; i++) {
				ParseFile(f);
				TotalFileSize = TotalFileSize + f.size;
			}
			
			var spaceLeft = "${freespace}" - TotalFileSize/(1024.0*1024.0);
			console.log(spaceLeft);
			var statusStr = Number(spaceLeft).toFixed(2) + "free out of "+ "${capacity}" + " MB";
			$("#statustext").text(statusStr);
			
			var usedspace = "${usedspace}" + TotalFileSize/(1024.0*1024.0);
			var meter = document.getElementById('statusBar');
			meter.value = usedspace;
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
//				submitbutton.style.display = "none";
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