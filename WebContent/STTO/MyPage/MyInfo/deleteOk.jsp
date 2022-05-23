<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="member.MemberBean" %>    
<%@ page import="member.MemberDBBean" %>    
<html>
<head>
<title>회원 삭제 처리</title>
<style type="text/css">
@import url('https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap');

	*{margin: 5px; padding: 5px;}
	.wrapper{
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 70vh;
	}
	#content{
		display: grid;
		place-items: center;
		font-family: 'Gowun Dodum', sans-serif;
		font-weight: bold;
	}
	.title{
		color: navy;
		font-weight: bold;
		font-family: 'Gowun Dodum', sans-serif;
	}

	.btn_normal {
	    position: relative;
	    border: none;
	    min-width: 70px;
	    min-height: 50px;
	    background: #ffb72b;
	    border-radius: 1000px;
	    color: white;
	    cursor: pointer;
	    font-weight: bold;
	    font-size: medium;
	    transition: 0.3s;
	    font-family: 'Gowun Dodum', sans-serif;
	}
	
	.btn_normal:hover {
	    transform: scale(1.2);
	}
	
	.btn_normal:hover::after {
	    content: "";
	    width: 30px;
	    height: 30px;
	    border-radius: 100%;
	    border: 6px solid #ffb72b;
	    position: absolute;
	    z-index: -1;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    animation: ring 1.5s infinite;
	  }
	  
	.btn_area{
		padding-top: 30px;
	}
</style>
</head>
<body>
<div class="wrapper">
    <%
 		String id = (String)session.getAttribute("mem_id");
  		String pw = request.getParameter("mem_pw");
        
        // 세션에서 아이디를, delete.jsp에서 입력받은 비밀번호를 가져온다.
        // 가져온 결과를 가지고 회원정보를 삭제한다. - 삭제결과를 반환
        MemberDBBean manager = MemberDBBean.getInstance();
        int check = manager.deleteMember(id, pw);
        
        if(check == 1){
            session.invalidate(); // 삭제했다면 세션정보를 삭제한다.
    %>
    <div id="content">
        <h1 class="title">회원정보가 삭제되었습니다.</h1>

    
        <input type="button"  class = "btn_normal"value="확인" onclick="javascript:window.location='/studyTogether/STTO/List/list.jsp'">
   		</center>
    <%    
         // 비밀번호가 틀릴경우 - 삭제가 안되었을 경우
        }else{
    %>
        <script>
            alert("비밀번호가 맞지 않습니다.");
            history.go(-1);
        </script>
    <%
        } 
    %>
</body>
</html>