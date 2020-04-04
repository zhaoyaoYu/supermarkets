package com.smbms.mapper;

import com.smbms.entity.Smbms_Role;

public interface Smbms_RoleMapper {
    int deleteByPrimaryKey(Long rid);

    int insert(Smbms_Role record);

    int insertSelective(Smbms_Role record);

    Smbms_Role selectByPrimaryKey(Long rid);

    int updateByPrimaryKeySelective(Smbms_Role record);

    int updateByPrimaryKey(Smbms_Role record);
}