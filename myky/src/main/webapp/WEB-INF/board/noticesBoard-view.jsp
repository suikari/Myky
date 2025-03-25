<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <style>
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

    
        .button {
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            width: fit-content;
        }
        .cntButton {
            padding : 5px 10px;
            font-size : 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border-radius: 6px;
            cursor: pointer;
            width: fit-content;
            margin-inline-end:auto;
        }
        .cntButtonBox{
            border-radius: 6px;
            border: 1px solid #202060;
            max-width: 1000px;
            margin-top: 20px;
            margin-bottom: 50px;
        }
        .cntTextBox{
            border-radius: 6px;
            border: 1px solid #202060;
            max-width: 1000px;
            width: 100%;
            margin: 5px;
            padding: 5px;
            margin-bottom: 50px;
        }
        .Button:hover  {
            background-color: #fca311;
            color: #202060;
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
            left:  250px;
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
     <jsp:include page="../common/header.jsp"/>

    <div id="app" class="container">
        <div id="viewPage">

            <div class="view-header">
                VIEW
            </div>
            <div class="view-sub">
                여러분의 이야기를 들려주세요.
            </div>
            <hr class="custom-hr">

            <div class="view-label">TITLE</div>
            <div class="view-box">{{info.title}}</div>

            

            <div class="view-label">CONTENT</div>
            <div class="view-boxContent" v-html="info.content"></div>

            <div class="view-label">첨부파일</div>
            <div class="view-files">
                <div v-for="item in fileList">
                    <div class="link-container">
                        <a :href="item.filePath" download class="FileDownload">{{item.fileName}}
                        <span class="FileDownload"> ({{ Math.ceil(item.fileSize/1024)}} kb) </span></a>
                        <img :src="item.filePath" :alt="item.fileName" class="preview-image">
                    </div>
                </div>
            </div>
            <table>
            </table>
            <table>
                <tr v-if="cmtList.commentId != null">
                    <div v-for="item in cmtList" >
                        <a  class="cntTextBox">
                            <label v-if="editCommentId == item.commentId">
                                {{item.userId}}: <input v-model="editContent">
                            </label>
                            <label v-else>{{item.userId}}:{{item.content}}
                            </label>
                        </a>
                        <span class="">
                            <template v-if="editCommentId == item.commentId">
                                <button class="button" @click="fnCommentUpdate(item.commentId)">저장</button>
                                <button class="button" @click="editCommentId = ''">취소</button>
                            </template>
                            <template v-else>
                                <template  v-if="sessionId == item.userId || sessionRole == 'ADMIN'">
                                    <button class="cntButton Button" @click="fnCommentEdit(item)">수정</button>
                                    <button class="cntButton Button" @click="fnCommentRemove(item.commentId)">❌</button>
                                </template>
                            </template>
                        </span>
                    </div>
                </tr>
            </table>
            <table class="cntButtonBox">
                <tr>
                    <th style="margin-right: 10px;"> 댓글 </th>
                    <td>
                        <textarea style="width: 430px" v-model="content" cols="60" rows="5"></textarea>
                    </td>
                    <td>
                        <button class="button" @click="fnCommentSave">저장</button>
                    </td>
                </tr>
            </table>
            <div class="buttonMargin" style="display: flex; gap: 5px;">
                <template v-if="sessionId == info.userId || sessionRole == 'ADMIN'">
                    <button class="button" @click="fnEdit()">수정</button>
                    <button class="button" @click="fnRemove()">삭제</button>
                </template>
                <button class="button" @click="fnBack(info)">뒤로가기</button>
            </div>
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
                        page: "${param.page}",
                        sessionId: "${sessionId}",
                        sessionRole: "${sessionRole}",
                        userId : {},
                        content : "",
                        commentId : "",
                        cmtList: [],
                        editCommentId : "",
                        editContent : "",
                        fileList: [],
                    };
                },
                computed: {
                    size(fileSize) {
                        console.log("1",fileSize);
                        let size = Math.ceil(parseInt(fileSize)/1024);

                        return parseInt(size);

                    }
                }, 
                methods: {
                    fnView(){
				        var self = this;
				        var nparmap = {
                            boardId : self.boardId,
                            option: "View",
                        };
				        $.ajax({
				        	url:"/board/view.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log(data);
                                self.info = data.info
                                self.cmtList = data.cmtList;
                                self.fileList = data.fileList;
				        	}
				        });
                    },
                    fnBack : function (info) {
                        let self = this;
                        location.href="/board/list.do?page=" + self.page;
                        
                    },
                    fnEdit : function (){
                        var self = this;
                        location.href="/board/edit.do?boardId=" + self.boardId;
                    },
                    fnRemove : function () {
                        var self = this;
                        var nparmap = {
                            boardId: self.boardId,
                        };
                        $.ajax({
                            url: "/board/remove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                location.href = "/board/list.do";
                                alert("삭제되었습니다!");
                            }
                        });
                    },
                    fnCommentEdit(item) {
                        let self = this;
                        self.editCommentId = item.commentId;
                        self.editContent = item.content;
                        console.log(self.editContent);
                        var nparmap = {
                            commentId: item.commentId
                        };
                    },
                    fnCommentUpdate(commentId){
                        var self = this;
                        var nparmap = {
                            commentId : commentId,
                            boardId : self.boardId,
                            userId : self.userId,
                            content : self.editContent,
                        };
                        $.ajax({
                            url: "/board/comment/update.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("수정됐습니다!");
                                self.editCommentId ="";
                                self.fnView();
                            }
                        });
                    },
                    fnCommentRemove(commentId) {
                        let self = this;

                        var nparmap = {
                            commentId: commentId
                        };
                        $.ajax({
                            url: "/board/CommentRemove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("삭제되었습니다");
                                self.fnView();
                            }
                        });
                    },
                    fnCommentSave() {
                        let self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            content: self.content,
                        };
                        $.ajax({
                            url: "/board/CommentAdd.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                alert("등록되었습니다");
                                self.fnView();
                                self.content="";
                            }
                        });
                    },
                },
                mounted() {
                	let self = this;
                    const params = new URLSearchParams(window.location.search);
                    this.boardId = params.get("boardId") || "";

                    
                    self.fnView();
                }
            });

            app.mount("#app");
        });
    </script>
