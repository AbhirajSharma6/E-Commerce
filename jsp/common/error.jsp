<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html><head><title>Error</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@400&display=swap" rel="stylesheet">
</head><body style="font-family:Poppins; background:#F7F7F7; min-height:100vh; display:flex; align-items:center; justify-content:center;">
<div class="text-center">
<h1 style="font-family:'Playfair Display'; font-size:5rem; color:#854836;">Oops</h1>
<p style="color:#888; font-size:1.1rem;">Something went wrong</p>
<a href="${pageContext.request.contextPath}/" class="btn px-4 py-2" style="background:#000; color:#fff; border-radius:0; letter-spacing:2px; font-size:0.85rem;">GO HOME</a>
</div></body></html>
