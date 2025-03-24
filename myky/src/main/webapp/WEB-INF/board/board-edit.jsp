<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

    <!-- Quill CSS -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">

    <!-- Quill JS -->
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    
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
            /* background-color: #202060; */
            color: #202060;
            font-weight: bold;
            height: 70px;
            width: 100%;
            padding: 10px;
            border-radius: 4px;
            text-align: center;
            align-items: center;
            justify-content: center;
            display: flex;
            align-items: left; /* 세로 중앙 정렬 */
            justify-content: left; /* 가로 중앙 정렬 */
            font-size: 50px;
            margin-top: 80px;
            margin-left: 650px;
            margin-bottom: 20px;
        }
        .section-headerDown {
            color: #333;
            font-weight: bold;
            text-align: left;
            display: flex;
            align-items: left; /* 세로 중앙 정렬 */
            justify-content: left;
            margin-left: -850px;
            margin-top: -35px;
            margin-bottom: 20px;
        }
        .title-label {
            font-size: 20px;
            font-weight: bold;
            color: #202060;
            margin-top: 100px;
            margin-bottom: 10px;
            width: 1000px;
        }
        /* 제목 input 박스 */
        input {
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
            width: 1000px;
            margin-bottom: -50px;
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
            margin-top: 20px;
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
        }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 
    <div id="app" class="container">
        <div class="section-header">
            EDIT
        </div>
        <div class="section-headerDown">
            공지사항을 수정합니다.
        </div>
        <hr class="custom-hr">

        <div class="title-label">TITLE</div>
        <div class="title-input">
            <input v-model="info.title">
        </div>
        <div class="title-label">CONTENT</div>
        <div>
            <div id="editor" style="height: 300px;"></div>
          </div>
        <div>
            <button class="buttonStyle" @click="fnEdit">저장</button>
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
                        boardId :"${map.boardId}",
                        info : {},
                        content : "",
                        title : "",
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
                            option: "UPDATE"
                        };
				        $.ajax({
				        	url:"/board/view.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log(data);
                                    self.info = data.info;
                                    self.fnQuill();
				        	}
				        });
                    },
                    fnEdit : function (){
                        var self = this;
				        var nparmap = self.info;
				        $.ajax({
				        	url:"/board/edit.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
                                alert("수정되었습니다.")
                                location.href="/board/list.do"
				        	}
				        });
                    },
                    fnQuill() {
                        let self = this;
                        var quill = new Quill('#editor', {
                            theme: 'snow',
                            modules: {
                                toolbar: [
                                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                    ['bold', 'italic', 'underline'],
                                    [{ 'list': 'ordered' }, { 'list': 'bullet' }],
                                    ['link', 'image'],
                                    ['clean'],
                                    [{ 'color': [] }, { 'background': [] }]
                                ]
                            }
                        });
                        quill.root.innerHTML = self.info.content;
                        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                        quill.on('text-change', function () {
                            self.info.content = quill.root.innerHTML;
                        });
                    }
                },
                mounted() {
                	var self = this;

                	self.fnView();
                        
                }
            });
            $(document).ready(function() {
      $('#summernote').summernote({
        height: 300, // set editor height
        minHeight: 300, // set minimum height of editor
        maxHeight: 300, // set maximum height of editor
      });
      if (!(typeof board_id == "undefined" || boardId == null || boardId == "")) {
        appInstance.fnUpdate();//
      }
      
    })
            app.mount("#app");
            console.log('jQuery 버전:', $.fn.jquery);
console.log('Summernote 상태:', typeof $.fn.summernote);
});

    </script>
