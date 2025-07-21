/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author trang
 */
public class OrderDAO {

    UserDTO user = new UserDTO();
    OrderDTO order = new OrderDTO();

    public OrderDTO getOrderById(int orderId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT o.OrderID, o.Date, o.TotalMoney, o.Status, "
                + "u.UserName, u.FullName, u.Email, u.BirthDay, u.Address, u.Phone "
                + "FROM tblOrders o JOIN tblUsers u ON o.UserName = u.UserName "
                + "WHERE o.OrderID = ? AND o.Status = 0";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setBirthDay(rs.getDate("BirthDay"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));

                order.setOrderId(rs.getInt("OrderID"));
                order.setDate(rs.getDate("Date"));
                order.setTotalMoney(rs.getDouble("TotalMoney"));
                order.setStatus(rs.getBoolean("Status"));
                order.setUser(user);

                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return null;
    }

    public OrderDTO getOrderByIdForRep(int orderId) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        OrderDTO order = new OrderDTO();
        UserDTO user = new UserDTO();

        String sql = "SELECT o.OrderID, o.Date, o.TotalMoney, o.Status, "
                + "u.UserName, u.FullName, u.Email, u.BirthDay, u.Address, u.Phone "
                + "FROM tblOrders o JOIN tblUsers u ON o.UserName = u.UserName "
                + "WHERE o.OrderID = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setBirthDay(rs.getDate("BirthDay"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));

                order.setOrderId(rs.getInt("OrderID"));
                order.setDate(rs.getDate("Date"));
                order.setTotalMoney(rs.getDouble("TotalMoney"));
                order.setStatus(rs.getBoolean("Status"));
                order.setUser(user);

                return order;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return null;
    }

    public List<OrderDTO> getAllOrders() {
        List<OrderDTO> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM tblOrders";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getInt("OrderID"));
                order.setDate(rs.getDate("Date"));
                order.setStatus(rs.getBoolean("Status"));

                order.setTotalMoney(rs.getDouble("TotalMoney"));

                String userName = rs.getString("UserName");
                user.setUserName(userName);
                order.setUser(user);

                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return orders;
    }

    public List<OrderDTO> getOrdersByUserName(String userName) {
        List<OrderDTO> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM tblOrders WHERE UserName = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, userName);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderId(rs.getInt("OrderID"));
                order.setDate(rs.getDate("Date"));
                order.setStatus(rs.getBoolean("Status"));
                order.setTotalMoney(rs.getDouble("TotalMoney"));

                String username = rs.getString("UserName");
                user.setUserName(userName);
                order.setUser(user);

                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return orders;
    }

    public boolean changeOrderStatus(int orderId, boolean newStatus) {
        Connection conn = null;
        PreparedStatement ps = null;
        String sql = "UPDATE tblOrders SET Status = ? WHERE OrderID = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, newStatus);
            ps.setInt(2, orderId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }

        return false;
    }

//Cookie list
    public int addOrder(UserDTO user, CartDTO cart) {
        int orderId = -1;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            conn.setAutoCommit(false); // Transaction start

            // 1. Insert into tblOrders
            String sql01 = "INSERT INTO tblOrders (Date, UserName, TotalMoney, status) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sql01, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, Date.valueOf(LocalDate.now()));
            ps.setString(2, user.getUserName());
            ps.setDouble(3, cart.getTotalMoney());
            ps.setBoolean(4, false); // false = not handled yet

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected == 0) {
                throw new SQLException("Insert tblOrders failed, no rows affected.");
            }

            // 2. Get generated order ID
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                throw new SQLException("Failed to retrieve generated OrderID.");
            }

            // 3. Insert order details
            String sql02 = "INSERT INTO tblOrderDetails (OrderID, ProductID, Quantity, UnitPrice, Discount) VALUES (?, ?, ?, ?, ?)";
            for (ItemDTO item : cart.getListItems()) {
                try ( PreparedStatement psDetail = conn.prepareStatement(sql02)) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, item.getProduct().getProductId());
                    psDetail.setInt(3, item.getQuantity());
                    psDetail.setDouble(4, item.getProduct().getUnitPrice());
                    psDetail.setDouble(5, item.getProduct().getDiscount());
                    psDetail.executeUpdate();
                }
            }

            conn.commit();
        } catch (Exception e) {
            System.err.println("Error in addOrder(): " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            orderId = -1; // failed
        } finally {
            closeResources(conn, ps, rs);
        }

        return orderId;
    }

    public CartDTO getCart(String username) {
        CartDTO cart = new CartDTO();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();

            // 1. Tìm orderID của đơn hàng chưa xử lý mới nhất
            String getLatestOrderSQL = "SELECT TOP 1 OrderID FROM tblOrders WHERE UserName = ? AND status = 0 ORDER BY OrderID DESC";
            ps = conn.prepareStatement(getLatestOrderSQL);
            ps.setString(1, username);
            rs = ps.executeQuery();

            int orderId = -1;
            if (rs.next()) {
                orderId = rs.getInt("OrderID");
            }

            if (orderId == -1) {
                return cart;
            }

            String sql = "SELECT d.ProductID, d.Quantity, d.UnitPrice, d.Discount, "
                    + "p.ProductName, p.Image, p.Description, p.Author, p.CategoryID, p.Status "
                    + "FROM tblOrderDetails d "
                    + "JOIN tblProducts p ON d.ProductID = p.ProductID "
                    + "WHERE d.OrderID = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setImage(rs.getString("Image"));
                product.setUnitPrice(rs.getDouble("UnitPrice"));
                product.setDiscount(rs.getDouble("Discount"));
                product.setStatus(rs.getBoolean("Status"));

                int quantity = rs.getInt("Quantity");
                double price = product.getSalePrice();
                ItemDTO item = new ItemDTO(product, quantity, price);

                cart.addItem(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return cart;
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
