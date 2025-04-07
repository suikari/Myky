<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
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
        <div id="viewPage">
            <div class="fb-section-header" v-if="category == 'F'">
                EDIT
            </div>
            <div class="fb-section-header" v-if="category == 'A'">
                NOTICE EDIT
            </div>
            <div class="fb-section-headerDown" >
                게시글 내용을 수정합니다.
            </div>
            <hr class="fb-custom-hr">

            <div class="fb-title-label">TITLE</div>
            <div class="fb-title-input">
                <input v-model="info.title">
            </div>
            <div class="fb-title-inputImg">
                <input type="file" id="file1" name="file1" multiple>
            </div>
            <div class="fb-title-label">CONTENT</div>
            <div>
                <div id="editor" style="height: 300px;"></div>
            </div>
            <div class="fb-view-label">첨부파일</div>
                <div class="fb-view-files">
                    <div v-for="item in fileList" :key="reload">
                        <div class="fb-link-container">
                            <span class="fb-FileDownload">{{item.fileName}}</span>
                            <span class="fb-FileDownload"> ({{ Math.ceil(item.fileSize/1024)}} kb)</span>
                                <button class="fb-buttonStyle" @click="fnRemove(item.fileId)">삭제</button>
                            <img :src="item.filePath" :alt="item.fileName" class="fb-preview-image">
                        </div>
                    </div>
                </div>
            <div>
                <button class="fb-button fb-buttonStyle" @click="fnEdit">저장</button>
                <button class="fb-button fb-buttonStyle" @click="fnBack(info)">뒤로가기</button>
            </div>
        </div>
    </div>


	<jsp:include page="/WEB-INF/common/footer.jsp"/>

</body>
</html>
<script>
    
                const app = Vue.createApp({
                data() {
                    return {
                        boardId :"${map.boardId}",
                        info : {},
                        content : "",
                        title : "",
                        reload : 0,
                        category : "",
                        sessionId : "${sessionId}" || '',
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
                            option: "UPDATE",
                            category : self.category,
                        };
				        $.ajax({
				        	url:"/board/view.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) {
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/list.do";
                                }
                                
                                // info가 null인 경우
                                if (!data.info) {
                                    alert("잘못된 접근입니다.");
                                    location.href = "/board/list.do?category=" + self.category;
                                    return;
                                }
                                self.info = data.info;
                                self.fileList = data.fileList;

                                if(self.sessionId != self.info.userId){
                                    alert("작성자만 접근 가능합니다.");
                                    location.href="/board/list.do?category="+self.category;
                                }
                                    self.fnQuill();
				        	}
				        });
                    },
                    fnFileView(){
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
                                self.fileList = data.fileList;
                                self.reload += 1; 
				        	}
				        });
                    },
                    fnEdit : function (){
                        var self = this;
				        var nparmap = {
                            title : self.info.title,
                            content : self.info.content,
                            boardId : self.boardId,
                            userId : self.sessionId
                        }
				        $.ajax({
				        	url:"/board/edit.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
                                alert("수정되었습니다.");

                                if( $("#file1")[0].files.length > 0){
                                    var form = new FormData();
                                    for(let i=0; i<$("#file1")[0].files.length; i++){
                                        form.append( "file1",  $("#file1")[0].files[i]);
                                    }
                                    form.append( "boardId", self.boardId); // 임시 pk
                                    self.upload(form);

                                } else {
                                    location.href="/board/list.do?category="+self.category;
                                }
				        	}
				        });
                    },
                    fnBack : function (info) {
                        let self = this;
                        location.href="/board/list.do?category="+self.category;                   
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
                    fnRemove : function (fileId) {
                        var self = this;
                        var nparmap = {
                            fileId : fileId,
                        };
                        $.ajax({
                            url: "/board/removeFile.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("삭제되었습니다!");
                                self.fnFileView();
                            }
                        });
                    },
                },
                mounted() {
                	var self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.boardId = params.get("boardId") || "";
                    self.category = params.get("category") || "F";
                	self.fnView();           
                    
                    if(!(self.category == 'A' || self.category == 'F')){
                        alert("잘못된 접근입니다.");
                        location.href="/board/list.do?category=F";
                    }
                    if(self.sessionId == ''){
                        alert("로그인이 필요합니다.");
                        location.href="/board/list.do?category="+self.category;
                    }else if(self.sessionId != 'ADMIN' && self.category =='A'){
                        alert("관리자만 접속 가능합니다.");
                        location.href="/board/list.do?category="+self.category;
                    }
                    
                }
            });
            app.mount("#fb-app");

    </script>
