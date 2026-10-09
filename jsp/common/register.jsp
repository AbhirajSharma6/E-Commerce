<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<div style="min-height:calc(100vh - 56px); display:flex; align-items:center; justify-content:center; background:#fff; padding:40px 0;">
    <div style="width:480px; padding:40px;">
        <h2 style="font-family:'Playfair Display',serif; font-size:2rem; margin-bottom:8px;">Create Account</h2>
        <p style="color:#888; font-size:0.9rem; margin-bottom:30px;">Join ShopEase as a Buyer or Seller</p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger py-2" style="font-size:0.85rem;"><%= request.getAttribute("error") %></div>
        <% } %>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Full Name</label>
                <input type="text" class="form-control" name="name" required style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;">
            </div>
            <div class="mb-3">
                <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Email</label>
                <input type="email" class="form-control" name="email" required style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;">
            </div>
            <div class="row mb-3">
                <div class="col-6">
                    <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Password</label>
                    <input type="password" class="form-control" name="password" required style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;">
                </div>
                <div class="col-6">
                    <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Confirm</label>
                    <input type="password" class="form-control" name="confirmPassword" required style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;">
                </div>
            </div>
            <div class="mb-3">
                <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Register As</label>
                <select class="form-select" name="role" required style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;">
                    <option value="BUYER">Buyer</option>
                    <option value="SELLER">Seller</option>
                </select>
            </div>
            <div class="mb-3">
                <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Phone</label>
                <input type="tel" class="form-control" name="phone" style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;">
            </div>
            <div class="mb-4">
                <label style="font-size:0.8rem; font-weight:600; letter-spacing:1px; text-transform:uppercase; color:#888;">Address</label>
                <textarea class="form-control" name="address" rows="2" style="border-radius:0; border:none; border-bottom:2px solid #ddd; padding:12px 0;"></textarea>
            </div>
            <button type="submit" class="btn w-100 py-3" style="background:var(--brown); color:#fff; border:none; border-radius:0; font-weight:600; font-size:0.85rem; letter-spacing:2px; text-transform:uppercase;">
                Create Account
            </button>
        </form>
        <p class="text-center mt-4" style="color:#888; font-size:0.85rem;">
            Already have an account? <a href="${pageContext.request.contextPath}/login" style="color:var(--brown); font-weight:600; text-decoration:none;">Sign In</a>
        </p>
    </div>
</div>

<%@ include file="footer.jsp" %>
