package com.myspring.team.recipe.service;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import com.myspring.team.recipe.vo.CommentVO;
import com.myspring.team.recipe.vo.ImageFileVO;
import com.myspring.team.recipe.vo.RecipeVO;

public interface RecipeService {

	public Map recipeLists(Map pagingMap) throws DataAccessException;
	public Map searchRecipeLists(Map searchMap) throws DataAccessException;
	public Map<String, Object> getRecipesList(Map<String, Object> searchMap);

	public int addRecipe(Map recipesMap) throws DataAccessException;
	public void addRecipeImage(Map<String, Object> imageMap) throws DataAccessException;
	public void deleteRecipeImage(int recipe_no, String fileName) throws DataAccessException;
	
	public RecipeVO viewRecipe(int recipe_no) throws DataAccessException;
	public List<ImageFileVO> viewRecipeImages(int recipe_no) throws DataAccessException;
	
	public void deleteRecipe(int recipe_no, String imagePath) throws DataAccessException;
	public void updateRecipe(Map updateMap) throws DataAccessException;

	public Map viewRecipeComment(Map pagingMap) throws DataAccessException;

	public boolean addComment(CommentVO comment) throws DataAccessException;

	public  CommentVO getLatestComment(int recipe_no) throws DataAccessException;

	public  List<CommentVO> getCommentsByRecipe(int recipe_no) throws DataAccessException;

	public Map<String, Object> getSortedComments(Map<String, Object> pagingMap) throws DataAccessException;


	public boolean markCommentAsDeleted(int comment_no) throws DataAccessException;

	public CommentVO updateComment(int commentNo, String action) throws DataAccessException;

	public boolean addReplyComment(CommentVO commentVO) throws DataAccessException;

	public CommentVO modComment(int commentNo, String comment_content) throws DataAccessException;
	public void updateViews(int recipe_no) throws DataAccessException;
	







}
