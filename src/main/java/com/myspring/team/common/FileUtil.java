package com.myspring.team.common;


import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

public class FileUtil {

    public static boolean saveFiles(String directoryPath, MultipartHttpServletRequest multipartRequest) {
        boolean allSuccess = true;

        // 디렉토리 생성
        File dir = new File(directoryPath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // 파일 목록 가져오기
        Iterator<String> fileNames = multipartRequest.getFileNames();

        while (fileNames.hasNext()) {
            String fileName = fileNames.next();
            List<MultipartFile> files = multipartRequest.getFiles(fileName);

            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) {
                    System.out.println("빈 파일이 감지되었습니다. 저장을 건너뜁니다.");
                    continue;
                }

                String filePath = directoryPath + File.separator + file.getOriginalFilename();
                boolean isSaved = saveFile(filePath, file);

                if (!isSaved) {
                    allSuccess = false;
                }
            }
        }

        return allSuccess;
    }

    private static boolean saveFile(String filePath, MultipartFile file) {
        try {
            File destinationFile = new File(filePath);

            // 디렉토리 없으면 생성
            if (!destinationFile.getParentFile().exists()) {
                destinationFile.getParentFile().mkdirs();
            }

            // 파일 저장
            file.transferTo(destinationFile);
            System.out.println("파일 저장 완료: " + filePath);
            return true;

        } catch (IOException e) {
            System.out.println("파일 저장 중 오류 발생: " + e.getMessage());
            return false;
        }
    }
}
