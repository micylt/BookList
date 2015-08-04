<!-- this is the registration jsp page of BookList -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> <!-- comment -->
<title>BookList</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- import of bootstrap css and js code -->
<link rel="stylesheet" type="text/css" href="css/background.css"> <!-- my css -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

<!--these next two scripts allow the use of the jQuery form validation plug in.-->
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="overlay">
		<nav class="navbar navbar-inverse">
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
					<li class="active"><a href="AccountPage.jsp">Home</a></li>
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
					<li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
					<li class="dropdown">
            		  <a class="dropdown-toggle" href="#" data-toggle="dropdown"> <span class="glyphicon glyphicon-log-in"></span> Login</a>
            		  <div class="dropdown-menu" style="padding: 5px; padding-bottom: 5px; background-color: #000000;">
<!-- login form -->   <form class="login-form" action="UserLoginController" accept-charset="UTF-8" id="loginform">
  					  <div class="form-group">
						<div class="col-sm-10">
							<input name="login_email" type="email" class="form-control" id="login_email" placeholder="name@example.com">
						</div>
					  </div>
					<div class="form-group">
						<div class="col-sm-10">
							<input name="login_pwd" type="password" class="form-control" id="login_pwd" placeholder="Password">
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
		<div class="wrapper1">
			<h1 class="centerHeader">
				<center>Welcome to BookList</center> <!-- TODO: GET RID OF <center></center> -->
			</h1>
			<p>
			<center>Buy and sell textbooks now.</center>
			</p>

			<!-- registration form -->
			<div class="form1">
				<form action="UserInfoController" class="form-horizontal" role="form" id="registerform" method="post" accept-charset="UTF-8"	>
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
		</div>
	</div>
</body>
</html>