package com.smbms.service.Impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Bill;
import com.smbms.entity.Smbms_Provider;
import com.smbms.entity.Smbms_User;

import com.smbms.mapper.Smbms_ProviderMapper;
import com.smbms.mapper.Smbms_UserMapper;
import com.smbms.service.Smbms_UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("Smbms_UserService")
public class Smbms_UserServiceImpl implements Smbms_UserService {

    @Resource
    private Smbms_UserMapper smbms_userMapper;

    @Override
    public Smbms_User userLogin(String userCode, String userPassword) {
        return smbms_userMapper.userLogin(userCode,userPassword);
    }
    @Override
    public int updatePassword(Integer id, String newPassword) {
        return smbms_userMapper.updatePassword(id,newPassword);
    }

    @Override           //查用户
    public PageInfo<Smbms_User> getUserByName(String userName, int pageNum, int pageSize) {
        Page<Smbms_User> page= PageHelper.startPage(pageNum,pageSize);

        smbms_userMapper.getUserByName(userName);
        return page.toPageInfo();
    }


    @Override           //查看个人用户数据
    public Smbms_User getUseByID(Integer id) {
        return smbms_userMapper.getUseByID(id);
    }

    @Override           //验证添加用户编码
    public int checkUserCode(String usercode) {
        return smbms_userMapper.checkUserCode(usercode);
    }

    @Override       //添加用户
    public  int addUser(Smbms_User smbms_user){
        return smbms_userMapper.addUser(smbms_user);
    }

    @Override       //修改用户信息
    public int updateUser(Smbms_User smbms_user) {
        return smbms_userMapper.updateUser(smbms_user);
    }

    @Override
    public int userIsDelete(Integer id, Integer isDelete) {
        return smbms_userMapper.userIsDelete(id,isDelete);
    }

}
