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
    <link rel="stylesheet" href="/css/board/board.css"/>
    

    <style>
      
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="fb-app" class="fb-container">

            <div id="fb-viewPage">
                <div class="fb-section-header" >
                    VIEW
                </div>
                <div class="fb-section-headerDown">
                    질문과 답
                </div>
                <hr class="fb-custom-hr">

                <div class="fb-title-label">
                    TITLE
                </div>
                <div class="fb-view-box">
                    <a style="font-size:20px">{{info.title}}</a>

                    <div class="fb-author-box">
                        <span class="fb-author-label">작성자</span>
                        <span class="fb-author-name">{{info.nickName}}</span>
                        <span class="fb-badge">{{info.points}} P</span>
                      </div>
                    <div>
                        <div class="fb-meta">
                            <span class="fb-date">🕒 {{info.createdAt}}</span>
                            <span class="fb-views">|  조회수 {{info.cnt}}</span>
                        </div>
                    </div>
                </div>
                    <div class="fb-view-label">CONTENT</div>
                    <div class="fb-view-boxContent" v-html="info.content"></div>
                    
    

                    <!-- 답글 달기 -->
                    <div class="fb-answer-actions">
                        <div @click="showEditor" v-if=" (vetList.vetId && info.userId != sessionId) && info.isAccepted === 'N'">
                            <div class="fb-answerButton">답변하기</div>
                        </div>
                        <div v-show="showAnsw" class="fb-editor-box">
                                <!--  Quill 에디터 -->
                            <div id="fb-editor" class="fb-editor answer2"></div>
                            <!--  등록 버튼 영역 -->
                            <button class="fb-cmtButton" @click="fnSaveReply">등록</button>
                        </div>
                    </div>


                <!-- 답변 출력 전체 -->
                <div v-for="answer in answerList" class="fb-answer-box">
                    <!-- 채택된 답변 -->
                    <div v-if="answer.comments">
                        <div class="fb-accepted-header" style="font-size: 18px; font-weight: bold; color: #202060;">
                            질문자 채택
                        </div>
                        
                        <!-- 별점 -->
                        <div class="star-rating">
                            <span v-for="n in 5" :key="n" class="star" :class="{ active: n <= answer.rating }">★</span>
                        </div>
                        <div class="fb-answer-nickname2">{{info.nickName}}</div>
                        <div class="fb-answer-header">
                            <div class="fb-answer-meta">{{ answer.createdAt }}</div>
                        </div>
                        <!-- 후기 -->
                        <div class="fb-answer-comments">
                            <span class="underline-animated underline-text">{{ answer.comments }}</span>
                        </div>

                        <!-- 답변 작성자 정보 -->
                        <div class="fb-answer-nickname"><span>수의사</span>  {{ answer.vetNickname }} ({{ answer.vetName }})</div>
                        <div class="fb-answer-header">
                            <div class="fb-answer-meta">{{ answer.createdAt }}</div>
                        </div>
                    <div>
                    <div class="fb-comment-box">
                        <img :src="userInfo.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                        alt="프로필 이미지"
                        class="fb-profile-img">
                    </div>
                    </div>

                        <!-- 본문 -->
                        <span class="underline-animated underline-text fb-answer-comments">
                            <div v-html="answer.reviewText"></div>
                        </span>
                    </div>

                    <!-- 답변 출력/채택 전 -->
                    <div v-else>
                        <div class="fb-answer-nickname">{{ answer.vetNickname }} ( {{ answer.vetName }} )</div>
                        <div class="fb-answer-header">
                            <div class="fb-answer-meta">{{ answer.createdAt }}</div>
                        </div>
                        <div>
                            <img :src="userInfo.profileImage || '/img/default-profile.png'"
                            alt="프로필 이미지"
                            class="fb-profile-img">
                        </div>
                        <div v-if="answer.isDeleted == 'N'" v-html="answer.reviewText"></div>
                        <div v-if="answer.isDeleted == 'Y'" > 삭제된 답변입니다 </div>
                    </div>

                 <!-- 답변 채택 -->
                    <template v-if="answer && answer.isDeleted === 'N'">

                    <!-- 채택 버튼 (질문자만 보임) -->
                        <template v-if="sessionId == info.userId && showChoice !== answer.reviewId && info.isAccepted == 'N'">
                            <button @click="fnShowChoice(answer.reviewId)" class="fb-choice-button">채택</button>
                        </template>

                        <!-- 채택 UI (showChoice === 현재 답변) -->
                        <template v-if="showChoice === answer.reviewId">
                            <div class="fb-accepted-answer-box" style="border: 2px solid #fca311; border-radius: 10px; padding: 15px; margin: 10px 0; background-color: #f0f8ff;">
                                
                                <!-- 라벨 -->
                                <div class="fb-accepted-header" style="font-size: 18px; font-weight: bold; color: #202060;">
                                질문자 채택
                                </div>

                                <!-- 별점 UI -->
                                <div class="form-group star-rating" style="margin-top: 15px;">
                                <label class="rating-label" for="rating" style="font-weight: bold; color:#fca311;"></label>
                                    <div class="stars" style="font-size: 20px;">
                                        <span v-for="star in 5" :key="star" class="star" :class="{ active: star <= rating }" @click="rating = star" style="cursor: pointer;">★</span>
                                    </div>
                                </div>

                                <!-- 후기 입력 -->
                                <input v-model="comments" placeholder="후기를 작성해주세요" style="width: 100%; padding: 10px; margin-top: 10px; border-radius: 5px; border: 1px solid #ccc;" />

                                <!-- 기존 댓글 표시 -->
                                <div>{{ answer.comments }}</div>
                                
                                <!-- 등록 버튼 -->
                                <button @click="fnAnSelect(answer.userId)" class="fb-choiceSaveButton">
                                    등록
                                </button>
                                <button class="fb-choiceSaveButton" @click="fnCancelChoice">취소</button>
                            </div>
                        </template>
                    </template>
                
                    <template v-if="(vetList.vetId == answer.vetId) && info.isAccepted === 'N' && answer.isDeleted == 'N'">  
                        <button class="fb-cmtButton" @click="fnAnEditCha(answer.reviewText, answer.reviewId)" v-if="showEdit !== answer.reviewId">수정</button>
                        <template v-if="(showEdit == answer.reviewId) && info.isAccepted === 'N'">
                            <div class="fb-editor-box">
                                <!-- 🖋 Quill 에디터 [수정]-->
                                <div>
                                    <div id="editorEdit" class="fb-quill-editor"></div>
                                </div>
                                <div class="fb-reply-buttons">
                                    <button class="fb-cmtButton" @click="fnAnEdit()">등록</button>
                                </div>
                            </div>
                            <button class="fb-cmtButton" @click="fnCancle">취소</button>
                        </template>
                        <button class="fb-cmtButton" @click="fnAnRemove(answer.reviewId)">❌ 삭제</button>
                    </template>
                    
                    <template v-if="isDeleted == 'Y'">
                        <div style="margin-bottom: 5px;">삭제된 답변입니다.</div>
                    </template>
                </div>
                  
                <div class="fb-footer-buttons">
                    <template v-if="sessionId == info.userId && info.isAccepted === 'N'">
                        <button class="fb-button" @click="fnEdit()">수정</button>
                    </template>
                    <template v-if="(sessionId == info.userId || sessionRole == 'ADMIN') && info.isAccepted == 'N'">
                        <button class="fb-button" @click="fnRemove()">삭제</button>
                    </template>
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
                        quillEdit: null, // ← 여기!
                        userInfo : {},
                    };
                },
                computed: {
                    acceptedAnswers() {
                        return this.answerList.filter(
                        answer => answer.comments && answer.comments !== 'null'
                        );
                    },
                    normalAnswers() {
                        return this.answerList.filter(
                        answer => (!answer.comments || answer.comments === 'null') && answer.isDeleted === 'N'
                        );
                    }
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
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/vetBoardList.do";
                                }
                                self.info = data.info;
                                self.answerList = data.answerList;
                                console.log("fnView",data);
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
                            message : "게시글에 답변이 등록되었습니다."

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
                                    return;
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
                            vetBoardId : self.vetBoardId,
                            createdAt : self.createdAt,
                            message : "답변이 채택되었습니다."

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
                        if (!confirm("정말 삭제하시겠습니까?")) {
                           alert("취소되었습니다.");
                           return;
                        } 
                        
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
                        self.showEdit = null;
                        alert("취소되었습니다.");
                        return;
                    },
                    fnCancelChoice() {
                        this.showChoice = null;
                    },
                    fnUserInfo : function(){
                        let self = this;
                        
                        var nparmap = {
                            userId : self.sessionId
                        };
                        
                        $.ajax({
                            url: "/user/info.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                self.userInfo = data.user;
                                console.log("user",data.user);
                            }
                        });
                    },
                    editorEdit : function(contents) {
                        let self = this;
                       
                            // 이미 인스턴스가 있다면 재생성하지 않음
                            if (self.quillEdit) {
                                self.quillEdit.root.innerHTML = contents;
                                return;
                            }

                            // 새로 생성
                            self.quillEdit = new Quill('#editorEdit', {
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

                            // 초기 내용 설정
                            self.quillEdit.root.innerHTML = contents;

                            // 에디터 내용이 변경될 때마다 Vue 데이터 업데이트
                            self.quillEdit.on('text-change', function () {
                                self.reviewText = self.quillEdit.root.innerHTML;
                            });


                    },
                },
                mounted() {
                    let self = this;
                    
                    const params = new URLSearchParams(window.location.search);
                    self.fnVetInfo();
                    self.fnView();
                    self.getCurrent();


                    self.fnUserInfo();

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
                                self.reviewText = quill.root.innerHTML;
                    });
                }
            });

            app.mount("#fb-app");
        });
    </script>
