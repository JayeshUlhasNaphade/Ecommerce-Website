

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.css">-->
        <title>Login</title>
        <%@include file="components/common_css_js.jsp" %>

        <style>
            * {
                padding: 0;
                margin: 0;
            }
            svg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                box-sizing: border-box;
                display: block;
                /*                background-color: #0e4166;
                                background-image: linear-gradient(to bottom, rgba(14, 65, 102, 0.86), #0e4166);*/


            }
        </style>
    </head>
    <body>



        <svg version="1.1" xmlns="http://www.w3.org/2000/svg"
             xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="100%" height="100%" viewBox="0 0 1600 900" preserveAspectRatio="xMidYMax slice">
        <defs>
        <linearGradient id="bg">
        <stop offset="0%" style="stop-color:rgba(130, 158, 249, 0.06)"></stop>
        <stop offset="50%" style="stop-color:rgba(76, 190, 255, 0.6)"></stop>
        <stop offset="100%" style="stop-color:rgba(115, 209, 72, 0.2)"></stop>
        </linearGradient>
        <path id="wave" fill="url(#bg)" d="M-363.852,502.589c0,0,236.988-41.997,505.475,0
              s371.981,38.998,575.971,0s293.985-39.278,505.474,5.859s493.475,48.368,716.963-4.995v560.106H-363.852V502.589z" />
        </defs>
        <g>
        <use xlink:href='#wave' opacity=".3">
        <animateTransform
            attributeName="transform"
            attributeType="XML"
            type="translate"
            dur="10s"
            calcMode="spline"
            values="270 230; -334 180; 270 230"
            keyTimes="0; .5; 1"
            keySplines="0.42, 0, 0.58, 1.0;0.42, 0, 0.58, 1.0"
            repeatCount="indefinite" />
        </use>
        <use xlink:href='#wave' opacity=".6">
        <animateTransform
            attributeName="transform"
            attributeType="XML"
            type="translate"
            dur="8s"
            calcMode="spline"
            values="-270 230;243 220;-270 230"
            keyTimes="0; .6; 1"
            keySplines="0.42, 0, 0.58, 1.0;0.42, 0, 0.58, 1.0"
            repeatCount="indefinite" />
        </use>
        <use xlink:href='#wave' opacty=".9">
        <animateTransform
            attributeName="transform"
            attributeType="XML"
            type="translate"
            dur="6s"
            calcMode="spline"
            values="0 230;-140 200;0 230"
            keyTimes="0; .4; 1"
            keySplines="0.42, 0, 0.58, 1.0;0.42, 0, 0.58, 1.0"
            repeatCount="indefinite" />
        </use>
        </g>
        </svg>



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

        <div class="container-fluid mt-5"> 
            <div class="row mt-2">
                <div class="col-md-4 offset-md-4">
                    <div class="card bg-transparent border-white-50 ">

                        <div class="card-body cardColor px-5">


                            <%--<%@include  file="components/message.jsp" %>--%>


                            <img src="img/banner-image.png" class="rounded mx-auto d-block" alt="User" width="50%" height="40%">
                            <h3 class="text-center">Welcome to Login<br><br></h3>
                            <form action="LoginServlet" method="post">


                                <div class="form-group mt-3">
                                    <label for="email" class="form-label">User Email</label>
                                    <input name="email" type="email" class="form-control" id="email" placeholder="example@gmail.com" aria-describedby="emailHelp" required>

                                </div>    

                                <div class="form-group mt-3">
                                    <label for="password" class="form-label">User Password</label>
                                    <input name="password" type="password" class="form-control" id="password" placeholder="********" aria-describedby="emailHelp" required>

                                </div>

                                <div class="container mt-3 text-center">
                                    <button  class="btn btn-outline-primary login text-black text-center px-5" onclick="spinner()">Login</button>

                                </div>

                                <br>
                                <p>New to Shopee? <strong><a class="text-decoration-none" href="register.jsp">Create an account</a></strong></p>
                            </form>

                        </div>
                    </div>
                </div>



                <!--                <script src="https://cdn.jsdelivr.net/npm/notyf@3/notyf.min.js">
                                </script>
                
                                <script>
                                    let notyf = new Notyf({
                                    duration: 5000,
                                    dismissible:true,
                                    position: {
                                        x: 'right',
                                        y: 'top',
                                    },
                                    });
                                    notyf.success('Login successful');                   
                                </script>-->

                </body>
                </html>
