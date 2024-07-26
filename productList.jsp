<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
	HttpSession httpSession = request.getSession();
	if (httpSession == null || httpSession.getAttribute("user") == null) {
		response.sendRedirect("login.jsp");
		return;

	}

	String user = (String) httpSession.getAttribute("user");
%>

<%
    // Database connection details
    String url = "jdbc:mysql://localhost:3306/ultras";
    String dbUser = "root";
    String dbPassword = "";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUser, dbPassword);
        String sql = "SELECT * FROM products";
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
%>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Brand Name</th>
                <th>Price</th>
                <th>Color</th>
                <th>Specification</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
<%
        while (rs.next()) {
            String id = rs.getString("id");
            String name = rs.getString("name");
            String brandName = rs.getString("brand_name");
            String price = rs.getString("price");
            String color = rs.getString("color");
            String specification = rs.getString("specification");
            String image = rs.getString("image");
%>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= brandName %></td>
                <td><%= price %></td>
                <td><%= color %></td>
                <td><%= specification %></td>
                <td><%= image %></td>
                <td>
                    <a href="editproduct.jsp?id=<%= id %>">Edit</a>
                </td>
            </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
        </table>
