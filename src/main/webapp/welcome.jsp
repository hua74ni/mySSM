<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<style type="text/css">body {
	margin-top: 180px;
}
</style>
<script type="text/javascript">

    function goMain(){
        window.location.href = '${pageContext.request.contextPath}/main.do';
    }

    function logout(){
        window.location.href = '${pageContext.request.contextPath}/logout.do';
    }

    function clearShiroCache(){
        window.location.href = '${pageContext.request.contextPath}/clearShiroCache.do';
    }

</script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><img src="resouces/image/welcome.gif" width="145" height="46" /></td>
  </tr>
</table>
<input id="btn" name="btn" type="button" onclick="goMain()" value="进入用户管理" />
<input type="button" onclick="clearShiroCache()" value="清除缓存" />
<input type="button" onclick="logout()" value="退出" />


</body>
</html>

