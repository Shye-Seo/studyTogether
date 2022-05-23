<%@page import="subPage.groupPageBean"%>
<%@page import="subPage.groupPageDBBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>new registration</title>
<link href="./GroupPageStyle/confirm.css" rel="stylesheet">
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
	<%
		response.setCharacterEncoding("UTF-8");
	Calendar cal = Calendar.getInstance();
	//현재 시간
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy년 MM월 dd일");
	String nowTime = sdf1.format(cal.getTime());

	//작성 날짜
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	String gr_mem_date = sdf.format(cal.getTime());
	%>
	<%
		int gr_mem_gnum = Integer.parseInt(request.getParameter("gr_mem_gnum"));
	int gr_mem_number = Integer.parseInt(request.getParameter("gr_mem_number"));
	int numValCheck = Integer.parseInt(request.getParameter("numValCheck"));
	String gr_mem_name = request.getParameter("gr_mem_name");
	String b_title = request.getParameter("b_title");

	groupPageDBBean grdb = groupPageDBBean.getInstance();
	ArrayList<groupPageBean> conlist = grdb.contentList(gr_mem_gnum, gr_mem_name);
	groupPageBean gsr = new groupPageBean();
	%>
	<div class="wrapper">
		<h1 class="title"><%=b_title%></h1>
	</div>
	<div class="wrapper">
		<h2 class="title">Today</h2>
		<h4 align="center"><%=nowTime%></h4>
	</div>
	<%
		//사용자 이름
	%>
	<div class="confirm_wrap_name">
		<h1><%=gr_mem_name%></h1>
		<button class="btn_normal"<%-- onclick="location.href='groupframe.jsp?gr_mem_gnum=<%=gr_mem_gnum%>';javascript:form.action='groupframe.jsp'" --%>>나가기</button>
	</div>

	<%
		//작성한 글
	%>
	<div style = "overflow:auto; width : auto; height : auto;">
	<%
		for (int i = 0; i < conlist.size(); i++) {
		gsr = conlist.get(i);
	%>
		<div class="confirm_wrap">
			<form method="post" action="show.jsp">
				<h1>
					<input type="hidden" name="gr_mem_gnum" value="<%=gr_mem_gnum%>">
					<input type="hidden" name="gr_mem_number" value="<%=gr_mem_number%>">
					<input type="hidden" name="gr_mem_date" value="<%=gr_mem_date%>">
					<input type="hidden" name="gr_mem_name" value="<%=gr_mem_name%>">
					<input type="hidden" name="gr_mem_study" value="<%=gsr.getGr_mem_study()%>">
					<input type="hidden" name="gr_mem_conid" value="<%=gsr.getGr_mem_conid()%>">
					<input type="hidden" name="numValCheck" value="<%=numValCheck%>" />
					<%=(i + 1) + ". " + gsr.getGr_mem_date()%>
				</h1>
				<input class="btn_normal" type="submit" value="확인하기" />
			</form>
		</div>
	<%
		}
	%>
	</div>
</body>
</html>

