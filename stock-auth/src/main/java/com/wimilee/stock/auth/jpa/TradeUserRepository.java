package com.wimilee.stock.auth.jpa;

import com.wimilee.jpa.BaseRepository;
import com.wimilee.stock.entity.user.TradeUser;
import org.springframework.stereotype.Repository;

/**
 * @author:wimilee
 * @date: 2022/6/20 17:24
 * @description: 用户信息数据层
 * @link:
 */
@Repository("tradeUserRepository")
public interface TradeUserRepository extends BaseRepository<TradeUser,Long> {
	/**
	 * 根据用户账户查询用户信息
	 */
	public TradeUser findByUserNo(String userNo);
}

