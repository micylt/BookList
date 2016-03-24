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
<link href='http://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
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
				<a class="navbar-brand" href="Registration.jsp">BookList</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav">
					<li><a href="AccountPage.jsp">Home</a></li>
					<li class="active"><a href="<%=response.encodeURL("AccountPage.jsp") %>">Buy</a></li> <!-- continue session to these links -->
					<li><a href="<%=response.encodeURL("SellBooks.jsp") %>">Sell</a></li>
					<li><a href="#">About</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#"><span class="glyphicon glyphicon-user"></span> Enter</a></li>
					<li class="dropdown"><a href="LogoutServlet"> <span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
				</ul>
			</div>
		</div>
		</nav>
		</div>
		
			<h1 class="centerHeader" style="font-size: 35px;"> Hello <%=userName%>, Login successful.</h1>
		
		<!-- search bar for finding textbooks -->
		<div class="colorstrip">
			<div class="container">
				<div class="row">
					<div class="col-sm-6 col-sm-offset-3">
						<!-- everything in this div is responsive -->
						<div class="search_container">
							<h3 style="color: white">Search for textbooks</h3>
							<div class="input-group stylish-input-group">
								<input type="text" class="form-control" placeholder="Enter ISBN number"> 
								<span class="input-group-addon"> <button type="submit">
										<span class="glyphicon glyphicon-search"></span> <!-- bootstrap icon -->
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<!-- scripts -->
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>