package com.wimilee.trade.mybatis.generator.customer;

import org.mybatis.generator.api.IntrospectedColumn;
import org.mybatis.generator.api.IntrospectedTable;
import org.mybatis.generator.api.dom.java.Field;
import org.mybatis.generator.api.dom.java.Method;
import org.mybatis.generator.api.dom.java.TopLevelClass;
import org.mybatis.generator.internal.DefaultCommentGenerator;
import org.mybatis.generator.internal.util.StringUtility;

/**
 * @author:wimilee
 * @date: 2022/6/19 20:13
 * @description:
 * @link:
 */
public class CustomCommentGenerator extends DefaultCommentGenerator {
	/**
	 * 类的头部信息生成
	 **/
	@Override
	public void addModelClassComment(TopLevelClass topLevelClass, IntrospectedTable introspectedTable) {
		topLevelClass.addJavaDocLine("/**");
		String remarks = introspectedTable.getRemarks();
		if (StringUtility.stringHasValue(remarks)) {
			String[] remarkLine = remarks.split(System.getProperty("line.separator"));
			for (String line : remarkLine) {
				topLevelClass.addJavaDocLine(" * " + line);
			}
		}
		topLevelClass.addJavaDocLine(" *");
		topLevelClass.addJavaDocLine(" * "+introspectedTable.getFullyQualifiedTable());
		topLevelClass.addJavaDocLine(" * @author:wimilee");
		topLevelClass.addJavaDocLine(" * @date:" + new java.util.Date());
		addJavadocTag(topLevelClass, false);
		topLevelClass.addJavaDocLine(" */");
	}

	/**
	 *  生成类的成员变量 注释
	 * */
	public void addFieldComment(Field field, IntrospectedColumn introspectedColumn,IntrospectedTable introspectedTable) {
		field.addJavaDocLine("/**");
		String remarks = introspectedColumn.getRemarks();
		if (StringUtility.stringHasValue(remarks)) {
			String[] remarkLine = remarks.split(System.getProperty("line.separator"));
			for (String line : remarkLine) {
				field.addJavaDocLine(" * " + line);
			}
		}
		field.addJavaDocLine(" */");
	}

    /**
	 * 生成类的方法注释
	 * */
	@Override
    public void addFieldComment(Field field, IntrospectedTable introspectedTable) {
		field.addJavaDocLine("/**");
		addJavadocTag(field, false);
		field.addJavaDocLine(" */");
	}

	/**
	 * 生成Getter的方法注释
    **/
	@Override
	public void addGetterComment(Method method, IntrospectedTable introspectedTable, IntrospectedColumn introspectedColumn) {
		method.addJavaDocLine("/**");
		String remarks = introspectedColumn.getRemarks();
		if (StringUtility.stringHasValue(remarks)) {
			String[] remarkLine = remarks.split(System.getProperty("line.separator"));
			for (String line : remarkLine) {
				method.addJavaDocLine(" * " + line);
			}
		}
	}

}
