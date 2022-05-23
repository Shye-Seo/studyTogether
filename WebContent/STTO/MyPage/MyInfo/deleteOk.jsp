<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="member.MemberBean" %>    
<%@ page import="member.MemberDBBean" %>    
<html>
<head>
<title>ȸ�� ���� ó��</title>
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
        
        // ���ǿ��� ���̵�, delete.jsp���� �Է¹��� ��й�ȣ�� �����´�.
        // ������ ����� ������ ȸ�������� �����Ѵ�. - ��������� ��ȯ
        MemberDBBean manager = MemberDBBean.getInstance();
        int check = manager.deleteMember(id, pw);
        
        if(check == 1){
            session.invalidate(); // �����ߴٸ� ���������� �����Ѵ�.
    %>
    <div id="content">
        <h1 class="title">ȸ�������� �����Ǿ����ϴ�.</h1>

    
        <input type="button"  class = "btn_normal"value="Ȯ��" onclick="javascript:window.location='/studyTogether/STTO/List/list.jsp'">
   		</center>
    <%    
         // ��й�ȣ�� Ʋ����� - ������ �ȵǾ��� ���
        }else{
    %>
        <script>
            alert("��й�ȣ�� ���� �ʽ��ϴ�.");
            history.go(-1);
        </script>
    <%
        } 
    %>
</body>
</html>