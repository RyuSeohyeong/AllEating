<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    <% request.setCharacterEncoding("utf-8"); %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
    <c:set var="userProductVO" value="${userProductInfo.userProductVO}" /><!--상품정보-->
<c:set var="userProductImglist" value="${userProductInfo.userProductImglist}" /><!--이미지리스트-->
<c:set var="userVO" value="${userProductInfo.userVO}" /><!--사업자리스트-->
    
<!DOCTYPE html>
<html>
<head>


    <title>상품 상세페이지</title>
<link href="${contextPath}/css/product_detail_01.css" rel="stylesheet" type="text/css" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
var bDisplay = true;
function doDisplay(){
    var con = document.getElementById("toDisplay");
    if(con.style.display == "none"){
        con.style.display = "block";
    } else {
        con.style.display = "none";
    }
}

</script>


</head>
<body>




<div class="css-16c0d8l">
<main id="productinfo" class="productinfocss">
<div class="imagefood">

               <c:forEach var="pimg" items="${userProductImglist}">
                <c:if test="${pimg.fileType =='main_image'}">
                  <img src="${contextPath}/download.do?fileName=${pimg.fileName}&productId=${userProductVO.productId}&cateCode=${userProductVO.cateCode}" alt="${pimg.fileName}" width="300px" height="300px">
                </c:if>
            </c:forEach>
</div>
<div id="list">
<section class="listcss">
<div class="listcss-1"> <c:choose>
         <c:when test="${userProductVO.deliveryType == 'reserve' }"> 예약배송<img src="${contextPath }/img/image_logo/thunder.png" style="width:20px;height:20px;">
         </c:when> 
        <c:when test="${userProductVO.deliveryType == 'normal' }"> 일반배송
         </c:when>
         </c:choose>
<h1 class="listcss-2"> 
        <c:choose>
         <c:when test="${userProductVO.deliveryType == 'reserve' }">[All Eating]
         </c:when>
        <c:when test="${userProductVO.deliveryType == 'normal' }">[${userProductVO.productBrand}]
         </c:when>
         </c:choose>
                   ${userProductVO.productName} </h1>
                   
                   
                   <div class="sale_text">  
                    <c:choose>
                    <c:when test="${userProductVO.productDiscount != 0}">
                 
                   <div class="sale_text_1" >${userProductVO.productDiscount}%</div>
                   <div class="sale_text_2">${userProductVO.productPrice}원</div>
                   <div class="sale_result"> ${userProductVO.productSalesPrice}원 </div> </c:when>
                   
                   <c:otherwise> <h6 class="sale_text_2">${userProductVO.productPrice}원</h6></c:otherwise>
                   </c:choose>
                  </div> 

</div>
<div class="listcss-5">로그인 후, 적립 혜택이 제공됩니다.</div>


<div class="list">
<dl class="dlcss" id="dlcss-2">
<dt class="listcss-6">배송</dt>
<dd class="listcss-7">
<p><c:choose>
         <c:when test="${userProductVO.deliveryType == 'reserve' }">21시 전 주문 시 내일 아침 7시 전 도착
         </c:when>
        <c:when test="${userProductVO.deliveryType == 'normal' }">택배 배송
         </c:when>
         </c:choose>

</p>
</dd>
</dl>

<dl class="dlcss">
<dt class="listcss-6">판매자</dt>
<dd class="listcss-7">
<p>${userVO.owner_name}</p>
</dd>
</dl>

<dl class="dlcss">
<dt class="listcss-6">포장타입</dt>
<dd class="listcss-7">
<p>${userProductVO.productPackType }</p>
</dd>
</dl>

<dl class="dlcss">
<dt class="listcss-6">판매단위</dt>
<dd class="listcss-7">
<p>${userProductVO.productUnit }</p>
</dd>
</dl>

<dl class="dlcss">
<dt class="listcss-6">중량/용량</dt>
<dd class="listcss-7">
<p>${userProductVO.productWeight}</p>
</dd>
</dl>

<dl class="dlcss">
<dt class="listcss-6">원산지</dt>
<dd class="listcss-7">
<p>${userProductVO.productOrigin}</p>
</dd>
</dl>

<dl class="dlcss">
<dt class="listcss-6">유통기한</dt>
<dd class="listcss-7">
<p>${userProductVO.productExpireDate}</p>
</dd>
</dl>

