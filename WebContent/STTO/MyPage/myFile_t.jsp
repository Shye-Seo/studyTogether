<%@page import="board.BoardDBBean"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="subPage.groupPageDBBean"%>
<%@page import="subPage.groupPageBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pagefile = request.getParameter("page");
	if(pagefile == null){
		pagefile = "board";
	}
	
	BoardBean board = new BoardBean();
	BoardDBBean db = BoardDBBean.getInstance();
	
	String mem_id = (String)session.getAttribute("mem_id");
	String mem_name = (String)session.getAttribute("mem_name");
	//int gr_mem_gnum = Integer.parseInt(request.getParameter("gr_mem_gnum"));
	
%>
<jsp:useBean id="gsr" class="subPage.groupPageBean"></jsp:useBean>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script type="text/javascript">
	    function check() {
			if ((".main_article").length > 0) {
				(".main_article").show();
			}else if ((".main_article").length > 0) {
				(".main_article").show();
			}
		}
    </script>
    <link href="MyPageStyle/myFile.css" rel="stylesheet">
</head>
<body>
<%
	String title = request.getParameter("title");
	String goal = request.getParameter("goal");
	String studyDate = request.getParameter("studyDate");
	
%>
    <header id="main_header">
        <div id="title" style="text-align: center;">
            <h1>스터디 참여목록</h1>
        </div>
        <nav id="main_gnb">
            <ul>
                <%-- <li><a href="#"><%=gsr.getPnum() %></a></li> --%>
                <li><a href="/studyTogether/STTO/List/list.jsp">나가기</a></li>
            </ul>
        </nav>
    </header>
    <div id="content">
        <section id="main_section">
   			<div class="main_article">
   			<jsp:include page='<%=pagefile+".jsp" %>'></jsp:include>
           </div> 
        </section>
            
        <aside id="main_aside">
            <div class="tab_item">
                <ul id="frame">
                    <li class="item">
                            <div class="description">
                        <jsp:include page="let1.jsp"></jsp:include>
                            </div>
                    </li>
                    <li class="item">
                            <div class="description">
                        <jsp:include page="let2.jsp"></jsp:include>
                            </div>
                    </li>
                    <li class="item">
                            <div class="description">
                        <jsp:include page="let3.jsp"></jsp:include>
                            </div>
                    </li>
                </ul>
            </div>
        </aside>
    </div>
</body>
</html>