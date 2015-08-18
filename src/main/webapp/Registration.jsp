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
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">Page 1 <span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">Page 1-1</a></li>
							<li><a href="#">Page 1-2</a></li>
							<li><a href="#">Page 1-3</a></li>
						</ul></li>
					<li><a href="#">Page 2</a></li>
					<li><a href="#">Page 3</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#sign-up"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
					<li class="dropdown">
            		  <a class="dropdown-toggle" href="#" data-toggle="dropdown"> <span class="glyphicon glyphicon-log-in"></span> Login</a>
            		  <div class="dropdown-menu" style="padding: 5px; padding-bottom: 5px; background-color: #000000;">
<!-- login form -->   <form class="login-form" action="UserLoginController" accept-charset="UTF-8" id="loginform">
  					  <div class="form-group">
						<div class="col-sm-10">
							<input name="login_email" type="email" class="login_creds" id="login_email" placeholder="name@example.com">
						</div>
					  </div>
					<div class="form-group">
						<div class="col-sm-10">
							<input name="login_pwd" type="password" class="login_creds" id="login_pwd" placeholder="Password">
							<% String user_status = (String) (session.getAttribute("user")); %>
							<% if (user_status != null && user_status.equals("DNE")) { %>
						    <div class="error">Invalid email or password.</div>
						    <% } %>
						</div>
					</div>
					<div class="form-group">
						<div id="col-sm-10">
							<input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit"value="Login"/>
							</div>
						</div>
					  </form>
                    </div>
                  </li>
			    </ul>
			</div>
		</div>
		</nav>
		</div>
		<div class="welcome" style="margin-bottom: 100px;">
			<h1 class="centerHeader">Welcome to BookList</h1>
			<h2 class="centerHeader2">Buy and sell textbooks now.</h2>
		</div>
		<div id="colorstrip" style="margin-bottom: 100px;">
			<h3 class="sec-header">BookList is a simple way for students<br>to buy and sell textbooks to each other at their own price</h3>
			<hr style="width: 50%; margin-bottom: 30px;">
			<div style="margin-bottom: 80px;"> <h4 class="sec-header">Choose whether to meet face to face or complete transactions online</h4></div>
			<div>
				<h4 class="sec-header" style="margin-bottom: 20px;">To get started<br>login or sign up now</h4>
				<div style="text-align:center"> <!-- centers the link -->
				<a href="#sign-up" class="glyphicon glyphicon-download" id="register-link"></a>
				</div>
			</div>
		</div>
			<h1 class="centerHeader"></h1>
			<!-- registration form -->
			<a name="sign-up"></a>
			<div class="form1" style="margin-bottom: 20px;">
				<form action="UserInfoController" class="form-horizontal" role="form" name ="registerform" id="registerform" method="post" accept-charset="UTF-8">
				    <label for="reg" style="color: white;">Sign Up</label> 
				    <div class="form-group">
						<div class="col-sm-10" id="col-sm-10">
							<input name="first_name" type="name" class="form-control" id="first_name" placeholder="First name">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10" id="col-sm-10">
							<input name="last_name" type="name" class="form-control" id="last_name" placeholder="Last name">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10" id="col-sm-10">
							<input name="email" type="email" class="form-control" id="email" placeholder="name@example.com">
							<% String email_status = (String) session.getAttribute("user"); %>
							<% if (email_status != null && email_status.equals("email_exists")) { %>
						    <div class="error">The email address you specified is already in use.</div>
						    <% } session.setAttribute("user", null); //set back to null when done checking %>
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10" id="col-sm-10">
							<input name="pwd" type="password" class="form-control" id="pwd" placeholder="Password">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10" id="col-sm-10">
							<input name="pwdcnf" type="password" class="form-control" id="pwdcnf" placeholder="Re-enter password">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-10" id="col-sm-10">
							<input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="commit" value="Submit"/>
						</div>
					</div>
				</form>
			</div>
			<div id="bottom-info">
			
		</div>
	</div>
<!-- scripts -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script src="jquery.easing.1.3.mine.js" type="text/javascript"></script> <!-- don't hot link this, download it -->
<script type="text/javascript" src="js/scrollToAnchor.js"></script>	<!-- not scrolling how I want it to -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
</html>