package com.wimilee.stock.auth.bo;

import com.wimilee.stock.entity.user.TradeUser;
import org.springframework.security.core.userdetails.User;
import java.util.Collections;

/**
 * @author:wimilee
 * @date: 2022/6/21 09:46
 * @description:
 * @link:
 */
public class OAuthTradeUser extends User {

	private static final long serialVersionUUID = -1L;

	/**
	 * 业务用户信息
	 */
	private TradeUser tradeUser;

	public OAuthTradeUser(TradeUser tradeUser) {
		// OAUTH2认证用户信息构造处理
		super(tradeUser.getUserNo(), tradeUser.getUserPwd(), (tradeUser.getStatus() == 0),
				true, true, (tradeUser.getStatus() == 0), Collections.emptyList());
		this.tradeUser = tradeUser;
	}

	public TradeUser getTradeUser() {
		return tradeUser;
	}
}
