<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<script src="js/swiper8.js"></script>
    <script src="/js/page-Change.js"></script>
	
    <link rel="stylesheet" href="css/main.css">
    <style>
        .content{
            width: 300px;
            height: 500px;
        }
        table, tr, th, td {
	    text-align: center;
	    border : 2px solid #bbb;
	    border-collapse: collapse;
	    padding : 5px;
	    }
        .textStyle{
                font-weight: bold;
                color : red;
        }
        .button{
            width:60px;
            height: 30px;
            background-color: rgb(16, 16, 65);
            color: rgb(222, 115, 38);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>
    <div id="app" class="container">
            <table>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
                <tr v-for="item in list">
                    <td>{{item.boardId}}</td>
                    <a href="javacript:;" @click="fnView(item.boardId)">
                        <td>{{item.title}}</td>
                    </a>
                    <td>{{item.userId}}</td>
                    <td>{{item.createdAt}}</td>
                    <td>{{item.cnt}}</td>
                </tr>
                <tr>
                </tr>
            </table>
            <button class="button" @click="fnAdd">글쓰기</button>

    </div>
    <jsp:include page="../common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                       list : [],
                       boardId : "",
                    };
                },
                computed: {
                    
                },
                methods: {
                    fnBoardList(){
                        let self= this;
                        let nparmap = {
                            boardId : self.boardId,
                            title : self.title,
                            userId : self.userId,
                            createdAt : self.createdAt,
                            cnt : self.cnt,
                        };
                    $.ajax({
				    	url:"/board/list.dox",
				    	dataType:"json",	
				    	type : "POST", 
				    	data : nparmap,
				    	success : function(data) { 
				    		console.log(data);
                            self.list = data.board;
                            console.log(self.list);

				    	    }
				        });
                    },
                    fnAdd : function (){   
                        let self= this;
                        pageChange("/board/edit.do",{boardId : self.boardId});
                    },
                    fnView : function (){
                        pageChange("/board/view.do", {boardId : self.boardId});
                    },
                    fnPage : function (){
                        let self = this;
                    }
                },               
                mounted() {
                	let self = this;
                    self.fnBoardList();
                }
            });
            app.mount("#app");
        });
    </script>
