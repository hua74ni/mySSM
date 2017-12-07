<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"/>
<html>
<head>
<script src="${pageContext.request.contextPath}/resouces/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resouces/bootstrap3/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resouces/bootstrap3/css/bootstrap.min.css">
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录界面</title>

<script type="text/javascript">

	$(function(){
	   var msg = '${requestScope.loginMsg}';
	   if(msg != undefined && msg != null && msg != ""){
	       alert(msg);
       }
	});
	
	function loginSubmit(){
		var username = $("#loginusername").val();
		var password = $("#loginpassword").val();
		var logincode = $("#logincode").val();
		var remember = 0;
		
		if(username == ''){
			alert("帐号和密码不能为空 ");
			return;
		}
		if(password == ''){
			alert("帐号和密码不能为空 ");
			return;
		}
		if(logincode == ''){
			alert("验证码不能为空 ");
			return;
		}

        $("#myForm").submit();

		<%--var jsondata = {"username":username,"password":password,"logincode":logincode,"locked":remember};--%>
		<%--$.ajax({--%>
			<%--url : "${pageContext.request.contextPath}/login.do",--%>
			<%--type : "post",--%>
			<%--contentType : "application/json",--%>
			<%--data : JSON.stringify(jsondata),--%>
			<%--success : function(data){--%>
			    <%--console.log(data);--%>
				<%--if(data.code == 1){--%>
					<%--alert("登录成功, 欢迎回来！");--%>
                    <%--&lt;%&ndash;$.post("${pageContext.request.contextPath}/main.do");&ndash;%&gt;--%>
					<%--window.location.href="${pageContext.request.contextPath}/main.do";--%>
				<%--}else if(data.code == 2){--%>
					<%--alert("账号或密码错误！");--%>
				<%--}else{--%>
					<%--alert("验证码输入错误！");--%>
				<%--}--%>
				<%--chageCode();--%>
			<%--},--%>
			<%--error : function(data){--%>
				<%--alert("出现异常！");--%>
			<%--}--%>
 		<%--});--%>


	}
	
	function registerSubmit(){
		var username = $("#username").val();
		var password = $("#password").val();
		var repassword = $("#repassword").val();
		var truename = $("#truename").val();
		var phone = $("#phone").val();
		var mail = $("#mail").val();
		var code = $("#code").val();
		
		if(username == ''){
			alert("请输入账号");
			return;
		}
		if(password == ''){
			alert("请输入密码");
			return;
		}
		if(password != repassword){
			alert("2次输入的密码不一样");
			return;
		}
		if(truename == ''){
			alert("请输入真实姓名");
			return;
		}
		if(phone == ''){
			alert("请输入手机号");
			return;
		}
		
		if(!(/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(phone))){ 
	        alert("不是完整的11位手机号或者正确的手机号前七位"); 
	        return; 
	    } 
		
		if(mail == ''){
			alert("请输入邮箱");
			return;
		}
		re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
		if(!re.test(mail)){
			alert("请输入正确格式的邮箱");
			return;
		}
		
		if(code == ''){
			alert("请输入验证码");
			return;
		}
		
		var jsondata = {"userName":username,"passWord":password,"realName":truename,"phone":phone,"mail":mail,"userId":code}; 
		$.ajax({
			url : "${pageContext.request.contextPath}/register.do",
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(jsondata),
			success : function(data){
				if(data.code == 1){
					alert("注册成功！");
					window.location.href="${pageContext.request.contextPath}/jsp/main.jsp";
				}
				if(data.code == 2){
					alert("注册失败！");		
				}
				if(data.code == 3){
					alert("验证码输入错误");		
				}
				if(data.code == 4){
					alert("用户名已存在");		
				}
			},
			error : function(data){
				alert("出现异常！");
			}
		})
	}
	
	function chageCode(){
        $('#codeImage').attr('src','${pageContext.request.contextPath}/authCode.do?abc='+Math.random());//链接后添加Math.random，确保每次产生新的验证码，避免缓存问题。
    }
	
</script>

