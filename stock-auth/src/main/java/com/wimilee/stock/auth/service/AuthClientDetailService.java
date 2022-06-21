package com.wimilee.stock.auth.service;

import com.wimilee.stock.commons.utils.GlobalConstants;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.security.oauth2.provider.ClientDetails;
import org.springframework.security.oauth2.provider.client.JdbcClientDetailsService;

import javax.sql.DataSource;

/**
 * @author:wimilee
 * @date: 2022/6/21 11:11
 * @description:
 * @link:
 */
public class AuthClientDetailService extends JdbcClientDetailsService {
	public AuthClientDetailService(DataSource dataSource) {
		super(dataSource);
	}

	/**
	 * 对客户端信息加入缓存处理
	 * @param clientId
	 * @return
	 */
	@Override
	@Cacheable(value = GlobalConstants.OAUTH_KEY_CLIENT_DETAILS, key = "#clientId", unless = "#result == null")
	public ClientDetails loadClientByClientId(String clientId) {
		return super.loadClientByClientId(clientId);
	}

}
