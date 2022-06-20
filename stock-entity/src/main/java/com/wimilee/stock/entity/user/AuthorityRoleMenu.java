package com.wimilee.stock.entity.user;

import com.wimilee.stock.entity.base.BaseEntity;
import lombok.Data;

import javax.persistence.*;


/**
 * 
 * t_authority_role_menu
 *
 */
@Entity
@Table(name= "t_authority_role_menu")
@Data
public class AuthorityRoleMenu extends BaseEntity {

    /**
     * 自定义角色id
     */
    private Long roleId;

    /**
     * 菜单id
     */
    private Long menuId;

    /**
     */
    private static final long serialVersionUID = 1L;
}