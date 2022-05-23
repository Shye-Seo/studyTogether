<%@page import="member.GroupRequestBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script language='javascript'>
	function reject(frm){
    	  frm.action = 'reject_Process.jsp';
	      frm.submit();
	      return true;
     }
</script>
<link rel="stylesheet" href="reqlist.css">
<style>
</style>
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<%
	String mem_id = request.getParameter("mem_id"); //작성자 아이디 받아와서 sql 실행
	int b_group = Integer.parseInt(request.getParameter("b_group"));
	int b_stmember = Integer.parseInt(request.getParameter("b_stmember"));
	int b_status = Integer.parseInt(request.getParameter("b_status"));
%>
<body>
<%
	response.setCharacterEncoding("UTF-8");
%>
<%	
	//현재 모집인원
	//ml.get(i).getB_status()에 넣어야됨
	int count = b_status;

	//정원
	int full = b_stmember;
%>
<% 
	MemberDBBean mdb = MemberDBBean.getInstance();
	ArrayList<GroupRequestBean> rql =  mdb.reqList(mem_id, b_group); //ArrayList
	if(b_status == b_stmember){
%>
	<script>
		alert("모집 완료된 급입니다.");
		history.go(-1);
	</script>
<% 
	}else{
%>
	<div class="wrapper">
      <table class="box">
		<tr>
			<td colspan = "6">
				<h1 class="title"><%=b_status%> / <%=b_stmember %></h1>	
			</td>
		</tr>
		<tr>
			<td>
			그룹 번호
			</td>
			<td>
			구인글 제목
			<td>
			신청자 아이디
			</td>
			<td>
			신청자 이름
			</td>
			<td>
			작성자 아이디
			</td>
		</tr>
		<%
			for(int i =0; i<rql.size();i++){
				GroupRequestBean grb = rql.get(i);
		%>
		<tr id = "lis">
			<td>
				<%=grb.getB_group() %>
			</td>
			<td>
				<%=grb.getB_title() %>
			</td>
			<td>
				<%=grb.getMem_id() %>
			</td>
			<td>
				<%=grb.getMem_name() %>
			</td>
			<td>
				<%=grb.getB_id() %>
			</td>
			<td>
				<!--  <button id = "acc" onclick = 'countUp();hide();'>승인</button>-->
				<form action ='simai_t.jsp' method = "post">
					<input type = "hidden" name = "mem_id" value = "<%=grb.getMem_id() %>">
					<input type = "hidden" name = "mem_name" value = "<%=grb.getMem_name() %>">
					
					<input type = "hidden" name = "b_group" value = "<%=grb.getB_group() %>">
					<input type = "hidden" name = "b_id" value = "<%=grb.getB_id() %>">
					<input type = "hidden" name = "b_stmember" value = "<%=b_stmember %>">
					<input type = "hidden" name = "b_status" value = "<%=b_status%>">
					<input class="btn_normal" type = "submit" value = "승인"/>
					<button class="btn_normal" id = "reg" onclick = 'return reject(this.form);'>기각</button>
				</form>
			</td>
		</tr>
		<% 
			}
		}
		%>
</table>
</body>
</html>
