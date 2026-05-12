/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Brand;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BrandDAO {

    public List<Brand> findAll() {
        List<Brand> list = new ArrayList<>();
        String sql = "SELECT brandId, name FROM Brands ORDER BY name";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Brand b = new Brand();
                b.setBrandId(rs.getInt("brandId"));
                b.setName(rs.getString("name"));
                list.add(b);
            }
        } catch (SQLException e) {
            System.err.println("BrandDAO.findAll error: " + e.getMessage());
            e.printStackTrace();
        }

        return list;
    }
}
