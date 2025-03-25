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
        #viewPage {
            max-width: 1000px;
            margin: 40px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 10px;
            /* box-shadow: 0 0 10px rgba(0,0,0,0.1); */
            font-family: 'Noto Sans KR', sans-serif;
        }

        #viewPage .view-header {
            font-size: 36px;
            font-weight: bold;
            color: #202060;
            margin-bottom: 10px;
        }

        #viewPage .view-sub {
            color: #333;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 30px;
        }

        #viewPage .view-label {
            font-size: 18px;
            font-weight: bold;
            color: #202060;
            margin-top: 40px;
            margin-bottom: 10px;
        }
        .view-labelContent {
            height: 500px;
        }

        #viewPage .view-box {
            border: 2px solid #202060;
            border-radius: 6px;
            padding: 15px;
            background-color: #fdfdfd;
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            word-break: break-word;
            white-space: pre-wrap;
        }
        .view-boxContent{
            border: 1px solid #202060;
            border-radius: 6px;
            padding: 15px;
            background-color: #fdfdfd;
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            word-break: break-word;
            white-space: pre-wrap;
            height: 500px;
        }
        #viewPage .view-files {
            margin-top: 10px;
        }

        #viewPage .file-link {
            color: #202060;
            font-weight: bold;
            text-decoration: none;
            margin-right: 10px;
            display: inline-block;
        }
        .view-files {
            margin-bottom: 20px;
            color: #202060;
            border: 1px solid #202060;
            border-radius: 6px;
            padding: 15px;
        }
        #viewPage .file-link:hover {
            color: #fca311;
        }
        .FileDownload{
            color: #202060;
            text-decoration: none;
            font-weight: bold;
        }
        .FileDownload:hover{
            color : #fca311; 
        }
        .buttonMargin {
            margin-top: 30px;
            margin-bottom: 30px;
        }

        .link-container {
            position: relative;
            display: inline-block;
        }

        .preview-image {
            display: none;
            position: absolute;
            top: -19px;
            left:  -165px;
            width: 150px;
            height: auto;
            border: 1px solid #ddd;
            background-color: white;
            padding: 5px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            z-index: 100;
        }

        .link-container:hover .preview-image {
            display: block;
        }
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 
    <div id="app" class="container">
        <div id="viewPage">
            <div class="section-header" v-if="category == 'F'">
                EDIT
            </div>
            <div class="section-header" v-if="category == 'A'">
                NOTICE EDIT
            </div>
            <div class="section-headerDown" >
                게시글 내용을 수정합니다.
            </div>
            <hr class="custom-hr">

            <div class="title-label">TITLE</div>
            <div class="title-input">
                <input v-model="info.title">
            </div>
            <div class="title-inputImg">
                <input type="file" id="file1" name="file1" multiple>
            </div>
            <div class="title-label">CONTENT</div>
            <div>
                <div id="editor" style="height: 300px;"></div>
            </div>
            <div class="view-label">첨부파일</div>
                <div class="view-files">
                    <div v-for="item in fileList" :key="reload">
                        <div class="link-container">
                            <span class="FileDownload">{{item.fileName}}</span>
                            <span class="FileDownload"> ({{ Math.ceil(item.fileSize/1024)}} kb) </span></a>
                                <button class="buttonStyle" @click="fnRemove(item.fileId)">삭제</button>
                            <img :src="item.filePath" :alt="item.fileName" class="preview-image">
                        </div>
                    </div>
                </div>
                <table>
                </table>
            <div>
                <button class="buttonStyle" @click="fnEdit">저장</button>
                <button class="button" @click="fnBack(info)">뒤로가기</button>
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
				        		console.log(data);
                                    self.info = data.info;
                                    self.fileList = data.fileList;
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
                            boardId : self.boardId
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
                        
                }
            });
            app.mount("#app");

    </script>
