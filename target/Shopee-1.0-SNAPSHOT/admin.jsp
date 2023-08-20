<%@page import="java.util.Map"%>
<%@page import="com.mycompany.shopee.helper.Helper"%>
<%@page import="com.mycompany.shopee.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.shopee.helper.FactoryProvider"%>
<%@page import="com.mycompany.shopee.dao.CategoryDao"%>
<%@page import="com.mycompany.shopee.entities.User"%>
<%

    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You have not logged In!");
        response.sendRedirect("login.jsp");
        return;

    } else {

        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not an ADMIN!");
            response.sendRedirect("login.jsp");
            return;
        }

    }


    Map<String,Long> m = Helper.getCounts(FactoryProvider.getFactory());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body class="bg-admin">
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
        <div class="container admin">

            <%@include  file="components/message.jsp" %>
            <div class="row pt-5">
                <!-- first -->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded" src="img/multiple-user.png" width="50%" height="50%" alt="alt"/>
                            </div>


                            <br>
                            <h2><%= m.get("userCount")%></h2>
                            <h3 class="text-uppercase text-muted">Users</h3>


                        </div>
                    </div>




                </div>

                <!-- second -->
                <div class="col-md-4">


                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded" src="img/categories.png" width="50%" height="50%" alt="alt"/>
                            </div>

                            <br>
                            <h2><%= list.size()%></h2>
                            <h3 class="text-uppercase text-muted">Categories</h3>


                        </div>
                    </div>

                </div>

                <!-- Third -->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded" src="img/products.png" width="50%" height="50%" alt="alt"/>
                            </div>

                            <br>
                            <h2><%= m.get("productCount")%></h2>
                            <h3 class="text-uppercase text-muted">Products</h3>

                            </div>
                    </div>

                </div>
            </div>


            <!-- second row -->

            <div class="row py-5">
                <!-- first -->
                <div class="col-md-4">

                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded" src="img/add-user.png" width="50%" height="50%" alt="alt"/>
                            </div>


                            <br>
                            <p> click here to add an admin.</p>
                            <h3 class="text-uppercase text-muted">Add Admin</h3>


                        </div>
                    </div>
                </div>

                <!-- second -->
                <div class="col-md-4">


                    <div class="card" data-bs-toggle="modal" data-bs-target="#add-category-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded" src="img/add-categories.png" width="50%" height="50%" alt="alt"/>
                            </div>

                            <br>
                            <p> click here to add new categories </p>
                            <h3 class="text-uppercase text-muted">Add Categories</h3>


                        </div>
                    </div>

                </div>

                <!-- Third -->
                <div class="col-md-4">

                    <div class="card"  data-bs-toggle="modal"  data-bs-target="#add-product-modal">
                        <div class="card-body text-center">

                            <div class="container">
                                <img style="max-width: 125px" class="img-fluid rounded" src="img/add-product.png" width="50%" height="50%" alt="alt"/>
                            </div>

                            <br>
                            <p> click here to add new products.</p>
                            <h3 class="text-uppercase text-muted">Add Products</h3>


                        </div>
                    </div>

                </div>
            </div>

        </div>


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="add-category-modalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-custom text-white">
                        <h5 class="modal-title " id="exampleModalLabel">Fill Category Details</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post">

                            <input type ="hidden" name="operation" value="addcategory"/>

                            <div class="form-group pt-2">  
                                <label for="catTitle" class="form-label">Category Title :</label>
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter Category Title" required/>

                            </div>  

                            <div class="form-group pt-3" >
                                <label for="catDesc" class="form-label">Category Description :</label>
                                <textarea style="height:250px" class="form-control" placeholder="Enter category Description" name="catDesc" required></textarea>

                            </div>  
                            
                            <hr>

                            <div class="container text-center py-3">

                                <button type="submit" class="btn btn-outline-success button-custom">Add Category</button>
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                            </div>

                        </form>


                    </div>
                    <!--                    <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                            <button type="button" class="btn btn-primary">Save changes</button>
                                        </div>-->
                </div>
            </div>
        </div>


        <!--product-->
        <div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="add-product-modalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-custom text-white">
                        <h5 class="modal-title " id="exampleModalLabel">Fill Product Details</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type ="hidden" name="operation" value="addproduct"/>

                            <div class="form-group pt-2">  
                                <label for="productTitle" class="form-label">Product Title :</label>
                                <input type="text" class="form-control" name="productTitle" placeholder="Enter Product Title" required/>

                            </div>  

                            <div class="form-group pt-3" >
                                <label for="productDesc" class="form-label">Product Description :</label>
                                <textarea style="height:70px" class="form-control" placeholder="Enter Product Description" name="productDesc" required></textarea>

                            </div>  

                            <div class="form-group pt-2">  
                                <label for="productPrice" >Product Price :</label>
                                <input type="text" class="form-control" name="productPrice" placeholder="Enter Product Price" required/>
                            </div>  

                            <div class="form-group pt-2">  
                                <label for="productDiscount" class="form-label">Product Discount :</label>
                                <input type="text" class="form-control" name="productDiscount" placeholder="Enter Product Discount" required/>
                            </div>  

                            <div class="form-group pt2">  
                                <label for="productQuantity" class="form-label">Product Quantity :</label>
                                <input type="text" class="form-control" name="productQuantity" placeholder="Enter Product Quantity" required/>
                            </div>  
                            
                            <%
                                
                                //CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                               //List<Category> list = cDao.getCategories();
                                
                            %>
                            

                            <div class=" mb-3 row pt-2">  
                                <label for="productCategory" class="col-sm-2 col-form-label">Category :</label>
                               
                                <div class="col-sm-10">
                                    <select name="catId" id="" class="form-select" aria-label="Default select example">
                                        <%
                                            
                                            for(Category cat:list){
                                        %>
                                        
                                        
                                        <option value="<%= cat.getCategoryId() %>"><%= cat.getCategoryTitle() %></option>
                                       
                                        <%
                                            }
                                        %>
                                        
                                    </select>
                                </div>

                            </div> 
                            
                            <div class="form-group pt-2">  
                                <label for="productImg">Product Image : </label>
                                <input type="file" name="productImg" id="productImg" placeholder="Enter Product Quantity" required/>
                            </div>  
                            
                            <hr>

                            <div class="container text-center py-3">

                                <button type="submit" class="btn btn-outline-success button-custom">Add product</button>
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
                            </div>



                        </form>


                    </div>                    
                </div>
            </div>
        </div>
                                        
                                        
        <%@include file="components/commons_modal.jsp" %>
        
    </body>
</html>
