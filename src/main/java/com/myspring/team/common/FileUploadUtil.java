package com.myspring.team.common;  // 패키지 경로 수정

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.myspring.team.goods.vo.ImageFileVO;

import net.coobird.thumbnailator.Thumbnails;

public class FileUploadUtil {

    private static final String CURR_IMAGE_REPO_PATH = "C:\\shopping\\file_repo";

    public List<ImageFileVO> upload(MultipartHttpServletRequest multipartRequest) throws Exception {
        List<ImageFileVO> fileList = new ArrayList<ImageFileVO>();
        Iterator<String> fileNames = multipartRequest.getFileNames();

        // 파일 갯수 로그 출력
        System.out.println("Number of files received: " + multipartRequest.getFileMap().size());

        while (fileNames.hasNext()) {
            ImageFileVO imageFileVO = new ImageFileVO();
            String fileName = fileNames.next();
            imageFileVO.setFileType(fileName);
            MultipartFile mFile = multipartRequest.getFile(fileName);
            String originalFileName = mFile.getOriginalFilename();

            // 각 파일 이름 출력
            System.out.println("Received file: " + originalFileName);

            // 파일 크기 출력
            System.out.println("File size: " + mFile.getSize() + " bytes");

            imageFileVO.setFileName(originalFileName);
            fileList.add(imageFileVO);

            // 파일 저장 경로 출력
            File file = new File(CURR_IMAGE_REPO_PATH + "\\" + fileName);
            if (mFile.getSize() != 0) { // File Null Check
                if (!file.exists()) { // 파일이 존재하지 않으면
                    if (file.getParentFile().mkdirs()) { // 디렉토리 생성
                        file.createNewFile(); // 파일 생성
                    }
                }
                // 파일을 temp 폴더로 이동
                mFile.transferTo(new File(CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + originalFileName));
                System.out.println("File saved to: " + CURR_IMAGE_REPO_PATH + "\\" + "temp" + "\\" + originalFileName);
            } else {
                System.out.println("File is empty, skipping upload for: " + originalFileName);
            }
        }

        // 업로드된 파일 리스트 크기 확인
        System.out.println("Total files processed: " + fileList.size());

        return fileList;
    }

    private void deleteFile(String fileName) {
        File file = new File(CURR_IMAGE_REPO_PATH + "\\" + fileName);
        try {
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void provideImage(int goods_id, String fileName, HttpServletResponse response) throws IOException {
        String filePath = CURR_IMAGE_REPO_PATH + "\\" + goods_id + "\\" + fileName;
        File imageFile = new File(filePath);

        if (imageFile.exists()) {
            // 파일 확장자에 맞는 콘텐츠 타입 설정
            String mimeType = Files.probeContentType(imageFile.toPath());
            response.setContentType(mimeType != null ? mimeType : "image/jpeg");

            // 파일 읽기
            try (FileInputStream fis = new FileInputStream(imageFile);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int len;
                while ((len = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }
            }
        } else {
            // 이미지가 존재하지 않으면 기본 이미지를 표시
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
        }
    }

}
