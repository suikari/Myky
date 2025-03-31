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
        #viewPage {
            max-width: 1000px;
            margin: 40px auto;
            padding: 40px;
            background-color: #fff;
            border-radius: 10px;
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
            font-size: 25px;
            font-weight: bold;
            color: #202060;
            margin-top: 40px;
            margin-bottom: 10px;
            max-width: 1000px;
            align-items: center;
        }
        .view-labelContent {
            height: 500px;
            text-align: center;
            align-items: center;
        }

        #viewPage .view-box {
            border: 2px solid #202060;
            font-weight: bold;
            border-radius: 6px;
            padding: 15px;
            background-color: #fdfdfd;
            font-size: 16px;
            line-height: 1.8;
            color: #333;
            word-break: break-word;
            white-space: pre-wrap;
            align-items: center;
            width: 100%;
            max-width: 1000px;
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
            min-height: 500px;
            text-align: center;
            align-items: center;
            width: 100%;
            max-width: 1000px;
        }
        #viewPage .view-files {
            margin-top: 10px;
            width: 100%;
            max-width: 1000px;
            text-align: center;
            align-items: center;
        }

        #viewPage .file-link {
            color: #202060;
            font-weight: bold;
            text-decoration: none;
            margin-right: 10px;
            display: inline-block;
            align-items: center;
            text-align: center;
        }
        .view-files {
            margin-bottom: 20px;
            color: #202060;
            border: 1px solid #202060;
            border-radius: 6px;
            padding: 15px;
            text-align: center;
            align-items: center;
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
            margin-bottom: 100px;
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
        .cmtButton {
            padding : 5px 10px;
            font-size : 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border-radius: 6px;
            cursor: pointer;
            width: fit-content;
            margin-inline-end:auto;
            border : none;
        }
        .cmtButtonBox{
            border-radius: 6px;
            max-width: 1000px;
            margin-top: 20px;
            margin-bottom: 5px;
            /* border : none; */
            border: 1px solid #202060;
        }
        .cmtButton2 {
            padding : 5px 10px;
            font-size : 14px;
            font-weight: bold;
            background-color: #c0c0c0;
            color: #353535;
            border-radius: 6px;
            cursor: pointer;
            width: fit-content;
            margin-inline-end:auto;
            border : none;
            margin: 1px;
        }
        .cmtInput{
            max-width: 400px;
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 4px;
            padding : 8px;
        }
        .cmtTextBox{
            border-radius: 6px;
            border: 1px solid #f7f7f8;
            background-color: #f5f5f5;
            max-width: 1000px;
            width: 100%;
            margin: 5px;
            padding: 5px;
            margin-bottom: 5px;
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
            border: 1px solid #ededed;
            background-color: white;
            padding: 5px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            z-index: 100;
        }

        .link-container:hover .preview-image {
            display: block;
        }
        .view-boxContent img {
            max-width: 70%;
            height: auto;
            display: block;
            margin: 10px auto;
            border-radius: 6px;
        }
        .cmt2button{
            margin-right: 10px;
            color: #888;
            font-size: 15px;
            cursor: pointer;
        }
        .likeButton2{
            width: 40px;
            height: 40px;
        }
        .likeButton{
            background-color: white;
            border: none;
            color: #202060;
            cursor: pointer;
        }
        .like-button-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            gap: 20px;
        }
        .answer-box {
            background-color: #f6f8fa;
            border: 1px solid #d1d5da;
            border-radius: 10px;
            padding: 16px;
            margin: 20px 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            position: relative;
            height: 300px;
            width: 100%;
            max-width: 1000px;
        }

        .answer-header {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .answer-nickname {
            font-weight: bold;
            color: #0366d6;
            margin-right: 10px;
        }

        .answer-meta {
            font-size: 12px;
            color: #888;
        }

        .answer-content {
            font-size: 15px;
            line-height: 1.6;
            color: #333;
            margin-bottom: 10px;
            white-space: pre-wrap;
        }

        .answer-actions {
            display: flex;
            gap: 10px;
            font-size: 13px;
            margin-top: 5px;
        }

        .answer-actions button,
        .answer-actions a {
            background: none;
            border: none;
            color: #0366d6;
            cursor: pointer;
        }

        .answer-actions button:hover,
        .answer-actions a:hover {
            text-decoration: underline;
        }

        .deleted-answer {
            color: #999;
            font-style: italic;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="app" class="container">

        <div id="app" class="container">
            <div id="viewPage">
    
                <div class="view-header" >
                    VIEW
                </div>
                <div class="view-sub">
                    질문과 답
                </div>
                <hr class="custom-hr">

                <div class="view-label">
                    TITLE
                </div>

                <div class="view-box">
                <a style="font-size:20px">{{info.title}}</a>
                    <!-- 날짜 표시 여기 넣기 -->
                    <div style="color: #fca311;">작성자: {{info.nickName}}</div>
                    <div style="font-size: 13px; color: #888; margin-top: 10px; margin-bottom: 0px;">
                        작성일: ( {{ info.updatedTime }} )  조회수: ( {{info.cnt}} )
                    </div>
                </div>
                <div>
                    포인트 {{info.point}}
                </div>
                <div class="view-label">CONTENT</div>
                <div class="view-boxContent" v-html="info.content"></div>

                <!-- ✅ 지식인 스타일 답변 박스 -->
                <div v-for="answer in answerList" class="answer-box">
                    <template v-if="answer.isDeleted === 'Y'">
                        <div class="deleted-answer">삭제된 댓글입니다.</div>
                    </template>
                    <template v-else>
                    <div class="answer-header">
                        <div class="answer-nickname">{{ answer.vetNickName }}</div>
                        <div class="answer-meta">{{ answer.createdAt }}</div>
                    </div>
                    <div class="answer-nickname">{{ answer.reviewText }}</div>
                    <div class="answer-content" v-html="answer.content"></div>
                
                    <div class="answer-actions">
                        <a @click="fnReply(item.reviewText)">답글 달기</a>
                        <div class="review-id">{{ info.nickName }}</div>
                
                        <template v-if="sessionId === answer.userId || sessionRole === 'ADMIN'">
                        <button @click="fnCommentEdit(answer)">수정</button>
                        <button @click="fnCommentRemove(answer.commentId)">❌ 삭제</button>
                        </template>
                    </div>
                    </template>
                </div>
                
              
                </div>

                <div class="buttonMargin" style="display: flex; gap: 5px;">
                    <template v-if="sessionId == info.userId || sessionRole == 'ADMIN'">
                        <button class="button" @click="fnEdit()">수정</button>
                        <button class="button" @click="fnRemove()">삭제</button>
                    </template>
                    <button class="button" @click="fnBack(info)">뒤로가기</button>
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
                       vetBoardId : "${map.vetBoardId}",
                        info : {},
                        page: "${param.page}",
                        sessionId: "${sessionId}",
                        sessionRole: "${sessionRole}",
                        userId : {}, 
                        nickName : "",
                        content : "",
                        updatedTime : "",
                        createdTime : "",
                        status : "",
                        answerList:[],
            
                    };
                },
                computed: {

                },
                methods: {
                    fnView(){
				        var self = this;
				        var nparmap = {
                            vetBoardId : self.vetBoardId,
                            option: "View",
                            category : self.category,
                        };
				        $.ajax({
				        	url:"/board/vetBoardView.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
				        		console.log(data);
                                self.info = data.info;
                                self.answerList = data.answerList;
				        	}
				        });
                    },
                    fnBack : function (info) {
                        let self = this;
                        location.href="/board/vetBoardList.do";
                        
                    },
                    fnEdit : function (){
                        var self = this;
                        location.href="/board/vetBoardEdit.do?vetBoardId=" + self.vetBoardId
                    },
                    fnRemove : function () {
                        var self = this;
                        var nparmap = {
                            vetBoardId: self.vetBoardId,
                        };

                        if (!confirm("정말 삭제하시겠습니까?")) {
                           alert("취소되었습니다.");
                           return;
                        } 
                        
                        $.ajax({
                            url: "/board/vetBoardRemove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                location.href = "/board/vetBoardList.do";
                                alert("삭제되었습니다!");
                            }
                        });
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                	self.vetBoardId = params.get("vetBoardId") || "";

                    self.fnView();
                }
            });

            app.mount("#app");
        });
    </script>
