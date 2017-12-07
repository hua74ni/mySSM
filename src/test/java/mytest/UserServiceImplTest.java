package mytest;

import com.ssm.mapper.UserMapper;
import com.ssm.pojo.SysPermission;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.junit.Assert.*;

/**
 * Created by huangdonghua on 2017/12/6.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/spring/applicationContext-dao.xml")
@Transactional
public class UserServiceImplTest {

    @Autowired
    private UserMapper userMapper;

    @Test
    public void queryPermissionByUserId() throws Exception {

        String userId = "lisi";
        List<SysPermission> list = userMapper.queryPermissionByUserId(userId);
        for (SysPermission sysPermission:
                list) {
            System.out.println(sysPermission);
        }

    }

}