/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
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
    
    
}
