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
        .rating-label {
            display: block;
            font-weight: bold;
            font-size: 16px;
            color: #000;
            margin-bottom: 6px;
        }

        .star-rating .stars {
            display: inline-block;
        }
        .star-rating .stars {
                display: inline-block;
        }

        .star-rating .star {
            font-size: 24px;
            cursor: pointer;
            color: #eee;
            transition: color 0.2s;
            user-select: none;

        }

        .star-rating .star.active {
            color: #FFD700;
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
                <div class="view-label">CONTENT</div>
                <div class="view-boxContent" v-html="info.content"></div>

                <div class="answer-actions">
                    <div @click="showEditor" v-if="vetList.vetId && info.isAccepted === 'N'">
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

                <!-- 답변 박스 -->
                <div v-for="answer in answerList" class="answer-box">
                    <template v-if="answer.isDeleted == 'N'">
                    <div class="answer-nickname">{{ answer.vetNickname }} ( {{ answer.vetName }} )</div>
                    <div class="answer-header">
                        <div class="answer-meta">{{ answer.createdAt }}</div>
                    </div>

                    <div  v-html="answer.reviewText"></div>
                    
                    
                 <!-- 댓글 내용 -->
                    
                 <template v-if="sessionId == info.userId">                        
                    <button @click="fnShowChoice(answer.reviewId)" class="choice-button">채택</button>
                </template>

                <template v-if="showChoice == answer.reviewId && info.isAccepted === 'Y'">
                    <div class="accepted-answer-box" style="border: 2px solid #4CAF50; border-radius: 10px; padding: 15px; margin: 10px 0; background-color: #f0f8ff;">
                        <!-- 채택된 답변 강조 -->
                        <div class="accepted-header" style="font-size: 18px; font-weight: bold; color: #4CAF50;">
                          질문자 채택
                        </div>
                        <!-- 별점 UI -->
                        <div class="form-group star-rating" style="margin-top: 15px;">
                            <label class="rating-label" for="rating" style="font-weight: bold;">별점</label>
                            <div class="stars" style="font-size: 20px;">
                            <span v-for="star in 5" :key="star" class="star" :class="{ active: star <= rating }" @click="rating = star" style="cursor: pointer;">★</span>
                            </div>
                        </div>
                        <!-- 후기 입력 -->
                            <input v-if="info.isAccepted === 'N'" v-model="comments" placeholder="후기를 작성해주세요" style="width: 100%; padding: 10px; margin-top: 10px; border-radius: 5px; border: 1px solid #ccc;" />
                            <div>{{answer.comments}}</div>
                        <!-- 등록 버튼 -->

                        <button v-if="info.isAccepted === 'N'" @click="fnAnSelect(answer.userId)" style="background-color: #4CAF50; color: white; padding: 10px 20px; border-radius: 5px; border: none; cursor: pointer; margin-top: 10px;">
                            등록
                        </button>
                    </div>
                    </template>

                
                    <template v-if="vetList.vetId == answer.vetId && info.isAccepted === 'N'">  
                            <button class="cmtButton" @click="fnAnEditCha(answer.reviewText, answer.reviewId)">수정</button>
                            
                            
                            <template v-if="showEdit == answer.reviewId && info.isAccepted === 'N'">
                                <div class="editor-box">
                                    <!-- 🖋 Quill 에디터 [수정]-->
                                    <div>
                                        <div id="editorEdit" class="quill-editor"></div>
                                    </div>
                                    <div class="reply-buttons">
                                        <button class="cmtButton" @click="fnAnEdit()">등록</button>
                                    </div>
                                </div>
                                <button class="cmtButton" @click="fnCancle">취소</button>
                            </template>
                            <button class="cmtButton" @click="fnAnRemove(answer.reviewId)">❌ 삭제</button>
                        </template>
                    </template>
                <template v-else>
                    <div style="margin-bottom: 5px;">삭제된 답변입니다.</div>
                </template>
                </div>

                  
                  <div class="cmtButton" style="display: flex; gap: 5px;">
                      <template v-if="sessionId == info.userId || sessionRole == 'ADMIN' && info.isAccepted === 'N'">
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
                        vetNickname : "",
                        nickName:"",
                        content : "",
                        updatedTime : "",
                        createdTime : "",
                        answerList :[],
                        data : {},
                        comments : "",
                        rating: '0',
                        vetName : "${map.nickName}",
                        showEdit : '0',
                        reviewText : "",
                        showAnsw : false,
                        vetList : {},
                        choiceBtn : false,
                        showChoice : '0',
                        reviewId : "",
                        points : "",
                        remark : "수의사 상담 point 적립",
                        isSelected : false,
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
                                console.log("지우라고해서",data);
				        	}
				        });
                    },
                    getCurrent : function(){
                        let self = this;
                        let nparmap = {
                            userId : self.sessionId,
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
                        location.href="/board/vetBoardEdit.do?vetBoardId=" + self.vetBoardId;
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
                                console.log("dd",data);

                                if(data.vet) {
                                    self.vetList = data.vet;
                                    console.log("vetList.vetId 로딩 완료:", self.vetList.vetId);
                                } else {

                                }

                            }
                        });
                    },
                    fnSaveReply : function(){
                        let self = this;

                        var nparmap = {
                            vetBoardId: self.info.vetBoardId,
                            reviewText : self.reviewText,
                            vetId : self.vetList.vetId,
                        };
                        console.log("s",self.vetList.vetId);
                        $.ajax({
                            url: "/board/vetBoardAnReply.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("멍멍", data);
                                self.fnView();
                                self.showEditor();
                                self.showEdit = 0;
                                if(data.status == "fail"){
                                    alert("이미 답변을 작성하셨습니다.");
                                    retrun;
                                }
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
                        self.reviewId = choiceId;
                        console.log("✅ 채택 선택됨: ", choiceId); // 확인용
                    },
                    fnAnSelect : function(userId){
                        let self = this;
                        let points = parseInt(self.points); //보내는 포인트(작성자 포인트)

                        if (self.isSelected) {
                            alert("이미 채택된 답변입니다.");
                            return;
                        }
                        if(!confirm("정말 채택하시겠습니까?")){
                            alert("취소 되었습니다.");
                            return;
                        }

                        var nparmap = {
                            reviewId : self.reviewId,
                            rating : self.rating,
                            comments : self.comments,
                            vetBoardId : self.vetBoardId
                        };
                        console.log("userId",userId);
                        let pointAdd = {
                            userId : userId, //받을 수의사 아이디
                            usedPoint : self.info.points,
                            remarks : self.remark,
                        }

                        $.ajax({
                            url: "/board/vetBoardAnSelect.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("채택",self.reviewText);
                                alert("답변이 채택되었습니다.");
                                self.isSelected = true;

                                $.ajax({
                                    url:"/point/used.dox",
                                    dataType:"json",	
                                    type : "POST", 
                                    data : pointAdd,
                                    success : function(data) { 
                                        console.log("받은포인트",data);
                                        console.log("포인트 확인",self.info.points);
                                        self.fnView();
                                    },
                                    
                                });
                            },
                                
                            error: function () {
                                console.error("채택 실패");
                            }
                        });
                    },
                    fnAnEdit : function(){
                        let self = this;

                        if (self.editorEditInstance) {
                            self.reviewText = self.editorEditInstance.root.innerHTML;
                        }


                        var nparmap = {
                            vetId : self.vetId,
                            reviewText : self.reviewText,
                            reviewId : self.reviewId,
                        };

                        $.ajax({
                            url: "/board/vetBoardAnEdit.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                console.log("답글 수정", data);
                                alert("수정되었습니다.")
                                location.href="/board/vetBoardView.do?vetBoardId=" + self.vetBoardId;
                            }
                        });
                    },
                    fnAnRemove : function (reviewId){
                        let self = this;
                        var nparmap = {
                            reviewId : reviewId,
                        };
                        console.log("보내는 리뷰 ID:", reviewId); // 👈

                        $.ajax({
                            url: "/board/vetBoardAnRemove.dox",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                            data: nparmap,
                            success: function (data) {
                                console.log("답글 삭제 성공", data);
                                alert("삭제되었습니다.");
                                self.fnView();
                            },
                            error: function (xhr, status, error) {
                                console.error("❌ 삭제 실패", status, error);
                                console.error("응답 내용:", xhr.responseText);
                                alert("삭제 중 오류 발생!");
                            }
                        });
                    },
                    fnAnEditCha : function (contents, answerId){
                        let self = this;
                        self.reviewId = answerId;
                        self.showEdit = answerId;
                            // 2초 후에 editorEdit() 함수 실행
                            setTimeout(function() {
                                self.editorEdit(contents);
                            }, 200);  // 2000ms = 2초.
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
                    self.fnVetInfo();
                    self.fnView();
                    self.getCurrent();
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
