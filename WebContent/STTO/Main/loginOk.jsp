<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	String mem_id = request.getParameter("mem_id");
	String mem_pw = request.getParameter("mem_pw");
	
	MemberDBBean manager = MemberDBBean.getInstance();
	BoardBean board = new BoardBean();
	
	int check = manager.userCheck(mem_id, mem_pw);
	MemberBean mb = manager.getMember(mem_id);
	
	if(mb == null) {
%>
		<script>
			alert('존재하지 않는 회원');
			history.go(-1);
		</script>
<%
	}else {
		String mem_name = mb.getMem_name();
		
		if(check == 1) { //세션에 사용자 정보 추가 후, main.jsp로 이동
			session.setAttribute("mem_id", mem_id);
			session.setAttribute("mem_name", mem_name);
			response.sendRedirect("/studyTogether/STTO/List/list.jsp");
	
		}else if(check == 0) {
%>
			<script>
				alert('비밀번호가 틀렸습니다.');
				history.go(-1);
			</script>		
<%
		}else { //실제로 검사는 안하지만 case로 처리함
%>
			<script>
				alert('아이디가 맞지 않습니다');
				history.go(-1);
			</script>				
<%
		}
	}
%>