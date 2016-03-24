package com.micylt.webproject.BookList.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.micylt.webproject.BookList.helpers.PostgresHelper;
import com.micylt.webproject.BookList.model.UserInfoBean;

public class UserInfoDAO {

	Connection conn = null;
	PostgresHelper postgresHelper = null;

	public UserInfoDAO() throws SQLException {

		if (conn == null) {
			postgresHelper = new PostgresHelper();
			postgresHelper.connect();
			conn = postgresHelper.getConnection();
		}
	}

	public void closeConnection() throws SQLException {
		conn = null;
		postgresHelper.close();
	}

	/**
	 * @param userInfo
	 * @return
	 * @throws SQLException
	 * Adds new user to booklist_users database.
	 */
	public boolean AddNewUser(UserInfoBean userInfo) throws SQLException {
		boolean retVal = false;

		PreparedStatement st = null;

		try {
			String query = "insert into users (first_name, last_name, email, password, salt, active) values (?, ?, ?, ?, ?, ?)";
			st = conn.prepareStatement(query);

			st.setString(1, userInfo.getFirstName());
			st.setString(2, userInfo.getLastName());
			st.setString(3, userInfo.getEmailAddress());
			st.setBytes(4, userInfo.getPassword());
			st.setBytes(5, userInfo.getSalt());
			st.setBoolean(6, true);

			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			throw new SQLException(e);
		} finally {
			if (st != null) {
				st.close();
			}
		}
		return retVal;
	}

	/**
	 * @param email
	 * @return
	 * @throws SQLException
	 * generates password salt for security encryption
	 */
	public byte [] getSaltForEmailAddress(String email) throws SQLException {
		byte [] salty = null;
		ResultSet rs = null;
		Statement st = null;

		try {
			String query = String.format("SELECT salt FROM users where email = '%s'", email);
			st = conn.createStatement();
			rs = st.executeQuery(query);

			while (rs.next()) {
				salty = rs.getBytes(1);
			}
			rs.close();
			st.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}

			if (st != null) {
				st.close();
			}
		}
		return salty;
	}

	/**
	 * @param email
	 * @return
	 * @throws SQLException
	 * generates password for security  encryption
	 */
	public byte [] getEncryptedPasswordForEmailAddress(String email) throws SQLException {
		byte [] encryptedPassword = null;
		ResultSet rs = null;
		Statement st = null;

		try {
			String query = String.format("SELECT password FROM users where email = '%s'", email);

			st = conn.createStatement();
			rs = st.executeQuery(query);

			while (rs.next()) {
				encryptedPassword = rs.getBytes(1);
			}
			rs.close();
			st.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (st != null) {
				st.close();
			}
		}
		return encryptedPassword;
	}

	/**
	 * @param email
	 * @return
	 * @throws SQLException
	 * Checks to see if the given email address already exists in the database
	 */
	public boolean emailExists(String email) throws SQLException {
		ResultSet rs = null;
		Statement st = null;

		try {
			String query = "SELECT email FROM users";

			st = conn.createStatement();
			rs = st.executeQuery(query);

			while (rs.next()) {
				if (rs.getString(1).equals(email)) {
					return true;
				}
			}
			rs.close();
			st.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (st != null) {
				st.close();
			}
		}
		return false;
	}

	/**
	 * @param email
	 * @return
	 * @throws SQLException
	 * returns user's first name
	 */
	public String getUserName(String email) throws SQLException {
		ResultSet rs = null;
		Statement st = null;
		String first_name = "failed to retrieve name";

		try {
			String query = String.format("SELECT first_name FROM users where email = '%s'", email);

			st = conn.createStatement();
			rs = st.executeQuery(query);

			while (rs.next()) {
				first_name = rs.getString(1); //get user's first name based on email address entered
			}
			rs.close();
			st.close();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (st != null) {
				st.close();
			}
		}
		return first_name;
	}
}