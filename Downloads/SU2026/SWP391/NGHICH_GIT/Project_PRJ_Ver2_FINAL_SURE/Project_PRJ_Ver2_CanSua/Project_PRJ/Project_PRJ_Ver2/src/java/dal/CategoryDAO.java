/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Category;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    public List<Category> findAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT categoryId, name FROM Categories WHERE status = 'ACTIVE'";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("categoryId"));
                c.setName(rs.getString("name"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.err.println("CategoryDAO.findAll error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}
