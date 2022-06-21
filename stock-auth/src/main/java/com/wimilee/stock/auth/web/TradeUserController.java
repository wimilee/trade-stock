package com.wimilee.stock.auth.web;

import com.wimilee.stock.auth.service.AuthStockUserDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author:wimilee
 * @date: 2022/6/21 11:03
 * @description:
 * @link:
 */
@RestController
@RequestMapping("/trade")
public class TradeUserController {
	@Autowired
	private AuthStockUserDetailService authStockUserDetailService;

	/**
	 * 获取用户信息
	 */
	@RequestMapping("/user")
	public UserDetails getUser(@RequestParam("username") String username) {
		return authStockUserDetailService.loadUserByUsername(username);
	}
}
