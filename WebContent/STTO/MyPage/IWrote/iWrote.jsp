<%@page import="member.GroupRequestBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <title>내가 작성한 글</title>
    <%
	request.setCharacterEncoding("UTF-8");
%>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
* {
	margin: 5px;
	padding: 5px;
}

li {
	list-style: none;
}

a {
	text-decoration: none;
}


</style>
</head>
<%
	String mem_id = (String)session.getAttribute("mem_id");
	//int b_status = Integer.parseInt(request.getParameter("b_status"));
%>
<body>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<%
	response.setCharacterEncoding("UTF-8");	
%>
<%
	MemberDBBean mdb = MemberDBBean.getInstance();
	ArrayList<BoardBean> ml = mdb.myList(mem_id);
%>
<table class="table table-hover">
    <tr>
      <th scope="col">그룹 번호</th>
      <th scope="col">구인글 제목</th>
      <th scope="col">모집 인원</th>
      <th scope="col">현재 인원</th>
      <th scope="col">작성자 아이디</th>
    </tr>
	<%
		for(int i =0; i<ml.size();i++){
			BoardBean bb = ml.get(i);
	%>
	<tr>
		<td>
			<%=bb.getB_group() %>
		</td>
		<td>
			<a href = "/studyTogether/STTO/MyPage/IWrote/reqlist.jsp?mem_id=<%=bb.getB_id() %>&b_group=<%=bb.getB_group()%>&b_stmember=<%=bb.getB_stmember()%>&b_status=<%=bb.getB_status()%>">
			<%=bb.getB_title() %>
			</a>
		</td>
		<td>
			<%=bb.getB_stmember() %>
		</td>
		<td>
			<%=bb.getB_status() %>
		</td>
		<td>
			<%=bb.getB_id() %>
		</td>
	</tr>
	<% 
		}
	%>
</table>
</body>
</html>