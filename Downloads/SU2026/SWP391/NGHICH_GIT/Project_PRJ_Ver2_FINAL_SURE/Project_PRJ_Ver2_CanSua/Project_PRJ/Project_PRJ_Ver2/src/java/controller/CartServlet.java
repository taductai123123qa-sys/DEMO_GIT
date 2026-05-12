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

import model.Cart;
import service.CartService;

/**
 *
 * @author Lecoo
 */
@WebServlet(name="CartServlet", urlPatterns={"/cart"})
public class CartServlet extends HttpServlet {
   
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
        Cart cart = cartService.getCart(request);
        request.setAttribute("cart", cart);
        request.getRequestDispatcher("Cart.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        if ("update".equals(action)) {
            String pid = request.getParameter("productId");
            String qty = request.getParameter("quantity");
            try {
                int productId = Integer.parseInt(pid);
                int quantity = Integer.parseInt(qty);
                cartService.updateQuantity(request, productId, quantity);
            } catch (NumberFormatException ignored) {
            }
        } else if ("remove".equals(action)) {
            String pid = request.getParameter("productId");
            try {
                int productId = Integer.parseInt(pid);
                cartService.removeItem(request, productId);
            } catch (NumberFormatException ignored) {
            }
        }
        response.sendRedirect("cart");
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
