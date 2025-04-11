<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>
    <link rel="stylesheet" href="/css/board/board.css"/>

    <style>

    </style>
    
    
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 
    <div id="fb-app" class="fb-container">
        <div class="fb-section-header" v-if="category == 'F'">
            ADD
        </div>
        <div class="fb-section-header" v-if="category == 'A'">
            NOTICE ADD
        </div>
            <div class="fb-section-headerDown">
                게시글 내용을 작성합니다.
            </div>
            <hr class="fb-custom-hr">

            <div class="fb-content-wrap">
                <div class="fb-title-label">TITLE</div>
                <div class="fb-title-input">
                    <input v-model="title">
                </div>
                <div class="fb-title-inputImg">
                    <input type="file" id="file1" name="file1" multiple>
                </div>
                <div class="fb-title-label">CONTENT</div>
                <div class="fb-editor-totalBox">
                    <div class="fb-editor-boxBig">
                        <div id="fb-editor"></div>
                    </div>
                    <div class="fb-buttonStyle fb-buttonMargin">
                        <button class="fb-button" @click="fnSave">저장</button>
                        <button class="fb-button" @click="fnBack(info)">뒤로가기</button>
                    </div>
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
                       title : "",
                       content : "",
                       sessionId : "${sessionId}" || '',
                       sessionRole : "${sessionRole}",
                       boardId : "",
                       category : "",                
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
                            category : self.category,
                        }
                        $.ajax({
				    	    url:"/board/add.dox",
				    	    dataType:"json",	
				    	    type : "POST", 
				    	    data : nparmap,
				    	    success : function(data) { 
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/list.do?category="+self.category;
                                }
                                alert("저장되었습니다.");
                                location.href="/board/list.do?category="+self.category;
                                self.fnQuill();


                                if( $("#file1")[0].files.length > 0){
                                    var form = new FormData();
                                    for(let i=0; i<$("#file1")[0].files.length; i++){
                                        form.append( "file1",  $("#file1")[0].files[i]);
                                    }
                                    form.append( "boardId", data.boardId); // 임시 pk
                                    self.upload(form); 

                                } else {
                                    location.href="/board/list.do?category="+self.category;
                                }
                            }
				        });
                    },
                     //파일업로드
                    upload : function(form){
                    	var self = this;
                    	 $.ajax({
                    		 url : "/fileUpload.dox"
                    	   , type : "POST"
                    	   , processData : false
                    	   , contentType : false
                    	   , data : form
                    	   , success:function(response) { 
                            location.href="/board/list.do?category="+self.category;

                    	   }	           
                       });
                    },
                    fnBack : function (info) {
                        let self = this;
                        location.href="/board/list.do?category=" + self.category;
                        
                    },
                
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.category = params.get("category") || "F";      
                    
                    if(!(self.category == 'A' || self.category == 'F')){
                        alert("잘못된 접근입니다.");
                        location.href="/board/list.do?category=F";
                    }
                    if(self.sessionId == ''){
                        alert("로그인이 필요합니다.");
                        location.href="/board/list.do?category="+self.category;
                    }else if(self.sessionRole != 'ADMIN' && self.category =='A'){
                        alert("관리자만 접속 가능합니다.");
                        location.href="/board/list.do?category="+self.category;
                    }
                	var quill = new Quill('#fb-editor', {
                    theme: 'snow',
                    modules: {
                        toolbar: [
                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                            ['bold', 'italic', 'underline'],
                            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                            ['link', 'image'],
                            ['clean'],
                            [{ 'color': [] }, { 'background': [] }],  
                        ]
                    }
                });
                    quill.on('text-change', function() {
                        self.content = quill.root.innerHTML;
                    });
                }
            });

            app.mount("#fb-app");
        });
    </script>
