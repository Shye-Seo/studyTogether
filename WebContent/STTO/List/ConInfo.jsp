<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="EUC-KR">
<title>글 정보</title>
<link href="./ListStyle/boardWrite.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>
</head>
<body>
<%
	int b_group = Integer.parseInt(request.getParameter("b_group"));
	BoardDBBean bdb = BoardDBBean.getInstance();
	BoardBean bb = bdb.getConInfo(b_group);
%>
<%
	String b_id = bb.getB_id();
	String b_title = bb.getB_title();
	
	String mem_id = (String)session.getAttribute("mem_id"); //신청자 이름
	String mem_name = (String)session.getAttribute("mem_name"); //신청자 아이디
%>
<div class="wrapper">
		<form  method = "post" action ="upLoad_Process.jsp" id="content">
		<h1 class="title">스터디 그룹 모집글</h1>
			<table border="1" align="center">
				<tr height="30">
					<td  width="80" align="center">작성자 </td>
					<td>
						<%=b_id %>
					</td>
					<td width="80" align="center">언  어</td>
					<td width="240">
						<%=bb.getLanguages() %> 
					</td>
				</tr>
				<tr height="30">
					<td width="80" align="center">지  역</td>
					<td width="240">
						<%=bb.getArea() %>
					</td>
					<td width="80" align="center">분  야</td>
					<td width="240">
						<%=bb.getB_inter_c() %>
					</td>
				</tr>
				<tr>
					<td  width="100" align="center"><b>시작일</b> </td>
					<td>
						<%=bb.getB_startdate() %>
					</td>
					
					<td width="100" align="center"><b>종료일</b></td>
					<td>
						<%=bb.getB_finishdate() %>
					</td>
				</tr>
				<tr height="30">
					<td width="80" align="center">글 제 목</td>
					<td width="240" colspan="3">
						<%=bb.getB_title() %>
					</td>
				</tr>
				<tr height="30">
					<td width="80" align="center">스터디 목표</td>
					<td width="240" colspan="3">
						<%=bb.getB_goal() %>
					</td>
				</tr>
				<tr>
					<td colspan="4" align="center">
						<%=bb.getB_content() %>
					</td>
				</tr>
			</table>
			<div align="center">
				<input type = "hidden" name = "mem_id" value = "<%=mem_id %>"><br>
				<input type = "hidden" name = "mem_name" value = "<%=mem_name%> "><br>
				<input type = "hidden" name = "b_id" value = "<%=b_id %>"><br>
				<input type = "hidden" name = "b_group" value = "<%=b_group %>"><br>
				<input type = "hidden" name = "b_title" value = "<%=b_title %>"><br>
<%if(mem_id != null || mem_name != null){
%>
				<input class="btn_normal" type="submit" value="가입 요청">
<% 
	}
%>				
				&nbsp;
				<input class="btn_normal" type="button" value="글목록" onclick="location.href='list.jsp'">
			</div>
		</form>
	</div>
</body>
</html>