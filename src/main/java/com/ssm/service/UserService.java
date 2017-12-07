package com.ssm.service;

import com.ssm.pojo.SysPermission;
import com.ssm.pojo.User;
import com.ssm.vo.UserVo;

import java.util.List;
import java.util.Map;

/**
 * Created by huangdonghua on 2017/11/5.
 */
public interface UserService {


    public Map<String,Object> queryUserPage(UserVo userVo) throws Exception;

    public User login(User user) throws Exception;

    public User shiroLogin(User user) throws Exception;

    public List<SysPermission> queryPermissionByUserId(String userId) throws Exception;

    public List<SysPermission> queryMenuByUserId(String userId) throws Exception;
}