<div class="choice">
<div class="choice-1">
<dl class="choice-2">
<dt class="choice-3">상품 선택</dt>
<dd class="choice-4">
<div class="choice-5">
<div class="choice-6">
<span class="choice-7"> [${userProductVO.productBrand}] ${userProductVO.productName}</span>
</div>
<div class="choice-8">
<div class="choice-9">
<button type="button" aria-label="수량내리기" disabled class="choicebutton-down"></button>
<div class="choice-10">1</div>
<button type="button" aria-label="수량올리기"  class="choicebutton-up"></button>
</div>
<div class="choice-11">
<span class="choice-12">13,900</span><span class="choice-12">원</span>
<span class="choice-13">11,610</span><span class="choice-13">원</span>
</div>
</div>
</div>
</dd>
</dl>
</div>





</div>

<div class="choice-cart-Info">
    <div class="choice-cart" >
        <div class="choice-cart-2"  id="toDisplay" style="display:none;">
        <div class="choice-cart-text">
             <h6 class="choice-cart-text-content">상품을 장바구니에 담았습니다.</h6>
        </div>
        <div class="choice-button">
        <button type="button" class="choice-button-view" onclick="location.href='${contextPath}/product/product_01.do'">쇼핑 계속하기</button>
        <button type="button" class="choice-button-view" onclick="location.href='${contextPath}/cart/myCart.do'">장바구니 가기</button>
        </div>
        </div> 
    </div>
</div>
<div class="total">
<div class="total-2">
<div class="total-3">
<span class="total-4">총 금액: </span>
<span class="total-4">0</span>
<span class="total-4">원</span>
</div>


</div>
</div>
<div class="circle">
<span class="circle-2">적립</span>
<span class="circle-3">구매 시 </span>
<span class="circle-3">0원</span>
<span class="circle-3">적립</span>
</div>

<div class="result">
<button type="button" class="resultbutton" width="56" height="56" radius="3">
<span class="heart">
<img src="${contextPath}/img/image_logo/heart_icon.png" class="heartimg">
</span>
</button>
<div class="cart">
<button type="button"   radius="3" class="cartbutton" onclick="doDisplay()">
<span class="cart-2">장바구니 담기</span>
</button>
 <div class="buy">
<button type="button"  radius="3" class="buybutton" onclick="location.href='${contextPath}/cart/pay_01.do'">
<span class="buy-2">구매하기</span>
</button>
 </div>
</div>

</div>
</div>
</section>
</div>

</main>
</div>



<div class="how">
<span>이런 상품은 어떠신가요</span>
<div class="how-1" >
<div class="how-2">
<img src="${contextPath}/img/image_food/mygumi.jpg" width="300" height="300">
<div class="howname">[오리온] 마이구미 청포도 번들팩(43.2g X 6봉지)</div>
<div class="howname">2,980원</div>
</div>



<div class="how-3" >
<img src="${contextPath}/img/image_food/sparklling.jpg" width="300" height="300">
<div class="howname">[KF365]무라벨 청포도알로에 스파클링(350ml X 24개)</div>
<div class="howname">11,900원</div>
</div>



<div class="how-4">
<img src="${contextPath}/img/image_food/vitajelly.jpg" width="300" height="300">
<div class="howname">[올키] 비타젤리 청포도맛(15일분)</div>
<div class="howname">12,900원</div>
</div>



</div>


</div>


<nav class="info">
<ul class="info-2" id="info-6">
<li class="info-3">
<a class="info-4">
<span class="info-5">상품설명</span>
</a>
</li>
<li class="info-3">
<a class="info-4">
<span class="info-5">상세정보</span>
</a>
</li>
<li class="info-3">
<a class="info-4">
<span class="info-5">후기</span>
</a>
</li>
<li class="info-3">
<a class="info-4">
<span class="info-5">상품문의</span>
</a>
</li>
</ul>
</nav>

<div class="homp">
<div class="homp-2" id="description">
<div class="homp-3">
<div class="homp-4">
<div class="goods-wrap">
<div class="goods-intro">
<div class="pic">
<c:forEach var="pimg" items="${userProductImglist}"> 
                <c:if test="${pimg.fileType =='detail_image1'}">
                  <img src="${contextPath}/download.do?fileName=${pimg.fileName}&productId=${userProductVO.productId}&cateCode=${userProductVO.cateCode}" alt="${pimg.fileName}" width="300px" height="300px">
                </c:if>
            </c:forEach>
<div class="context-last">
   <small>${userProductVO.productContentTitle}</small>
    <h3><c:choose>
         <c:when test="${userProductVO.deliveryType == 'reserve' }">[All Eating]
         </c:when>
        <c:when test="${userProductVO.deliveryType == 'normal' }">[${userProductVO.productBrand}]
         </c:when>
         </c:choose>
                   ${userProductVO.productName}</h3>
    <hr>
    <p>${userProductVO.productContent}</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>




</body>
</html>