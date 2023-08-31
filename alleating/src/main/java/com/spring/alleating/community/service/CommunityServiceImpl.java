package com.spring.alleating.community.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.spring.alleating.community.dao.CommunityDAO;
import com.spring.alleating.community.vo.ReviewBoardVO;
import com.spring.alleating.member.vo.MemberVO;
import com.spring.alleating.order.vo.AllEatingOrderVO;
import com.spring.alleating.product.vo.ProductImgVO;

@Service("communityService")
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	CommunityDAO communityDAO;

	@Override
	public void insertReview(ReviewBoardVO reviewBoardVO) {
		communityDAO.insertReview(reviewBoardVO);
		
		/*
		 * // 이미지파일 이름 및 정보 DB에 등록 ArrayList<ProductImgVO> reviewimgFileList =
		 * reviewBoardVO.getReviewimgFileList(); for (ProductImgVO productImgVO :
		 * reviewimgFileList) { productImgVO.setProductId(reviewBoardVO.getProductId());
		 * communityDAO.insertReviewImg(productImgVO); }
		 */
	   
	}

	 
    
}
	
	

	
	
	

	
	
	


