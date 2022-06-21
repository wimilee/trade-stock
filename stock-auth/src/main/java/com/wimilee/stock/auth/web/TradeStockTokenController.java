package com.wimilee.stock.auth.web;

import com.wimilee.stock.commons.utils.GlobalConstants;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.token.TokenStore;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.util.StringUtils;

/**
 * @author:wimilee
 * @date: 2022/6/21 10:01
 * @description:
 * @link:
 */
@RestController
@Log4j2
@RequestMapping("/token")
public class TradeStockTokenController {
	private static final String STOCK_OAUTH_ACCESS = GlobalConstants.OAUTH_PREFIX_KEY;

	@Autowired
	private RedisTemplate stockRedisTemplate;

	@Autowired
	private TokenStore tokenStore;

	@Autowired
	private CacheManager cacheManager;

	/**
	 * 认证页面跳转
	 */
	@RequestMapping("/login")
	public ModelAndView require() {
		return new ModelAndView("ftl/login");
	}

	/**
	 * 认证成功
	 */
	@RequestMapping("/success")
	public String success() {
		log.info("认证成功");
		return "login success";
	}

	/**
	 * 退出登录
	 */
	@DeleteMapping("/logout")
	public String logout(@RequestHeader(value = HttpHeaders.AUTHORIZATION, required = false) String authorization) {
		if (StringUtils.isEmpty(authorization)) {
			return "退出失败，token 为空";
		}
		String tokenValue = authorization.replace(OAuth2AccessToken.BEARER_TYPE, "").trim();
		OAuth2AccessToken oAuth2AccessToken = tokenStore.readAccessToken(tokenValue);
		if (oAuth2AccessToken == null || oAuth2AccessToken.isExpired()) {
			return "退出失败，token 不存在";
		}
		OAuth2Authentication oAuth2Authentication = tokenStore.readAuthentication(tokenValue);
		cacheManager.getCache(GlobalConstants.OAUTH_KEY_STOCK_USER_DETAILS).evict(oAuth2Authentication.getName());
		tokenStore.removeAccessToken(oAuth2AccessToken);
		return "退出成功,token:" + tokenValue;
	}

	/**
	 * 清除token
	 */
	@DeleteMapping("/{token}")
	public String removeToken(@PathVariable String token) {
		if (StringUtils.isEmpty(token)) {
			return "清除失败，token 为空";
		}
		OAuth2AccessToken oAuth2AccessToken = tokenStore.readAccessToken(token);
		if (oAuth2AccessToken == null || oAuth2AccessToken.isExpired()) {
			return "清除失败，token 不存在";
		}
		OAuth2AccessToken oAuth2AccessTokenClear = tokenStore.readAccessToken(token);
		tokenStore.removeAccessToken(oAuth2AccessTokenClear);
		return "清除成功,token:" + token;
	}
}
