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
	String mem_id = (String)session.getAttribute("mem_id");
	String mem_name = (String)session.getAttribute("mem_name");
	
%>
<jsp:useBean id="gsr" class="subPage.groupPageBean"></jsp:useBean>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="myFile.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');
</style>
<title>나의 스터디</title>
</head>
<body>
<%
	double starttime = System.nanoTime(); //시작점
%>
<%
	String title = request.getParameter("title");
	String goal = request.getParameter("goal");
	String studyDate = request.getParameter("studyDate");
	
%>
<div class="wrapper">
	<div class="content">
    <header id="main_header">
        <div align="center">
            <h1 class="title">나의 스터디</h1>
        </div>
        <nav id="main_gnb">
            <ul>
                <li>
                <input class="btn_normal" type="button" value="나가기" onclick="javascript:window.location='/studyTogether/STTO/List/list.jsp'">
                </li>
            </ul>
        </nav>
    </header>
    
    <div id="content">
   			<div class="main_article">
   			<jsp:include page='<%=pagefile+".jsp" %>'></jsp:include>
           </div> 
            
        <aside id="main_aside">
                <ul id="frame">
                    <li class="item">
                        <div class="description">
                            <jsp:include page="let4.jsp"></jsp:include>
                        </div>
                    </li>
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
        </aside>
    </div>
    </div>
</div>

</body>
</html>