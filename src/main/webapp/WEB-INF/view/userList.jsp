<%--
  Created by IntelliJ IDEA.
  User: huangdonghua
  Date: 2017/11/5
  Time: 下午8:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户管理</title>
    <script src="${pageContext.request.contextPath}/resouces/js/jquery.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resouces/bootstrap3/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resouces/bootstrap3/css/bootstrap-theme.min.css">

    <script src="${pageContext.request.contextPath}/resouces/bootstrap3/js/bootstrap.min.js"></script>

    <link href="${pageContext.request.contextPath}/resouces/css/jquery-confirm.min.css"
            rel="stylesheet" type="text/css" />
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resouces/js/jquery-confirm.min.js"></script>
    <!--  表格会出现黑线，底部翻页变成大图标，很不好看还有阴影，不建议使用
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css" />
-->
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/resouces/css/dataTables.bootstrap.css" />
    <!-- 导出数据按钮样式 -->
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath}/resouces/css/dataTables.tableTools.css" />
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resouces/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resouces/js/dataTables.bootstrap.js"></script>
    <!-- 导出数据按钮引用的js-->
    <script type="text/javascript" charset="utf-8"
            src="${pageContext.request.contextPath}/resouces/js/dataTables.tableTools.js"></script>
    <script language="JavaScript">
        //删除
        function delBtn(obj){
            var id = $(obj).attr('data-id');
            var url = "${pageContext.request.contextPath}/user/deleteUser.do";
            var jsonData = {'id':id};
            $.ajax({
                url:url,
                type:'post',
                data : jsonData,
                success : function(data){
                    if(data.code == 1){
                        alert("删除成功");
                    }else{
                        alert("删除失败");
                    }
                }
            });
        }
        //退出
        function logout(){
            window.location.href = "${pageContext.request.contextPath}/logout.do";
        }
    </script>
    <style>
        table th,td{
            text-align: center;
        }
    </style>
</head>
<body>

    <div style="margin: 10px;">
        <table id="example" class="table table-bordered table-condensed">
            <thead>
            <tr>
                <th><input name="id" type="checkbox" /></th>
                <th>用户编号</th>
                <th>账号</th>
                <th>用户名</th>
                <th>密码</th>
                <th>盐</th>
                <th>用户状态</th>
                <th>操作&nbsp;&nbsp;:&nbsp;&nbsp;
                    <button id="addSeller" class="btn btn-primary btn-sm">
                        <span class="glyphicon glyphicon-plus"></span> &nbsp;新增
                    </button>
                </th>
            </tr>
            </thead>
        </table>
    </div>
    <div>
        <button onclick="javascript:logout()">退出</button>
    </div>

    <script language="JavaScript">
        $(function() {
            var table = $("#example").DataTable({
                "aLengthMenu":[4,8,10,20],
                "searching":true,//禁用搜索
                "lengthChange":true,
                "paging": true,//开启表格分页
                "bProcessing" : true,
                "bServerSide" : true,
                "bAutoWidth" : false,
                "sort" : "position",
                "deferRender":true,//延迟渲染
                "bStateSave" : false, //在第三页刷新页面，会自动到第一页
                "iDisplayLength" : 10,
                "iDisplayStart" : 0,
                "dom": '<l<\'#topPlugin\'>f>rt<ip><"clear">',
                // "dom": 'T<"clear">lfrtip',
                // "dom": 'iCflrtp',
//	     "tableTools": {
//	            "sSwfPath": contextPath +"/js/copy_csv_xls_pdf.swf",
//	            "sRowSelector": "td:not(:first-child)"
//	           ,
////	            "aButtons": [
////	                 {sExtends: "csv", oSelectorOpts: {page: "current" }},
////	                 "print"],
//	            "sRowSelect": "os",
//	        },
                "ordering": true,//全局禁用排序
                "ajax": {
                    "type": "POST",
                    "url": "${pageContext.request.contextPath}/user/userList.do",
                    "data":function(d){
//                        d.state=$("#state").val();
//                        d.deptname=$("#deptname").val().trim();
//                        d.startTime=$("#startTime").val();
//                        d.endTime=$("#endTime").val();
                    }
                },
                "aoColumns" : [{
                    "mData" : "id",
                    "orderable": false , // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "2%"
                },{
                    "mData" : "id",
                    "orderable" : true, // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "10%",
                }, {
                    "mData" : "usercode",
                    "orderable" : true, // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "10%"
                }, {
                    "mData" : "username",
                    "orderable" : false, // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "10%"
                },{
                    "mData" : "password",
                    "orderable" : false, // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "10%"
                },{
                    "mData" : "salt",
                    "orderable" : false, // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "10%"
                },{
                    "mData" : "locked",
                    "orderable" : false, // 禁用排序
                    "sDefaultContent" : "",
                    "sWidth" : "8%",
                    "render" : function(data, type, full, meta) {
                        if(data==0){
                            return data ='正常';
                        }else{
                            return data ='被锁';
                        }
                        return   data;
                    }
                },
                    {
                        "mData" : "id",
                        "orderable" : false, // 禁用排序
                        "sDefaultContent" : '',
                        "sWidth" : "14%",
                        "render":function(data, type, full, meta){
                            return  data='<button id="deleteOne" class="btn btn-danger btn-sm" onclick="javascript:delBtn(this)" data-id='+data+'>删 除</button>';
                        }
                    }],
                "columnDefs" :
                    [{
                        "orderable" : false, // 禁用排序
                        "targets" : [0], // 指定的列
                        "data" : "id",
                        "render" : function(data, type, full, meta) {
                            return '<input type="checkbox" value="'+ data + '" name="id"/>';
                        }
                    }],
                "oLanguage" : { // 国际化配置
                    "sProcessing" : "正在获取数据，请稍后...",
                    "sLengthMenu" : "显示 _MENU_ 条",
                    "sZeroRecords" : "没有找到数据",
                    "sInfo" : "从 _START_ 到  _END_ 条记录 总记录数为 _TOTAL_ 条",
                    "sInfoEmpty" : "记录数为0",
                    "sInfoFiltered" : "(全部记录数 _MAX_ 条)",
                    "sInfoPostFix" : "",
                    "sSearch" : "搜索",
                    "sUrl" : "",
                    "oPaginate" : {
                        "sFirst" : "第一页",
                        "sPrevious" : "上一页",
                        "sNext" : "下一页",
                        "sLast" : "最后一页"
                    }
                },
//                initComplete:initComplete,
                drawCallback: function( settings ) {
                    $('input[name=id]')[0].checked=false;//取消全选状态
//	        function initComplete(data){
//	        	//上方topPlugin DIV中追加HTML
//	        	var topPlugin='<button id="addButton" class="btn btn-success btn-sm" data-toggle="modal" data-target="#addUser" style="display:block;">' +
//	        				  '<span class="glyphicon glyphicon-plus" aria-hidden="true"></span>批量删除</button>';
//
//	        	//删除用户按钮的HTMLDOM
//	            var deleteHtml='<button id="deleteButton" class="btn btn-danger btn-sm" style="flot:left;margin-right:10px;">批量删除用户</button>' +
//	    					       '<span name="deleteTips" style="flot:left;margin-right:10px;color:green;"></span><div style="clear:left;"></div>';
//
//	    		$("#topPlugin").append(topPlugin);//在表格上方topPlugin DIV中追加HTML
//	           // $("#deleteDep").append(deleteHtml);//表格下方的按钮操作区
//	           // $("#deleteButton").on("click", deleteUser);//给下方按钮绑定事件
//
//          }
                }
            });



        });



    </script>

</body>

</html>
