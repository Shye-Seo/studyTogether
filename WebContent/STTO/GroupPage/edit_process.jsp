<%@page import="subPage.groupPageBean"%>
<%@page import="subPage.groupPageDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%
	groupPageBean gsr = new groupPageBean();
	groupPageDBBean gsrd = groupPageDBBean.getInstance();

	int gr_mem_number = Integer.parseInt(request.getParameter("gr_mem_number"));
	String gr_mem_name = request.getParameter("gr_mem_name");
	
	
	int gr_mem_gnum = Integer.parseInt(request.getParameter("gr_mem_gnum"));
	String gr_mem_study = request.getParameter("gr_mem_study");
	int gr_mem_conid = Integer.parseInt(request.getParameter("gr_mem_conid"));
	int re = gsrd.editBoard(gr_mem_study, gr_mem_gnum, gr_mem_name, gr_mem_conid);
%>

<%
	if(re == 1){
%>
<script>
	alert("수정완료");
	location.href = "groupframe.jsp?gr_mem_gnum=<%=gr_mem_gnum%>";
</script>
<%		
	}else{
%>
<script>
	alert("수정 실패");
	location.href = "groupframe.jsp?gr_mem_gnum=<%=gr_mem_gnum%>";
</script>
<%
	}
%>
</body>
</html>