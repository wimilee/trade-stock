package com.wimilee.jpa;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.NoRepositoryBean;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * @author:wimilee
 * @date: 2022/7/30 18:20
 * @description:
 * @link:
 */
@NoRepositoryBean
public interface BaseRepository<T,ID> extends PagingAndSortingRepository<T,ID>, JpaRepository<T,ID> {

}
