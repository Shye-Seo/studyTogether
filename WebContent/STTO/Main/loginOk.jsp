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
			alert('�������� �ʴ� ȸ��');
			history.go(-1);
		</script>
<%
	}else {
		String mem_name = mb.getMem_name();
		
		if(check == 1) { //���ǿ� ����� ���� �߰� ��, main.jsp�� �̵�
			session.setAttribute("mem_id", mem_id);
			session.setAttribute("mem_name", mem_name);
			response.sendRedirect("/studyTogether/STTO/List/list.jsp");
	
		}else if(check == 0) {
%>
			<script>
				alert('��й�ȣ�� Ʋ�Ƚ��ϴ�.');
				history.go(-1);
			</script>		
<%
		}else { //������ �˻�� �������� case�� ó����
%>
			<script>
				alert('���̵� ���� �ʽ��ϴ�');
				history.go(-1);
			</script>				
<%
		}
	}
%>