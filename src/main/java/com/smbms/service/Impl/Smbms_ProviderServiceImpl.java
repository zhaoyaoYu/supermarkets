package com.smbms.service.Impl;


import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Provider;
import com.smbms.mapper.Smbms_ProviderMapper;
import com.smbms.service.Smbms_ProviderService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("Smbms_ProviderService")
public class Smbms_ProviderServiceImpl  implements Smbms_ProviderService {
    @Resource
    private Smbms_ProviderMapper smbms_providerMapper;

    @Override
    public PageInfo<Smbms_Provider> getProviderByName(String proName,Integer pageNum,Integer pageSize) {
        //开启PageHelper分页
        Page<Smbms_Provider> page = PageHelper.startPage(pageNum, pageSize);
        smbms_providerMapper.getProviderByName(proName);
        return page.toPageInfo();
    }

    @Override
    public Smbms_Provider getProviderByID(Integer pid) {
        return smbms_providerMapper.getProviderByID(pid);
    }

    @Override
    public int deleteProvider(String proCode) {
        return smbms_providerMapper.deleteProvider(proCode);
    }

    @Override
    public int checkProviderCode(String proCode) {
        return smbms_providerMapper.checkProviderCode(proCode);
    }

    @Override
    public int addProvider(Smbms_Provider smbms_provider) {
        return smbms_providerMapper.addProvider(smbms_provider);
    }

    @Override
    public int updateProvider(Smbms_Provider smbms_provider) {
        return smbms_providerMapper.updateProvider(smbms_provider);
    }


    @Override
    public List<Smbms_Provider> getProList() {
        return smbms_providerMapper.getProviderByName("");
    }

}
