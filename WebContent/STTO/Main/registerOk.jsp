<%@page import="board.BoardBean"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mb" class="member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
	MemberDBBean manager = MemberDBBean.getInstance();
	if(manager.confirmID(mb.getMem_id()) == 1){
%>		
		<script>
			alert("중복되는 아이디가 존재합니다."); //스크립트를 추가해서 팝업창이 뜨도록 한 것
			history.back(); //중복된 아이디가 존재하면 다시 회원가입화면으로 돌아감
		</script>
<%
	}else{
		int re = manager.insertMember(mb);
		//회원가입을 하는 경우이기 때문에 insert해야함
		
		if(re == 1){
%>
		<script>
			alert("회원가입을 축하드립니다.\n회원으로 로그인 해주세요.");
			document.location.href="login.jsp";
		</script>
<%
		}else{ //중복은 아니지만, insert할 때 문제가 있을 경우
%>
		<script>
			alert("회원가입을 실패했습니다.");
			document.location.href="login.jsp";
		</script>
<%
		}
	}
%>