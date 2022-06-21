package com.wimilee.stock.auth.config;

import com.wimilee.stock.commons.encrypt.EncryptUtil;
import com.wimilee.stock.commons.exception.ComponentException;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 * @author:wimilee
 * @date: 2022/6/21 15:29
 * @description:
 * @link:
 */
@Service
@Log4j2
public class StockPasswordEncoder implements PasswordEncoder {

	/**
	 * 密码编码处理
	 * @param rawPassword
	 * @return
	 */
	@Override
	public String encode(CharSequence rawPassword) {
		return rawPassword.toString();
	}

	/**
	 * 密码校验判断处理
	 * @param rawPassword
	 * @param encodedPassword
	 * @return
	 */
	@Override
	public boolean matches(CharSequence rawPassword, String encodedPassword) {
		if(rawPassword != null && rawPassword.length() > 0){
			try {
				// 这里通过MD5及B64加密
				String password = EncryptUtil.encryptSigned(rawPassword.toString());
				boolean isMatch= encodedPassword.equals(password);
				if(!isMatch) {
					log.warn("密码 不一致！");
				}
				return isMatch;
			} catch (ComponentException e) {
				log.error(e.getMessage(), e);
			}
		}
		return false;
	}
}
