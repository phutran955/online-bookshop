/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author trang
 */
public class UserDAO {
    
    public UserDAO() {
        
    }
    
    public boolean login(String username, String password) {
        UserDTO user = getUserByUserName(username);
        if (user != null) {
            if (user.getPassword().equals(password)) {
                if (user.isStatus()) {
                    return true;
                }
            }
        }
        return false;
    }
    
    public UserDTO getUserByUserName(String uname) {
        UserDTO user = null;
        
        String sql = "SELECT * FROM tblUsers WHERE UserName= ?";
        
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, uname);
            ResultSet rs = pr.executeQuery();
            
            while (rs.next()) {
                int userID = rs.getInt("userID");
                String userName = rs.getString("userName");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String roleID = rs.getString("roleID");
                String email = rs.getString("email");
                Date birthday = rs.getDate("birthDay");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                boolean status = rs.getBoolean("status");
                
                user = new UserDTO(userID, userName, fullName, password, roleID, email, birthday, address, phone, status);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return user;
    }
    
    public List<UserDTO> getListUsersByUserName(String uname) {
        List<UserDTO> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM tblUsers WHERE UserName LIKE ?";
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + uname + "%"); // đúng cú pháp LIKE

            rs = ps.executeQuery();
            
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setPassword(rs.getString("Password"));
                user.setRoleID(rs.getString("RoleID"));
                user.setEmail(rs.getString("Email"));
                user.setBirthDay(rs.getDate("BirthDay")); // kiểu Date
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setStatus(rs.getBoolean("Status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace(); // nên in chi tiết lỗi để debug
        } finally {
            closeResources(conn, ps, rs);
        }
        
        return userList;
    }
    
    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT UserID, UserName, FullName, Password, RoleID, Email, BirthDay, Address, Phone, Status FROM tblUsers ORDER BY UserName";
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setPassword(rs.getString("Password"));
                user.setRoleID(rs.getString("RoleID"));
                user.setEmail(rs.getString("Email"));
                user.setBirthDay(rs.getDate("BirthDay"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setStatus(rs.getBoolean("Status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public List<UserDTO> getAllActiveUsers() {
        List<UserDTO> userList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String sql = "SELECT UserID, UserName, FullName, Password, RoleID, Email, BirthDay, Address, Phone, Status FROM tblUsers WHERE Status=1";
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getInt("UserID"));
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setPassword(rs.getString("Password"));
                user.setRoleID(rs.getString("RoleID"));
                user.setEmail(rs.getString("Email"));
                user.setBirthDay(rs.getDate("BirthDay"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setStatus(rs.getBoolean("Status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public boolean updatePassword(String username, String newPassword) {
        String sql = "UPDATE tblUsers SET password = ? WHERE UserName = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, username);
            
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateUser(UserDTO user) {
        String sql = "UPDATE tblUsers SET FullName=?, Password=?, Email=?, BirthDay=?, Address=?, Phone=? WHERE UserID=?";
        try ( Connection conn = DbUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            
            if (user.getBirthDay() != null) {
                ps.setDate(4, new java.sql.Date(user.getBirthDay().getTime()));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }
            
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());
            ps.setInt(7, user.getUserID());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateStatus(int userID, boolean status) {
        String sql = "UPDATE tblUsers SET Status = ? WHERE UserID = ?";
        boolean success = false;
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, userID);
            
            success = ps.executeUpdate() > 0;
        } catch (Exception e) {
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
