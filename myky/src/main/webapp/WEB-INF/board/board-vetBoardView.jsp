<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수의사 게시판</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <!-- Quill CDN -->
    <link href="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.snow.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/quill@2.0.3/dist/quill.js"></script>
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
                    수의사분들과 함께 질문을 나눠보세요
                </div>
                <hr class="fb-custom-hr">

                <div class="fb-post-wrapper">
                    <div class="fb-post-header">
                    <div class="fb-post-title">{{ info.title }}</div>
                    <div class="fb-post-meta">
                        <span class="fb-nickname">{{ info.nickName }}</span>
                        <span class="fb-badge">{{info.points}} P</span>
                        <span class="fb-date">🕒 {{ info.createdAt }}</span>
                        <span class="fb-views">조회수 {{ info.cnt }}</span>
                    </div>
                    </div>
              
                    <div class="fb-post-content" v-html="info.content"></div>
                </div>


                    <!-- 답글 달기 -->
                    <div class="fb-answer-actions">
                        <div @click="showEditor" v-if=" (vetList.vetId && info.userId != sessionId) && info.isAccepted === 'N'">
                            <div class="fb-answerButton">답변하기</div>
                        </div>
                        <div v-show="showAnsw" class="fb-editor-box-an">
                                <!--  Quill 에디터 -->
                            <div id="fb-editor" class="fb-editor answer2"></div>
                            <!--  등록 버튼 영역 -->
                            <button class="fb-cmtButton" @click="fnSaveReply">등록</button>
                        </div>
                    </div>


                <!-- 답변 출력 전체 -->
                <div v-for="answer in answerList" class="fb-answer-box">
                    <!-- 채택된 답변 -->
                    <div v-if="answer.comments" class="fb-accepted-answer">
                        <div class="fb-accepted-header">
                            질문자 채택
                        </div>
                        
                        <!-- 별점 -->
                        <div class="star-rating">
                            <span v-for="n in 5" :key="n" class="star" :class="{ active: n <= answer.rating }">★</span>
                        </div>
                        <div class="fb-answer-meta-container">
                            <img :src="info.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                                alt="프로필 이미지"
                                class="fb-top-profile-img2">
                            <div class="fb-answer-meta-text">
                                <div class="fb-answer-nickname2">{{info.nickName}}</div>
                                <div class="fb-answer-header">
                                    <div class="fb-answer-meta">{{ answer.createdAt }}</div>
                                </div>
                                <div class="underline-animated underline-text fb-answer-comments">{{ answer.comments }}</div>
                            </div>
                        </div>
                        <!-- 후기 -->

                        <!-- 답변 작성자 정보 -->
                        <div class="fb-top-profile">
                            <img :src="answer.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                                alt="프로필 이미지"
                                class="fb-top-profile-img">
                            
                            <div class="fb-top-profile-info">
                                <div class="fb-info-box">
                                    <div class="fb-profile-name" style="font-size: 20px; color: #fca311;">{{ answer.vetName }}</div>                            
                                    <span class="fb-profile-badges" style="font-size: 15px;">{{answer.affiliatedHospital}}</span >
                                    <span class="fb-badge orange">{{answer.eMail}}</span >
                                </div>
                                <!-- 수의사별 별점 표시 -->
                                <div v-if="answer.vetAnswerdetail" class="vet-rating">                           
                                    <!-- 별점 표시 -->
                                    <div class="star-rating">
                                        <span v-for="n in 5" :key="n" class="star"
                                              :class="{ active: n <= getAverageRating(answer) }">★</span>
                                    </div>
                                    {{ answer.vetAnswerdetail.length }}건 채택
                                    <div class="average-rating">평균 평점: {{ getAverageRating(answer) }} </div>
                                </div>                            
                            </div>
                        </div>
                        <!-- 본문 -->

                            <div v-html="answer.reviewText" class="quill-output"></div>
                    </div>

                    <!-- 답변 출력/채택 전 -->
                    <div v-else>
                        <div class="fb-top-profile">
                            <img :src="answer.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                                alt="프로필 이미지"
                                class="fb-top-profile-img">
                            
                            <div class="fb-top-profile-info">
                            <div class="fb-info-box">
                                <div class="fb-profile-name" style="font-size: 20px; color: #fca311;">{{ answer.vetName }}</div>                            
                                <span class="fb-profile-badges" style="font-size: 15px;">{{answer.affiliatedHospital}}</span >
                                <span class="fb-badge orange">{{answer.eMail}}</span >
                            </div>
                            <div class="fb-answer-meta">{{ answer.createdAt }}</div>
                                <div v-if="answer.vetAnswerdetail" class="vet-rating">
                                    {{ answer.vetAnswerdetail.length }}건 채택
                                
                                    <!-- 별점 표시 -->
                                    <div class="star-rating">
                                        <span v-for="n in 5" :key="n" class="star"
                                                :class="{ active: n <= getAverageRating(answer) }">★</span>
                                    </div>
                                    <div class="average-rating">평균 평점: {{ getAverageRating(answer) }} </div>
                                </div>
                            </div>
                        </div>
                        <div class="quill-output" v-if="answer.isDeleted == 'N'" v-html="answer.reviewText"></div>
                        <div class="quill-output" v-if="answer.isDeleted == 'Y'" > 삭제된 답변입니다 </div>
                        
                    </div>

                 <!-- 답변 채택 -->
                    <template v-if="answer && answer.isDeleted === 'N'">

                    <!-- 채택 버튼 (질문자만 보임) -->
                        <template v-if="sessionId == info.userId && showChoice !== answer.reviewId && info.isAccepted == 'N'">
                            <button @click="fnShowChoice(answer.reviewId)" class="fb-choice-button">채택</button>
                        </template>

                        <!-- 채택 UI (showChoice === 현재 답변) -->
                        <template v-if="showChoice === answer.reviewId">
                            <div class="fb-accepted-answer-box">
                                
                                <!-- 라벨 -->
                                <div class="fb-accepted-header">
                                질문자 채택
                                </div>

                                <!-- 별점 UI -->
                                <div class="form-group star-rating" style="margin-top: 15px;">
                                <label class="rating-label" for="rating" style="color:#fca311;"></label>
                                    <div class="stars" style="font-size: 20px;">
                                        <span v-for="star in 5" :key="star" class="star" :class="{ active: star <= rating }" @click="rating = star" style="cursor: pointer;">★</span>
                                    </div>
                                </div>

                                <!-- 후기 입력 -->
                                <input v-model="comments" class="answer-commentsInput" placeholder="후기를 작성해주세요" ref="reviewInput" />

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
                        <button class="fb-cmtButton" @click="fnAnRemove(answer.reviewId)">삭제</button>
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
                <div class="fb-mini-board">
                    <table class="fb-mini-table">
                        <tr class="fb-mini-table-th fb-mini-th">
                            <th colspan="4">전체글</th>
                        </tr>

                        <tr class="fb-mini-td" v-for="list2 in list.slice(0,5)" 
                            :style="list2.vetBoardId === info.vetBoardId ? 'font-weight: bold; background-color: #f8f8f8' : ''"
                            @click="fnVetList(list2.vetBoardId)">
                            <td style="width: 600px;">{{list2.title}}</td>
                            <td>{{list2.points}}P</td>
                            <td>{{list2.createdAt}}</td>
                            <td>
                                <span :class="[
                                    list2.isAccepted === 'Y' ? 'fb-mini-accepted' : 
                                    parseInt(list2.commentCount) > 0 ? 'fb-mini-waiting' : 
                                    'fb-mini-noAnswer'
                                ]">
                                    {{list2.isAccepted === 'Y' ? '채택완료' : 
                                      parseInt(list2.commentCount) > 0 ? '채택전' : 
                                      '답변대기'}}
                                </span>
                            </td>
                        </tr>
                    </table>
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
                        list : [],
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
                        vetRatings : {},
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
                            vetId : self.vetId
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

				        	},
				        });
                    },
                    fnVetBoardList() {
                        let self = this;
                        let nparmap = {
                            searchOption: self.searchOption,
                            page: (self.page - 1) * self.pageSize,
                            pageSize: self.pageSize,
                            orderKey: self.orderKey,
                            orderType: self.orderType,
                            keyword: self.keyword,
                            userId: self.userId,
                            nickName : self.nickName,
                            content : self.content,
                        };
                        $.ajax({
                            url: "/board/vetBoardList.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/vetBoardList.do";
                                }
                                
                                // 현재 게시글의 인덱스 찾기
                                let currentIndex = data.vetBoard.findIndex(item => item.vetBoardId === self.vetBoardId);
                                
                                // 현재 게시글 기준 앞뒤 2개씩 총 5개 게시글 추출
                                let start = Math.max(0, currentIndex - 2);
                                let end = Math.min(start + 5, data.vetBoard.length);
                                
                                // start가 끝에서부터 5개 미만일 경우 앞에서부터 조정
                                if (end - start < 5) {
                                    start = Math.max(0, end - 5);
                                }
                                
                                self.list = data.vetBoard.slice(start, end);

                                // 나머지 코드는 그대로 유지
                                if (data.count && data.count.cnt !== undefined) {
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                }
                            }
                        });
                    },
                    fnVetList(vetBoardId){
                        let self = this;                        
                        localStorage.setItem("page", self.page);
                        location.href="/board/vetBoardView.do?vetBoardId=" + vetBoardId;
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

                                if(data.vet) {
                                    self.vetList = data.vet;
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
                        $.ajax({
                            url: "/board/vetBoardAnReply.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
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
                        this.$nextTick(() => {
                        // document로 특정 요소 선택
                            const inputElement = document.querySelector('.answer-commentsInput'); // v-model 바인딩된 입력란

                            if (inputElement) {
                            inputElement.focus();  // 포커스 주기
                            inputElement.scrollIntoView({
                                behavior: 'smooth',  // 부드러운 스크롤
                                block: 'center'      // 요소를 화면 중앙에 맞추기
                                });
                            }
                        });

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
                                alert("답변이 채택되었습니다.");
                                self.isSelected = true;

                                $.ajax({
                                    url:"/point/used.dox",
                                    dataType:"json",	
                                    type : "POST", 
                                    data : pointAdd,
                                    success : function(data) { 
                                        self.showChoice = '';
                                        self.reviewId = '';
                                        self.fnView();
                                    },
                                    
                                });
                            },                                
                            error: function () {
                                alert("채택이 실패하였습니다.");
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

                                alert("삭제되었습니다.");
                                self.fnView();
                            },
                            error: function (xhr, status, error) {

                                alert("삭제 중 오류가 발생했습니다.");
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
                    getAverageRating(answer) {
                        const details = answer.vetAnswerdetail || [];
                        const validRatings = details.map(item => Number(item.rating)).filter(r => !isNaN(r) && r > 0);

                        if (validRatings.length === 0) return 0;

                        const total = validRatings.reduce((sum, r) => sum + r, 0);
                        return (total / validRatings.length).toFixed(1);
                    },
                },
                mounted() {
                    let self = this;
                    
                    const params = new URLSearchParams(window.location.search);
                    self.fnVetInfo();
                    self.fnView();
                    self.getCurrent();
                    self.fnVetBoardList();

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
