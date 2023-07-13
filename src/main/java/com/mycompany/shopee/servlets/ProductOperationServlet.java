package com.mycompany.shopee.servlets;

import com.mycompany.shopee.dao.CategoryDao;
import com.mycompany.shopee.dao.ProductDao;
import com.mycompany.shopee.entities.Category;
import com.mycompany.shopee.entities.Product;
import com.mycompany.shopee.helper.FactoryProvider;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "ProductOperationServlet", urlPatterns = {"/ProductOperationServlet"})
public class ProductOperationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDesc");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

               
                response.sendRedirect("admin.jsp");
                return;

            } 
            
            if (op.trim().equals("addproduct")) {

                String productTitle,productDesc ;
                int productPrice,productDiscount,productQuantity;
                
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("productImg");
                
                if (request.getParameter("productTitle") != null) {
                    productTitle = request.getParameter("productTitle");
                } else {
                    productTitle = "";
                }
                  
                if (request.getParameter("productDesc") != null) {
                    productDesc = request.getParameter("productDesc");
                } else {
                    productDesc = "";
                }

                
                if (request.getParameter("productPrice") != null) {
                    productPrice = Integer.parseInt(request.getParameter("productPrice"));
                } else {
                    productPrice = 0;
                }
                
                
                if (request.getParameter("productDiscount") != null) {
                    productDiscount = Integer.parseInt(request.getParameter("productDiscount"));
                } else {
                    productDiscount = 0;
                }
                
                
                
                 if (request.getParameter("productQuantity") != null) {
                    productQuantity = Integer.parseInt(request.getParameter("productQuantity"));
                } else {
                    productQuantity = 0;
                }
                

                Product p = new Product();
                p.setpName(productTitle);
                p.setpDesc(productDesc);
                p.setpPrice(productPrice);
                p.setpQuantity(productQuantity);
                p.setpDiscount(productDiscount);
                p.setpPhoto(part.getSubmittedFileName());

                CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
                Category category = cDao.getCategoryById(catId);

                p.setCategory(category);

                ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
                int pid = pDao.saveProduct(p);
//                out.println("product save success");

//                pic upload
                
                String path = request.getRealPath("img")+File.separator+"products"+File.separator+part.getSubmittedFileName();
                System.out.println(path);
                
                try {
                    
                //uploading code
                FileOutputStream fos = new FileOutputStream(path);
                
                InputStream is = part.getInputStream();
                
//               reading data
                    
                byte[] data = new byte[is.available()];
                
                is.read(data);
                
//                writing data
                fos.write(data);
                
                fos.close();
                
                
                } catch (Exception e) {
                    e.printStackTrace();
                }


                out.println("Product save successfully");
                HttpSession session = request.getSession();
                session.setAttribute("message", "product added successfully!");
                response.sendRedirect("admin.jsp");
               
                return;                        
            }

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
