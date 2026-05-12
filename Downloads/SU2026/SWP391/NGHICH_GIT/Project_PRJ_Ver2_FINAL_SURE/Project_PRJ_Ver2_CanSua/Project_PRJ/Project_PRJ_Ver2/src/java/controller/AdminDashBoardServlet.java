/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.DashBoardDAO;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="AdminDashBoardServlet", urlPatterns={"/admindashboard"})
public class AdminDashBoardServlet extends HttpServlet {

    private final DashBoardDAO dashBoardDAO = new DashBoardDAO();

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BigDecimal totalRevenue = dashBoardDAO.getTotalRevenue();
        BigDecimal todayRevenue = dashBoardDAO.getTodayRevenue();
        int totalOrders = dashBoardDAO.getTotalOrders();
        int totalUsers = dashBoardDAO.getTotalUsers();

        List<model.DashboardStatusCount> statusStats = dashBoardDAO.getOrderStatusStats();
        List<model.DashboardMonthlyRevenue> monthlyRevenue = dashBoardDAO.getMonthlyRevenue();

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("todayRevenue", todayRevenue);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("statusStats", statusStats);
        request.setAttribute("monthlyRevenue", monthlyRevenue);

        request.getRequestDispatcher("/admin/DashBoard.jsp").forward(request, response);
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
