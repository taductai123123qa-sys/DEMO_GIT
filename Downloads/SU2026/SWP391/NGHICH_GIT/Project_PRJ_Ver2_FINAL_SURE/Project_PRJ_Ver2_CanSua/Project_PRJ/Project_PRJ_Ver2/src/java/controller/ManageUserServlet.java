/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "ManageUserServlet", urlPatterns = {"/manageuser"})
public class ManageUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userDAO.findAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/admin/ManageUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String idStr = request.getParameter("userId");

        if (action != null && idStr != null) {
            try {
                int userId = Integer.parseInt(idStr);
                switch (action) {
                    case "toggleStatus":
                        handleToggleStatus(userId, request);
                        break;
                    case "toggleRole":
                        handleToggleRole(userId, request);
                        break;
                    default:
                        request.setAttribute("error", "Hành động không hợp lệ.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "UserId không hợp lệ.");
            }
        }

        doGet(request, response);
    }

    private void handleToggleStatus(int userId, HttpServletRequest request) {
        List<User> current = userDAO.findAll();
        User target = current.stream()
                .filter(u -> u.getUserId() == userId)
                .findFirst()
                .orElse(null);

        if (target == null) {
            request.setAttribute("error", "Không tìm thấy người dùng.");
            return;
        }

        String newStatus = "ACTIVE";
        if ("ACTIVE".equalsIgnoreCase(target.getStatus()) || target.getStatus() == null) {
            newStatus = "BLOCK";
        }

        if (userDAO.updateStatus(userId, newStatus)) {
            request.setAttribute("message", "Cập nhật trạng thái thành công.");
        } else {
            request.setAttribute("error", "Không thể cập nhật trạng thái.");
        }
    }

    private void handleToggleRole(int userId, HttpServletRequest request) {
        List<User> current = userDAO.findAll();
        User target = current.stream()
                .filter(u -> u.getUserId() == userId)
                .findFirst()
                .orElse(null);

        if (target == null) {
            request.setAttribute("error", "Không tìm thấy người dùng.");
            return;
        }

        String newRole = "ADMIN".equalsIgnoreCase(target.getRole()) ? "USER" : "ADMIN";

        if (userDAO.updateRole(userId, newRole)) {
            request.setAttribute("message", "Cập nhật vai trò thành công.");
        } else {
            request.setAttribute("error", "Không thể cập nhật vai trò.");
        }
    }
}
