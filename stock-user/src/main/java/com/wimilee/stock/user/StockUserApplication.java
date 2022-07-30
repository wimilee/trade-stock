package com.wimilee.stock.user;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author:wimilee
 * @date: 2022/6/3 00:38
 * @description: user starter
 * @link:
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableFeignClients
@ComponentScan(basePackages = {"com.wimilee"})
@EnableJpaRepositories(basePackages =  {"com.wimilee"})
@EnableTransactionManagement
public class StockUserApplication {

	public static void main(String[] args) {

		SpringApplication.run(StockUserApplication.class, args);
	}

}
