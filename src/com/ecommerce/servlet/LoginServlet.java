package com.ecommerce.servlet;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Handles user authentication (login and logout).
 * Redirects users to their role-specific dashboard upon successful login.
 */
@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    /** Display the login page */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/logout".equals(path)) {
            // Invalidate session and redirect to login
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/login?message=logged_out");
            return;
        }

        // Check if already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectToDashboard(response, request.getContextPath(), user.getRole());
            return;
        }

        request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
    }

    /** Process login form submission */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Please enter both email and password.");
            request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.authenticate(email.trim(), password.trim());

            if (user != null) {
                // Create session and store user
                HttpSession session = request.getSession(true);
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(30 * 60); // 30 minutes

                // Redirect to role-specific dashboard
                redirectToDashboard(response, request.getContextPath(), user.getRole());
            } else {
                request.setAttribute("error", "Invalid email or password.");
                request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("/jsp/common/login.jsp").forward(request, response);
        }
    }

    /** Redirect user to the appropriate dashboard based on their role */
    private void redirectToDashboard(HttpServletResponse response, String contextPath, User.Role role)
            throws IOException {
        switch (role) {
            case ADMIN:
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case SELLER:
                response.sendRedirect(contextPath + "/seller/dashboard");
                break;
            case BUYER:
                response.sendRedirect(contextPath + "/buyer/dashboard");
                break;
        }
    }
}
