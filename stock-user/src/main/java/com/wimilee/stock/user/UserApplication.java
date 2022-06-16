package com.wimilee.stock.user;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
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
@RestController
public class UserApplication {
	public static void main(String[] args) {
		SpringApplication.run(UserApplication.class, args);
	}

	@RequestMapping("/welcome")
	public String welcome() {
		return "welcome to user";
	}
}
