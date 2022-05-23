<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardBean board = new BoardBean();
	BoardDBBean db = BoardDBBean.getInstance();
	
	String mem_id = (String)session.getAttribute("mem_id");
	String mem_name = (String)session.getAttribute("mem_name");

%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1><a href="/studyTogether/STTO/MyPage/myFile.jsp"><%=mem_id%><br>(<%=mem_name%>)</a></h1>
</body>
</html>