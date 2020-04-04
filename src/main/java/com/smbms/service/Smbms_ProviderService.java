package com.smbms.service;

import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Provider;

import java.util.List;

public interface Smbms_ProviderService {
    //供应商数据
    public PageInfo<Smbms_Provider> getProviderByName(String proName, Integer pageNum, Integer pageSize);

    //根据id查询供应商数据
    public Smbms_Provider getProviderByID(Integer pid);
    // 删除订单数据
    public int  deleteProvider(String proCode);


    //验证供应商id
    public int checkProviderCode(String proCode);
    //添加供应商
    public  int addProvider(Smbms_Provider smbms_provider);
    //更改供应商数据
    public  int updateProvider(Smbms_Provider smbms_provider);


    //查询所有供应商信息
  //  public List<Smbms_Provider> getProList();
    public List<Smbms_Provider> getProList();
}
