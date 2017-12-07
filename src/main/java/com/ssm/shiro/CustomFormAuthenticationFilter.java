package com.ssm.shiro;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by huangdonghua on 2017/11/12.
 */
public class CustomFormAuthenticationFilter extends FormAuthenticationFilter {

    @Override
    protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {

        //在这里进行验证码的校验
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        String url = String.valueOf(httpServletRequest.getRequestURL());
        System.out.println(url);
        HttpSession session = httpServletRequest.getSession();
        String strCode = (String) session.getAttribute("strCode");

        String logincode = httpServletRequest.getParameter("logincode");
        if(logincode!=null && strCode!=null && !logincode.equals(strCode)){
            //如果校验失败，将验证码错误失败信息，通过shiroLoginFailure设置到request中
            httpServletRequest.setAttribute("shiroLoginFailure", "randomCodeError");
            //拒绝访问，不再校验账号和密码
            return true;
        }

        return super.onAccessDenied(request, response);
    }
}
