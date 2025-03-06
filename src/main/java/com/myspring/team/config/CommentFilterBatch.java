package com.myspring.team.config;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.core.io.ClassPathResource;
import com.myspring.team.recipe.dao.RecipeDAO;
import com.myspring.team.recipe.vo.CommentVO;
import org.springframework.beans.factory.annotation.Autowired;

import javax.annotation.PostConstruct;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

@Component
public class CommentFilterBatch {

    @Autowired
    private RecipeDAO recipeDAO;

    // 금지어를 저장할 HashSet
    private Set<String> bannedWords = new HashSet<>();
    
    // 업데이트된 댓글 수를 저장할 변수
    private int updatedCount = 0;

    @PostConstruct
    public void init() {
        // 스프링 빈이 생성될 때 실행되는 초기화 메서드
        System.out.println("CommentFilterBatch 빈이 정상 등록되었습니다. (댓글 필터링 동작)");
        loadBannedWords(); // 금지어 목록을 불러오는 메서드 실행
    }

    /**
     * 금지어 리스트를 txt 파일에서 불러와 HashSet에 저장하는 메서드
     */
    private void loadBannedWords() {
        System.out.println("필터링 단어 로딩");
        try {
            // resources 폴더 내 txt/fword_list.txt 파일을 불러옴
            ClassPathResource resource = new ClassPathResource("txt/fword_list.txt");
            
            // UTF-8 인코딩을 사용하여 파일을 읽음
            BufferedReader br = new BufferedReader(new InputStreamReader(resource.getInputStream(), "UTF-8"));
            String line;
            
            // 파일에서 한 줄씩 읽어 금지어 리스트에 추가
            while ((line = br.readLine()) != null) {
                bannedWords.add(line.trim());
            }
            br.close();
            
            System.out.println("금지어 리스트 로드 완료. 총 " + bannedWords.size() + "개.");
        } catch (IOException e) {
            // 파일 로드 중 오류 발생 시 예외 처리
            System.err.println("금지어 리스트 로드 중 오류 발생: " + e.getMessage());
        }
    }

    /**
     * 매 10초마다 실행되며, 댓글 내용을 확인하고 금지어가 포함된 경우 필터링하여 업데이트하는 메서드
     */
  @Scheduled(cron = "*/10 * * * * *") 
    
    //매일 새벽 12시에 실행후 업데이트
  //@Scheduled(cron = "0 0 0 * * *") 
    public void filterCommentContent() {
        try {
            // 현재 시간 출력
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            System.out.println("스케줄러 실행 시작: " + dateFormat.format(calendar.getTime()));

            // 데이터베이스에서 모든 댓글을 조회
            List<CommentVO> commentsList = recipeDAO.selectAllComments();
            if (commentsList == null || commentsList.isEmpty()) {
                System.out.println("댓글 목록이 비어있거나 NULL입니다.");
                return;
            }

            // 조회된 댓글 리스트를 순회하며 금지어 필터링 수행
            for (CommentVO comment : commentsList) {
                if (comment == null || comment.getComment_content() == null) {
                    continue;
                }
                String commentContent = comment.getComment_content();
                boolean isFiltered = false;

                // 금지어 목록을 순회하며 댓글에 포함된 금지어를 필터링
                for (String bannedWord : bannedWords) {
                    if (commentContent.contains(bannedWord)) {
                        commentContent = commentContent.replaceAll(bannedWord, "필터링된 댓글입니다.");
                        isFiltered = true;
                    }
                }

                // 금지어가 포함된 경우, 필터링된 내용을 DB에 업데이트
                if (isFiltered) {
                    Map<String, Object> updateParams = new HashMap<>();
                    updateParams.put("comment_no", comment.getComment_no());
                    updateParams.put("comment_content", commentContent);
                    
                    System.out.println("필터링 된 댓글 : " + comment.toString());
                    try {
                        // 데이터베이스에 필터링된 댓글 내용 업데이트
                        recipeDAO.updateFilteredContent(updateParams);
                        updatedCount++;
                        System.out.println("댓글 업데이트 완료: " + comment.getComment_no());
                    } catch (Exception e) {
                        System.err.println("댓글 업데이트 중 오류 발생: " + e.getMessage());
                    }
                }
            }

            System.out.println("불건전한 내용 필터링 완료. 업데이트된 댓글 수: [" + updatedCount + "]");

        } catch (Exception e) {
            // 스케줄러 실행 중 발생하는 예외를 처리
            System.err.println("스케줄러 실행 오류: " + e.getMessage());
        }
    }
}
