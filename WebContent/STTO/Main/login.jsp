<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>
<link rel="stylesheet" href="login.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Signika+Negative:wght@500&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>

</head>
<body>
<div class="wrapper">
	<form method="post" action="loginOk.jsp" id="content">
		<h1 id="title" align="center">Log in</h1>
		<table align="center" id="table">
			<tr height="30">
				<td align="center">
					�� �� ��
				</td>
				<td>
					&nbsp;&nbsp;<input type="text" name="mem_id">
				</td>
			</tr>
			<tr height="30">
				<td align="center">
					��й�ȣ
				</td>
				<td>
					&nbsp;&nbsp;<input type="password" name="mem_pw">
				</td>
			</tr>
		</table>
		<div align="center">
			<input class="btn_normal" type="submit" value="�α���">
			&nbsp;
			<input class="btn_normal" type="button" value="ȸ������" onclick="javascript:window.location='register.jsp'">
		</div>
	</form>
	</div>
</body>
</html>