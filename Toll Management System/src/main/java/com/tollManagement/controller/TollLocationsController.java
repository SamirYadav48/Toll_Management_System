package com.tollManagement.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.tollManagement.model.TollBoothModel;
import com.tollManagement.model.UserModel;
import com.tollManagement.config.DbConfig;

/**
 * Servlet implementation class TollLocationsController
 * @author Samir yadav
 * @lmuId 23048505
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/TollLocationsController" })
public class TollLocationsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TollLocationsController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		UserModel user = (UserModel) session.getAttribute("user");
		
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		List<TollBoothModel> tollBooths = new ArrayList<>();

		try (Connection conn = DbConfig.getDbConnection()) {
			String query = "SELECT boothId, location, status, created_at, updated_at FROM toll_booths ORDER BY boothId";
			try (PreparedStatement stmt = conn.prepareStatement(query);
				 ResultSet rs = stmt.executeQuery()) {

				while (rs.next()) {
					TollBoothModel booth = new TollBoothModel();
					booth.setBoothId(rs.getString("boothId"));
					booth.setLocation(rs.getString("location"));
					booth.setStatus(rs.getString("status"));
					booth.setCreatedAt(rs.getTimestamp("created_at"));
					booth.setUpdatedAt(rs.getTimestamp("updated_at"));
					tollBooths.add(booth);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Error fetching toll locations: " + e.getMessage());
		}

		request.setAttribute("tollBooths", tollBooths);
		request.getRequestDispatcher("/WEB-INF/pages/customerPages/tollLocations.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
