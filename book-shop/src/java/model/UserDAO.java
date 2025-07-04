/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import utils.DbUtils;

/**
 *
 * @author trang
 */
public class UserDAO {

    public UserDAO() {

    }

    public boolean login(String username, String password) {
        UserDTO user = getUserById(username);
        if (user != null) {
            if (user.getPassword().equals(password)) {
                if (user.isStatus()) {
                    return true;
                }
            }
        }
        return false;
    }

    public UserDTO getUserById(String uname) {
        UserDTO user = null;
        try {
            // B0 - Tao sql
            String sql = "SELECT * FROM tblUsers WHERE username= ?";

            // B1 - ket noi
            Connection conn = DbUtils.getConnection();

            // B2 - Tao cong cu de thuc thi cau lenh sql
            //Statement st = conn.createStatement();
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, uname);

            // B3 - Thuc thi cau lenh
            ResultSet rs = pr.executeQuery();

            // B4 - Duyet bang
            while (rs.next()) {
                String username = rs.getString("username");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");

                user = new UserDTO(username, password, fullName, roleID, status);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return user;
    }
}
