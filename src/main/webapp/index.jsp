<%-- 
    Document   : index
    Created on : 27-Apr-2023, 10:44:54 pm
    Author     : ADMIN
--%>
<%@page import="com.mycompany.shopee.helper.Helper"%>
<%@page import="com.mycompany.shopee.entities.Category"%>
<%@page import="com.mycompany.shopee.dao.CategoryDao"%>
<%@page import="com.mycompany.shopee.entities.Product"%>
<%@page import="java.util.*"%>
<%@page import="com.mycompany.shopee.dao.ProductDao"%>
<%@page import="com.mycompany.shopee.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shoppe - Home </title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


        <%@include file="components/common_css_js.jsp" %>





    </head>
    <body>
        <%@include file="components/navbar.jsp" %>


        <div id="spinner-overlay">
            <div id="spinner"></div>
        </div>

        <script>
            window.addEventListener('load', function () {
                var spinnerOverlay = document.getElementById('spinner-overlay');
                // Show the spinner
                spinnerOverlay.style.display = 'flex';
                // Hide the spinner after 5 seconds
                setTimeout(function () {
                    spinnerOverlay.style.display = 'none';
                }, 3000);
            });
        </script>




        <div class="row mt-3 mx-auto">

            <%                String cat = request.getParameter("category");
                int pageno;
                ProductDao p = new ProductDao(FactoryProvider.getFactory());
                List<Product> plist = null;

                int offset = 1;
                int limit = 2;
                if (cat == null || cat.trim().equals("all")) {
                    plist = p.getAllProducts();
                } else {
                    int cid = Integer.parseInt(cat.trim());
                    plist = p.getAllProducts(cid);
                }

                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                List<Category> clist = cDao.getCategories();

                int productId = 0;

            %>



            <!--show categories-->
            <div class="col-md-2 cat" >

                <div class="list-group">

                    <a href="index.jsp?category=all" class="list-group-item list-group-item-action active" aria-current="true">
                        All Products
                    </a>



                    <%                        for (Category category : clist) {
                    %>

                    <a href="index.jsp?category=<%= category.getCategoryId()%>" class="list-group-item list-group-item-action"><%=category.getCategoryTitle()%></a>

                    <%
                        }
                    %>

                </div>
            </div>



            <!--show products-->
            <div class="col-md-9 v1"  >


                <div id="productContainer" class="row row-cols-1 row-cols-md-2 g-4 ml-5">
                    <%
                        for (Product product : plist) {
                    %>
                    <div class="col-md-4 ">
                        <a href="product.jsp?product=<%= product.getpId()%>" class="stretched-link text-decoration-none" >
                            <div class="card h-100 w-70 text-muted ">

                                <img src="img/products/<%= product.getpPhoto()%>" class="card-img-top w-50 rounded mx-auto mt-3 d-block align-item-center" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title fs-6"><%= Helper.get10Words(product.getpName())%></h5>

                                    <p class="card-text"><%= Helper.get10Words(product.getpDesc())%></p>



                                </div>

                                <div class="container align-item-left">
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-fill text-warning"></i>
                                    <i class="bi bi-star-half text-warning"></i>

                                </div>



                                <div class="card-footer d-flex justify-content-between text-center">
                                    <h5 class="text-success align-item-center">&#8377; <%= product.getPriceAfterApplyingDiscount()%>/-  <del>&#8377;<%= product.getpPrice()%></del> </h5>
                                    <button class="btn btn-dark float-end text-white" onclick="add_to_cart(<%= product.getpId()%>,'<%= product.getpName()%>', <%= product.getPriceAfterApplyingDiscount()%> )">Add to cart</button>



                                </div>
                            </div>
                            <%
                                productId = product.getpId();
                            %>
                        </a>
                    </div>
                    <%
                        }

                        if (plist.size() == 0) {

                            out.println("<h5>No Product available.<h5>");

                        }

                    %>

                    
                </div>

                <div class="container load align-item-center mt-5" id="remove_row">
                    <button class="btn btn-success"  data-vid="<%= productId%>"  id="loadMoreBtn">Load More</button>
                </div>
            </div> 
        </div>





 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function () {
            var page = 1;
            
            function loadProducts() {
                $.ajax({
                    url: "loadMore",
                    type: "GET",
                    data: { page: page },
                    dataType: "json",
                    success: function (data) {
                        if (data.length > 0) {
                            var productContainer = $("#productContainer");
                            data.forEach(function (product) {
                                // Create Bootstrap card HTML and append it to productContainer
                                var cardHTML = '<div class="card">' +
                                    '<div class="card-body">' +
                                    '<img src="img/products/'+product.img'" class="card-img-top w-50 rounded mx-auto mt-3 d-block align-item-center" alt="...">'
                                    '<h5 class="card-title">' + product.name + '</h5>' +
                                    '<p class="card-text">' + product.description + '</p>' +
                                    '</div>' +
                                    '</div>';
                                productContainer.append(cardHTML);
                            });
                            page++; // Increment page for the next loadMore request
                        } else {
                            // No more products to load
                            $("#loadMoreBtn").hide();
                        }
                    }
                });
            }
            
            // Trigger loadProducts on page load
            loadProducts();
            
            // Load more products when the "Load More" button is clicked
            $("#loadMoreBtn").click(loadProducts);
        });
    </script>



    </body>
</html>
