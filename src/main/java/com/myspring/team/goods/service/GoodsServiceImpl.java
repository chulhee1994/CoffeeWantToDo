package com.myspring.team.goods.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.myspring.team.goods.dao.GoodsDAO;
import com.myspring.team.goods.vo.GoodsVO;

@Service("goodsService")
public class GoodsServiceImpl implements GoodsService{
	@Autowired
	private GoodsDAO goodsDAO;
	public List<GoodsVO> getGoodsListByStatus(Map<String, Object> condMap) {
	    return goodsDAO.selectGoodsList(condMap);  // 기존 메서드 그대로 사용
	}

	 // 상품 상세 정보를 가져오는 메서드
	public GoodsVO getGoodsDetail(int goodsId) {
	    // 상품 상세 정보를 가져오기
	    List<GoodsVO> goodsList = goodsDAO.getGoodsDetail(goodsId);

	    // 이미지 처리용 변수 초기화
	    String mainImage = "";
	    String detailImage1 = "";
	    String detailImage2 = "";
	    String detailImage3 = "";

	    // goodsList가 null이거나 비어 있으면 처리
	    if (goodsList == null || goodsList.isEmpty()) {
	        System.out.println("상품 상세 정보를 찾을 수 없습니다.");
	        return null;  // 상품 정보를 찾을 수 없으므로 null 반환 또는 예외 처리
	    } else {
	        System.out.println("상품 상세 정보를 찾을 수 있습니다.");
	    }

	    // 이미지 리스트를 순회하면서 fileType에 따라 분리
	    for (GoodsVO image : goodsList) {
	        System.out.println("이미지 정보: " + image.getFileType() + ", " + image.getFileName());
	        switch (image.getFileType()) {
	            case "main_image":
	                mainImage = image.getFileName();
	                break;
	            case "detail_image1":
	                detailImage1 = image.getFileName();
	                break;
	            case "detail_image2":
	                detailImage2 = image.getFileName();
	                break;
	            case "detail_image3":
	                detailImage3 = image.getFileName();
	                break;
	        }
	    }

	    // 상품의 이미지를 저장
	    GoodsVO goodsVO = goodsList.get(0);  // 상품은 첫 번째 항목에 이미 포함되어 있으므로 여기를 유지

	    goodsVO.setMainImage(mainImage);
	    goodsVO.setDetailImage1(detailImage1);
	    goodsVO.setDetailImage2(detailImage2);
	    goodsVO.setDetailImage3(detailImage3);

	    // 여기에 필요한 추가 설정이나 반환 로직을 추가

	    return goodsVO;
	}

    // 상품 검색 메서드
    public List<GoodsVO> searchGoodsByQuery(String searchQuery) {
    	System.out.println("Search query: " + searchQuery);  // 로그 추가
        return goodsDAO.selectGoodsWithMainImage(searchQuery);
    }
	// 날씨 정보를 받아서 상품을 검색하는 메서드
    public List<GoodsVO> getGoodsByWeather(String weatherMain) {
    	System.out.println("서비스날씨 정보: " + weatherMain); 
        return goodsDAO.selectGoodsByWeather(weatherMain); // DAO 메서드를 호출하여 결과를 반환
    }
    
    @Override
    public List<GoodsVO> getAllGoods() throws DataAccessException {
        return goodsDAO.selectAllGoods();
    }

    @Override
    public List<GoodsVO> getGoodsBySeller(String sellerId) throws DataAccessException {
        return goodsDAO.selectGoodsBySeller(sellerId);
    }    
}
