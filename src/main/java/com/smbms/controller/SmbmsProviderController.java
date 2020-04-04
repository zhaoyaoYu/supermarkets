package com.smbms.controller;


import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Provider;
import com.smbms.entity.Smbms_User;
import com.smbms.service.Smbms_ProviderService;
import com.smbms.service.Smbms_UserService;
import com.sun.deploy.net.HttpResponse;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/provider")
public class SmbmsProviderController {
    @Resource
    private Smbms_ProviderService smbms_providerService;

    /*查供应商数据*/
    @RequestMapping("/getProviderByName")
    @ResponseBody
    public Object getProviderByName(String proName,Integer pageNum,@RequestParam(defaultValue = "5") Integer pageSize) throws ParseException {
        PageInfo<Smbms_Provider> pageInfo = smbms_providerService.getProviderByName(proName, pageNum, pageSize);

        return pageInfo;


    }


    /*根据id查供应商数据*/
    @RequestMapping("/getProByCode/{pid}/{pageNum}")
    public ModelAndView getProByCode(@PathVariable("pid")Integer pid,@PathVariable("pageNum")Integer pageNum){
        ModelAndView mv =new ModelAndView();
        Smbms_Provider smbms_provider=smbms_providerService.getProviderByID(pid);

        mv.addObject("pro",smbms_provider);
        mv.addObject("pageNum",pageNum);
        mv.setViewName("providerView");
        return mv;
    }

    @RequestMapping("/returnProList/{pageNum}")
    public ModelAndView returnProList(@PathVariable("pageNum")Integer pageNum){
        ModelAndView mv =new ModelAndView();
        mv.addObject("pageNum",pageNum);
        mv.setViewName("providerList");
        return mv;
    }


    /*删除供应商数据*/
    @RequestMapping("/deleteProvider/{proCode}/{pageNum}")
    public ModelAndView deleteProvider(@PathVariable("proCode") String proCode,@PathVariable("pageNum") Integer pageNum){
        smbms_providerService.deleteProvider(proCode);
        ModelAndView mv =new ModelAndView();
        mv.addObject("pageNum",pageNum);
        mv.setViewName("providerList");
        return mv;
    }

    /*配置异常处理*/
    @ExceptionHandler
    public  ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex){
        ModelAndView mv =new ModelAndView();
        if (ex instanceof EnumConstantNotPresentException){
                  mv.setViewName("providerError");
        }
        return mv;
    }



    @RequestMapping("/checkProviderCode")
    @ResponseBody
    public String checkProviderCode(String procode){
        int count=smbms_providerService.checkProviderCode(procode);
        if (count>0){
            return "false";
        }else {
            return "true";
        }
    }

    @RequestMapping("/addProvider")
    public String addProvider(Smbms_Provider smbms_provider){

        smbms_providerService.addProvider(smbms_provider);
        System.out.println("smbms_provider"+smbms_provider);
        return "providerList";
    }




    /*修改用户信息*/
    @RequestMapping("/getProviderByPIDUp/{pid}/{pageNum}")
    public ModelAndView getProviderByPIDUp(@PathVariable("pid") Integer pid,@PathVariable("pageNum") Integer pageNum){
        ModelAndView mv =new ModelAndView();

        mv.setViewName("providerUpdate");
        Smbms_Provider smbmsProvider=smbms_providerService.getProviderByID(pid);


        mv.addObject("providerInfo",smbmsProvider);
        mv.addObject("pageNum",pageNum);
        return mv;
    }
    @RequestMapping("/updateProvider/{pid}/{pageNum}")
    public ModelAndView updateProvider(@PathVariable("pid") Integer pid, Smbms_Provider provider, @PathVariable("pageNum") Integer pageNum, HttpSession session) throws ParseException {

        ModelAndView mv =new ModelAndView();
        provider.setPid(pid);
        Smbms_Provider smbms_provider= (Smbms_Provider) session.getAttribute("provider");
        smbms_providerService.updateProvider(provider);

        mv.setViewName("providerList");
        mv.addObject("pageNum",pageNum);
        return mv;

    }

    @RequestMapping("/providerView/{pageNum}")
    public ModelAndView providerView(@PathVariable("pageNum")Integer pageNum){
        ModelAndView mv =new ModelAndView();
        mv.setViewName("providerList");
        mv.addObject("pageNum",pageNum);
        return mv;
    }
}
