/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.shopee.dao;

import com.mycompany.shopee.entities.Product;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

/**
 *
 * @author ADMIN
 */
public class ProductDao {
    private SessionFactory factory;
    public int page =0;
    List<Product> list=null;
 
    
    public ProductDao(SessionFactory factory){
        this.factory = factory;
    }
    
    
    public int saveProduct(Product product){
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        
        int productId = (int) session.save(product);
        tx.commit();
        session.close();
        
        return productId;
    }
    
    
   public int page(){
        page++;
        return page;
  }
    
    public List<Product> getAllProducts(){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product");
        list = query.list();    
        return list;
    } 
    
    //get all product of given category
    public List<Product> getAllProducts(int cid){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product as p where category.categoryId =: id");
        query.setParameter("id", cid);
        list =  query.list();
        return list;
    } 
    
  
   
    
    public List<Product> getProducts(int id){
        
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product WHERE product.pId >: id");
        query.setParameter("id", id);
        query.setMaxResults(2);
        List<Product> list = query.list();
        return list;
    } 
    
    
    // give specific product details 
    public Product getProductById(int pid){
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Product WHERE pId =: id");
        query.setParameter("id", pid);
       
        Product product = (Product) query.uniqueResult();
        return product;
    } 
    
}
