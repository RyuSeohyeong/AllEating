package com.spring.alleating.community.dao;



import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.alleating.community.vo.ReviewBoardVO;
import com.spring.alleating.product.vo.ProductImgVO;



@Mapper
@Repository("communityDAO")
public interface CommunityDAO {
	
	public void insertReview(Map reviewMap)throws DataAccessException;
    public void insertReviewImg(ProductImgVO productImgVO)throws DataAccessException;

}
