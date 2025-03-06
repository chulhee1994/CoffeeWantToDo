package com.myspring.team.recipe.dao;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.eclipse.core.internal.utils.Convert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myspring.team.recipe.vo.CommentVO;
import com.myspring.team.recipe.vo.ImageFileVO;
import com.myspring.team.recipe.vo.RecipeVO;
import com.myspring.team.review.vo.ReviewVO;

@Repository("recipeDAO")
public class RecipeDAOImpl implements RecipeDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int selectToRecipes() throws DataAccessException {
		int toRecipes = sqlSession.selectOne("mapper.recipe.selectToRecipes");
		return toRecipes;
	}
	@Override
	public List<RecipeVO> recipeLists(Map pagingMap) throws DataAccessException {
		List<RecipeVO> recipeList = sqlSession.selectList("mapper.recipe.recipeLists",pagingMap);
		return recipeList;
	}
	
	@Override
	public int selectSearchToRecipes(Map searchMap) throws DataAccessException {
		int toSearchRecipes = sqlSession.selectOne("mapper.recipe.selectSearchToRecipes",searchMap);
		return toSearchRecipes;
	}
	
	 @Override
	    public List<RecipeVO> searchRecipeLists(Map searchMap) throws DataAccessException{
	        return sqlSession.selectList("mapper.recipe.searchRecipeLists", searchMap);
	    }
	 
		@Override
		public int getToRecipes(Map<String, Object> searchMap) throws DataAccessException {
			int getToRecipes = sqlSession.selectOne("mapper.recipe.getToRecipes", searchMap);
			return getToRecipes;
		}
	 
	 
	 @Override
	    public List<RecipeVO> getRecipesByGoodsId(Map<String, Object> searchMap) throws DataAccessException{
	        return sqlSession.selectList("mapper.recipe.getRecipesByGoodsId", searchMap);
	    }
	 
	 
	
	@Override
	public RecipeVO viewRecipe(int recipe_no) throws DataAccessException {
		return sqlSession.selectOne("mapper.recipe.viewRecipe",recipe_no);
	}
	@Override
	public List<ImageFileVO> viewRecipeImages(int recipe_no) throws DataAccessException {
	    return sqlSession.selectList("mapper.recipe.viewRecipeImages", recipe_no);
	}
	@Override
	public List<CommentVO> viewRecipeComment(Map pagingMap) throws DataAccessException {
		List<CommentVO> commentsList = sqlSession.selectList("mapper.recipe.viewRecipeComment",pagingMap);
		return commentsList;
	}
	@Override
	@Transactional
	public int addRecipe(Map recipesMap) throws DataAccessException {
		int recipe_no = sqlSession.selectOne("mapper.recipe.seq_recipe_no_nextval");
		
		
		
		recipesMap.put("recipe_no", recipe_no);
		sqlSession.insert("mapper.recipe.addRecipe", recipesMap);
		return recipe_no;
	}
	
	@Override
	public void addRecipeImage(Map<String, Object> imageMap) throws DataAccessException {
	    sqlSession.insert("mapper.recipe.insertRecipeImage", imageMap);
	}

    @Override
    public void deleteRecipeComment(int recipe_no) throws DataAccessException {
        sqlSession.delete("mapper.recipe.deleteRecipeComment", recipe_no);
    }
    @Override
    public void deleteRecipe(int recipe_no) throws DataAccessException {
        sqlSession.delete("mapper.recipe.deleteRecipe", recipe_no);
    }
    @Override
	public void deleteRecipeImageNames(int recipe_no) throws DataAccessException {
    	sqlSession.delete("mapper.recipe.deleteRecipeImageNames", recipe_no);
	}

    @Override
    public void deleteRecipeImages(String imagePath) throws Exception {
        File folder = new File(imagePath);
        System.out.println("삭제 이미지 경로: " + imagePath); 
        if (folder.exists() && folder.isDirectory()) {
            for (File file : folder.listFiles()) {
                if (file.isFile()) {
                    if (!file.delete()) {
                        throw new Exception("파일 삭제 실패: " + file.getName());
                    }
                }
            }
            if (!folder.delete()) {
                throw new Exception("이미지 폴더 삭제 실패");
            }
        }
    }
    
    
    
    
    @Override
	public int selectToComments(int recipe_no) throws DataAccessException {
	    return sqlSession.selectOne("mapper.recipe.selectToComments", recipe_no);  // 매개변수 전달 ✅
	}
	
    @Override
    public int insertComment(CommentVO comment) throws DataAccessException {
        return sqlSession.insert("mapper.recipe.insertComment", comment);
    }
    
    @Override
    public int insertReplyComment(CommentVO commentVO) throws DataAccessException{
        return sqlSession.insert("mapper.recipe.insertReplyComment", commentVO);
    }
    @Override
    public CommentVO getLatestComment(int recipe_no) throws DataAccessException {
        return sqlSession.selectOne("mapper.recipe.getLatestComment", recipe_no);
    }

    @Override
    public List<CommentVO> getCommentsByRecipe(int recipe_no) throws DataAccessException {
        return sqlSession.selectList("mapper.recipe.getCommentsByRecipe", recipe_no);
    }
	

    
        // ✅ 정렬된 댓글 가져오기 (페이징 포함)
    @Override
    public Map<String, Object> getSortedComments(Map<String, Object> pagingMap)  throws DataAccessException{
        List<CommentVO> commentsList = sqlSession.selectList("mapper.recipe.getSortedComments", pagingMap);
        int totalComments = sqlSession.selectOne("mapper.recipe.getTotalComments", pagingMap.get("recipe_no"));

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("commentsList", commentsList);
        resultMap.put("totalComments", totalComments);
        return resultMap;
    }
	@Override
	public boolean markCommentAsDeleted(int comment_no) throws DataAccessException {
		  int result = sqlSession.update("mapper.recipe.markCommentAsDeleted",comment_no);
		return result>0;
	}
	
	@Override
    public void updateLike(int commentNo) throws DataAccessException {
        sqlSession.update("mapper.recipe.updateLike", commentNo);
    }

    @Override
    public void updateDislike(int commentNo) throws DataAccessException{
        sqlSession.update("mapper.recipe.updateDislike", commentNo);
    }

    @Override
    public CommentVO getComment(int commentNo) throws DataAccessException{
        return sqlSession.selectOne("mapper.recipe.getComment", commentNo);
    }
	@Override
	public CommentVO modComment(int commentNo, String comment_content) throws DataAccessException {
		 Map<String, Object> params = new HashMap<>();
	        params.put("comment_no", commentNo);
	        params.put("comment_content", comment_content);
		return sqlSession.selectOne("mapper.recipe.modComment",params);
	}
	@Override
	public void updateRecipe(Map updateMap) throws DataAccessException {
		sqlSession.update("mapper.recipe.updateRecipe",updateMap);
	}
	@Override
	public void deleteRecipeImage(int recipe_no, String fileName) throws DataAccessException {
		Map deleteMap = new HashMap();
		deleteMap.put("recipe_no", recipe_no);
		deleteMap.put("fileName", fileName);
		sqlSession.delete("mapper.recipe.deleteRecipeImage", deleteMap);
	}
	
	
	@Override
	public List<CommentVO> selectAllComments() throws DataAccessException {
		return sqlSession.selectList("mapper.recipe.selectAllComments");
	}
	@Override
	public void updateFilteredContent(Map<String, Object> updateParams) throws DataAccessException {
		sqlSession.update("mapper.recipe.updateFilteredContent",updateParams);
	}
	@Override
	public void updateViews(int recipe_no) throws DataAccessException {
		sqlSession.update("mapper.recipe.updateViews",recipe_no);
	}
	
    
    
    
    
	

}
