package com.smbms.mapper;

import com.smbms.entity.Smbms_Address;

public interface Smbms_AddressMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Smbms_Address record);

    int insertSelective(Smbms_Address record);

    Smbms_Address selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Smbms_Address record);

    int updateByPrimaryKey(Smbms_Address record);
}