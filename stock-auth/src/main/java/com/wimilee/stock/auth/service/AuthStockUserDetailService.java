package com.wimilee.stock.auth.service;

import com.wimilee.stock.auth.bo.OAuthTradeUser;
import com.wimilee.stock.auth.jpa.TradeUserRepository;
import com.wimilee.stock.commons.utils.GlobalConstants;
import com.wimilee.stock.entity.user.TradeUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * @author:wimilee
 * @date: 2022/6/21 13:51
 * @description:
 * @link:
 */
@Service
public class AuthStockUserDetailService implements UserDetailsService {
	@Autowired
	private TradeUserRepository tradeUserRepository;
	@Autowired
	private CacheManager cacheManager;

	@Override
	public UserDetails loadUserByUsername(String userNo) throws UsernameNotFoundException {
		//查询缓存
		Cache cache =  cacheManager.getCache(GlobalConstants.OAUTH_KEY_STOCK_USER_DETAILS);
		if (cache!=null && cache.get(userNo)!=null) {
			return (UserDetails) cache.get(userNo).get();
		}
		//查询数据库
		TradeUser tradeUser = tradeUserRepository.findByUserNo(userNo);
		if (tradeUser==null){
			throw new UsernameNotFoundException("用户不存在");
		}
		//对用户信息进行封装处理
		OAuthTradeUser userDetails = new OAuthTradeUser(tradeUser);
		//加入缓存
		cache.put(userNo, userDetails);
		return userDetails;
	}

}
