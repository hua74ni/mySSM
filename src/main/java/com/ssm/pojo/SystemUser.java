package com.ssm.pojo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by huangdonghua on 2017/12/3.
 */
public class SystemUser extends User implements Serializable {

    //用户菜单
    private List<SysPermission> menus = new ArrayList<SysPermission>();
    //用户权限
    private List<SysPermission> permissions = new ArrayList<SysPermission>();

    public List<SysPermission> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<SysPermission> permissions) {
        this.permissions = permissions;
    }

    public List<SysPermission> getMenus() {
        return menus;
    }

    public void setMenus(List<SysPermission> menus) {
        this.menus = menus;
    }

}
