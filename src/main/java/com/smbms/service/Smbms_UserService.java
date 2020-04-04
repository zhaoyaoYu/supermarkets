package com.smbms.service;


import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Bill;
import com.smbms.entity.Smbms_Provider;
import com.smbms.entity.Smbms_User;
import org.springframework.web.bind.annotation.PathVariable;

public interface Smbms_UserService {

    //登录
    public Smbms_User userLogin(String userCode,String userPassword);

    //修改密码
    public int updatePassword(Integer id,String newPassword);

    //显示数据
    public PageInfo<Smbms_User> getUserByName(String userName, int pageNum, int pageSize);


    //根据用户id查数据
    public Smbms_User getUseByID(Integer id);
    //验证添加用户编码
    public int checkUserCode(String usercode);
    //添加用户
    public int addUser(Smbms_User smbms_user);
    //修改用户信息
    public int updateUser(Smbms_User smbms_user);
    //更改用户状态
    public int userIsDelete(Integer id, Integer isDelete);
}
