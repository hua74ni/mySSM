package com.ssm.controller;

import com.ssm.pojo.User;
import com.ssm.service.UserService;
import com.ssm.vo.UserVo;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

/**
 * Created by huangdonghua on 2017/11/5.
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequiresPermissions("user:query")
    @RequestMapping("/userList")
    public @ResponseBody Map<String,Object> queryUserPage(UserVo userVo,
                         @RequestParam(required = false,name = "order[0][column]") String order_column,
                         @RequestParam(required = false,name = "order[0][dir]") String order_column_dir,
                         @RequestParam(required = false,name = "search[value]") String username){
        if(order_column != null && !order_column.equals("")){
            userVo.setOrder_column(Integer.valueOf(order_column));
        }
        if(order_column_dir != null && !order_column_dir.equals("")){
            userVo.setOrder_column_dir(order_column_dir);
        }
        if(username != null && !username.equals("")){
            userVo.setUsername(username);
        }

        Map<String,Object> map = null;
        try {
            map = userService.queryUserPage(userVo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }



    @RequestMapping("/deleteUser")
    @ResponseBody
    public Map<String,Object> deleteUser(@RequestBody String id){

        Map<String,Object> map = new HashMap<String, Object>();

        System.out.println("删除ID"+id);

        map.put("code",1);

        return map;


    }







}
