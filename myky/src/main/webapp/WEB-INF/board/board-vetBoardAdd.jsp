<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>수의사 게시판 ADD</title>
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

        <div class="fb-section-header">
            ADD
        </div>
        <div class="fb-section-headerDown">
            게시글 내용을 작성합니다.
        </div>
        <hr class="fb-custom-hr">

        <div class="fb-content-wrap">
            <div class="fb-title-label">POINT</div>
            <div class="fb-point-input">
                <div class="fb-point-box">
                    <span class="fb-point-unit2"> {{ usedPoint === '' ? '보유포인트' : '사용포인트' }} </span>
                    <input v-model="usedPoint" class="fb-point-place fb-point-clear-input"
                    v-bind:placeholder="currentPoint.currentPoint" @input="fnCheck" @focus="isUsed = false">
                    <span class="fb-point-unit">P</span>
                    <button class="fb-clear-btn" :class="{ 'disabled': !usedPoint }" @click="usedPoint = 0"><img src="../img/freeBoard/close.png"></button>
                    
                </div>
                <button class="fb-fill-btn" @click="usedPoint = currentPoint.currentPoint">
                    전액입력
                </button>
                <!-- <button class="fb-point-button" :class="{ 'fb-point-button-active': isUsed }" @click="fnUsePoint">사용</button> -->
            </div>
            <div class="fb-title-label">
                <div>TITLE</div>
            </div>
                <div class="fb-title-input">
                    <input v-model="title">
                </div>
            <div class="fb-title-label">CONTENT</div>
            <div class="fb-editor-boxBigAdd">
                <div id="fb-editor" style="height: 500px;"></div>
            </div>
            <div class="fb-buttonStyle fb-buttonMargin">
                <button class="fb-button" @click="fnSave">저장</button>
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
                       title : "",
                       content : "",
                       sessionId : "${sessionId}",
                       vetBoardId : "",
                       selectPoint : "",
                       point : "",
                       currentPoint : "",
                       usedPoint : '',
                       remark : "수의사 상담 point 차감",
                       isUsed: false,
                    };
                },
                computed: {

                },
                methods: {
                    fnSave(){
                        let self = this;
                        let usedPoint = -Math.abs(parseInt(self.usedPoint));
                        if(!(self.isNumber(usedPoint))){
                            alert("숫자만 입력해주세요");
                            return;
                        }
                        let nparmap = {
                            title : self.title,
                            content : self.content,
                            userId : self.sessionId,
                            points : self.usedPoint,
                        }
                        let pointUsed = {
                            userId : self.sessionId,
                            usedPoint : usedPoint,
                            remarks : self.remark,
                        }
                        
                        let nparmap1 = {
                            userId : self.sessionId,
                        };

                        $.ajax({
				        	url:"/point/current.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap1,
				        	success : function(data) {
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/vetBoardList.do";
                                }
                                let currentPoint = data.point.currentPoint;

                                if(currentPoint < self.usedPoint){
                                    alert("포인트가 부족합니다.");
                                    return;
                                }

                                $.ajax({
                                    url:"/board/vetBoardAdd.dox",
                                    dataType:"json",	
                                    type : "POST", 
                                    data : nparmap,
                                    success : function(data) {
                                        if(confirm("정말 저장하시겠습니까? 저장 후, 사용한 포인트는 차감됩니다.")){
                                            $.ajax({
                                                url:"/point/used.dox",
                                                dataType:"json",	
                                                type : "POST", 
                                                data : pointUsed,
                                                success : function(data) { 
                                                    location.href = "/board/vetBoardList.do"
                                                }
                                            });
                                        } else {
                                            alert("취소되었습니다.");
                                        } 
                                    },
                                });    
				        	}
				        });
                                            
                    },
                    fnCheck : function (){
                        let self = this;
                        self.usedPoint = self.usedPoint.replace(/[^0-9]/g,'');
                        self.isUsed = false;
                    },
                    getPoints : function(){
                        let self = this;
                        let nparmap = {
                            userId : self.sessionId,
                        };
                        $.ajax({
				        	url:"/point/current.dox",
				        	dataType:"json",	
				        	type : "POST", 
				        	data : nparmap,
				        	success : function(data) { 
                                self.currentPoint = data.point;
				        	}
				        });
                    },
                    fnBack : function (info) {
                        let self = this;
                        location.href="/board/vetBoardList.do";
                    
                    },
                    isNumber(val) {
                        let self = this;

                        return typeof val === 'number' && !isNaN(val);
                    },
                    fnUsePoint (){
                        let self = this;
                        self.isUsed = !self.isUsed;
                    }
                },
                mounted() {
                	let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.getPoints();

                    if(self.sessionId == ''){
                        alert("로그인이 필요합니다.");
                        location.href="/board/vetBoardList.do?category="+self.category;
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
