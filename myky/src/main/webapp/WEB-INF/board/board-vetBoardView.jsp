<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <!-- Quill CDN -->
    <link href="https://cdn.quilljs.com/1.3.6/quill.snow.css" rel="stylesheet">
    <script src="https://cdn.quilljs.com/1.3.6/quill.min.js"></script>

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
            padding: 6px 14px;
            font-size: 14px;
            font-weight: bold;
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .cmtButtonBox{
            border-radius: 6px;
            max-width: 1000px;
            margin-top: 20px;
            margin-bottom: 5px;
            border: 1px solid #202060;
        }
        .cmtButton2 {
            padding: 6px 10px;
            font-size: 13px;
            font-weight: bold;
            background-color: #c0c0c0;
            color: #353535;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .cmtButton:hover {
            background-color: #202060;
            color: #fca311;
        }
        .cmtButton2:hover {
            background-color: #a8a8a8;
        }
        .editor-box {
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 16px;
            max-width: 1000px;
            width: 100%;
            box-sizing: border-box;
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
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
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
        .editor-wrapper {
            margin-top: 10px;
            padding: 10px;
            background-color: #ffffff;
            border-radius: 6px;
            border: 1px solid #ffffff;
            max-width: 1000px;
            width: 100%;
            height: 700px;
        }
        .quill-editor {
            height: 200px;
            width: 100%;
            margin-bottom: 16px;
        }
        .reply-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .answerButton{
            width: 7%;
            text-align: center;
        }
        .answer-box {
            background-color: #f6f8fa;
            border: 1px solid #d1d5da;
            border-radius: 10px;
            padding: 16px;
            margin: 20px 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            position: relative;
            width: 100%;
            position: relative;
            max-width: 1000px;
            flex-direction: column;
        }
        .choice-button {
            margin-top: 10px;
            align-self: flex-end; /* 오른쪽으로 정렬 */
            background-color: #202060;
            color: #fca311;
            border: none;
            border-radius: 6px;
            padding: 6px 14px;
            cursor: pointer;
            font-size: 14px;
        }
        .choice-button:hover {
            background-color: #fca311;
            color: #202060;
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
                        ( 포인트 {{info.points}} )
                        작성일: ( {{ info.updatedTime }} )  조회수: ( {{info.cnt}} )
                    </div>
                </div>
                <div>
                </div>
                <div class="view-label">CONTENT</div>
                <div class="view-boxContent" v-html="info.content"></div>

                <!-- ✅ 지식인 스타일 답변 박스 -->
                <div v-for="answer in answerList" class="answer-box">
                    <div class="answer-header">
                        <div class="answer-nickname">{{ answer.vetNickName }}</div>
                        <div class="answer-meta">{{ answer.createdAt }}</div>
                    </div>
                    <div v-html="answer.reviewText"></div>
                    <button @click="fnShowChoice(answer.reviewId)" class="choice-button">채택</button>
                    <template v-if="showChoice == answer.reviewId">
                        <input v-model="comments" placeholder="후기를 작성해주세요">
                    </template>
                    <template v-if="sessionId === info.userId || sessionRole === 'ADMIN'">
                    <template v-if="showEdit != answer.reviewId">  
                       <button class="cmtButton" @click="fnAnEditCha(answer.reviewText, answer.reviewId)">수정</button>
                    </template>
                    <template v-else>
                        <div class="editor-box">
                            <!-- 🖋 Quill 에디터 [수정]-->
                            <div >
                                <div id="editorEdit" class="quill-editor"></div>
                            </div>
                            <div class="reply-buttons">
                              <button class="cmtButton" @click="fnAnEdit()">등록</button>
                            </div>
                          </div>
                        <button class="cmtButton" @click="fnCancle">취소</button>
                    </template>
                      <button class="cmtButton" @click="fnAnRemove(answer.commentId)">❌ 삭제</button>
                    </template>
                </div>

                <div class="answer-actions">
                    <div @click="showEditor">
                         <div class="cmtButton answerButton">답글 달기</div>
                    </div>
                    <div v-show="showAnsw" class="editor-box">
                      <!--  Quill 에디터 -->
                      <div id="editor" class="quill-editor"></div>
                  
                      <!--  등록 버튼 영역 -->
                      <div class="reply-buttons">
                        <button class="cmtButton" @click="fnSaveReply">등록</button>
                      </div>
                    </div>
                  </div>
                </div>

                <div class="cmtButton" style="display: flex; gap: 5px;">
                    <template v-if="sessionId == info.userId || sessionRole == 'ADMIN'">
                        <button class="cmtButton" @click="fnEdit()">수정</button>
                        <button class="cmtButton" @click="fnRemove()">삭제</button>
                    </template>
                    <button class="cmtButton" @click="fnBack(info)">뒤로가기</button>
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
                        vetNickName : "",
                        nickName:"",
                        content : "",
                        updatedTime : "",
                        createdTime : "",
                        answerList:{},
                        data : {},
                        comments : "",
                        vetId : "",
                        rating: "",
                        vetName : "${map.nickName}",
                        showEdit : '0',
                        reviewText : "",
                        showAnsw : false,
                        vetList : {},
                        choiceBtn : false,
                        showChoice : '0',
                        
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
                                self.info = data.info;
                                self.answerList = data.answerList;
                                self.getCurrent();
				        	}
				        });
                    },
                    getCurrent : function(){
                        let self = this;
                        let nparmap = {
                            userId : self.info.userId,
                        }
                        $.ajax({
                            url:"/point/current.dox",
                            dataType:"json",	
                            type : "POST", 
                            data : nparmap,
                            success : function(data) {
                                self.data = data.point;
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
                                alert("삭제되었습니다");
                            }
                        });
                    },
                    fnVetInfo : function () {
                        var self = this;
                        var nparmap = {
                            userId : self.sessionId
                        };
                        
                        $.ajax({
                            url: "/user/vetInfo.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log(data);
                                self.vetList = data.vet;
                            }
                        });
                    },
                    fnSaveReply : function(){
                        let self = this;
                        var nparmap = {
                            vetBoardId: self.info.vetBoardId,
                            reviewText : self.reviewText,
                            vetId : self.vetId,
                            vetName : self.vetName,
                            vetNickName : self.vetNickName,
                        };
                        $.ajax({
                            url: "/board/vetBoardAnReply.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("멍멍",self.reviewText);
                                self.fnView();
                                self.showEditor();
                                self.showEdit();
                                self.showChoice();

                                alert("저장되었습니다");
                            }
                        });
                    },
                    showEditor : function() {
                        let self = this;
                        self.showAnsw = !self.showAnsw;
                    },
                    fnShowChoice : function(choiceId){
                        let self =  this;
                        self.showChoice = choiceId;
                    },
                    fnAnSelect : function(){
                        let self = this;
                        var nparmap = {
                            vetId : self.vetId,
                            userId : sessionId,
                            rating : self.rating,
                            comments : self.comments,
                        };

                        $.ajax({
                            url: "/board/vetBoardAnSelect.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("멍멍",self.reviewText);
                                if(confirm="정말 채택하시겠습니까?"){

                                }
                            }
                        });
                    },
                    fnAnEdit : function(){
                        let self = this;
                        var nparmap = {
                            vetId : self.vetId,
                            userId : sessionId,
                            reviewText : self.reviewText,
                        };

                        $.ajax({
                            url: "/board/vetBoardAnEdit.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("답글 수정", data);

                            }
                        });
                    },
                    fnAnEditCha : function (contents, answerId){
                        let self = this;
                        self.showEdit = answerId;
                            // 2초 후에 editorEdit() 함수 실행
                            setTimeout(function() {
                                self.editorEdit(contents);
                            }, 200);  // 2000ms = 2초
                    },
                    fnCancle : function(){
                        let self = this;
                        alert("취소되었습니다.")
                        return;
                    },
                    editorEdit : function(contents) {
                        let self = this;
                        var quillEdit = new Quill('#editorEdit', {
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
                        quillEdit.root.innerHTML = contents;
                        // 에디터 내용이 변경될 때마다 Vue 데이터를 업데이트
                        quillEdit.on('text-change', function () {
                            self.reviewText = quillEdit.root.innerHTML;
                        });
                    },
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.fnView();
                    self.fnVetInfo();
                    var quill = new Quill('#editor', {
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
                                self.reviewText = quill.root.innerHTML;
                    });
                }
            });

            app.mount("#app");
        });
    </script>
