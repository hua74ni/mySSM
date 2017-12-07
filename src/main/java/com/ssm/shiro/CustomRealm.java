package com.ssm.shiro;

import com.ssm.pojo.SysPermission;
import com.ssm.pojo.SystemUser;
import com.ssm.pojo.User;
import com.ssm.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by huangdonghua on 2017/11/12.
 */
public class CustomRealm extends AuthorizingRealm{

    @Autowired
    private UserService userService;

    //设置realm的名称
    @Override
    public void setName(String name){
        super.setName("customRealm");
    }

    //realm的认证方法,从数据库查询用户信息
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String userCode = (String) authenticationToken.getPrincipal();

        User sysUser = null;

        try{
            User loginUser = new User();
            loginUser.setUsercode(userCode);
            sysUser = userService.shiroLogin(loginUser);

        } catch (Exception e) {
            e.printStackTrace();
        }

        if(sysUser == null){
            return null;
        }

        String password = sysUser.getPassword();
//        String salt = sysUser.getSalt();

        SystemUser activeUser = new SystemUser();
        activeUser.setUsercode(sysUser.getUsercode());
        activeUser.setPassword(sysUser.getPassword());
        activeUser.setId(sysUser.getId());
        activeUser.setLocked(sysUser.getLocked());
        activeUser.setUsername(sysUser.getUsername());

        List<SysPermission> menus = null;

        try {
            menus = userService.queryMenuByUserId(sysUser.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        activeUser.setMenus(menus);

//        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(activeUser,password, ByteSource.Util.bytes(salt),this.getName());
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(activeUser,password,this.getName());

        return simpleAuthenticationInfo;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SystemUser activeUser = (SystemUser) principalCollection.getPrimaryPrincipal();

        List<SysPermission> permissionList = null;

        try {
            permissionList = userService.queryPermissionByUserId(activeUser.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        activeUser.setPermissions(permissionList);

        List<String> permissions = new ArrayList<String>();

        if(permissionList != null){
            for (SysPermission sysPermission:
                    permissionList) {
                permissions.add(sysPermission.getPercode());
            }
        }

        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        simpleAuthorizationInfo.addStringPermissions(permissions);

        return simpleAuthorizationInfo;
    }

    public void clearCahced(){
        PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
        super.clearCache(principals);
    }

}
