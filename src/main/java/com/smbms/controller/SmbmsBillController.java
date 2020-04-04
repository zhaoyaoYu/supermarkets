package com.smbms.controller;


import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Bill;
import com.smbms.entity.Smbms_Provider;

import com.smbms.service.Smbms_BillService;
import com.smbms.service.Smbms_ProviderService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bill")
public class SmbmsBillController {

    @Resource
    private Smbms_BillService smbms_billService;
    @Resource
    private Smbms_ProviderService smbms_providerService;
    /*查账单数据*/
    @RequestMapping("/getBillList")
    @ResponseBody
    public Object getBillList(String productName, Integer providerId, Integer isPayment, Integer pageNum, @RequestParam(defaultValue = "5") Integer pageSize){
        Map<String,Object> map=new HashMap<>();

        List<Smbms_Provider> proList = smbms_providerService.getProList();


        PageInfo<Smbms_Bill> pageInfo=smbms_billService.getBillList(productName, providerId, isPayment, pageNum, pageSize);
        map.put("pageInfo",pageInfo);
        map.put("proList",proList);
        return map;
    }




    @RequestMapping("/billView/{pageNum}")
    public ModelAndView billView(@PathVariable("pageNum")Integer pageNum){
        ModelAndView mv =new ModelAndView();
        mv.setViewName("billList");
        mv.addObject("pageNum",pageNum);
        return mv;
    }
    /*根据id查商品数据*/
    @RequestMapping("/getBillByID/{bid}/{pageNum}")
    public ModelAndView getBillByID(@PathVariable("bid") Integer bid,@PathVariable("pageNum")Integer pageNum){

        ModelAndView mv =new ModelAndView();

        mv.setViewName("billView");

        Smbms_Bill smbms_bill=smbms_billService.getBillByID(bid);

        mv.addObject("bill",smbms_bill);
        mv.addObject("pageNum",pageNum);
        return mv;
    }



    /*修改用户信息*/
    @RequestMapping("getBillByIDUp/{bid}/{pageNum}")
    public ModelAndView getBillByIDUp(@PathVariable("bid") Integer bid,@PathVariable("pageNum") Integer pageNum){
        ModelAndView mv =new ModelAndView();

        mv.setViewName("billUpdate");
        Smbms_Bill smbmsBill=smbms_billService.getBillByID(bid);
        mv.addObject("billInfo",smbmsBill);
        mv.addObject("pageNum",pageNum);
        return mv;
    }
    @RequestMapping("updateBill/{bid}/{pageNum}")
    public ModelAndView updateUser(@PathVariable("bid") Integer bid, Smbms_Bill bill, @PathVariable("pageNum") Integer pageNum, HttpSession session){

        ModelAndView mv =new ModelAndView();

        bill.setBid(bid);
        Smbms_Bill smbmsBill= (Smbms_Bill) session.getAttribute("bill");

        smbms_billService.updateBill(bill);
        mv.setViewName("billList");
        mv.addObject("pageNum",pageNum);
        return mv;

    }


    /*删除商品数据*/
    @RequestMapping("/deleteBill/{bid}/{pageNum}")
    public ModelAndView deleteProvider(@PathVariable("bid") Integer bid,@PathVariable("pageNum") Integer pageNum){
        smbms_billService.deleteBill(bid);
        ModelAndView mv =new ModelAndView();
        mv.setViewName("billList");
        mv.addObject("pageNum",pageNum);
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





    /*添加商品信息*/
    @RequestMapping("/checkBillCode")
    @ResponseBody
    public String checkBillCode(String billCode){
        int count=smbms_billService.checkBillCode(billCode);
        if (count>0){
            return "false";
        }else {
            return "true";
        }
    }
    @RequestMapping("/addBill")
    public String addProvider(Smbms_Bill smbms_bill){

        smbms_billService.addBill(smbms_bill);
        return "billList";
    }

}
