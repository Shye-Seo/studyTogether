<%@page import="member.MemberBean"%>
<%@page import="board.BoardBean"%>
<%@page import="subPage.groupPageBean"%>
<%@page import="subPage.groupPageDBBean"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="gsr" class ="subPage.groupPageBean"/>
<jsp:setProperty name ="gsr" property = "*"/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link href="./GroupPageStyle/groupframe.css" rel="stylesheet">
<%
	request.setCharacterEncoding("UTF-8");
%>
</head>
<body style="margin : auto;">
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%>
<%	
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
	String nowTime = sdf.format(cal.getTime());
		
	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd");
%>
<%
	int gr_mem_gnum = (int)session.getAttribute("gr_mem_gnum");
	String mem_id = (String) session.getAttribute("mem_id");
%>
<%
	groupPageDBBean gsrd = groupPageDBBean.getInstance();
	int numValCheck = gsrd.valNumCheck(mem_id, gr_mem_gnum); //groupPageDBBean 56
	ArrayList<groupPageBean> memlist = gsrd.memlist(gr_mem_gnum); //groupPageDBBean 79
%>
<%
	BoardBean bb = gsrd.getBInfo(gr_mem_gnum); //groupPageDBBean 113
%>
    	<div class ="title" >
      		  <h1><%=bb.getB_title() %></h1>
    	</div>
    	<div class ="title" >
       		 <h1><%=bb.getB_goal() %></h1>
    	</div>
        <div>
        	<table class="box">
        		<tr>
        			<td class ="date" colspan="3">
			       		 <h2>Today -<%=nowTime %></h2>
        			</td>
        		</tr>
	<% 
		for(int i =0; i<memlist.size();i++){
			gsr = memlist.get(i);
	%>
        		<tr>
        			<td class ="date">
        			<a class="tooltip" href="#" style="float: left;">
        				<%=gsr.getGr_mem_name()%>
						<span class="classic1">
							<h5>이름</h5>
							<h5>이메일</h5>
							<h5>자기 소개</h5> 
						</span>
						<span class="classic2">
							<h5><%=gsr.getGr_mem_name() %></h5>
							<h5><%=gsr.getMem_email() %></h5>
							<h5><%=gsr.getGroup_introduce() %></h5> 
		     			</span>
	        		</a>
		        		<div style="float: right;">
							<form method = "post" name = "form">
					        		<input type ="hidden" name ="gr_mem_gnum" value = "<%=gsr.getGr_mem_gnum() %>"/>
					        		<input type ="hidden" name ="gr_mem_number" value = "<%=gsr.getGr_mem_number() %>"/>
					        		<input type ="hidden" name ="gr_mem_name" value = "<%=gsr.getGr_mem_name() %>"/>
					        		<input type ="hidden" name ="numValCheck" value = "<%=numValCheck %>"/>
					        		<input type ="hidden" name ="b_title" value = "<%=bb.getB_title() %>"/>
		        					<input class="btn_normal" type="submit" value="확인" onclick="javascript: form.action='confirm.jsp';"/>
				        	</form>
		        		</div>
		        		<div style="float: right;">
							<form method = "post" name = "form">
					        		<input type ="hidden" name ="gr_mem_gnum" value = "<%=gsr.getGr_mem_gnum() %>"/>
					        		<input type ="hidden" name ="gr_mem_number" value = "<%=gsr.getGr_mem_number() %>"/>
					        		<input type ="hidden" name ="gr_mem_name" value = "<%=gsr.getGr_mem_name() %>"/>
<%
		if(numValCheck == gsr.getGr_mem_number()){
%>		
					        		<input class="btn_normal" type="submit" value="기록" onclick="javascript: form.action='input.jsp';"/>
<%
	}
%>
				        	</form>
		        		</div>
        			</td>
        		</tr>
<% 		
	}	
%>
<%
	String enddate = gsr.getGroup_finishdate();
%>
<%
	Calendar today = Calendar.getInstance();
	Calendar dday = Calendar.getInstance();
	
	String finish = enddate;
	
	int finishYear = Integer.parseInt(finish.substring(0,4));
	int finishMonth = Integer.parseInt(finish.substring(5,7));
	int finishDate = Integer.parseInt(finish.substring(8));
	
	dday.set(finishYear, finishMonth-1, finishDate); //디데이 날짜 설정
	
	long l_dday = dday.getTimeInMillis() / (24*60*60*1000);
	long l_today = today.getTimeInMillis() / (24*60*60*1000);
	
	long substract = 0;
	String ddayStr = "D";
	
	if (l_today > l_dday) {
	    substract = l_today-l_dday;
	    ddayStr = "종료";
	} else if (l_today < l_dday) {
	    substract = l_dday-l_today;
	    ddayStr += "-" + substract;
	} else {
	    ddayStr += "-Day";
	}
%>   		       		
        	</table>
        </div>
        <div id="quote">
	    	<h3></h3>	
	        <h4></h4>
    	</div>
    <script src="quotes.js"></script>
    	<div>
	        <table class="description">
	            <tr>
	                <td class="date_description">
	                    <div style="text-align: center; line-height : 10px;">
	                        <h1><%=ddayStr %></h1>
	                    </div>            
	                </td>
	            </tr>
	            <tr>
	                <td class="goal_description">
	                </td>
	            </tr>
	        </table>
	    </div>
</body>
</html>