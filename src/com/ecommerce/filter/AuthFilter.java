package com.ecommerce.filter;

import com.ecommerce.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Authentication and authorization filter.
 * Ensures that protected resources are only accessible to logged-in users
 * with the appropriate role.
 */
@WebFilter(urlPatterns = {"/admin/*", "/seller/*", "/buyer/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Check if user is logged in
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Not logged in – redirect to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }

        // Check role-based access
        String path = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String relativePath = path.substring(contextPath.length());

        if (relativePath.startsWith("/admin") && user.getRole() != User.Role.ADMIN) {
            httpResponse.sendRedirect(contextPath + "/login?error=unauthorized");
            return;
        } else if (relativePath.startsWith("/seller") && user.getRole() != User.Role.SELLER) {
            httpResponse.sendRedirect(contextPath + "/login?error=unauthorized");
            return;
        } else if (relativePath.startsWith("/buyer") && user.getRole() != User.Role.BUYER) {
            httpResponse.sendRedirect(contextPath + "/login?error=unauthorized");
            return;
        }

        // User is authenticated and authorized – proceed
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
