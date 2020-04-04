package com.smbms.mapper;

import com.smbms.entity.Smbms_Provider;
import com.smbms.entity.Smbms_User;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface Smbms_UserMapper {
    //登录
    public Smbms_User userLogin(@Param("userCode") String userCode, @Param("userPassword") String userPassword);

    //修改密码
    public int updatePassword(@Param("id") Integer id,@Param("newPassword") String newPassword);


    //根据列表用户查数据
    public List<Smbms_User> getUserByName(@Param("userName") String userName);



    //根据用户id查数据
    public Smbms_User getUseByID(Integer id);
    //验证添加用户编码
    public int checkUserCode(String usercode);
    //添加用户
    public int addUser(Smbms_User smbms_user);
    //修改用户信息
    public int updateUser(Smbms_User smbms_user);
    //更改用户状态
    public int userIsDelete(@Param("id") Integer id,@Param("isDelete") Integer isDelete);
}