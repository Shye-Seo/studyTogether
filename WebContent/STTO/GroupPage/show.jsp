<%@page import="java.text.SimpleDateFormat"%>
<%@page import="subPage.groupPageBean"%>
<%@page import="subPage.groupPageDBBean"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>내가 쓴 글</title>
<link rel="stylesheet" href="./GroupPageStyle/show.css">
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap')
	;

* {
	margin: 5px;
	padding: 5px;
}

li {
	list-style: none;
}

body {
	align-content: center;
	text-align: center;
}

a {
	text-decoration: none;
}

.title {
	color: navy;
	font-family: 'Signika Negative', sans-serif;
	font-size: 2em;
	font-weight: bold;
	text-align: center;
}

#txt {
	border: 3px solid navy;
	border-radius: 30px;
	width: 1000px;
	font-family: 'Gowun Dodum', sans-serif;
	font-weight: bold;
	margin-bottom: 20px;
	padding: 20px;
}

.btn_normal {
	position: relative;
	border: none;
	min-width: 100px;
	min-height: 50px;
	background: #ffb72b;
	border-radius: 1000px;
	color: white;
	cursor: pointer;
	font-weight: bold;
	font-size: medium;
	transition: 0.3s;
	font-family: 'Gowun Dodum', sans-serif;
}

.btn_normal:hover {
	transform: scale(1.2);
}

.btn_normal:hover::after {
	content: "";
	width: 30px;
	height: 30px;
	border-radius: 100%;
	border: 6px solid #ffb72b;
	position: absolute;
	z-index: -1;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	animation: ring 1.5s infinite;
}
</style>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
	<%
		response.setCharacterEncoding("UTF-8");
	%>
	<%
		int gr_mem_gnum = Integer.parseInt(request.getParameter("gr_mem_gnum"));
	int gr_mem_number = Integer.parseInt(request.getParameter("gr_mem_number"));
	String gr_mem_date = request.getParameter("gr_mem_date");
	String gr_mem_name = request.getParameter("gr_mem_name");
	String gr_mem_study = request.getParameter("gr_mem_study");
	int gr_mem_conid = Integer.parseInt(request.getParameter("gr_mem_conid"));

	groupPageDBBean gsrd = groupPageDBBean.getInstance();
	groupPageBean gsr = new groupPageBean();

	gsr = gsrd.getRecord(gr_mem_gnum, gr_mem_name, gr_mem_conid);
	%>
	<%
		ArrayList<groupPageBean> conlist = gsrd.contentList(gr_mem_gnum, gr_mem_name);
	%>
	<div style="display: inline-block; text-align: center;" align="center">
		<input type="hidden" name="groupmember" value="<%=gr_mem_name%>">
		<input type="hidden" name="content" value="<%=gr_mem_study%>">
		<div class="title" align="center">
			<h1 class="title" align="center">내가 쓴 글</h1>
		</div>
		<div align="center">
			<form method="post" name="form">
				<input type="hidden" name="gr_mem_gnum" value="<%=gr_mem_gnum%>">
				<input type="hidden" name="gr_mem_number" value="<%=gr_mem_number%>">
				<input type="hidden" name="gr_mem_name" value="<%=gr_mem_name%>">
				<input type="hidden" name="gr_mem_date" value="<%=gr_mem_date%>">
				<input type="hidden" name="gr_mem_study" value="<%=gr_mem_study%>">
				<input type="hidden" name="gr_mem_conid" value="<%=gr_mem_conid%>">
				<input style="position: relative; right: 130px; top: 232px;" class="btn_normal" type="submit" value="글 수정" onclick="javascript:form.action='edit.jsp';" />
			</form>
		</div>
		<div id="txt" align="center">
			<%
				for (int i = 0; i < conlist.size(); i++) {
				gsr = conlist.get(i);
			%>
			<form method="post" action="show_t.jsp">
				<strong> <%=(i + 1) + ". " + gsr.getGr_mem_date()%> - <span><%=gr_mem_study%></strong></span>
				<input type="hidden" name="gr_mem_gnum" value="<%=gsr.getGr_mem_gnum()%>">
				<input type="hidden" name="gr_mem_number" value="<%=gsr.getGr_mem_number()%>">
				<input type="hidden" name="gr_mem_date" value="<%=gsr.getGr_mem_date()%>">
				<input type="hidden" name="gr_mem_name" value="<%=gsr.getGr_mem_name()%>">
				<input type="hidden" name="gr_mem_conid" value="<%=gsr.getGr_mem_conid()%>">
				<input type="hidden" name="gr_mem_study" value="<%=gsr.getGr_mem_study()%>">
				<input style="position: relative; right : 123px; top: 118px;" class="btn_normal" type="submit" value="확인하기" />
			</form>
			<% 
				}
			%>
		</div>
		<div align="center">
			<button style="position: relative; left : 120px;" class="btn_normal" onclick="location.href='groupframe.jsp';javascript:form.action='confirm.jsp'">나가기</button>
		</div>
	</div>
</body>
</html>


