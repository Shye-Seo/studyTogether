<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gsr" class = "member.GroupRequestBean"/>
<jsp:setProperty name = "gsr" property = "*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
<%
	response.setCharacterEncoding("UTF-8");
%>
<%-- 게시글 제목, 작성자 아이디, 게시글 번호 --%>
<%
	String b_id = request.getParameter("b_id");
	int b_group = Integer.parseInt(request.getParameter("b_group"));

	String mem_id = request.getParameter("mem_id");
	String mem_name = request.getParameter("mem_name");

	
	MemberDBBean mbd = MemberDBBean.getInstance();
	int re = mbd.deleteList(gsr);
	if(re == 1){
%>
<script>
	alert("죄송합니다. 기각되셨습니다.");
	history.go(-1);
</script>
<%		
	}else{
%>
<script>
	alert("저희와 함께 할수 없습니다.");
	location.href = "outer_reqlist.jsp";
</script>
<%
	}
%>
</body>
</html>