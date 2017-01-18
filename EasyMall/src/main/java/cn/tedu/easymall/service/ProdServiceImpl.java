package cn.tedu.easymall.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.tedu.easymall.mapper.ProdMapper;
import cn.tedu.easymall.pojo.Products;

@Service
public class ProdServiceImpl implements ProdService {

	@Resource
	private ProdMapper prodMapper;

	@Override
	public List<Products> findAllProd() {
		return prodMapper.findAllProd();
	}

	@Override
	public List<Products> findProdUseLimit(String name, String category, double minprice, double maxprice) {
		return prodMapper.findProdUseLimit(name, category, minprice, maxprice);
	}

	@Override
	public Products findProdById(String prodId) {
		return prodMapper.findProdById(prodId);
	}

	@Override
	public List<Products> findProdByCate(String category) {
		return prodMapper.findProdByCate(category);
	}

	@Override
	public void deletProd(String[] prodId) {
		for (String productId : prodId) {
			prodMapper.deletProd(productId);
		}
	}

	@Override
	public void saveProd(Products prod) {
		prodMapper.saveProd(prod);
	}

	@Override
	public void update(Products prod) {
		prodMapper.update(prod);
	}

}
