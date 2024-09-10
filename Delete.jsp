<%@page import="mybean.board.Board"%>
<%@page import="mybean.dbcp.DBConnectionMgr"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=utf-8" %>

<html>
<head><title>JSPBoard</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check() {
		if (document.form.pass.value == "") {
		alert("패스워드를 입력하세요.");
		form.pass.focus();
		return false;
		}
		document.form.submit();
	}
</script>
</head>
<body>
<jsp:useBean id="dao" class="mybean.board.BoardDao"/>

	<%
	int b_num = Integer.parseInt(request.getParameter("b_num"));
	
	if(request.getMethod().equalsIgnoreCase("post")){
		String pass = request.getParameter("b_pass"); //사용자로부터
		
		Board tmpBoard = dao.getBoard(b_num,false); //db로부터 꺼내온
		String dbPass = tmpBoard.getB_pass();
		
		if(pass.equals(dbPass)){
			dao.deleteBoard(b_num);
			response.sendRedirect("List.jsp"); //등록하고 list페이지로 이동하게 
		} else { //비밀번호가 같지 않으면,
	%>
		<script>
			alert("비밀번호가 틀렸습니다.");
			history.back();
		</script>
	<%
			}
		}
	%>
	
	<center>
	<br><br>
	<table width=50% cellspacing=0 cellpadding=3>
	 <tr>
	  <td bgcolor=#dddddd height=21 align=center>
	      사용자의 비밀번호를 입력해 주세요.</td>
	 </tr>
	</table>
	<table width=70% cellspacing=0 cellpadding=2>
	<form name=form method=post action="Delete.jsp" >
	<!-- 한 페이지 안에서 처리 비밀번호 입력하면 다시 삭제 창으로 돌아가는  -->
	<input type="hidden" name="b_num" value="<%= b_num %>" />
	<!-- hidden으로 넘기는거 놓칠 가능성 높으니까 잘 써주기 -->
	 <tr>
	  <td align=center>
	   <table align=center border=0 width=91%>
	    <tr> 
	     <td align=center>  
		  <input type=password name="b_pass" size=17 maxlength=15 required="required">
		 </td> 
	    </tr>
	    <tr>
	     <td><hr size=1 color=#eeeeee></td>
	    </tr>
	    <tr>
	     <td align=center>
		  <input type=submit value="삭제완료"> 
	      <input type=reset value="다시쓰기"> 
	      <input type=button value="뒤로" onClick="history.back()">
		 </td>
	    </tr> 
	   </table>
	  </td>
	 </tr>
	</form> 
	</table>
	</center>
</body>
</html>
