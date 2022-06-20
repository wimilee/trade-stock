package com.wimilee.stock.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

/**
 * @author:wimilee
 * @date: 2022/6/20 17:17
 * @description:
 * @link:
 */
@SpringBootApplication
@EnableDiscoveryClient
@ComponentScan(basePackages = {"com.wimilee"})
@EntityScan(basePackages = {"com.wimilee"})
@EnableJpaRepositories(basePackages =  {"com.wimilee"})
@EnableCaching
public class StockAuthApplication {
	public static void main(String[] args) {
		SpringApplication.run(StockAuthApplication.class, args);
	}
}
