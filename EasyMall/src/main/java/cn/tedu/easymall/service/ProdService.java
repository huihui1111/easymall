package cn.tedu.easymall.service;

import java.util.List;

import cn.tedu.easymall.pojo.Products;

public interface ProdService {

	public List<Products> findAllProd();

	public List<Products> findProdUseLimit(String name, String category, double minprice, double maxprice);

	public Products findProdById(String prodId);

	public List<Products> findProdByCate(String category);

	public void deletProd(String[] prodId);

	public void saveProd(Products prod);

	public void update(Products prod);

}
