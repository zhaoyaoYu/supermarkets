package com.smbms.service.Impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.smbms.entity.Smbms_Bill;
import com.smbms.entity.Smbms_Provider;
import com.smbms.mapper.Smbms_BillMapper;
import com.smbms.service.Smbms_BillService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;


@Service("Smbms_BillService")
public class Smbms_BillServiceImpl implements Smbms_BillService {

    @Resource
    private Smbms_BillMapper smbms_billMapper;

    @Override
    public PageInfo<Smbms_Bill> getBillList(String productName, Integer providerId, Integer isPayment, Integer pageNum, Integer pageSize) {
        //开启PageHelper分页
        Page<Smbms_Bill> page = PageHelper.startPage(pageNum, pageSize);

            smbms_billMapper.getBillList(productName, providerId, isPayment);

        return page.toPageInfo();
    }

    @Override
    public Smbms_Bill getBillByID(Integer bid) {
        return smbms_billMapper.getBillByID(bid);
    }

    @Override
    public int checkBillCode(String billcode) {
        return smbms_billMapper.checkBillCode(billcode);
    }

    @Override
    public int addBill(Smbms_Bill smbms_bill) {
        return smbms_billMapper.addBill(smbms_bill);
    }

    @Override
    public int updateBill(Smbms_Bill smbms_bill) {
        return smbms_billMapper.updateBill(smbms_bill);
    }

    @Override
    public int deleteBill(Integer bid) {
        return smbms_billMapper.deleteBill(bid);
    }
}
