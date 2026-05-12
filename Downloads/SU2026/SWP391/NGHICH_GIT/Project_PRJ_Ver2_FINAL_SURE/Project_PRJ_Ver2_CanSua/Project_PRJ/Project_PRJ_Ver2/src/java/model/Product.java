package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Product {
    private int productId;
    private String name;
    private String description;
    private BigDecimal price;
    private int stock;
    private int soldCount;
    private int categoryId;
    private int brandId;
    private Timestamp createdAt;
    private String images;
    private String status;

    // Constructor rỗng
    public Product() {
    }

    // Constructor đầy đủ (dùng khi cần)
    public Product(int productId, String name, String description, BigDecimal price, 
                   int stock, int soldCount, int categoryId, int brandId, 
                   Timestamp createdAt, String images, String status) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock = stock;
        this.soldCount = soldCount;
        this.categoryId = categoryId;
        this.brandId = brandId;
        this.createdAt = createdAt;
        this.images = images;
        this.status = status;
    }

    // Getters và Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getSoldCount() {
        return soldCount;
    }

    public void setSoldCount(int soldCount) {
        this.soldCount = soldCount;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    // toString để debug dễ dàng
    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", soldCount=" + soldCount +
                ", images='" + images + '\'' +
                '}';
    }
}