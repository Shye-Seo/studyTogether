<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="register.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>
<script type="text/javascript" src="script.js" charset="UTF-8"></script>

</head>
<body>
<div class="wrapper">
	<form name="reg_frm" method="post" action="registerOk.jsp" id="content">
		<h1 class="title">Welcome To STTO</h1>
		<table border="1">
			<tr>
				<td colspan="2" align="center">
					<h1>회원가입</h1>
					'*' 표시 항목은 필수 입력 항목입니다.
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					아이디 *
				</td>
				<td>
					<input type="text" size="20" name="mem_id" placeholder="아이디">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					비밀번호 *
				</td>
				<td>
					<input type="password" size="20" name="mem_pw" placeholder="비밀번호">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					비밀번호 확인 *
				</td>
				<td>
					<input type="password" size="20" name="pw_check" placeholder="비밀번호 확인">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					이    름 *
				</td>
				<td>
					<input type="text" size="20" name="mem_name" placeholder="이름">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					주민번호 *
				</td>
				<td>
					<input type="text" size="20" name="mem_jumin" placeholder="주민번호">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					전화번호 *
				</td>
				<td>
					<input type="text" size="20" name="mem_tel" placeholder="전화번호">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					이메일
				</td>
				<td>
					<input type="text" size="30" name="mem_email" placeholder="이메일">
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					관심분야 *
				</td>
				<td>
					<input type="checkbox" name="mem_interests" value="backend">&nbsp;백엔드
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="mem_interests" value="frontend">&nbsp;프론트엔드
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					언어 *
				</td>
				<td>
					<select id="language" name="mem_inter_ch">
						<option value="언어" selected="selected">언어</option>
						<option value="java">java</option>
						<option value="python">python</option>
						<option value="jsp">jsp</option>
						<option value="spring">spring</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="120" align="center">
					소개글
				</td>
				<td>
					<textarea name="mem_introduce" rows="10" cols="50" placeholder="소개글"></textarea>
				</td>
			</tr>
		</table>
		<div align="center" class="btn_area">
			<input class="btn_normal" type="button" value="등록" onclick="check_ok()">
			&nbsp;&nbsp;&nbsp;
			<input class="btn_normal" type="reset" value="다시입력">
			&nbsp;&nbsp;&nbsp;
			<input class="btn_normal" type="button" value="가입안함" onclick="javascript:window.location='login.jsp'">
		</div>
	</form>
</div>
</body>
</html>