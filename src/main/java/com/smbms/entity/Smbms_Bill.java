package com.smbms.entity;

import java.math.BigDecimal;
import java.util.Date;

public class Smbms_Bill {
    private Integer bid;

    private String billcode;

    private String productname;

    private String productdesc;

    private String productunit;

    private BigDecimal productcount;

    private BigDecimal totalprice;

    private Integer ispayment;

    private Integer providerid;
    private Date createddate;
    private Smbms_Provider smbms_provider;

    public Date getCreateddate() {
        return createddate;
    }

    public void setCreateddate(Date createddate) {
        this.createddate = createddate;
    }

    public Smbms_Provider getSmbms_provider() {
        return smbms_provider;
    }

    public void setSmbms_provider(Smbms_Provider smbms_provider) {
        this.smbms_provider = smbms_provider;
    }

    public Integer getBid() {
        return bid;
    }


    public void setBid(Integer bid) {
        this.bid = bid;
    }

    public String getBillcode() {
        return billcode;
    }

    public void setBillcode(String billcode) {
        this.billcode = billcode == null ? null : billcode.trim();
    }

    public String getProductname() {
        return productname;
    }

    public void setProductname(String productname) {
        this.productname = productname == null ? null : productname.trim();
    }

    public String getProductdesc() {
        return productdesc;
    }

    public void setProductdesc(String productdesc) {
        this.productdesc = productdesc == null ? null : productdesc.trim();
    }

    public String getProductunit() {
        return productunit;
    }

    public void setProductunit(String productunit) {
        this.productunit = productunit == null ? null : productunit.trim();
    }

    public BigDecimal getProductcount() {
        return productcount;
    }

    public void setProductcount(BigDecimal productcount) {
        this.productcount = productcount;
    }

    public BigDecimal getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(BigDecimal totalprice) {
        this.totalprice = totalprice;
    }

    public Integer getIspayment() {
        return ispayment;
    }

    public void setIspayment(Integer ispayment) {
        this.ispayment = ispayment;
    }

    public Integer getProviderid() {
        return providerid;
    }

    public void setProviderid(Integer providerid) {
        this.providerid = providerid;
    }
}