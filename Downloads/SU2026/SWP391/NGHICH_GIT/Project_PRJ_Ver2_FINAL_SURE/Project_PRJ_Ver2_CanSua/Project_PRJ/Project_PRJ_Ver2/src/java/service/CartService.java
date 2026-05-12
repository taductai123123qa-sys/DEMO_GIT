package service;

import dal.ProductDAO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Cart;
import model.CartItem;
import model.Product;

public class CartService {

    private final ProductDAO productDAO = new ProductDAO();

    public Cart getCart(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    public void addToCart(HttpServletRequest request, int productId, int quantity) {
        Cart cart = getCart(request);
        Product product = productDAO.getById(productId);
        if (product == null || quantity <= 0) return;

        // Giới hạn số lượng theo tồn kho
        int currentQty = cart.getItems().stream()
                .filter(ci -> ci.getProduct().getProductId() == productId)
                .mapToInt(CartItem::getQuantity)
                .sum();
        int maxCanAdd = product.getStock() - currentQty;
        if (maxCanAdd <= 0) {
            request.getSession().setAttribute("cartError",
                    "Sản phẩm \"" + product.getName() + "\" đã đạt tối đa tồn kho trong giỏ.");
            return;
        }
        if (quantity > maxCanAdd) {
            quantity = maxCanAdd;
        }

        cart.addItem(product, quantity);
        request.getSession().setAttribute("cartCount", cart.getTotalQuantity());
    }

    public void updateQuantity(HttpServletRequest request, int productId, int quantity) {
        Cart cart = getCart(request);
        Product product = productDAO.getById(productId);
        if (product == null) return;

        if (quantity > product.getStock()) {
            quantity = product.getStock();
        }

        cart.updateQuantity(productId, quantity);
        request.getSession().setAttribute("cartCount", cart.getTotalQuantity());
    }

    public void removeItem(HttpServletRequest request, int productId) {
        Cart cart = getCart(request);
        cart.removeItem(productId);
        request.getSession().setAttribute("cartCount", cart.getTotalQuantity());
    }

    public void clearCart(HttpServletRequest request) {
        Cart cart = getCart(request);
        cart.clear();
        request.getSession().setAttribute("cartCount", 0);
    }
}
