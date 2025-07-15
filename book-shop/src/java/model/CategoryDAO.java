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

public class CategoryDAO {

    // SQL Queries
    private static final String GET_ALL_CATEGORY = "SELECT * FROM tblCategories";

    public List<CategoryDTO> getAllCategory() {
        List<CategoryDTO> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(GET_ALL_CATEGORY);
            rs = ps.executeQuery();

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setCategoryId(rs.getInt("categoryId"));
                category.setCategoryName(rs.getString("categoryName"));
                categories.add(category);
            }
        } catch (Exception e) {
            System.err.println("Error in getAllCategory(): " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return categories;
    }

    public List<ProductDTO> getProductsByCatIDWithPaging(int catID, int page, int pageSize) {
        List<ProductDTO> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM tblProducts WHERE Status = 1 AND CategoryID = ? "
                + "ORDER BY ProductID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, catID);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            rs = ps.executeQuery();

            while (rs.next()) {
                ProductDTO product = new ProductDTO();
                product.setProductId(rs.getInt("ProductID"));
                product.setProductName(rs.getString("ProductName"));
                product.setAuthor(rs.getString("Author"));
                product.setUnitPrice(rs.getDouble("UnitPrice"));
                product.setUnitsInStock(rs.getInt("UnitsInStock"));
                product.setQuantitySold(rs.getInt("QuantitySold"));
                product.setImage(rs.getString("Image"));
                product.setDescription(rs.getString("Description"));
                product.setReleaseDate(rs.getDate("ReleaseDate"));
                product.setDiscount(rs.getDouble("Discount"));
                product.setStatus(rs.getBoolean("Status"));

                CategoryDTO category = new CategoryDTO();
                category.setCategoryId(catID);
                product.setCategory(category);

                int supID = rs.getInt("SupplierID");
                SupplierDTO supplier = new SupplierDTO();
                supplier.setSupplierId(supID);
                product.setSupplier(supplier);

                products.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return products;
    }

    public int countProductsByCatID(int catID) {
        int count = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT COUNT(*) FROM tblProducts WHERE Status = 1 AND CategoryID = ?";

        try {
            conn = DbUtils.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, catID);
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, ps, rs);
        }

        return count;
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
