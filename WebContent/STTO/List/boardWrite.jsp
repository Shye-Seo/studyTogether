<%@page import="member.MemberDBBean"%>
<%@page import="member.MemberBean"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="board.BoardBean" scope="request"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%
	String mem_id = (String)session.getAttribute("mem_id");
	
	BoardDBBean db = BoardDBBean.getInstance();
	MemberBean member = new MemberBean();
	MemberDBBean mdb = MemberDBBean.getInstance();
%>
<html>
<head>
<meta charset="UTF-8">
<link href="./ListStyle/boardWrite.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>
<title>글쓰기</title>
	<script src="board.js" type="text/javascript"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
</head>
<body>
	<div class="wrapper">
		<form name="reg_frm" method="post" action="boardWrite_ok.jsp" id="content">
			<h1 class="title">스터디 그룹 모집글</h1>
			<input type="hidden" name="b_id" value="<%= mem_id %>">
			<table border="1">
				<tr height="30">
					<td width="80" align="center">글 제 목
					</td>
					<td width="240" colspan="4">
						<input type="text" name="b_title" size="100" maxlength="100">
					</td>
					<td width="80" align="center"><%=mem_id %></td>
				</tr>
				<tr height="30">
					<td width="80" align="center">스터디 목표
					</td>
					<td width="240" colspan="5">
						<input type="text" name="b_goal" size="100" maxlength="100">
					</td>
				</tr>
					<td align="center">
						멤버수
					</td>
					<td colspan="2">
						<select name="b_stmember">
							<option selected="selected">선택</option>
							<option>2</option>
							<option>3</option>
							<option>4</option>
							<option>5</option>
							<option>6</option>
						</select>
					</td>
					<td width="80" align="center">분  야</td>
					<td width="240" colspan="2">
						<select id="b_inter_c" name="b_inter_c">
							<option value="분야" selected="selected">선택</option>
							<option value="backend">백엔드</option>
							<option value="frontend">프론트엔드</option>
						</select>
					</td>
					
				</tr>
				<tr height="30">
					<td width="80" align="center">지  역</td>
					<td width="240" colspan="2">
						<select name="area">
							<option value="지역" selected="selected">지역</option>
							<option value="seoul">서울</option>
							<option value="gyeonggi">경기</option>
							<option value="incheon">인천</option>
							<option value="busan">부산</option>
							<option value="daegu">대구</option>
							<option value="daejeon">대전</option>
							<option value="gwangju">광주</option>
							<option value="online">온라인</option>
						</select>
					</td>
					<td width="80" align="center">언  어</td>
					<td width="240" colspan="2">
						<select id="languages" name="languages">
							<option value="언어" selected="selected">선택</option>
							<option value = "java" >java</option>
							<option value = "javascript" >javascript</option>
							<option value = "spring" >spring</option>
							<option value = "kotlin" >kotlin</option>
							<option value="python">python</option>
							<option value="jsp">jsp</option>
						</select>
					</td>
				</tr>
				<tr>
					<td  width="100" align="center"><b>시작일</b> </td>
					<td colspan="2"><input type="tel" name="b_startdate" placeholder="ex)2022.01.01"></td>
					
					<td width="100" align="center"><b>종료일</b></td>
					<td colspan="2"><input type="text" name="b_finishdate" placeholder="ex)2022.01.01"></td>
				</tr>
				<tr>
					<td width="80" align="center">글내용
					</td>
					<td colspan="6">
						<textarea rows="10" cols="90" name="b_content"></textarea>
					</td>
				</tr>
			</table>
			<div align="center" class="btn_area">
				<input class="btn_normal" type="submit" value="글쓰기">
				&nbsp;
				<input class="btn_normal" type="reset" value="다시작성">
				&nbsp;
				<input class="btn_normal" type="button" value="글목록" onclick="location.href='list.jsp'">
			</div>
		</form>
	</div>
</body>
</html>