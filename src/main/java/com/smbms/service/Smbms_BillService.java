package com.smbms.service;

import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Bill;


import java.util.List;

public interface Smbms_BillService {


    //根据账单列表查供应商
    public PageInfo<Smbms_Bill> getBillList(String productName, Integer providerId, Integer isPayment,Integer pageNum,Integer pageSize);

    //根据商品id查数据
    public Smbms_Bill getBillByID(Integer bid);
    //验证添加商品编码
    public int checkBillCode(String billcode);
    //添加商品
    public int addBill(Smbms_Bill smbms_bill);
    //修改商品信息
    public int updateBill(Smbms_Bill smbms_bill);
    //删除订单数据
    public  int deleteBill(Integer bid);
}
