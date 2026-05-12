package model;

import java.math.BigDecimal;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

public class Cart {
    private final Map<Integer, CartItem> items = new LinkedHashMap<>();

    public void addItem(Product product, int quantity) {
        if (product == null || quantity <= 0) return;
        CartItem existing = items.get(product.getProductId());
        if (existing == null) {
            items.put(product.getProductId(), new CartItem(product, quantity));
        } else {
            existing.setQuantity(existing.getQuantity() + quantity);
        }
    }

    public void updateQuantity(int productId, int quantity) {
        CartItem item = items.get(productId);
        if (item == null) return;
        if (quantity <= 0) {
            items.remove(productId);
        } else {
            item.setQuantity(quantity);
        }
    }

    public void removeItem(int productId) {
        items.remove(productId);
    }

    public Collection<CartItem> getItems() {
        return items.values();
    }

    public int getTotalQuantity() {
        return items.values().stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }

    public BigDecimal getTotalAmount() {
        return items.values().stream()
                .map(CartItem::getTotalPrice)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public void clear() {
        items.clear();
    }

    /**
     * Trả về cart mới chỉ chứa các sản phẩm có productId trong set đã cho.
     * Dùng khi user chọn một số sản phẩm để thanh toán.
     */
    public Cart filterByProductIds(Set<Integer> productIds) {
        Cart filtered = new Cart();
        if (productIds == null || productIds.isEmpty()) return filtered;
        for (Integer pid : productIds) {
            CartItem item = items.get(pid);
            if (item != null) {
                filtered.addItem(item.getProduct(), item.getQuantity());
            }
        }
        return filtered;
    }

    /**
     * Xóa các sản phẩm có productId trong set khỏi giỏ hàng.
     */
    public void removeItemsByIds(Set<Integer> productIds) {
        if (productIds != null) {
            productIds.forEach(this::removeItem);
        }
    }
}
