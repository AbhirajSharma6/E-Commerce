<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div style="min-height:calc(100vh - 56px); display:flex;">
    <!-- Left side - branding -->
    <div style="flex:1; background:var(--black); display:flex; align-items:center; justify-content:center; position:relative; overflow:hidden;">
        <div style="position:absolute; top:0;left:0;right:0;bottom:0; background:linear-gradient(135deg,rgba(133,72,54,0.3),rgba(255,178,44,0.1));"></div>
        <div style="position:relative; text-align:center; padding:40px;">
            <div style="font-family:'Playfair Display',serif; font-size:3.5rem; color:#fff; letter-spacing:5px; font-weight:700;">SHOPEASE</div>
            <div style="width:60px; height:3px; background:var(--gold); margin:20px auto;"></div>
            <p style="color:#aaa; font-size:1rem; max-width:300px; line-height:1.8;">Premium e-commerce platform with dedicated dashboards for every user.</p>
        </div>
    </div>

    <!-- Right side - form -->
    <div style="flex:1; display:flex; align-items:center; justify-content:center; background:#fff;">
        <div style="width:380px; padding:40px;">
            <h2 style="font-family:'Playfair Display',serif; font-size:2rem; margin-bottom:8px;">Welcome Back</h2>
            <p style="color:#888; font-size:0.9rem; margin-bottom:30px;">Sign in to your account</p>

            <% if (request.getParameter("message") != null) { %>
                <% if ("registered".equals(request.getParameter("message"))) { %>
                    <div class="alert alert-success py-2" style="font-size:0.85rem;"><i class="bi bi-check-circle me-1"></i> Registration successful!</div>
                <% } else if ("logged_out".equals(request.getParameter("message"))) { %>
                    <div class="alert py-2" style="background:#eff6ff; color:#1e40af; font-size:0.85rem;"><i class="bi bi-info-circle me-1"></i> Logged out.</div>
                <% } %>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger py-2" style="font-size:0.85rem;"><%= request.getAttribute("error") %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="mb-3">
                    <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Email</label>
                    <input type="email" class="form-control" name="email" required placeholder="you@example.com" style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0; background:transparent;">
                </div>
                <div class="mb-4">
                    <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Password</label>
                    <input type="password" class="form-control" name="password" required placeholder="Enter password" style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0; background:transparent;">
                </div>
                <button type="submit" class="btn w-100 py-3" style="background:var(--black); color:#fff; border:none; border-radius:0; font-weight:600; font-size:0.85rem; letter-spacing:2px; text-transform:uppercase;">
                    Sign In
                </button>
            </form>

            <p class="text-center mt-4" style="color:#888; font-size:0.85rem;">
                New here? <a href="${pageContext.request.contextPath}/register" style="color:var(--brown); font-weight:600; text-decoration:none;">Create Account</a>
            </p>

            <div style="background:var(--cream); padding:16px; margin-top:20px; border-left:3px solid var(--gold);">
                <p style="font-size:0.75rem; font-weight:600; color:var(--brown); margin-bottom:6px; letter-spacing:1px;">DEMO ACCOUNTS</p>
                <div style="font-size:0.78rem; color:#666; line-height:1.8;">
                    Admin: admin@ecommerce.com / admin123<br>
                    Seller: seller@test.com / seller123<br>
                    Buyer: buyer@test.com / buyer123
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