</head>
<div class="jumbotron" style="height: 570px;">
	<div class="container" align="center" style="margin-top: 130px;">
		<h2 class="text-info"
			style="font-family: 宋体; font-weight: bold; font-size: 49px">主&nbsp;界&nbsp;面</h2>
		<br> <br>
		<div class="text-muted">模态窗体的用例</div>
		<br> <br>
		<button type="button" class="btn btn-lg btn-primary" data-toggle="modal" data-target="#myModal1">登录</button>
		&nbsp;&nbsp;&nbsp;
		<button type="button" class="btn btn-lg btn-info" data-toggle="modal" data-target="#myModal2">注册</button>
	</div>
</div>

<!-- 登录的模态框（modal） -->
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
<div class="modal-dialog">
	<div class="modal-content">
	
		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">
				<span aria-hidden="true">×</span><span class="sr-only">Close</span>
			</button>
			<h4 class="modal-title">登录界面</h4>
		</div>
		<form id="myForm" action="${pageContext.request.contextPath}/login.do" method="post">
		<div class="modal-body" style="height:340px;">
			<p style="font-size:23px;margin: 8px 18px;">
				用户名:<input type="text" name="username" id="loginusername" class="form-control" style="font-size: 17px;height: 44px;" placeholder="输入用户名..."/><br>
			</p>
			<p style="font-size:23px;margin: 8px 18px;">
				密&nbsp;&nbsp;&nbsp;&nbsp;码:<input type="password" name="password" id="loginpassword" class="form-control" style="font-size: 17px;height: 44px;" placeholder="输入密码..."/>
				<br>
			</p>
			<p style="font-size:14px;margin: 8px 18px;">
				自动登录:<input type="checkbox" name="rememberMe" id="rememberMe"/>
				<p style="font-size:20px;margin: 0px 20px;height: 85px; float:right; " class="input-group rowSpacing" >
					<img type="image" src="${pageContext.request.contextPath}/authCode.do" aria-describedby="basic-addon1" id="codeImage" onclick="chageCode()" title="图片看不清？点击重新得到验证码" style="cursor:pointer;"/>
					<input type="text" name="logincode" id="logincode" class="form-control" style="font-size: 16px;height: 38px;width:64px;"/>
					<br>
				</p>			
		</div>
		
		<div class="modal-footer">
			<button class="btn btn-primary  btn-success" type="button" onclick="loginSubmit()">登录</button>
			<button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
		</div>
		</form>
	</div>
	<!-- /.modal-content -->
</div>
<!-- /.modal-dialog -->
</div>


<!-- 注册的模态框（Modal） -->
<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
        
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">注册界面</h4>
            </div>
            
            <div class="modal-body">
            	<p style="font-size:20px;margin: 0px 20px;height: 85px;">
					真实姓名:<input type="text" name="truename" id="truename" class="form-control" style="font-size: 16px;height: 44px;"/><br>
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 85px;">
					用户名:<input type="text" name="username" id="username" class="form-control" style="font-size: 16px;height: 44px;"/><br>
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 85px;">
					密&nbsp;&nbsp;&nbsp;&nbsp;码:<input type="password" name="password" id="password" class="form-control" style="font-size: 16px;height: 44px;"/>
					<br>
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 85px;">
					确认密码:<input type="password" name="repassword" id="repassword" class="form-control" style="font-size: 16px;height: 44px;"/>
					<br>
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 85px;">
					手机号:<input type="text" name="phone" id="phone" class="form-control" style="font-size: 16px;height: 44px;"/><br>
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 85px;">
					邮&nbsp;&nbsp;&nbsp;&nbsp;箱:<input type="text" name="mail" id="mail" class="form-control" style="font-size: 16px;height: 44px;"/><br>
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 40px;">
					验证码:
				</p>
				<p style="font-size:20px;margin: 0px 20px;height: 85px;" class="input-group rowSpacing">
					<input type="text" name="code" id="code" class="form-control" style="font-size: 16px;height: 38px;width:64px;"/>
					<img type="image" src="${pageContext.request.contextPath}/authCode.do" aria-describedby="basic-addon1" id="codeImage" onclick="chageCode()" title="图片看不清？点击重新得到验证码" style="cursor:pointer;"/>
					<br>
				</p>
				
			</div>
            
            <div class="modal-footer">
            	<button type="button" class="btn btn-primary" onclick="registerSubmit()">注册</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
            
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

</html>