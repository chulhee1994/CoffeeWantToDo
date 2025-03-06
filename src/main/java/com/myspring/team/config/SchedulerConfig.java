package com.myspring.team.config;

import javax.annotation.PreDestroy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.client.RestTemplate;

@Configuration
@EnableScheduling
@ComponentScan(basePackages = "com.myspring.team")
public class SchedulerConfig {

    private ThreadPoolTaskScheduler taskScheduler; // ✅ 필드로 선언하여 저장

    @Bean
    public ThreadPoolTaskScheduler taskScheduler() {
        taskScheduler = new ThreadPoolTaskScheduler(); // ✅ 객체를 필드에 저장
        taskScheduler.setPoolSize(5);
        taskScheduler.setThreadNamePrefix("Scheduler-");
        taskScheduler.setWaitForTasksToCompleteOnShutdown(true); // 애플리케이션 종료 시 작업 대기
        taskScheduler.setAwaitTerminationSeconds(30); // 작업 종료 대기 시간
        return taskScheduler;
    }

    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @PreDestroy
    public void shutdownScheduler() {
        System.out.println(" 스케줄러 종료 중...");
        if (taskScheduler != null) { // ✅ Null 체크 후 종료
            taskScheduler.shutdown();
            System.out.println(" 스케줄러 종료 완료");
        } else {
            System.out.println(" 스케줄러가 이미 종료되었거나 초기화되지 않았습니다.");
        }
    }
}
