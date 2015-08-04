package com.micylt.webproject.BookList.userinfo.controller;

import java.io.IOException;
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
import com.micylt.webproject.BookList.model.UserInfoBean;
import com.micylt.webproject.BookList.utils.PasswordEncryptionService;

/**
 * Servlet implementation class RegistrationController1
 * This is the servlet that is responsible for creating, reading, updating, and deleting the user contact info
 * CRUD
 */

public class UserInfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserInfoController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String forward = null;
		String first_name = request.getParameter("first_name").toUpperCase();
		String last_name = request.getParameter("last_name").toUpperCase();
		String plainTextPassword = request.getParameter("pwd");
		String email = request.getParameter("email").toUpperCase();//case insensitive

		UserInfoBean userInfo = new UserInfoBean();

		userInfo.setFirstName(first_name);
		userInfo.setLastName(last_name);
		userInfo.setEmailAddress(email);
		first_name = first_name.charAt(0) + first_name.substring(1).toLowerCase();

		HttpSession session = request.getSession();
		forward = newUser(userInfo, plainTextPassword);

		if (forward.equals("AccountPage.jsp")) { //everything's fine
			session.setAttribute("user", first_name);
			//setting session to expire in 30 mins
			session.setMaxInactiveInterval(30 * 60);
			Cookie userName = new Cookie("user", first_name);
			response.addCookie(userName);
			//get the encoded URL string
			encodeURL(forward, response);
		} else if (forward.equals("Registration.jsp")) {//email already exists in database
			session.setAttribute("user", "email_exists");
			encodeURL("Registration.jsp", response);
		} else { //some SQL or system error occurred
			encodeURL(forward, response);
		}
	}

	/**
	 * encodes URL passed in
	 */
	private void encodeURL(String URL, HttpServletResponse response) throws ServletException, IOException {
		String encodedURL = response.encodeRedirectURL(URL);
		response.sendRedirect(encodedURL);
	}

	private String newUser(UserInfoBean userInfo, String plainTextPassword) {
		String webPageToForwardTo = "SystemError.jsp";	// Send the user to the next page;

		try {
			PasswordEncryptionService encryptService = new PasswordEncryptionService();

			byte [] salt = encryptService.generateSalt();
			byte [] encryptedPassword = encryptService.getEncryptedPassword(plainTextPassword, salt);

			userInfo.setPassword(encryptedPassword);
			userInfo.setSalt(salt);
			webPageToForwardTo = "AccountPage.jsp";
		} catch (NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (InvalidKeySpecException e) {
			e.printStackTrace();
		}

		UserInfoDAO userInfoDao = null;

		try {
			userInfoDao = new UserInfoDAO();

			if (!(userInfoDao.emailExists(userInfo.getEmailAddress()))) { // check if email already exists in database
				userInfoDao.AddNewUser(userInfo);
			} else { //the email address entered is already in use
				System.out.println("The email address you entered already exist in the booklist_users database.");
				webPageToForwardTo = "Registration.jsp";
			}

		} catch (SQLException e) {
			e.printStackTrace();
			webPageToForwardTo = "SqlError.jsp"; // Send to an error web page
		} finally {
			try {
				if (userInfoDao != null)
					userInfoDao.closeConnection();
			} catch (SQLException e) {
				e.printStackTrace();
				webPageToForwardTo = "SqlError.jsp"; // Send to an error web page
			}
		}
		return webPageToForwardTo;
	}
}