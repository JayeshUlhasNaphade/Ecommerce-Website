<%@page import="com.mycompany.shopee.entities.User"%>

<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
%>
        <script>
                Toastify({
                text: "Please Login First",
                duration: 3000,
                destination: "https://github.com/apvarun/toastify-js",
                newWindow: true,
                close: true,
                gravity: "top", // `top` or `bottom`
                position: "right", // `left`, `center` or `right`
                stopOnFocus: true, // Prevents dismissing of toast on hover
                style: {
                    background: "linear-gradient(to right, #00b09b, #96c93d)",
                },
                onClick: function () {} // Callback after click
            }).showToast();
        </script>
<%
 
        response.sendRedirect("login.jsp");
        return;

    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CheckOut</title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script> 
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>
        <%@include file="components/navbar.jsp" %>


        <div class="container-fluid">
            <div class="row mt-5">
                <div class="col-md-6">
                    <div  class="card">


                        <div class="card-body">
                            <h3 class="text-center mb-5">Your Cart</h3>

                            <div class="cart-body">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div  class="card">


                        <div class="card-body">
                            <h3 class="text-center mb-5">Your details for order</h3>

                            <form action="#">
                                <div class="form-group">
                                    <label for="email">Email address</label>
                                    <input value="<%= user.getUserEmail() %>" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="name">Your Name</label>
                                    <input Value="<%= user.getUserName() %>" type="text" class="form-control" id="name" aria-describedby="nameHelp" placeholder="Enter name">
                                </div>
                                <div class="form-group">
                                    <label for="mobile">Phone no.</label>
                                    <input Value="<%= user.getUserPhone() %>" type="text" class="form-control" id="mobile" aria-describedby="nameHelp" placeholder="Enter mobile no.">
                                </div>
                                <div class="form-group">
                                    <label for="shippingAddress">Your Shipping Address</label>
                                    <textarea Value="<%= user.getUserAddress() %>" class="form-control" id="shippingAddress" name="shippingAddress" rows="3" placeholder="Enter Address"></textarea>
                                </div>
                                <div class="container text-center">
                                    <button class="btn btn-outline-success button-custom">Order Now</button>
                                    <button class="btn btn-outline-primary">Continue Shopping</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%@include file="components/commons_modal.jsp" %>

    </body>
</html>
