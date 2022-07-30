package com.wimilee.stock.user.dao;

import com.wimilee.jpa.BaseRepository;
import com.wimilee.stock.user.vo.CompanyVo;
import org.springframework.stereotype.Repository;

import java.util.Optional;

/**
 * @author:wimilee
 * @date: 2022/7/30 23:47
 * @description:
 * @link:
 */
@Repository("StockCompanyVoRepository")
public interface StockCompanyVoRepository extends BaseRepository<CompanyVo, Long> {
	public Optional<CompanyVo> findById(Long id);
}
