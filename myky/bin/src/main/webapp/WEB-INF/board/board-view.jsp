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
	
    <link rel="stylesheet" href="css/main.css">
    <style>
    


    </style>
</head>
<body>
     <jsp:include page="../common/header.jsp"/>

    <div id="app" class="container">

            <div>
                제목 : {{info.title}}
            </div>
            <div>
                내용 :<div v-html="info.content"></div>
            </div>
            <div>
                <button @click="fnEdit()">수정</button>
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
                        boardId : "${map.boardId}",
                        info : {},
                       
                    };
                },
                computed: {

                }, 
                methods: {
                    fnView(){
				        var self = this;
				        var nparmap = {
                            boardId : self.boardId
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
                },
                mounted() {
                	let self = this;
                    self.fnView();
                	
                }
            });

            app.mount("#app");
        });
    </script>
