package com.ssm.interceptor;

/**
 * Created by huangdonghua on 2017/12/6.
 */

import com.ssm.utils.PropertiesUtil;
import com.ssm.utils.RedisUtil;
import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.binding.MapperProxy;
import org.apache.log4j.Logger;
import org.springframework.aop.framework.ReflectiveMethodInvocation;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;
import java.util.ArrayList;
import java.util.List;


public class MethodCacheInterceptor implements MethodInterceptor {
    private Logger logger = Logger.getLogger(MethodCacheInterceptor.class);
    private RedisUtil redisUtil;
    private static List<String> targetNamesList; // 不加入缓存的service名称
    private static List<String> methodNamesList; // 不加入缓存的方法名称
    private static Long defaultCacheExpireTime; // 缓存默认的过期时间
    private static Long xxxRecordManagerTime; //
    private static Long xxxSetRecordManagerTime; //

    /**
     * 初始化读取不需要加入缓存的类名和方法名称
     */
    static  {
        try {
            String tmpTargetNames = PropertiesUtil.getString("targetNames");
            String tmpMethodNames = PropertiesUtil.getString("methodNames");

            String[] targetNames = new String[10];
            String[] methodNames = new String[10];

            if (!StringUtils.isEmpty(tmpTargetNames)) {
                targetNames = tmpTargetNames.split(",");
            }

            if (!StringUtils.isEmpty(tmpMethodNames)) {
                methodNames = tmpMethodNames.split(",");
            }

            // 加载过期时间设置
            defaultCacheExpireTime = Long.valueOf(PropertiesUtil.getString("defaultCacheExpireTime"));
            xxxRecordManagerTime = Long.valueOf(PropertiesUtil.getString("com.service.impl.xxxRecordManager"));
            xxxSetRecordManagerTime = Long.valueOf(PropertiesUtil.getString("com.service.impl.xxxSetRecordManager"));
            // 创建list
            targetNamesList = new ArrayList<String>(targetNames.length);
            methodNamesList = new ArrayList<String>(methodNames.length);
            Integer maxLen = targetNames.length > methodNames.length ? targetNames.length
                    : methodNames.length;
            // 将x需要缓存的类名和方法名添加到list中
            for (int i = 0; i < maxLen; i++) {
                if (i < targetNames.length) {
                    targetNamesList.add(targetNames[i]);
                }
                if (i < methodNames.length) {
                    methodNamesList.add(methodNames[i]);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Object invoke(MethodInvocation invocation) throws Throwable {
        Object value = null;

        //你配置了两个通知、切点，每次拿到2次，感觉存在问题
        String targetName = invocation.getThis().getClass().getName();
        targetName = targetName.substring(0,13);
        String methodName = invocation.getMethod().getName();
        // 需要缓存的内容
        //if (!isAddCache(StringUtil.subStrForLastDot(targetName), methodName)) {
        if (!isAddCache(targetName, methodName)) {
            // 执行方法返回结果
            return invocation.proceed();
        }
        Object[] arguments = invocation.getArguments();
        String key = getCacheKey(targetName, methodName, arguments);
        System.out.println(key);

        try {
            // 判断是否有缓存
            if (redisUtil.exists(key)) {
                return redisUtil.get(key);
            }
            // 写入缓存
            value = invocation.proceed();
            if (value != null) {
                final String tkey = key;
                final Object tvalue = value;
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        if (tkey.startsWith("com.ssm.service.impl.xxxRecordManager")) {
                            redisUtil.set(tkey, tvalue, xxxRecordManagerTime);
                        } else if (tkey.startsWith("com.ssm.service.impl.xxxSetRecordManager")) {
                            redisUtil.set(tkey, tvalue, xxxSetRecordManagerTime);
                        } else {
                            redisUtil.set(tkey, tvalue, defaultCacheExpireTime);
                        }
                    }
                }).start();
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (value == null) {
                return invocation.proceed();
            }
        }
        return value;
    }

    /**
     * 是否加入缓存
     *
     * @return
     */
    private boolean isAddCache(String targetName, String methodName) {
        boolean flag = false;
        if (targetNamesList.contains(targetName)
                || methodNamesList.contains(methodName)) {
            flag = true;
        }
        return flag;
    }

    /**
     * 创建缓存key
     *
     * @param targetName
     * @param methodName
     * @param arguments
     */
    private String getCacheKey(String targetName, String methodName,
                               Object[] arguments) {
        StringBuffer sbu = new StringBuffer();
        sbu.append(targetName).append("_").append(methodName);
        if ((arguments != null) && (arguments.length != 0)) {
            for (int i = 0; i < arguments.length; i++) {
                sbu.append("_").append(arguments[i]);
            }
        }
        return sbu.toString();
    }

    public void setRedisUtil(RedisUtil redisUtil) {
        this.redisUtil = redisUtil;
    }
}
