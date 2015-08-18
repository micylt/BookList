 <!-- this is the registration jsp page of BookList -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>BookList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- import of css -->
<link rel="stylesheet" type="text/css" href="css/background.css"> <!-- my css -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
</head>
<body>

	<%
		//allow access only if session exists
		String user = null;
		if (session.getAttribute("user") == null) {
			response.sendRedirect("Registration.jsp");
		} else {
			user = (String) session.getAttribute("user");
		}
		String userName = null;
		String sessionID = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("user"))
					userName = cookie.getValue();
				if (cookie.getName().equals("JSESSIONID"))
					sessionID = cookie.getValue();
			}
		} else {
			sessionID = session.getId();
		}
	%>

	<div class="overlay">
		<div class ="navrap" style="margin-bottom: 80px;">
		<nav class="navbar navbar-inverse" id="navbar">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="Registration.jsp">BookList</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li class="active"><a href="<%=response.encodeURL("AccountPage.jsp") %>">Home</a></li>
					<li><a href="<%=response.encodeURL("AccountPage.jsp") %>">Buy</a></li> <!-- continue session to these links -->
					<li><a href="<%=response.encodeURL("SellBooks.jsp") %>">Sell</a></li>
					<li><a href="#">About</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-user"></span>
							Enter</a></li>
					<li class="dropdown"><a href="LogoutServlet"> <span
							class="glyphicon glyphicon-log-in"></span> Logout
					</a></li>
				</ul>
			</div>
		</div>
		</nav>
		</div>
		<div class="wrapper1">
			<h1 class="centerHeader">
				<center>
					Hello
					<%=userName%>, ready to list your books?
				</center>
				<!-- get rid of <center></center> -->
			</h1>
		</div>
		<div id="colorstrip">
			<!-- everything in this div is responsive -->
			<div class="sale-container">
				<h3 style="color: white">Sell your textbooks</h3>
				<form name="salesForm" class="sales-form" role="form" method="post" accept-charset="UTF-8">
					<div class="sale-entry">
						<label for="book_title" class="sale-label">Book Title</label> 
						<input name="title" class="sale-input" id="book_title" placeholder="Book Title">
					</div>
					<div class="sale-entry">
						<label for="isbn" class="sale-label">ISBN Number</label> 
						<input name="isbn" class="sale-input" id="isbn" placeholder="Enter ISBN number">
					</div>
					<div class="sale-entry">
						<label for="price" class="sale-label">Price</label> 
						<input name="price" class="sale-input" id="price" placeholder="Price">
					</div>
					<div class="sale-entry">
						<label for="condition" class="sale-label">Condition</label>
						<select name="condition" id="condition" style="width: 350px;">
						<option value="select">-</option>
						<option value="new">New</option>
						<option value="like-new">Like new</option>
						<option value="good">Good</option>
						<option value="acceptable">Acceptable</option>
						<option value="damaged">Damaged</option>
						</select>
					</div>
					<label for="description" class="sale-label">Comments (optional)</label>
					<div class="sale-entry">
						<textarea cols="76" rows="4" name="description"></textarea>
					</div>
				</form>
				<!-- </div> -->
			</div>
		</div>
<!-- scripts -->
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>