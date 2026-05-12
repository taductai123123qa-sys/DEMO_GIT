/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;
import model.Cart;
import service.CartService;
import service.OrderService;
import utils.SessionUtil;

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private final CartService cartService = new CartService();
    private final OrderService orderService = new OrderService();

    private Set<Integer> parseSelectedIds(String selected) {
        if (selected == null || selected.isBlank()) return null;
        return Arrays.stream(selected.split(","))
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .map(s -> {
                    try { return Integer.parseInt(s); } catch (NumberFormatException e) { return null; }
                })
                .filter(i -> i != null)
                .collect(Collectors.toSet());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Cart cart = cartService.getCart(request);
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        String selectedParam = request.getParameter("selected");
        Set<Integer> selectedIds = parseSelectedIds(selectedParam);
        Cart displayCart = cart;

        if (selectedIds != null && !selectedIds.isEmpty()) {
            request.getSession().setAttribute("checkoutSelectedIds", selectedIds);
            displayCart = cart.filterByProductIds(selectedIds);
            if (displayCart.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }
        } else {
            request.getSession().removeAttribute("checkoutSelectedIds");
        }

        request.setAttribute("cart", displayCart);
        request.getRequestDispatcher("/CheckOut.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect("login?redirect=checkout");
            return;
        }

        Cart cart = cartService.getCart(request);
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        @SuppressWarnings("unchecked")
        Set<Integer> selectedIds = (Set<Integer>) request.getSession().getAttribute("checkoutSelectedIds");
        Cart orderCart = cart;
        if (selectedIds != null && !selectedIds.isEmpty()) {
            orderCart = cart.filterByProductIds(selectedIds);
            if (orderCart.isEmpty()) {
                response.sendRedirect("cart");
                return;
            }
        }

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isBlank()) {
            paymentMethod = "COD";
        }

        try {
            int orderId = orderService.checkout(request, orderCart, paymentMethod);
            if (selectedIds != null && !selectedIds.isEmpty()) {
                cart.removeItemsByIds(selectedIds);
            } else {
                cartService.clearCart(request);
            }
            request.getSession().removeAttribute("checkoutSelectedIds");
            request.getSession().setAttribute("cartCount", cart.getTotalQuantity());
            request.setAttribute("orderId", orderId);
            request.getRequestDispatcher("/order-success.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không thể tạo đơn hàng: " + e.getMessage());
            doGet(request, response);
        }
    }
}
