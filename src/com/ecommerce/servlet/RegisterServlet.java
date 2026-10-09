package com.ecommerce.servlet;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;
import com.ecommerce.model.User.Role;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles new user registration for Sellers and Buyers.
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    /** Display registration form */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
    }

    /** Process registration form */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String roleStr = request.getParameter("role");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Name, email, and password are required.");
            request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
            return;
        }

        try {
            // Check duplicate email
            if (userDAO.emailExists(email.trim())) {
                request.setAttribute("error", "Email already registered.");
                request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
                return;
            }

            // Create user
            Role role = Role.valueOf(roleStr.toUpperCase());
            User user = new User(name.trim(), email.trim(), password.trim(), role);
            user.setPhone(phone);
            user.setAddress(address);

            if (userDAO.insert(user)) {
                response.sendRedirect(request.getContextPath() + "/login?message=registered");
            } else {
                request.setAttribute("error", "Registration failed. Please try again.");
                request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Registration error: " + e.getMessage());
            request.getRequestDispatcher("/jsp/common/register.jsp").forward(request, response);
        }
    }
}
