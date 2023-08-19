package com.spring.alleating.owner.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;


import com.spring.alleating.owner.product.dao.OwnerProductDAO;
import com.spring.alleating.product.vo.ProductImgVO;
import com.spring.alleating.product.vo.ProductVO;

@Service("ownerProductService")

public class OwnerProductServiceImpl implements OwnerProductService {

	@Autowired
	private OwnerProductDAO ownerProductDAO;
	
	@Override
	public int addNewProduct(Map newProductMap) throws Exception{
		double num = Math.random();
		int productId = (int)(num * 899999);
		
		ownerProductDAO.insertNewProduct(newProductMap);
		ArrayList<ProductImgVO> imageFileList = (ArrayList)newProductMap.get("imageFileList");
		for(ProductImgVO productImgVO : imageFileList) {
			productImgVO.setProductId(productId);
		}
	
		
		
		ownerProductDAO.insertProductImageFile(imageFileList);
		return productId;
	}
	
	
	@Override
	public Map productDetail(int productId) throws Exception {
		Map productMap = new HashMap();
		ProductVO productVO=ownerProductDAO.selectProductDetail(productId);
		List imageFileList =ownerProductDAO.selectProductImageFileList(productId);
		productMap.put("product", productVO);
		productMap.put("imageFileList", imageFileList);
		return productMap;
	}
	
	@Override
	public List productImageFile(int productId) throws Exception{
		List imageList =ownerProductDAO.selectProductImageFileList(productId);
		return imageList;
	}
	

	
	
	



	
	@Override
	public void addNewProductImg(List imageFileList) throws Exception {
		ownerProductDAO.insertProductImageFile(imageFileList);
		
	}


	/*
	 * @Override public int addProduct(Map productMap) throws Exception {
	 * 
	 * double num = Math.random(); int productId = (int)(num * 899999);
	 * 
	 * 
	 * ownerProductDAO.insertProduct(productMap);
	 * 
	 * 
	 * return productId; }
	 */
	
	




		
	}



	

