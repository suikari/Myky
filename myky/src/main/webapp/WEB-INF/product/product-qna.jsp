<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Q&A 상세보기</title>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
        .qna-container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            border: 1px solid #ddd;
            padding: 30px;
            border-radius: 6px;
        }

        .qna-header {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .qna-meta {
            font-size: 14px;
            color: #777;
            margin-bottom: 20px;
        }

        .qna-content {
            font-size: 16px;
            line-height: 1.6;
            margin-bottom: 40px;
        }

        .answer-box {
            border-top: 1px solid #ccc;
            padding-top: 30px;
        }

        textarea {
            width: 100%;
            padding: 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            margin-top: 10px;
            padding: 8px 16px;
            background-color: black;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .admin-answer {
            background-color: #f4f4f4;
            padding: 15px;
            margin-top: 20px;
            border-left: 5px solid #28a745;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>

    <div id="app" class="container">
        <div class="qna-container" v-if="qna">
            <div class="qna-header">{{ qna.title }}</div>
            <div class="qna-meta">
                작성자: {{ qna.userId }} | 작성일: {{ qna.createdAt }} | 조회수: {{ qna.viewCount }}
            </div>
            <div class="qna-content" v-html="qna.questionText"></div>

            <div class="answer-box">
                <template v-if="qna.answer">
                    <div class="admin-answer">
                        <strong>📌 관리자 답변</strong><br />
                        <div style="margin-top: 8px;" v-html="qna.answer"></div>
                    </div>
                </template>

                <template v-else-if="isAdmin">
                    <h4>답변 등록</h4>
                    <textarea v-model="adminAnswer" rows="4" placeholder="답변을 입력하세요"></textarea>
                    <button @click="submitAnswer">답변 등록</button>
                </template>

                <template v-else>
                    <p style="color: gray;">아직 등록된 답변이 없습니다.</p>
                </template>
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
                    productId: '',
                    qnaId: '',
                    qna: null,
                    adminAnswer: '',
                    sessionId: "${sessionId}" // 세션 ID 받기
                };
            },
            computed: {
                isAdmin() {
                    return this.sessionId === 'admin'; // 관리자 ID 조건은 필요 시 바꿔줘
                }
            },
            methods: {
                fetchQna() {
                    const self = this;
                    $.ajax({
                        url: "/product/qnaView.dox",
                        type: "POST",
                        data: {
                            productId: self.productId,
                            qnaId: self.qnaId
                        },
                        dataType: "json",
                        success(data) {
                            console.log("Q&A 상세", data);
                            self.qna = data.qna;
                        }
                    });
                },
                submitAnswer() {
                    const self = this;
                    if (!self.adminAnswer) {
                        alert("답변을 입력하세요");
                        return;
                    }

                    $.ajax({
                        url: "/product/qnaAnswer.dox",
                        type: "POST",
                        data: {
                            qnaId: self.qnaId,
                            answer: self.adminAnswer
                        },
                        dataType: "json",
                        success(data) {
                            alert("답변이 등록되었습니다.");
                            self.fetchQna(); // 답변 등록 후 다시 불러오기
                            self.adminAnswer = '';
                        }
                    });
                }
            },
            mounted() {
                const params = new URLSearchParams(window.location.search);
                this.productId = params.get("productId");
                this.qnaId = params.get("qnaId");

                if (!this.qnaId || !this.productId) {
                    alert("잘못된 접근입니다.");
                    return;
                }

                this.fetchQna();
            }
        });

        app.mount("#app");
    });
</script>
