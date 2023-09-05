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
	
	//후기 등록
	public int insertReview(Map reviewMap)throws DataAccessException;
    public void insertReviewImg(ProductImgVO productImgVO)throws DataAccessException;
    public void updateReviewStatus(Map reviewUpMap)throws DataAccessException;  //상품 후기 업데이트
    //작성한 후기들 목록
    public List<ReviewBoardVO> selectWrittenReview (Map writtenReviewInfo) throws DataAccessException; //작성한 후기 목록 select
    //사용자들 전체 후기 목록
    public List<ReviewBoardVO> selectAllReview (Map allReviewInfo) throws DataAccessException;

}
