package com.smbms.entity;

import java.util.Date;

public class Smbms_Provider {
    private Integer pid;

    private String procode;

    private String proname;

    private String prodesc;

    private String procontact;

    private String prophone;

    private String proaddress;

    private String profax;

    private Integer createdby;

    private Date creationdate;

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getProcode() {
        return procode;
    }

    public void setProcode(String procode) {
        this.procode = procode == null ? null : procode.trim();
    }

    public String getProname() {
        return proname;
    }

    public void setProname(String proname) {
        this.proname = proname == null ? null : proname.trim();
    }

    public String getProdesc() {
        return prodesc;
    }

    public void setProdesc(String prodesc) {
        this.prodesc = prodesc == null ? null : prodesc.trim();
    }

    public String getProcontact() {
        return procontact;
    }

    public void setProcontact(String procontact) {
        this.procontact = procontact == null ? null : procontact.trim();
    }

    public String getProphone() {
        return prophone;
    }

    public void setProphone(String prophone) {
        this.prophone = prophone == null ? null : prophone.trim();
    }

    public String getProaddress() {
        return proaddress;
    }

    public void setProaddress(String proaddress) {
        this.proaddress = proaddress == null ? null : proaddress.trim();
    }

    public String getProfax() {
        return profax;
    }

    public void setProfax(String profax) {
        this.profax = profax == null ? null : profax.trim();
    }

    public Integer getCreatedby() {
        return createdby;
    }

    public void setCreatedby(Integer createdby) {
        this.createdby = createdby;
    }

    public Date getCreationdate() {
        return creationdate;
    }

    public void setCreationdate(Date creationdate) {
        this.creationdate = creationdate;
    }
}