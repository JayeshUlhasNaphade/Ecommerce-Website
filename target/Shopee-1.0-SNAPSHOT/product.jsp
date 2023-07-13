<%-- 
    Document   : product
    Created on : 18-Jun-2023, 11:17:38 am
    Author     : ADMIN
--%>
<%@page import="com.mycompany.shopee.helper.Helper"%>
<%@page import="com.mycompany.shopee.entities.Product"%>
<%@page import="com.mycompany.shopee.dao.ProductDao"%>
<%@page import="com.mycompany.shopee.helper.FactoryProvider"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>
        <%
            String pro = request.getParameter("product");

            ProductDao p = new ProductDao(FactoryProvider.getFactory());

            int pid = Integer.parseInt(pro.trim());
            Product list = p.getProductById(pid);

        %>

        <div class="container mt-5 d-flex justify-content-center">
            <div class="col">
                <div class="row-md-15 d-flex justify-content-center">

                    <!-- Product image -->
                    <img src="img/products/<%= list.getpPhoto()%>" alt="Product Image" class="img-fluid">
                </div>
                <div class="row-md-12">
                    <!-- Product details -->
                    <%
                        int rand = (int) ((Math.random() * (6 - 1)) + 1);
                        for (int i = 0; i < rand; i++) {
                    %>
                    <i class="bi bi-star-fill text-warning"></i>
                    <%
                        }
                    %>
                    <h2 class="mt-5"><%= list.getpName()%></h2>
                    <p class="mt-5">
                        <%= list.getpDesc()%>
                    </p>
                    <h4 class="text-success align-item-center mt-5">&#8377; <%= list.getPriceAfterApplyingDiscount()%> /-</h4>

                    <div class="d-flex float-end justify-content-space-evenly">
                        <button class="btn btn-dark float-end text-white ml-5" onclick="add_to_cart(<%= list.getpId()%>,'<%= list.getpName()%>', <%= list.getPriceAfterApplyingDiscount()%>)">Add to cart</button>
                        <button class="btn btn-dark float-end text-white ml-5">Buy</button>

                    </div>

                    <!-- Add any other product information here -->
                </div>
            </div>


    </body>
</html>
