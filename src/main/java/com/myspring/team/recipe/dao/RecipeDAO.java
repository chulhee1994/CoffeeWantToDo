package com.myspring.team.recipe.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.recipe.vo.CommentVO;
import com.myspring.team.recipe.vo.ImageFileVO;
import com.myspring.team.recipe.vo.RecipeVO;
import com.myspring.team.review.vo.ReviewVO;

public interface RecipeDAO {

	//전체 레시피 리스트 출력
	public List<RecipeVO> recipeLists(Map pagingMap) throws DataAccessException;	
	public List<RecipeVO> searchRecipeLists(Map searchMap) throws DataAccessException;
	
	//게시글 갯수 정해서 가져오기
	public int selectToRecipes() throws DataAccessException;
	public int selectSearchToRecipes(Map searchMap) throws DataAccessException;
	
	public int getToRecipes(Map<String, Object> searchMap) throws DataAccessException;
	public List<RecipeVO> getRecipesByGoodsId(Map<String, Object> searchMap) throws DataAccessException;
	
	//레시피 글 작성
	public int addRecipe(Map recipesMap) throws DataAccessException;
	
	public void updateRecipe(Map updateMap) throws DataAccessException;
	public RecipeVO viewRecipe(int recipe_no) throws DataAccessException;
	public List<ImageFileVO> viewRecipeImages(int recipe_no) throws DataAccessException;

	public List<CommentVO> viewRecipeComment(Map pagingMap) throws DataAccessException;
	

	public int selectToComments(int recipe_no) throws DataAccessException;

	
		// 댓글 추가
		public int insertComment(CommentVO comment) throws DataAccessException;

		// 가장 최근 추가된 댓글 조회
		public CommentVO getLatestComment(int recipe_no) throws DataAccessException;

		// 특정 레시피의 모든 댓글 조회
		public List<CommentVO> getCommentsByRecipe(int recipe_no) throws DataAccessException;

		public Map<String, Object> getSortedComments(Map<String, Object> pagingMap) throws DataAccessException;

		public void addRecipeImage(Map<String, Object> imageMap) throws DataAccessException;

		public void deleteRecipe(int recipe_no) throws DataAccessException;
		public void deleteRecipeComment(int recipe_no) throws DataAccessException;
		public void deleteRecipeImageNames(int recipe_no) throws DataAccessException;
		public void deleteRecipeImages(String imagePath) throws Exception;

		public boolean markCommentAsDeleted(int comment_no) throws DataAccessException;

		public void updateLike(int commentNo) throws DataAccessException;

		public void updateDislike(int commentNo) throws DataAccessException;

		public CommentVO getComment(int commentNo) throws DataAccessException;

		public int insertReplyComment(CommentVO commentVO) throws DataAccessException;

		public CommentVO modComment(int commentNo, String comment_content) throws DataAccessException;
		public void deleteRecipeImage(int recipe_no, String fileName) throws DataAccessException;
		
		
		
		public List<CommentVO> selectAllComments()  throws DataAccessException;
		public void updateFilteredContent(Map<String, Object> updateParams)  throws DataAccessException;
		
		public void updateViews(int recipe_no) throws DataAccessException;
		



	
}
	