package com.wimilee.stock.auth.jpa;

import com.wimilee.stock.entity.user.TradeUser;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

/**
 * @author:wimilee
 * @date: 2022/6/20 17:24
 * @description: 用户信息数据层
 * @link:
 */
@Repository("tradeUserRepository")
public interface TradeUserRepository extends PagingAndSortingRepository<TradeUser, Long>, JpaSpecificationExecutor<TradeUser> {
	/**
	 * 根据用户账户查询用户信息
	 */
	public TradeUser findByUserNo(String userNo);
}

