package com.wimilee.stock.user.vo;

import lombok.Data;

/**
 * @author:wimilee
 * @date: 2022/7/30 23:44
 * @description:
 * @link:
 */
@Data
public class CompanyVo {

	/**
	 * 公司ID
	 */
	private Long id;

	/**
	 * 公司名称
	 */
	private String companyName;

	/**
	 * 机构类型
	 */
	private String institutionTypeId;

	/**
	 * 联系人
	 */
	private String contactUser;

	/**
	 * 联系电话
	 */
	private String contactPhone;

	/**
	 * 管理员账号
	 */
	private String adminUser;

	/**
	 * 机构ID
	 */
	private String institutionId;

}


