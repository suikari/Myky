<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

    <style>
        body {
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #f8f8f8;
        margin: 0;
        padding: 0;
    }

    #app {
        max-width: 600px;
        margin: 40px auto;
        padding: 30px;
        background-color: #ffffff;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        border-radius: 10px;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 6px;
        color: #333;
    }

    input, textarea {
        width: 100%;
        padding: 12px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 6px;
        margin-bottom: 20px;
        box-sizing: border-box;
        background-color: #fff;
        transition: border-color 0.3s ease;
    }

    input:focus, textarea:focus {
        border-color: #1a73e8;
        outline: none;
    }

    button {
        padding: 12px 24px;
        font-size: 14px;
        font-weight: bold;
        background-color: #202060;
        color: #fca311;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button:hover {
            background-color: #fca311;
            color: #202060;
    }
    </style>
    
    
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 

    <div id="app" class="container">
        <div>
            <label>제목</label>
            <input v-model="title">
        </div>
        <div>
            <label>내용</label>
            <textarea cols="50" rows="20" v-model="content"></textarea>
        </div>
        <div>
            <button @click="fnSave">저장</button>
        </div>
    </div>

	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                       title : "",
                       content : "",
                       sessionId : "${sessionId}",                    
                    };
                },
                computed: {

                },
                methods: {
                    fnSave(){
                        let self = this;
                        let nparmap = {
                            title : self.title,
                            content : self.content,
                            userId : self.sessionId
                        }
                        $.ajax({
				    	    url:"/board/add.dox",
				    	    dataType:"json",	
				    	    type : "POST", 
				    	    data : nparmap,
				    	    success : function(data) { 
				    	    	console.log(data);
                                alert("저장되었습니다")
                                location.href="/board/list.do"
                                console.log(self.sessionId);
                            }
				        });
                    },

                },
                mounted() {
                    let self = this;                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
