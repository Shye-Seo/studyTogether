<%@page import="subPage.groupPageBean"%>
<%@page import="subPage.groupPageDBBean"%>
<%@page import="java.sql.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="gsr" class ="subPage.groupPageBean"/>
<jsp:setProperty name ="gsr" property = "*"/>
<%
	response.setCharacterEncoding("UTF-8");
%>
<%	
	int gr_mem_gnum = Integer.parseInt(request.getParameter("gr_mem_gnum"));
	int gr_mem_number = Integer.parseInt(request.getParameter("gr_mem_number"));
	String gr_mem_name = request.getParameter("gr_mem_name");
	String gr_mem_date = request.getParameter("gr_mem_date");
	String gr_mem_study = request.getParameter("gr_mem_study");
	groupPageDBBean gsrdb = groupPageDBBean.getInstance();
	
	int check  = gsrdb.valcheck(gr_mem_name, gr_mem_date);
%>
<%	//작성 함
	if(check == 1){
%>
<script>
	alert("응 저장 안해");
</script>
<% 		
	response.sendRedirect("groupframe.jsp");
	}else{ 
		gsrdb.insertRecord(gsr,gr_mem_gnum);
		response.sendRedirect("groupframe.jsp");
%>
<script>
alert("저장 했다리");
</script>
<%
	}
%>
