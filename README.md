ShopEase — Online E-Commerce Platform

A full-stack Java web application featuring Admin, Seller, and Buyer dashboards with complete e-commerce functionality.

Built with Java 11+ | Servlets 4.0 | MySQL 8.0 | Bootstrap 5.3

Features

Admin Dashboard
- User Management — Create, edit, delete user accounts
- Product Management — Oversee all product listings
- Order Management — Track and update order statuses
- System Overview — Real-time stats (users, products, orders, revenue)

Seller Dashboard
- Product Listing — Add, edit, delete products with images
- Inventory Management — Low stock alerts, stock updates
- Order Processing — View and fulfill orders
- Sales Analytics — Revenue tracking

Buyer Dashboard
- Product Browsing — Search, filter by category
- Shopping Cart — Add, update, remove items
- Wishlist — Save favorite products with images
- Checkout — Multiple payment options (COD, UPI, Card, Net Banking)
- Order Tracking — Visual status timeline
- Flash Sale Timer — Dynamic discount countdown
- Cookie Consent Popup

Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Java 11+ |
| Web Framework | Java Servlets 4.0, JSP |
| Database | MySQL 8.0 |
| JDBC Driver | MySQL Connector/J |
| Server | Apache Tomcat 9.x |
| Frontend | Bootstrap 5.3, Bootstrap Icons |
| Fonts | Playfair Display, Poppins |
| Architecture | MVC (Model-View-Controller) |

Project Structure

ecommerce-platform/
  database/schema.sql
  images/
  jsp/
    admin/ (dashboard, users, products, orders)
    seller/ (dashboard, products, orders, inventory)
    buyer/ (dashboard, products, cart, checkout, orders, wishlist)
    common/ (header, footer, login, register)
  src/com/ecommerce/
    model/ (User, Product, Order, CartItem, OrderItem)
    dao/ (GenericDAO, UserDAO, ProductDAO, OrderDAO, CartDAO, WishlistDAO)
    servlet/ (LoginServlet, AdminServlet, SellerServlet, BuyerServlet)
    filter/ (AuthFilter)
    util/ (DBConnection)
  WEB-INF/
    classes/
    lib/mysql-connector-j.jar
    web.xml
  index.jsp

How to Run
Live Website: https://whisking-update-drank.ngrok-free.dev/ecommerce-platform/

1. Install Java JDK 11+, MySQL 8.0, Apache Tomcat 9.x
2. Run database/schema.sql in MySQL
3. Update DB credentials in src/com/ecommerce/util/DBConnection.java
4. Place mysql-connector-j.jar in WEB-INF/lib/
5. Copy the project folder to Tomcat webapps/
6. Start Tomcat and open http://localhost:8080/ecommerce-platform/

Demo Accounts

| Role | Email | Password |

| Admin | admin@ecommerce.com | admin123 |
| Seller | seller@test.com | seller123 |
| Buyer | buyer@test.com | buyer123 |


Java Concepts Used

| Concept | Implementation |

| OOP | Encapsulation, Enums (Role, Status), Serializable |
| Generics | GenericDAO interface |
| Collections | ArrayList, List |
| Interfaces | GenericDAO, Serializable, Filter |
| Exception Handling | try-with-resources in DAO layer |
| Singleton | DBConnection class |
| DAO Pattern | Separate data access layer |
| MVC | Model, View, Controller |
| JDBC | PreparedStatements, Transactions, Batch operations |
| Servlets | WebServlet, WebFilter, Session Management |
