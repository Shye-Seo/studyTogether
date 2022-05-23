<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@page import="member.MemberBean"%>
<%@page import="member.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="board" class="board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="board"/>    
<%
	    String mem_id = (String)session.getAttribute("mem_id");
		String mem_name = (String)session.getAttribute("mem_name");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null){
			pageNum = "1";
		}
	String b_id, b_title, b_content;
	int b_stmember;
%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<meta charset="EUC-KR">
<title>main</title>
<link href="./ListStyle/list.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css2?family=Pacifico&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>
</head>
<body>
<div class="wrapper"><!-- 반응형으로 폼을 중앙에 두기 위해 삽입한 div  -->
<div class="content">
<%
	if(mem_id != null){
		%>
		안녕하세요. <%= mem_name %>(<%= mem_id %>)님
		<%
	}else{
		
	}
%>
<%
	double starttime = System.nanoTime(); //시작점
%>
	<div align="right" class="main">
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
		if(session.getAttribute("id") != null){
			mem_id = (String)session.getAttribute("id");
		}
		//로그인을 하지 않았을 때 보여지는 화면
		if(mem_id == null) {
	%>
		<input class="btn_normal" type="button" value="로그인" onclick="javascript:window.location='/studyTogether/STTO/Main/login.jsp'">
		&nbsp;
		<input class="btn_normal" type="button" value="회원가입" onclick="javascript:window.location='/studyTogether/STTO/Main/register.jsp'">
	<%
		//로그인이 되어 있는 상태에서 보여지는 화면
		}else{
	%>
		<input class="btn_normal" type="button" value="글쓰기" onclick="location.href='boardWrite.jsp';javascript:form.action='/studyTogether/STTO/List/boardWrite.jsp'">
		&nbsp;
		<input class="btn_normal" type="button" value="나의 스터디" onclick="javascript:window.location='/studyTogether/STTO/MyPage/myFile.jsp'">
		&nbsp;
		<input class="btn_normal" type="button" value="로그아웃" onclick="javascript:window.location='/studyTogether/STTO/Main/logOut.jsp'">
	<%
		}
	%>
	<div class="main_logo" align="center">
		STTO
	</div>
	<form action="list.jsp" method="get" id="cen">
		<table class="table_search" align="center"  id="tab">
			<tr>
				<td align="center" >
					<select id="b_area" name="b_area">
						<option value="지역" selected="selected" onchange="checkArea()">지역</option>
						<option value="seoul">서울</option>
						<option value="gyeonggi">경기</option>
						<option value="incheon">인천</option>
						<option value="busan">부산</option>
						<option value="daegu">대구</option>
						<option value="daejeon">대전</option>
						<option value="gwangju">광주</option>
						<option value="online">온라인</option>
					</select>
				</td>
				<td align="center">
					<select id="b_inter_s" name="b_inter_s" >
						<option value="개발분야" selected="selected">개발 분야</option>
						<option value="backend">백엔드</option>
						<option value="frontend">프론트엔드</option>
					</select>
				</td>
				<td align="center">
					<select id="b_inter_c" name="b_inter_c" >
						<option value="언어" selected="selected">언어</option>
						<option value = "java" >java</option>
						<option value = "javascript" >javascript</option>
						<option value = "spring" >spring</option>
						<option value = "kotlin" >kotlin</option>
						<option value="python">python</option>
						<option value="jsp">jsp</option>
					</select>
				</td>
			</tr>
		</table>
		
		<table class="table_list" align="center">
			<tr height="25" bgcolor="#F7F7F7" 
			    onmouseover="this.style.backgroundColor='#eeeeef'" 
			    onmouseout="this.style.backgroundColor='#f7f7f7'">
			<%
				//검색
				String b_area = request.getParameter("b_area");
				String b_inter_s = request.getParameter("b_inter_s");
				String b_inter_c = request.getParameter("b_inter_c");
			%>
			<%
				BoardDBBean db = BoardDBBean.getInstance();
				ArrayList<BoardBean> list = db.listBoard(b_area, b_inter_s, b_inter_c);
				
		 		for(int i=0; i<list.size(); i++){
						board = list.get(i);
						int b_group = board.getB_group();
						
						b_title = board.getB_title();
						String language = board.getLanguages();
						String inter_c = board.getB_inter_c();
						String area = board.getArea();
						if(i%4==0){
			%>
				<tr></tr>
			<% 
			}
			%>
				<td>
					<a href = "ConInfo.jsp?b_group=<%=b_group%>">
						<div class = "consi">
							<div class = "consi_lan">
								<%
									if(language.equals("java")) {
								%>
									<img src="../icon/java.png">
								<% 
									}else if(language.equals("javascript")) {
								%>
									<img src="../icon/js.png">
								<%
									}else if(language.equals("spring")) {
								%>
										<img src="../icon/spring.png">
								<%
									}else if(language.equals("jsp")) {
								%>
										<img src="../icon/jsp.png">
								<%
									}else if(language.equals("kotlin")) {
								%>
										<img src="../icon/kotlin.png">
								<%
									}else if(language.equals("python")) {
								%>
										<img src="../icon/python.png">
								<%
									}	
								%>
							</div>
							<div class = "consi_inch" >
								<%
									if(inter_c.equals("backend")) {
								%>
									<img src="../icon/back.png">
								<% 
									}else if(inter_c.equals("frontend")){
								%>
									<img src="../icon/front.png">
								<% 
									}
								%>
							</div>
							<br><br>
							<div class = "consi_area" align = center>
								지역 : <%=area %>
							</div>
							<div class = "consi_title" align = center>
								<%=b_title %>
							</div>
						</div>
					</a>
				</td>
			<%
				}
			%>
			</tr>
	 </table>
	 <div align = "center">
		<input class="btn-search" type="submit" value="찾기" >
	</div>
	</form>
<%
	double endtime = System.nanoTime();
	double estimatedTime = endtime - starttime;
	System.out.print(estimatedTime/100000000);
	System.out.println();
%>
</body>
</html>