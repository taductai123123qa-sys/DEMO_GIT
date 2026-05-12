/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import service.CartService;

/**
 *
 * @author Lecoo
 */
@WebServlet(name="AddToCartServlet", urlPatterns={"/addtocart"})
public class AddToCartServlet extends HttpServlet {
   
    private final CartService cartService = new CartService();

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
        String pid = request.getParameter("productId");
        int quantity = 1;
        String qtyParam = request.getParameter("qty");
        if (qtyParam != null) {
            try {
                int q = Integer.parseInt(qtyParam);
                if (q > 0) {
                    quantity = q;
                }
            } catch (NumberFormatException ignored) {
            }
        }
        try {
            int productId = Integer.parseInt(pid);
            cartService.addToCart(request, productId, quantity);
        } catch (NumberFormatException ignored) {
        }

        String ajax = request.getParameter("ajax");
        String requestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "1".equals(ajax) || "XMLHttpRequest".equalsIgnoreCase(requestedWith);

        if (isAjax) {
            response.setContentType("application/json;charset=UTF-8");
            Object cartCountObj = request.getSession().getAttribute("cartCount");
            int count = (cartCountObj instanceof Number) ? ((Number) cartCountObj).intValue() : 0;
            String json = "{\"success\":true,\"cartCount\":" + count + "}";
            response.getWriter().write(json);
        } else {
            response.sendRedirect("cart");
        }
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

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
