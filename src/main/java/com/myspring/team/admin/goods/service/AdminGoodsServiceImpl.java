package com.myspring.team.admin.goods.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import com.myspring.team.admin.goods.dao.AdminGoodsDAO;
import com.myspring.team.goods.vo.GoodsVO;
import com.myspring.team.goods.vo.ImageFileVO;

@Service("adminGoodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class AdminGoodsServiceImpl implements AdminGoodsService {
	@Autowired
	private AdminGoodsDAO adminGoodsDAO;
	
	@Override
	public int addNewGoods(Map newGoodsMap) throws Exception{
		int goods_id = adminGoodsDAO.insertNewGoods(newGoodsMap);
		ArrayList<ImageFileVO> imageFileList = (ArrayList)newGoodsMap.get("imageFileList");
		
		System.out.println("Image File List Size: " + imageFileList.size());

		for(ImageFileVO imageFileVO : imageFileList) {
			imageFileVO.setGoods_id(goods_id);
		}
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
		return goods_id;
	}
	@Override
	public void addNewGoodsImage(List imageFileList) throws Exception{
		adminGoodsDAO.insertGoodsImageFile(imageFileList);
	}
	public List<GoodsVO> getGoodsListByStatus(Map<String, Object> condMap) {
	    return adminGoodsDAO.selectGoodsList(condMap);  // 기존 메서드 그대로 사용
	}
	
	
	public List<GoodsVO> getGoodsListByStatusseller(Map<String, Object> condMap) {
	    return adminGoodsDAO.selectGoodsListseller(condMap);  // 기존 메서드 그대로 사용
	}
	
	public GoodsVO getmodgoodsForm(int goodsId) {
	    // 상품 상세 정보를 가져오기
	    List<GoodsVO> goodsList = adminGoodsDAO.getmodgoodsForm(goodsId);

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
	   // 상품 정보 업데이트
    public void updateGoods(Map<String, Object> updatedGoodsMap) throws Exception {
        adminGoodsDAO.updateGoods(updatedGoodsMap);
    }

    // 이미지 파일 업데이트
    public void updateGoodsImageFile(List<ImageFileVO> imageFileList) throws Exception {
        // 이미지 파일 리스트 확인
        System.out.println("업데이트할 이미지 파일 리스트 크기: " + imageFileList.size());
        for (ImageFileVO file : imageFileList) {
            System.out.println("fileName: " + file.getFileName() + ", fileType: " + file.getFileType() + ", goods_id: " + file.getGoods_id());
        }

        // DAO 호출
        adminGoodsDAO.updateGoodsImageFile(imageFileList);
    }

    // 상품 이미지 파일 삭제
    public void deleteGoodsImage(int goodsId) throws Exception {
        Map<String, Object> deletedGoodsMap = new HashMap<>();
        deletedGoodsMap.put("goods_id", goodsId);
        adminGoodsDAO.deleteGoodsImageFile(deletedGoodsMap); // 상품 이미지 삭제
    }
    public void deleteGoods(Map<String, Object> deletedGoodsMap) throws Exception {
        // 먼저 이미지 파일 삭제
        adminGoodsDAO.deleteGoodsImageFile(deletedGoodsMap);
        
        // 그 다음 상품 정보 삭제
        adminGoodsDAO.deleteGoods(deletedGoodsMap);
    }
    // 상품 검색 메서드
    public List<GoodsVO> searchGoodsByQuery(String searchQuery) {
    	System.out.println("Search query: " + searchQuery);  // 로그 추가
        return adminGoodsDAO.selectGoodsWithMainImage(searchQuery);
    }
    // 상품 상태를 'Y'로 변경하는 메서드
    public void updateGoodsStatusToY(int goods_id) {
        adminGoodsDAO.updateGoodsStatusToY(goods_id);
    }
    
    
    //이포근
    public List<GoodsVO> getGoodsListByStatus2(Map<String, Object> condMap) {
        return adminGoodsDAO.selectGoodsList2(condMap);  // 기존 메서드 그대로 사용
    }
	
	public List<GoodsVO> getGoodsListByStatus3(Map<String, Object> condMap) {
        return adminGoodsDAO.selectGoodsList3(condMap);  // 기존 메서드 그대로 사용
    }
	
	public List<GoodsVO> getGoodsListByStatus4(Map<String, Object> condMap) {
        return adminGoodsDAO.selectGoodsList4(condMap);  // 기존 메서드 그대로 사용
    }
	
	public List<GoodsVO> getSellerGoodsListByStatus2(Map<String, Object> condMap) {
        return adminGoodsDAO.selectSellerGoodsList2(condMap);  // 기존 메서드 그대로 사용
    }
    
    public List<GoodsVO> getSellerGoodsListByStatus3(Map<String, Object> condMap) {
        return adminGoodsDAO.selectSellerGoodsList3(condMap);  // 기존 메서드 그대로 사용
    }
    
    public List<GoodsVO> getSellerGoodsListByStatus4(Map<String, Object> condMap) {
        return adminGoodsDAO.selectSellerGoodsList4(condMap);  // 기존 메서드 그대로 사용
    }
    
}
