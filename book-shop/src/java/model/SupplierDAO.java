/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author trang
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

public class SupplierDAO {

    public SupplierDTO getSupplierByID(int id) {
        SupplierDTO supplier = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM tblSuppliers WHERE SupplierID = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                supplier = new SupplierDTO();
                supplier.setSupplierId(rs.getInt("SupplierID"));
                supplier.setCompanyName(rs.getString("CompanyName"));
                supplier.setContactName(rs.getString("ContactName"));
                supplier.setCountry(rs.getString("Country"));
                supplier.setPhone(rs.getString("Phone"));
                supplier.setHomePage(rs.getString("HomePage"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return supplier;
    }

    public List<SupplierDTO> getAllSuppliers() {
        List<SupplierDTO> supList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM tblSuppliers";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                SupplierDTO supplier = new SupplierDTO();

                supplier.setSupplierId(rs.getInt("SupplierID"));
                supplier.setCompanyName(rs.getString("CompanyName"));
                supplier.setContactName(rs.getString("ContactName"));
                supplier.setCountry(rs.getString("Country"));
                supplier.setPhone(rs.getString("Phone"));
                supplier.setHomePage(rs.getString("HomePage"));
                supList.add(supplier);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return supList;
    }

    public List<SupplierDTO> getSuppliersByName(String name) {
        List<SupplierDTO> supList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM tblSuppliers WHERE CompanyName LIKE ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            rs = ps.executeQuery();

            while (rs.next()) {
                SupplierDTO supplier = new SupplierDTO();
                supplier.setSupplierId(rs.getInt("SupplierID"));
                supplier.setCompanyName(rs.getString("CompanyName"));
                supplier.setContactName(rs.getString("ContactName"));
                supplier.setCountry(rs.getString("Country"));
                supplier.setPhone(rs.getString("Phone"));
                supplier.setHomePage(rs.getString("HomePage"));

                supList.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }
        return supList;
    }

    public boolean create(SupplierDTO supplier) {
        Connection conn = null;
        PreparedStatement ps = null;

        String sql = "INSERT INTO tblSuppliers (CompanyName, ContactName, Country, Phone, HomePage) "
                + "VALUES (?, ?, ?, ?, ?)";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, supplier.getCompanyName());
            ps.setString(2, supplier.getContactName());
            ps.setString(3, supplier.getCountry());
            ps.setString(4, supplier.getPhone());
            ps.setString(5, supplier.getHomePage());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return false;
    }

    public boolean update(SupplierDTO supplier) {
        Connection conn = null;
        PreparedStatement ps = null;

        String sql = "UPDATE tblSuppliers SET CompanyName = ?, ContactName = ?, Country = ?, Phone = ?, HomePage = ? "
                + "WHERE SupplierID = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            
            ps.setString(1, supplier.getCompanyName());
            ps.setString(2, supplier.getContactName());
            ps.setString(3, supplier.getCountry());
            ps.setString(4, supplier.getPhone());
            ps.setString(5, supplier.getHomePage());
            ps.setInt(6, supplier.getSupplierId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, null);
        }
        return false;
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
