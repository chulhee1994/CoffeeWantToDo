package com.myspring.team.recipe.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.recipe.vo.RecipeVO;

public interface RecipeController {
	
	//레시피 리스트 출력
	public ModelAndView recipeLists(HttpServletRequest req, HttpServletResponse res) throws Exception;
	
	public ModelAndView searchRecipeLists(Map<String, String> searchParams, HttpServletRequest req) throws Exception;
	//레시피 글 작성
	public ModelAndView recipeForm(HttpServletRequest req,HttpServletResponse res) throws Exception;

	//레시피 글 추가
	public ResponseEntity addRecipe(MultipartHttpServletRequest req, HttpServletResponse res) throws Exception;

	public ResponseEntity deleteRecipe(int recipe_no, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public ModelAndView editRecipe(int recipe_no, HttpServletRequest req, HttpServletResponse res) throws Exception;

	public ModelAndView viewRecipe(int recipe_no, int section, int pageNum, HttpServletRequest req,HttpServletResponse res) throws Exception;


	/*
	 * 		레시피 댓글 구분선
	 * 
	 * */
	

	public Map<String, Object> sortComments(int recipe_no, String orderBy, int section, int pageNum) throws Exception;

	public Map<String, Object> updateComment(int commentNo, String action, HttpSession session, HttpServletRequest req,
			HttpServletResponse res) throws Exception;

	public ResponseEntity addReplyComment(HttpServletRequest req) throws Exception;

	public Map<String, Object> deleteComment(int comment_no) throws Exception;

	public Map modComment(int commentNo, String action, HttpServletRequest req, HttpServletResponse res)
			throws DataAccessException;



	public ResponseEntity<String> updateRecipe(MultipartHttpServletRequest req,HttpServletResponse res) throws Exception;










}
