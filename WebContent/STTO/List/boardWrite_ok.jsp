<%@page import="data.dataTransDBBean"%>
<%@page import="data.dataTransBean"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Enumeration"%>
<%@page import="board.BoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>
<%

	String mem_id = (String)session.getAttribute("mem_id"); // 글쓴이 아이디
	String mem_name = (String)session.getAttribute("mem_name"); // 글쓴이 이름
%>
<% 
	String b_id = request.getParameter("b_id"); // 작성자 이
	String b_title = request.getParameter("b_title"); //
	String b_goal = request.getParameter("b_goal"); //

	int b_stmember = Integer.parseInt(request.getParameter("b_stmember")); //
	

	String b_inter_c = request.getParameter("b_inter_c"); // 분야
	String area = request.getParameter("area"); // 지역
	String languages = request.getParameter("languages"); // 언 어
	
	String b_startdate = request.getParameter("b_startdate"); //
	String b_finishdate = request.getParameter("b_finishdate"); //
	
	String b_content = request.getParameter("b_content"); //
%>
<%
	//글 작성 후 작성자 정보 임시테이블로 이동
	BoardDBBean db = BoardDBBean.getInstance();
	dataTransDBBean dtdb  = dataTransDBBean.getInstance();
%>

<%	
	if(db.insertBoard(board) == 1){// 데이터가 들어갔을 때, 어떻게 처리 할 것인가. 1= 데이터 입력성공. else= 실패.
		response.sendRedirect("list.jsp");
	}else { 
		response.sendRedirect("boardWrite.jsp");
	}
%>