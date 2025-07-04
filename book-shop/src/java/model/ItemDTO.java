/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author trang
 */
public class ItemDTO {  
    private int id;
    private UserDTO user;
    private ProductDTO product;
    private int quantity;

    public ItemDTO() {
    }

    public ItemDTO(UserDTO user, ProductDTO product, int quantity) {
        this.user = user;
        this.product = product;
        this.quantity = quantity;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public UserDTO getUser() {
        return user;
    }

    public void setUser(UserDTO user) {
        this.user = user;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public boolean increaseQuantity(int quantity) {
        this.quantity += quantity;
        return true;
    }

    public double getTotalPrice() {
        return product.getUnitPrice() * quantity;
    }

}
