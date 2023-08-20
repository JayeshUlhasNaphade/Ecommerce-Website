<%@page import="com.mycompany.shopee.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.shopee.dao.CategoryDao"%>
<%@page import="com.mycompany.shopee.helper.FactoryProvider"%>
<%@page import="com.mycompany.shopee.entities.User"%>
<%

    User user1 = (User) session.getAttribute("current-user");


%>




<nav class="navbar sticky-top navbar-expand-lg navbar-dark  px-5 ">
    <div class="container-fluid px-5">
        <a class="navbar-brand" href="index.jsp">Shopee</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item px-2">
                    <a class="nav-link" aria-current="page" href="index.jsp">Home</a>
                </li>


                <%                    CategoryDao c = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> list = c.getCategories();
                %>


                <li class="nav-item dropdown px-2">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" 
                       role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categories
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">

                        <%
                            for (Category cat : list) {
                        %>

                        <a href="#" class="list-group-item list-group-item-action"><%=cat.getCategoryTitle()%></a>

                        <%
                            }
                        %>

                    </ul>
                </li>
                <li class="nav-item px-2">
                    <a class="nav-link " href="about.jsp" tabindex="-1">About us</a>
                </li>
            </ul>

            <ul>
                <div class="input-group mt-2">
                    <div class="form-outline" style="width: 70vh;">
                        <input id="search-input" type="search" id="form1" class="form-control " placeholder="search" />

                    </div>
                    <button id="search-button" type="button" class="btn btn-primary button-custom" style="height: min-content;">
                        <i class="bi bi-search"></i>
                    </button>

                </div>
            </ul>

            <ul class="navbar-nav ml-auto">

                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal"  data-bs-target="#cart"> <i class="bi bi-cart" style="width:20px;"></i><span class="cart-items"> (0)</span></a>
                </li>
                <%
                    if (user1 == null) {

                %>

                <li class="nav-item">
                    <a class="nav-link"  href="login.jsp">Login</a>
                </li>

                <%            } else {

                %>  



                <li class="nav-item dropdown px-2">
                    <a class="nav-link dropdown-toggle" href="<%= user1.getUserType().equals("admin")? "admin.jsp":"index.jsp"  %>" id="navbarDropdown" role="button" data-bs-toggle="dropdown" >
                        <%= user1.getUserName()%>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="nav-link.active dropdown-item "  href="LogoutServlet">LogOut</a></li>

                    </ul>
                </li>

                <%
                    }
                %>





            </ul>

        </div>
    </div>
</nav>

<!--
<nav class="navbar sticky-top navbar-expand-lg navbar-dark bg-dark px-5 ">
  <div class="container-fluid px-5">
    <a class="navbar-brand" href="#">Shopee</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
       <ul class="navbar-nav me-auto mb-2 mb-lg-0">
           <li class="nav-item px-2">
          <a class="nav-link " aria-current="page" href="index.jsp">Home</a>
        </li>
        
        <li class="nav-item dropdown px-2">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" 
             role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Categories
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
            <li><a class="dropdown-item" href="#">Action</a></li>
            <li><a class="dropdown-item" href="#">Another action</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="#">Something else here</a></li>
          </ul>
        </li>
        <li class="nav-item px-2">
          <a class="nav-link" href="about.jsp" tabindex="-1">About us</a>
        </li>
      </ul>
         <ul class="navbar-nav ml-auto">
          <li class="nav-item custom">
              <a class="nav-link"  href="login.jsp">Login</a>
           </li>
          
        </ul>
     
    </div>
  </div>
</nav>-->