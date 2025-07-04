/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author trang
 */
public class ItemDAO {

    /*functions*/
    /*public boolean addToCart(String username, int productId, int quantity) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        String sql = "IF EXISTS (SELECT * FROM tblCartItems WHERE username = ? AND productId = ?) "
                + "BEGIN "
                + "UPDATE tblCartItems SET quantity = quantity + ? WHERE username = ? AND productId = ? "
                + "END "
                + "ELSE "
                + "BEGIN "
                + "INSERT INTO tblCartItems (username, productId, quantity) VALUES (?, ?, ?) "
                + "END";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, username);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setString(4, username);
            ps.setInt(5, productId);
            ps.setString(6, username);
            ps.setInt(7, productId);
            ps.setInt(8, quantity);

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in addToCart(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }

    public List<ItemDTO> getCart(String username) {
        List<ItemDTO> items = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT p.*, c.quantity "
                + "FROM tblCartItems c "
                + "JOIN tblProducts p ON c.productId = p.id "
                + "WHERE c.username = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("image"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("catID"),
                        rs.getString("author"),
                        rs.getBoolean("status")
                );

                UserDTO user = new UserDTO();
                user.setUsername(username);

                int quantity = rs.getInt("quantity");

                items.add(new ItemDTO(user, product, quantity));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return items;
    }*/

    public boolean updateQuantity(String username, int productId, int quantity) {
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;

        String sql = "IF EXISTS (SELECT * FROM tblCartItems WHERE username = ? AND productId = ?) "
                + "BEGIN UPDATE tblCartItems SET quantity = quantity + ? WHERE username = ? AND productId = ? END "
                + "ELSE BEGIN INSERT INTO tblCartItems (username, productId, quantity) VALUES (?, ?, ?) END";
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, username);
            ps.setInt(2, productId);
            ps.setInt(3, quantity);
            ps.setString(4, username);
            ps.setInt(5, productId);
            ps.setString(6, username);
            ps.setInt(7, productId);
            ps.setInt(8, quantity);

            int rowsAffected = ps.executeUpdate();
            success = (rowsAffected > 0);

        } catch (Exception e) {
            System.err.println("Error in addToCart():  " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return success;
    }

    private void closeResources(Connection conn, PreparedStatement ps, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (Exception e) {
            System.err.println("Error closing resources: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
