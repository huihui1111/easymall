package cn.tedu.easymall.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.tedu.easymall.mapper.ProdMapper;
import cn.tedu.easymall.pojo.Products;

@Service
public class CartServiceImpl implements CartService {

	@Resource
	private ProdMapper prodMapper;

	@Override
	public Products findProdById(String id) {

		return prodMapper.findProdById(id);
	}

}
