<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<script src="js/swiper8.js"></script>
	<script src="path/to/your/scripts.js"></script>
    <link rel="stylesheet" href="css/main.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f8f8f8;
            margin: 0;
            padding: 0;
        }

        #app {
            max-width: 700px;
            margin: 40px auto;
            padding: 30px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }

        .section-header {
            background-color: #202060;
            color: #fca311;
            font-weight: bold;
            padding: 10px;
            border-radius: 4px;
            margin-top: 20px;
            margin-bottom: 10px;
            text-align: center;
        }

        .section-content {
            font-size: 16px;
            color: #333;
            line-height: 1.6;
            white-space: pre-wrap;
            padding: 10px 0 20px 0;
            text-align: center;
        }

        button {
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        button:hover {
            background-color: #fca311;
            color: #202060;
        }
    </style>
    
</head>
<body>
     <jsp:include page="../common/header.jsp"/>

    <div id="app" class="container">

            <div class="section-header">
                제목
            </div>
            <div class="section-content">{{info.title}}</div>
            <div class="section-header">
                내용
            </div>
            <div class="section-content" v-html="info.content"></div>
            <div>
                <button @click="fnEdit()">수정</button>
                <button @click="fnBack(info)">뒤로가기</button>
            </div>

    </div>

     <jsp:include page="../common/footer.jsp"/>

    
</body>
</html>
<script>

    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        userId: "",
                        boardId : "${map.boardId}",
                        info : {},
                        page: "${param.page}",
                        sessionId: "${sessionId}",
                        sessionIdStatus: "${sessionStatus}",
                    };
                },
                computed: {

                }, 
                methods: {
                    fnView(){
				        var self = this;
				        var nparmap = {
                            boardId : self.boardId,
                            page: self.page,
                        };
				        $.ajax({
				        	url:"/board/view.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log(data);
                                    self.info = data.info
                                    console.log(data);
				        	}
				        });
                    },
                    fnBack: function (info) {
                        let self = this;
                        pageChange("/board/list.do", {
                            page: self.page
                        });
                    },
                },
                mounted() {
                	let self = this;
                    self.fnView();
                }
            });

            app.mount("#app");
        });
    </script>
