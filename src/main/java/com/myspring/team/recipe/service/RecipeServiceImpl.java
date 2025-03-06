package com.myspring.team.recipe.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.order.dao.OrderDAO;
import com.myspring.team.recipe.dao.RecipeDAO;
import com.myspring.team.recipe.vo.CommentVO;
import com.myspring.team.recipe.vo.ImageFileVO;
import com.myspring.team.recipe.vo.RecipeVO;

@Service("recipeService")
@Transactional(rollbackFor = Exception.class) // 트랜잭션 적용 및 예외 시 롤백
public class RecipeServiceImpl implements RecipeService {

	@Autowired
	private RecipeDAO recipeDAO;
	

	@Override
	public Map recipeLists(Map pagingMap) throws DataAccessException {
		
		Map recipesMap = new HashMap();
		List<RecipeVO> recipesList = recipeDAO.recipeLists(pagingMap);
		
		int toRecipes = recipeDAO.selectToRecipes();
		recipesMap.put("recipesList", recipesList);
		recipesMap.put("toRecipes", toRecipes);
		return recipesMap;
	}

	 @Override
	 public Map searchRecipeLists(Map searchMap) throws DataAccessException {
		Map<String, Object> recipesMap = new HashMap<>();
		List<RecipeVO> recipesList = recipeDAO.searchRecipeLists(searchMap);
		
		int toSearchRecipes = recipeDAO.selectSearchToRecipes(searchMap);
		
		recipesMap.put("recipesList", recipesList);
		recipesMap.put("toRecipes", toSearchRecipes);
		recipesMap.put("section",searchMap.get("section"));
		recipesMap.put("pageNum", searchMap.get("pageNum"));
		
		 return recipesMap;
	    }
	 
	 @Override
		public Map<String, Object> getRecipesList(Map<String, Object> searchMap) {
		 Map<String, Object> recipesMap = new HashMap<>();
		 
		 List<RecipeVO> recipesList = recipeDAO.getRecipesByGoodsId(searchMap);
		 int getToRecipes = recipeDAO.getToRecipes(searchMap);
		 
		 recipesMap.put("recipesList", recipesList);
		 recipesMap.put("getToRecipes", getToRecipes);
		 recipesMap.put("recipe_section", searchMap.get("recipe_section"));
		 recipesMap.put("recipe_pageNum", searchMap.get("recipe_pageNum"));
		 
		 return recipesMap;
		}
	 
	
	@Override
	public RecipeVO viewRecipe(int recipe_no) throws DataAccessException {
		return recipeDAO.viewRecipe(recipe_no);
	}
	@Override
	public List<ImageFileVO> viewRecipeImages(int recipe_no) throws DataAccessException{
	    return recipeDAO.viewRecipeImages(recipe_no);
	}

	@Override
	public int addRecipe(Map recipesMap) throws DataAccessException {
		return recipeDAO.addRecipe(recipesMap);
	}
	
    @Override
    public void addRecipeImage(Map<String, Object> imageMap) throws DataAccessException {
        recipeDAO.addRecipeImage(imageMap);
    }
	
    @Override
    public void deleteRecipe(int recipe_no, String imagePath) throws DataAccessException {
        // 댓글 및 답글 삭제
        recipeDAO.deleteRecipeComment(recipe_no);
        
        //레시피ㅣ 이미지 테이블에 있는 이름 삭제
        recipeDAO.deleteRecipeImageNames(recipe_no);
        
        // 레시피 게시글 삭제
        recipeDAO.deleteRecipe(recipe_no);
        
        // 이미지 파일 및 폴더 삭제
        try {
			recipeDAO.deleteRecipeImages(imagePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
        
    }
	@Override
	public Map<String, Object> viewRecipeComment(Map pagingMap) throws DataAccessException {
		Map<String, Object> commentsMap = new HashMap<>();
		
		List<CommentVO> commentsList = recipeDAO.viewRecipeComment(pagingMap);
		int toComments = recipeDAO.selectToComments((int) pagingMap.get("recipe_no"));
		
		commentsMap.put("commentsList", commentsList);
		commentsMap.put("toComments", toComments);
		return commentsMap;
	}
	// 댓글 추가
	@Override
    public boolean addComment(CommentVO comment) throws DataAccessException {
        return recipeDAO.insertComment(comment) > 0;
    }
	
    @Override
    public boolean addReplyComment(CommentVO commentVO) throws DataAccessException {
        int result = recipeDAO.insertReplyComment(commentVO);
        return result > 0;
    }
    // 가장 최근 추가된 댓글 조회
	@Override
	public CommentVO getLatestComment(int recipe_no) throws DataAccessException {
	    CommentVO comment = recipeDAO.getLatestComment(recipe_no);
	    return comment;
	}

    // 특정 레시피의 전체 댓글 조회
	@Override
    public List<CommentVO> getCommentsByRecipe(int recipe_no) throws DataAccessException{
        return recipeDAO.getCommentsByRecipe(recipe_no);
    }
	
	@Override
	public Map<String, Object> getSortedComments(Map<String, Object> pagingMap) throws DataAccessException{
	    return recipeDAO.getSortedComments(pagingMap);
	}
	@Override
	public boolean markCommentAsDeleted(int comment_no) throws DataAccessException {
	    return recipeDAO.markCommentAsDeleted(comment_no);
	}
	
	@Override
    public CommentVO updateComment(int commentNo, String action) throws DataAccessException{
        if ("like".equals(action)) {
            recipeDAO.updateLike(commentNo);
        } else if ("dislike".equals(action)) {
        	recipeDAO.updateDislike(commentNo);
        }
        return recipeDAO.getComment(commentNo); // 업데이트된 데이터 반환
    }
	
	@Override
	public CommentVO modComment(int commentNo, String comment_content) throws DataAccessException{
		return recipeDAO.modComment(commentNo,comment_content);
	}
	/*
	 * 					댓글 기능
	 * 
	 * 
	 * */

	@Override
	public void updateRecipe(Map updateMap) throws DataAccessException {
		recipeDAO.updateRecipe(updateMap);
	}

	@Override
	public void deleteRecipeImage(int recipe_no, String fileName) throws DataAccessException {
		recipeDAO.deleteRecipeImage(recipe_no,fileName);
	}

	@Override
	public void updateViews(int recipe_no) throws DataAccessException {
		recipeDAO.updateViews(recipe_no);
	}

	
}
