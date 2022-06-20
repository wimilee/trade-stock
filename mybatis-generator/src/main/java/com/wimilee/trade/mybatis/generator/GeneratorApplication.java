package com.wimilee.trade.mybatis.generator;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

import java.util.List;

/**
 * @author:wimilee
 * @date: 2022/6/17 17:28
 * @description:
 * @link:
 */
public class GeneratorApplication {
	public static void main(String[] args) {
		try {
			//记录警告信息
			List<String> warnings = new java.util.ArrayList<>();
			boolean overwrite = true;
			//配置转换器
			Configuration config = new ConfigurationParser(warnings).parseConfiguration(GeneratorApplication.class.getClassLoader().getResourceAsStream("generatorConfig.xml"));
			//回调方法
			DefaultShellCallback callback = new DefaultShellCallback(overwrite);
			//创建mybatis生成器
			MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config, callback, warnings);
			//生成代码
			myBatisGenerator.generate(null);
			//打印警告信息
			if (warnings.size() > 0) {
				System.out.println("Warnings:");
				for (String warning : warnings) {
					System.out.println(warning);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
