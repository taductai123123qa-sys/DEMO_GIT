package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.User;

public class SessionUtil {

    public static void storeUser(HttpServletRequest request, User user) {
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("username", user.getFullName());
        session.setAttribute("email", user.getEmail());
        session.setAttribute("role", user.getRole());
    }

    public static User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        Object obj = session.getAttribute("user");
        return (obj instanceof User) ? (User) obj : null;
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getUser(request) != null;
    }

    public static boolean isAdmin(HttpServletRequest request) {
        User u = getUser(request);
        return u != null && "ADMIN".equalsIgnoreCase(u.getRole());
    }

    public static void logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
