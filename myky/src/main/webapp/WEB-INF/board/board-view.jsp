<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
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
            max-width: 1000px;
            margin: 40px auto;
            padding: 40px;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
    
        .section-header {
            font-size: 22px;
            font-weight: bold;
            color: #202060;
            margin-top: 40px;
            margin-bottom: 10px;
        }
    
        .section-divider {
            width: 100%;
            height: 2px;
            background-color: #202060;
            margin-bottom: 20px;
        }
    
        .section-content {
            font-size: 16px;
            color: #333;
            line-height: 1.8;
            white-space: pre-wrap;
            padding: 10px 0 20px 0;
            word-break: break-word;
        }
    
        .button-area {
            margin-top: 40px;
            display: flex;
            gap: 10px;
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
            width: fit-content;
            transition: background-color 0.3s ease;
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
            <div class="section-divider"></div>
            <div class="section-header">내용</div>
            <div class="section-content" v-html="info.content"></div>
            <div class="section-divider"></div>
            <div>
                <div v-if="sessionId == info.userId || sessionRole == 'admin'">
                    <button @click="fnEdit()">수정</button>
                    <button @click="fnRemove()">삭제</button>
                </div>
            </div>
            <table>
                <tr>
                    <th>작성자</th>
                    <td style="width: 400px">내용</td>
                </tr>
            </table>
            <table>
                <tr v-if="cmtList.commentId != null">
                    <div v-for="item in cmtList">
                        <label v-if="editCommentId == item.commentId">
                            {{item.userId}}: <input v-model="editContent">
                        </label>
                        <label v-else>{{item.userId}}:{{item.content}}
                        </label>
                        <template v-if="editCommentId == item.commentId">
                            <button @click="fnCommentUpdate(item.commentId)">저장</button>
                            <button @click="editCommentId = ''">취소</button>
                        </template>
                        <template v-else>
                            <template v-if="sessionId == info.userId || sessionRole == 'admin'">
                                <button @click="fnCommentEdit(item)">🕳</button>
                                <button @click="fnCommentRemove(item.commentId)">❌</button>
                            </template>
                        </template>
                    </div>
                </tr>
            </table>
            <table>
                <tr>
                    <th> 댓글 입력 : </th>
                    <td>
                        <textarea style="width: 430px" v-model="content" cols="60" rows="5"></textarea>
                    </td>
                    <td>
                        <button @click="fnCommentSave">저장</button>
                    </td>
                </tr>
            </table>

            <button @click="fnBack(info)">뒤로가기</button>

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
                        imgList: [],
                    };
                },
                computed: {

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
                                self.imgList = data.imgList;
				        	}
				        });
                    },
                    fnBack : function (info) {
                        let self = this;
                        pageChange("/board/list.do", {
                            page: self.page
                        });
                    },
                    fnEdit : function (){
                        var self = this;
                        pageChange("/board/edit.do",{boardId : self.boardId});
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
                    self.fnView();
                }
            });

            app.mount("#app");
        });
    </script>
