package com.smbms.mapper;

import com.smbms.entity.Smbms_Provider;
import com.smbms.entity.Smbms_User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface Smbms_ProviderMapper {
    //根据列表查供应商
    public List<Smbms_Provider> getProviderByName(@Param("proName") String proName);

    //根据id查询供应商数据
    public Smbms_Provider getProviderByID(Integer pid);


    //删除订单数据
    public  int deleteProvider(String proCode);


    //验证供应商id
    public int checkProviderCode(String proCode);
    //添加供应商
    public  int addProvider(Smbms_Provider smbms_provider);
    //更改供应商数据
    public  int updateProvider(Smbms_Provider smbms_provider);

}