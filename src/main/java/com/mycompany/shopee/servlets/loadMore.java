/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.shopee.servlets;

import com.mycompany.shopee.dao.ProductDao;
import com.mycompany.shopee.entities.Product;
import com.mycompany.shopee.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


/**
 *
 * @author ADMIN
 */
@WebServlet(name = "loadMore", urlPatterns = {"/loadMore"})
public class loadMore extends HttpServlet {

    private SessionFactory factory;
    
    
    
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int page = Integer.parseInt(request.getParameter("page"));
        int pageSize = 2; // Number of products to fetch per page

        // Retrieve products from the database using Hibernate
        ProductDao p = new ProductDao(FactoryProvider.getFactory());
        List<Product> products =  p.getAllProducts();

        // Convert products to JSON array
        JSONArray jsonArray = new JSONArray();
        for (Product product : products) {
            JSONObject jsonProduct = new JSONObject();
            jsonProduct.put("img", product.getpPhoto());
            jsonProduct.put("name", product.getpName());
            jsonProduct.put("description", product.getpDesc());
            jsonProduct.put("price", product.getpPrice());
            jsonArray.put(jsonProduct);
        }

        // Set the response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Write JSON array to response
        response.getWriter().write(jsonArray.toString());
    }


}
