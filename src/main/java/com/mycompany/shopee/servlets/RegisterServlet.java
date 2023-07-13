
package com.mycompany.shopee.servlets;

import com.mycompany.shopee.entities.User;
import com.mycompany.shopee.helper.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.Transaction;


@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
        
            try {
                String userName =request.getParameter("user_name");
                String userEmail =request.getParameter("user_email");
                String userPassWord =request.getParameter("user_password");
                String userPhone=request.getParameter("user_phone");
                String userAddress =request.getParameter("user_address");
               
                
                HttpSession httpSession = request.getSession();
                
                if(userName.isEmpty()){
                    
                    httpSession.setAttribute("message", "Name is blank");
                    response.sendRedirect("register.jsp");
                    return;
                }
                
                if(userEmail.isEmpty()){
                    httpSession.setAttribute("message", "Email is blank");
                    response.sendRedirect("register.jsp");
                    return;
                }
                
                if(userPassWord.length()<6){
                    httpSession.setAttribute("message", "Invalid Password!");
                    response.sendRedirect("register.jsp");
                    return;
                    
                }
                
                if(userPhone.length()<10){
                   httpSession.setAttribute("message", "Invalid Mobile umber!");
                    response.sendRedirect("register.jsp");
                    return;
                }
                
                if(userAddress.isEmpty()){
                    httpSession.setAttribute("message", "Invalid Address!");
                    response.sendRedirect("register.jsp");
                    return;
                }
                
                
       
                
                // Creating user object to store data
                
                User user = new User(userName, userEmail, userPassWord, userPhone, "default.jpg", userAddress,"normal");
                
                Session hibernateSession = FactoryProvider.getFactory().openSession();
                Transaction tx = hibernateSession.beginTransaction();
                
                int userId = (int) hibernateSession.save(user);
                
         
                
                tx.commit();
                hibernateSession.close();
               
                
                httpSession.setAttribute("message", "Registration Successful!");
                response.sendRedirect("login.jsp");
                return;

            } catch (Exception e) {
                e.printStackTrace();
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
