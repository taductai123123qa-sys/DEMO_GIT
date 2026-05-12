package service;

import dal.UserDAO;
import model.User;

public class AuthService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String emailOrUsername, String password) {
        return userDAO.checkLogin(emailOrUsername, password);
    }

    public User register(String firstName, String lastName, String email, String password) {
        if (userDAO.emailExists(email)) {
            return null;
        }
        String fullName = (firstName + " " + lastName).trim();
        return userDAO.createUser(fullName, email, password);
    }
}
