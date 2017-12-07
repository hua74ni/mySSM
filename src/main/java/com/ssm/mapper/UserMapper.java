package com.ssm.mapper;

import com.ssm.pojo.SysPermission;
import com.ssm.pojo.User;
import com.ssm.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * Created by huangdonghua on 2017/11/5.
 */

public interface UserMapper extends Mapper<User>{

    public List<User> queryUserPage(@Param("userVo") UserVo userVo);

    public int queryUserTotal(@Param("userVo") UserVo userVo);

    public User queryUserByUserCode(@Param("usercode") String usercode);

    public List<SysPermission> queryPermissionByUserId(@Param("userId") String userId);

    public List<SysPermission> queryMenuByUserId(@Param("userId") String userId);

}
