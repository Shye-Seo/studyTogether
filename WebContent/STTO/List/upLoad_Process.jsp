<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body>
<%
	response.setCharacterEncoding("UTF-8");
%>
<%-- �Խñ� ����, �ۼ��� ���̵�, �Խñ� ��ȣ --%>
<%
	String b_id = request.getParameter("b_id");
	String b_title = request.getParameter("b_title");
	int b_group = Integer.parseInt(request.getParameter("b_group"));
	String mem_id = request.getParameter("mem_id");
	String mem_name = request.getParameter("mem_name");
%>
<%
	MemberDBBean mdb = MemberDBBean.getInstance();
	int check = mdb.getRequest(b_id, b_title, b_group, mem_id, mem_name);
	if(check == 1){
%>
	<script>
		alert("��û �Ϸ�");
		history.go(-1);
	</script>		
<% 
	}else{
%>
	<script>
		alert("��");
		history.go(-1);
	</script>
<% 
	}
%>
</body>
</html>