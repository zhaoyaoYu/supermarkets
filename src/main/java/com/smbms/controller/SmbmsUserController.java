package com.smbms.controller;


import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Bill;
import com.smbms.entity.Smbms_Provider;
import com.smbms.entity.Smbms_User;
import com.smbms.service.Smbms_ProviderService;
import com.smbms.service.Smbms_UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.xml.crypto.Data;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/user")
public class SmbmsUserController {

    @Resource
    private Smbms_UserService smbms_userService;


    /*登录方法*/
    @RequestMapping("/login")
    public String userLogin(String userCode, String userPassword, HttpSession session){
        Smbms_User smbms_user = smbms_userService.userLogin(userCode, userPassword);

        if(smbms_user!=null){
            //保存数据到Session
            session.setAttribute("user",smbms_user);
            return "welcome";
        }else{
            return "login";
        }
    }

    /*退出*/
    @RequestMapping("/logOut")
    public String userLogOut(HttpSession session){
        session.removeAttribute("user");
        return "login";
    }


    /*y验证密码*/

    @RequestMapping("/checkPassword")
    @ResponseBody
    public String checkPassword(String oldPass,HttpSession session){
        Smbms_User user = (Smbms_User)session.getAttribute("user");
        System.out.println(user.getUserpassword());
        if(user.getUserpassword().equals(oldPass)){
            return "success";
        }else{
            return "failure";
        }
    }

    /*修改密码*/
    @RequestMapping("/updatePassword")
    public String updatePassowrd(String newPassword,HttpSession session){
        Smbms_User user =(Smbms_User) session.getAttribute("user");
        int count = smbms_userService.updatePassword(user.getId(),newPassword);
        if (count>0){
            session.removeAttribute("user");
            return "login";
        }else {
            return "welcome";
        }
    }


    /*查数据*/
    @RequestMapping("/getUserByName")
    @ResponseBody
    public Object getUserByName(String userName,Integer pageNum,@RequestParam(defaultValue = "3") Integer pageSize){
        PageInfo<Smbms_User> pageInfo = smbms_userService.getUserByName(userName, pageNum, pageSize);
        //通过pageInfo获取到list集合
        List<Smbms_User> list = pageInfo.getList();
        for (Smbms_User user:list) {
            Calendar calendar = Calendar.getInstance();
            //获取数据库日期
            calendar.setTime(user.getBirthday());

            //获取出生日期的年份
            int birthDayYear = calendar.get(Calendar.YEAR);
            //获取当前时间
            calendar.setTime(new Date());
            //获取当前年份
            int timeYear = calendar.get(Calendar.YEAR);
            //当前年份-出生日期年份就是年龄
            user.setUserage(timeYear-birthDayYear);
        }
        return pageInfo;
    }




    @RequestMapping("/userView/{pageNum}")
    public ModelAndView userView(@PathVariable("pageNum")Integer pageNum){
        ModelAndView mv =new ModelAndView();
        mv.setViewName("userList");
        mv.addObject("pageNum",pageNum);
        return mv;
    }
    /*根据id查用户数据*/
    @RequestMapping("/getUserByID/{id}/{pageNum}")
    public ModelAndView getUserByID(@PathVariable("id") Integer id,@PathVariable("pageNum")Integer pageNum){
        System.out.println("asasa"+id);
        ModelAndView mv =new ModelAndView();
        mv.setViewName("userView");
        Smbms_User smbms_user=smbms_userService.getUseByID(id);
        mv.addObject("user",smbms_user);
        mv.addObject("pageNum",pageNum);
        return mv;
    }



    /*根据编码校验用户*/
    @RequestMapping("/checkUserCode")
    @ResponseBody
    public String checkUserCode(String usercode){
        int count=smbms_userService.checkUserCode(usercode);
        System.out.println("controlle======"+usercode);
        if (count>0){
            return "false";
        }else {
            return "true";
        }
    }



    /*添加用户*/
    @RequestMapping("/addUser")
    public  String addUser(Smbms_User smbms_user, String birthdaydate,HttpSession session ) throws ParseException {
        System.out.println(smbms_user);
        System.out.println(birthdaydate);
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        smbms_user.setBirthday(simpleDateFormat.parse(birthdaydate));
        System.out.println(birthdaydate);
        Smbms_User smbmsUser=(Smbms_User)session.getAttribute("user");
        smbms_user.setCreatedby(smbmsUser.getId());
        smbms_user.setCreationdate(new Date());
        System.out.println(birthdaydate);
        smbms_userService.addUser(smbms_user);
        return "userList";
    }


    /*修改用户信息*/
    @RequestMapping("getUserByIDUp/{id}/{pageNum}")
    public ModelAndView getUserByIDUp(@PathVariable("id") Integer id,@PathVariable("pageNum") Integer pageNum){
        ModelAndView mv =new ModelAndView();

        mv.setViewName("userUpdate");
        Smbms_User smbmsUser=smbms_userService.getUseByID(id);

        mv.addObject("userInfo",smbmsUser);
        mv.addObject("pageNum",pageNum);
        return mv;
    }
    @RequestMapping("updateUser/{id}/{pageNum}")
    public ModelAndView updateUser(@PathVariable("id") Integer id,Smbms_User user,String birthdaydate,@PathVariable("pageNum") Integer pageNum,HttpSession session) throws ParseException {

        ModelAndView mv =new ModelAndView();
        user.setId(id);

        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        user.setBirthday(simpleDateFormat.parse(birthdaydate));
        Smbms_User smbmsUser= (Smbms_User) session.getAttribute("user");
        user.setModifyby(smbmsUser.getId());

        user.setModifydate(new Date());

        smbms_userService.updateUser(user);

        mv.setViewName("userList");
        mv.addObject("pageNum",pageNum);
        return mv;

    }

    /*更改用户状态*/

    @RequestMapping("/userIsDelete/{id}/{pageNum}/{isdelete}")
    public ModelAndView userIsDelete(@PathVariable("id") Integer id,@PathVariable("pageNum")Integer pageNum,@PathVariable("isdelete")Integer isdelete){
        smbms_userService.userIsDelete(id,isdelete);
        ModelAndView mv=new ModelAndView();
        mv.setViewName("userList");
        mv.addObject("pageNum",pageNum);
        return mv;
    }
}

