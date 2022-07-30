package com.wimilee.stock.user.dao;

import com.wimilee.jpa.BaseRepository;
import com.wimilee.stock.entity.user.TradeUser;
import com.wimilee.stock.user.vo.CompanyVo;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 * @author:wimilee
 * @date: 2022/6/23 14:47
 * @description:
 * @link:
 */
@Repository("StockUserRepository")
public interface StockUserRepository extends BaseRepository<TradeUser, Long> {
	@Query(value = "select 1 from t_trade_user where user_no = ?1 and email=?2 and phone=?3", nativeQuery = true)
	Integer checkRegister(String userNo,String email,String phone);


}
