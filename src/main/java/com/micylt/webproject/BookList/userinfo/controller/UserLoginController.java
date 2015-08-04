package com.micylt.webproject.BookList.userinfo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.micylt.webproject.BookList.DAO.UserInfoDAO;
import com.micylt.webproject.BookList.utils.PasswordEncryptionService;

/**
 * Servlet implementation class RegistrationController1
 */

//This is the servlet that is responsible for creating, reading, updating, and deleting the user contact info
//CRUD

public class UserLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserLoginController() {
		super();

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 * initiates user login
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("login_email").toUpperCase();//get email(case insensitive) and pass from jsp page
		String plainTextPassword = request.getParameter("login_pwd");
		String user_name;
		
		HttpSession session = request.getSession();
		user_name = userLogin(email, plainTextPassword);//decide where to forward user

		if (user_name.equals("UserDNE.jsp")) {//invalid user_name
			session.setAttribute("user", "DNE");
			encodeURL("Registration.jsp", response);
		} else if (user_name.equals("SqlError.jsp") || user_name.equals("SystemError.jsp")) {
			encodeURL("SqlError.jsp", response);
		} else {//valid user_name
			user_name = user_name.charAt(0) + user_name.substring(1).toLowerCase();//case insensitive
			session.setAttribute("user", user_name);
			//setting session to expire in 30 mins
			session.setMaxInactiveInterval(30 * 60);
			Cookie userName = new Cookie("user", user_name);
			response.addCookie(userName);
			//get the encoded URL string
			encodeURL("AccountPage.jsp", response);
		}
	}
	
	/**
	 * encodes URL passed in
	 */
	private void encodeURL(String URL, HttpServletResponse response) throws ServletException, IOException {
		String encodedURL = response.encodeRedirectURL(URL);
		response.sendRedirect(encodedURL);
	}

	/**
	 * @param emailAddress
	 * @param plainTextPassword
	 * @return
	 * validates user's login credentials
	 */
	private String userLogin(String emailAddress, String plainTextPassword) {
		String loginResponse = null;
		UserInfoDAO userInfoDao = null;
		byte [] dbEncryptedPassword;
		byte [] salt;

		try {
			userInfoDao = new UserInfoDAO();
			if (!(userInfoDao.emailExists(emailAddress))) { // check if the email provided is in the database
				System.out.println("The email address you entered does not exist in the database."); // temp for testing
				loginResponse = "UserDNE.jsp"; // temp for testing
			} else {
				salt = userInfoDao.getSaltForEmailAddress(emailAddress); // gets the original salt for this email for database
				dbEncryptedPassword = userInfoDao.getEncryptedPasswordForEmailAddress(emailAddress); // gets password from database
				PasswordEncryptionService encryptService = new PasswordEncryptionService();

				try {
					boolean passwordsAreEqual = encryptService.authenticate(plainTextPassword, dbEncryptedPassword, salt); //check if pass matches

					if (passwordsAreEqual) {
						loginResponse = userInfoDao.getUserName(emailAddress); //credentials passed
						System.out.println("Password correct!");
					} else {
						loginResponse = "UserDNE.jsp"; // temp for testing
						System.out.println("Wrong password");
					}

				} catch (NoSuchAlgorithmException e1) {
					loginResponse = "SystemError.jsp";	//send the user to the next page;
					e1.printStackTrace();
				} catch (InvalidKeySpecException e1) {
					loginResponse = "SystemError.jsp";	//send the user to the next page;
					e1.printStackTrace();
				} finally {
					try {
						if (userInfoDao != null)
							userInfoDao.closeConnection();
					} catch (SQLException e) {
						e.printStackTrace();
						loginResponse = "SqlError.jsp";	//send to an error web page
					}
				}
			}
		} catch (SQLException e) {
			loginResponse = "SystemError.jsp";	//send the user to the next page;
			e.printStackTrace();
		} finally {
			try {
				if (userInfoDao != null)
					userInfoDao.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
				loginResponse = "SqlError.jsp";	//send to an error web page
			}
		}
		return loginResponse;
	}
}