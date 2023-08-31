package com.spring.alleating.community.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.support.AbstractMultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.alleating.common.base.BaseController;
import com.spring.alleating.community.service.CommunityService;
import com.spring.alleating.community.vo.ReviewBoardVO;
import com.spring.alleating.member.vo.MemberVO;
import com.spring.alleating.product.vo.ProductImgVO;
import com.spring.alleating.product.vo.ProductVO;

@Controller("communityController")
public class CommunityControllerImpl  implements CommunityController {
	private static final String REVIEW_IMAGE_REPO = "C:\\alleating\\review_image_repo";
	@Autowired
	CommunityService communityService;
	
	
	@Autowired 
	ReviewBoardVO reviewBoardVO;
	@Override
	@RequestMapping(value= "/community/review_01.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ModelAndView review_01(HttpServletRequest request, HttpServletResponse response)throws Exception {
		HttpSession session = request.getSession();
		session.setAttribute("side_menuType", "review_01");
		
		String viewName = (String)request.getAttribute("viewName");
		System.out.println(viewName); 
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(viewName); //add
		return mav;
	}

	
/////////////////////////////////// 게시물 작성 페이지로 이동하기/////////////////
	@Override
	public String addreview(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session  = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
		String id= memberVO.getId();
		
		String productId = request.getParameter("productId");
		int _productId = Integer.parseInt(productId);
		
		String viewName = (String)request.getAttribute("viewName");	
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("productId", _productId);
		mav.setViewName(viewName);
		return viewName; 
		
	
	}
	
	//////////////////////////////게시물 작성 ////////////////////////////
	
	

	@Override
	@RequestMapping(value="/myPage/completeReview.do", method = { RequestMethod.POST, RequestMethod.GET })
	public ResponseEntity completeReview( MultipartHttpServletRequest multipartRequest, HttpServletResponse response) throws Exception {
		
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			reviewMap.put(name, value);
		}
		String imageFileName = upload(multipartRequest);
		String id= (String) reviewMap.get("id");
		String productId = (String) reviewMap.get("productId");
		/* int _productId = Integer.parseInt(productId); */
		String productName =  (String) reviewMap.get("productName");
		String content = (String) reviewMap.get("content");
		String productBrand = (String) reviewMap.get("productBrand");
		
		Map zzMap = new HashMap<>();
		zzMap.put("id", id);
		zzMap.put("productId", productId);
		zzMap.put("productName", productName);
		zzMap.put("content", content);
		zzMap.put("productBrand", productBrand);
	     
	     		
		
	
		
		  
		/* reviewMap.put("id", _id); */
		/*
		 * reviewMap.put("productId", _productId); reviewMap.put("content", content);
		 * reviewMap.put("productBrand", productBrand); reviewMap.put("productName",
		 * productName);
		 */
		
		/* String id = (String) reviewMap.get("id"); */
		
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		try {
			/* int articleNO = communityService.insertReview(zzMap); */
	
			if (imageFileName != null && imageFileName.length() != 0) {
				File srcFile = new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
				File destDir = new File(REVIEW_IMAGE_REPO + "\\" + id);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			}
			message = "<script>";
			message += " alert('성공');";
			message += " location.href='" + multipartRequest.getContextPath() + "/myPage/myPage_review.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			File srcFile = new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
			srcFile.delete();

			message = " <script>";
			message += " alert('실패'); ";
			message += " location.href='" + multipartRequest.getContextPath() + "/myPage/myPage_review.do'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;

	}
	
    

		//upload method
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		String imageFileName = null;

		Iterator<String> fileNames = multipartRequest.getFileNames();
		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			imageFileName = mFile.getOriginalFilename();
			File file = new File(REVIEW_IMAGE_REPO + "\\" + fileName);
			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					if (file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName));
			}
		}
		return imageFileName;
	}
		
	
	}
	
		



	




	

	


	
	
	
	