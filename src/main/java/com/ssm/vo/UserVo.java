package com.ssm.vo;

import java.io.Serializable;

/**
 * Created by huangdonghua on 2017/11/5.
 */
public class UserVo implements Serializable {

    private int length;
    private int start;
    private int order_column;
    private String order_column_dir;
    private String username;

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getOrder_column() {
        return order_column;
    }

    public void setOrder_column(int order_column) {
        this.order_column = order_column;
    }

    public String getOrder_column_dir() {
        return order_column_dir;
    }

    public void setOrder_column_dir(String order_column_dir) {
        this.order_column_dir = order_column_dir;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "UserVo{" +
                "length=" + length +
                ", start=" + start +
                ", order_column=" + order_column +
                ", order_column_dir='" + order_column_dir + '\'' +
                ", username='" + username + '\'' +
                '}';
    }
}
