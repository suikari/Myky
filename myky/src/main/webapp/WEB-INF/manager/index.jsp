<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // URL에서 menu와 submenu 값 가져오기
    String menu = request.getParameter("menu");
    String submenu = request.getParameter("submenu");

    // 기본값 설정
    if (menu == null) menu = "stat";
    if (submenu == null) submenu = "1";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
       
    <!-- ApexCharts CSS -->
    <link href="https://cdn.jsdelivr.net/npm/apexcharts@3.35.3/dist/apexcharts.css" rel="stylesheet">

    <!-- Vue 3 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/vue@3.2.31/dist/vue.global.js"></script>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Vue 3 Script -->
    <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.35.3"></script> 
 
     <style>
    </style>
    
</head>
<body>



     <jsp:include page="/WEB-INF/common/header.jsp"/>
 

	<div id="managerMain" class="row">
	
	    <jsp:include page="/WEB-INF/manager/common/side.jsp"/>
	
	
        <% if ("stat".equals(menu)) { %>
        
             <% if ("1".equals(submenu)) { %>
                 <jsp:include page="/WEB-INF/manager/stats/main.jsp"/>
             <% } else if ("2".equals(submenu)) { %>
                 <jsp:include page="/WEB-INF/manager/stats/userlist.jsp"/>
             <% } else if ("3".equals(submenu)) { %>
                 <jsp:include page="/WEB-INF/manager/stats/product.jsp"/>
             <% } else if ("4".equals(submenu)) { %>
             <% } %>
             
        <% } else if ("board".equals(menu)) { %>
        
             <% if ("1".equals(submenu)) { %>
                 <jsp:include page="/WEB-INF/manager/board/main.jsp"/>
             <% } else if ("2".equals(submenu)) { %>
                 <jsp:include page="/WEB-INF/manager/board/comment.jsp"/>
             <% } else if ("3".equals(submenu)) { %>            
                 <jsp:include page="/WEB-INF/manager/board/vetboard.jsp"/>             
             <% } else if ("4".equals(submenu)) { %>
                 <jsp:include page="/WEB-INF/manager/board/product.jsp"/>
             <% } %>
             
        <% } else if ("product".equals(menu)) { %>
			<% if ("1".equals(submenu)) { %>
			      <jsp:include page="/WEB-INF/manager/product/main.jsp"/>
			<% } else if ("2".equals(submenu)) { %>
				  <jsp:include page="/WEB-INF/manager/product/order.jsp"/>
			<% } else if ("3".equals(submenu)) { %>
			<% } else if ("4".equals(submenu)) { %>
				 <jsp:include page="/WEB-INF/manager/product/product-add.jsp"/>
			<% } %>
			
		<% } else if ("member".equals(menu)) { %>
			<% if ("1".equals(submenu)) { %>
			    <jsp:include page="/WEB-INF/manager/member/main.jsp"/>
			<% } else if ("2".equals(submenu)) { %>
				<jsp:include page="/WEB-INF/manager/member/membership.jsp"/>
			<% } else if ("3".equals(submenu)) { %>
				<jsp:include page="/WEB-INF/manager/member/vet.jsp"/>
			<% } else if ("4".equals(submenu)) { %>
				<jsp:include page="/WEB-INF/manager/member/partner.jsp"/>
			<% } %>
			
		<% } else { %>
			
        <% } %>
        
   
	</div>
	

    <jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>

        	let self = this;
        	const params = new URLSearchParams(window.location.search);
            
            self.menu = params.get("menu") || "stat";
            self.submenu = params.get("submenu") || "1";

 </script>
