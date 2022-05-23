<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>new registration</title>
<link href="./GroupPageStyle/input.css" rel="stylesheet">
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
<%
	response.setCharacterEncoding("UTF-8");

	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMdd");
%>

<%
	int gr_mem_gnum = Integer.parseInt(request.getParameter("gr_mem_gnum"));
	int gr_mem_number = Integer.parseInt(request.getParameter("gr_mem_number"));
	String gr_mem_name = request.getParameter("gr_mem_name");
	
	String gr_mem_date = sdf.format(cal.getTime());
%>
<header id="main_header">
        <div id="title">
            <h1 align="center">내가 쓴 글</h1>
        </div>
</header>
    <div id="content">
        <section id="main_section">
            <article class="main_article">
				<form method="post" action = input_process.jsp>
					<div class ="wrap">
					<div class="in" align="center">
							<input type="hidden" value="<%=gr_mem_gnum%>" name="gr_mem_gnum">
							<input type="hidden" value="<%=gr_mem_number%>" name="gr_mem_number">
							<input type="hidden" value="<%=gr_mem_date%>" name="gr_mem_date">
							<input type="hidden" value="<%=gr_mem_name%>" name="gr_mem_name">
							<textarea class="txt" cols='100' rows='20' name='gr_mem_study' style="margin-bottom: 20px;"></textarea>
							<div>
								<input class="btn_normal" type="submit" value="기록하기">
								<input class="btn_normal" type="button" value="그룹 페이지" onclick="javascript:window.location='groupframe.jsp?gr_mem_gnum=<%=gr_mem_gnum%>'">
							</div>
						</div>
				    </div>
				</form>
            </article>
        </section>
    </div>
</body>
</html>