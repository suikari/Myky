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
            padding-bottom: 120px; /* 푸터 높이만큼 확보 */
        }
        #app {
            padding-bottom: 120px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        /* EDIT */
        .section-header {
            color: #202060;
            font-weight: bold;
            height: 70px;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
            align-items: center;
            justify-content: center;
            display: flex;
            align-items: left; /* 세로 중앙 정렬 */
            justify-content: left; /* 가로 중앙 정렬 */
            font-size: 50px;
            width: 100%;
            margin-top: 100px;
            max-width: 1000px;
        }
        .section-headerDown {
            color: #333;
            font-weight: bold;
            text-align: left;
            display: flex;
            align-items: left; /* 세로 중앙 정렬 */
            justify-content: left;
            width: 100%;
            margin-top: 10px;
            max-width: 1000px;
            width: 100
        }
        .title-label {
            font-size: 20px;
            font-weight: bold;
            color: #202060;
            margin-top: 70px;
            margin-bottom: 10px;
            width: 1000px;
            max-width: 100%;
        }
        /* 제목 input 박스 */
        input {
            margin-top: -100px;
            width: 100%;
            max-width: 500px;
            padding: 8px 10px;
            border: 2px solid #202060;
            border-radius: 6px;
            font-size: 16px;
            outline: none;
            transition: border-color 0.3s;
        }
        .title-input {
            max-width: 1000px;
            width: 100%;
            margin-bottom: -50px;
            
        }
       .title-inputImg{
            width: 1000px;
            margin-bottom: -50px;
            margin-top: 80px;
        }
        input:focus {
            border-color: #fca311;
        }
        /* 에디터 컨테이너 감싸기 */
        #editor {
          background-color: #ffffff; /* 크림톤 배경 */
          border: 2px solid #202060; /* 연한 베이지 */
          border-radius: 12px;
          padding: 15px;
          box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
          font-family: 'Nanum Gothic', sans-serif;
          font-size: 16px;
          line-height: 1.6;
          align-items: center;
          margin-top: 30px;
          transition: border-color 0.3s;
          width: 1000px;
        }
        #editor .ql-editor:focus{
            outline: none;
            border-color: #fca311 !important;
            border-radius: 12px;
            box-shadow: 0 0 0 3px rgba(252, 163, 17, 0.3);
        }
        /* 툴바도 살짝 꾸미기 */
        .ql-toolbar {
            margin-top: 0px;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 8px;
            color: #202060;
            font-weight: bold;
            font-size: 20px;
            width: 1000px;
            margin-bottom: -20px;
        }
        .buttonStyle {
            margin-top: 50px;
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
        }

        button:hover {
            background-color: #fca311;
            color: #202060;
        }
        .custom-hr {
            width: 1000px;
            max-width: 100%;
            border: none;
            border-top: 1px solid #ccc;
            margin-top: 10px;
            margin-bottom: 40px;
            width: 100%;

            max-width: 1000px;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 
    <div id="app" class="container">

        <div class="section-header" v-if="category == 'F'">
            ADD
        </div>
        <div class="section-header" v-if="category == 'A'">
            NOTICE ADD
        </div>
            <div class="section-headerDown">
                게시글 내용을 작성합니다.
            </div>
            <hr class="custom-hr">

            <div>
                <div class="title-label">TITLE</div>
                <div class="title-input">
                    <input v-model="title">
                </div>
                <div class="title-inputImg">
                    <input type="file" id="file1" name="file1"  multiple>
                </div>
            </div>
            <div>
                <div class="title-label">
                    POINT
                    <div>
                        현재 point 조회
                        {{point.currentPoint}}개
                    </div>
                    <input>개 사용
                    <button @click="selectPoint">사용</button>
                </div>
            </div>
            <div class="title-label">CONTENT</div>
            <div>
                <div id="editor" style="height: 300px;"></div>
            </div>
            <div>
                <button class="buttonStyle" @click="fnSave">저장</button>
                <button class="button" @click="fnBack(info)">뒤로가기</button>
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
                       vetBoardId : "",
                       selectPoint : "",
                       point : "",
                       currentPoint : "",
                       usePoint : "",
                       usedPoint : "",
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
                            userId : self.sessionId,
                            usedPoint : self.usedPoint,
                        }
                        $.ajax({
				    	    url:"/board/vetBoardAdd.dox",
				    	    dataType:"json",	
				    	    type : "POST", 
				    	    data : nparmap,
				    	    success : function(data) { 
                                // if(){

                                // }
                            }
				        });
                        $.ajax({
				        	url:"/point/used.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log("11",data);
                                if(confirm("정말 저장하시겠습니까? 저장 후, 사용한 포인트는 차감됩니다.")){
                                    alert("저장되었습니다.");
                                } else {                                
                                    alert("취소되었습니다.");
                                }
				        	}
				        });
                    },
                    selectPoint : function (){
                        let self = this;
                        let nparmap = {
                            userId : self.sessionId,
                        };
                    },
                    getPoints : function(){
                        let self = this;
                        let nparmap = {
                            userId : self.sessionId,
                        };
                        $.ajax({
				        	url:"/point/current.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log("11",data);
                                self.point = data.point;

				        	}
				        });
                    },
                },
                mounted() {
                	let self = this;
                    self.getPoints();
                	
                }
            });

            app.mount("#app");
        });
    </script>
