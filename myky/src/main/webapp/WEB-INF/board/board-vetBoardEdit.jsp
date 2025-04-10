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
    <link rel="stylesheet" href="/css/board/board.css"/>
    <style>
      
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="fb-app" class="fb-container">
        <div id="fb-viewPage">
            <div class="fb-section-header">
                EDIT
            </div>
            <div class="fb-section-headerDown" >
                게시글 내용을 수정합니다.
            </div>
            <hr class="fb-custom-hr">

            <div class="fb-title-label">TITLE</div>
            <div class="fb-title-input">
                <input v-model="info.title">
            </div>

            <div class="fb-title-label">CONTENT</div>
            <div class="fb-editor-boxBig">
                <div id="fb-editor" style="height: 1000px;"></div>
            </div>
            <div class="fb-buttonStyle">
                <button class="fb-button" @click="fnEdit">저장</button>
                <button class="fb-button" @click="fnBack(info)">뒤로가기</button>
            </div>
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
                       info : {},
                       content : "",
                       title : "",
                       vetBoardId : "${map.vetBoardId}",
                       answerList : [],
                       sessionId : "${sessionId}" || '',
                    };
                },
                computed: {

                },
                methods: {
                    fnView(){
				        var self = this;
				        var nparmap = {
                            vetBoardId : self.vetBoardId,
                            option: "UPDATE",
                        };
				        $.ajax({
				        	url:"/board/vetBoardView.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/vetBoardList.do";
                                }
                                // info가 null인 경우
                                if (!data.info) {
                                    alert("잘못된 접근입니다.");
                                    location.href = "/board/vetBoardList.do";
                                    return;
                                }

                                if(self.sessionId != data.info.userId){
                                    alert("작성자만 접근 가능합니다.");
                                    location.href="/board/vetBoardList.do";
                                }
                                    self.info = data.info;
                                    self.answerList = data.answerList;
                                    self.fnQuill();
				        	}
				        });
                    },
                    fnEdit : function (){
                        var self = this;
				        var nparmap = {
                            title : self.info.title,
                            content : self.info.content,
                            vetBoardId : self.vetBoardId,
                            userId : self.sessionId,
                        }
				        $.ajax({
				        	url:"/board/vetBoardEdit.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
                                alert("수정되었습니다.");
                                    location.href="/board/vetBoardList.do";
				        	}
				        });
                    },
                    fnBack : function (info) {
                        let self = this;
                        location.href="/board/vetBoardList.do";   
                                    
                    },
                    fnQuill() {
                        let self = this;
                        var quill = new Quill('#fb-editor', {
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
                    },
                },
                mounted() {
                	var self = this;
                    const params = new URLSearchParams(window.location.search);
                	self.fnView();

                    if(self.sessionId == ''){
                        alert("로그인이 필요합니다.");
                        location.href="/board/vetBoardList.do";
                    }
                }
            }); 
            app.mount("#fb-app");
        }); 
    </script>
