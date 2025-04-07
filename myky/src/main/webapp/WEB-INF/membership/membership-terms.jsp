<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멤버십 가입 - 약관 동의</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="/css/membership/membership.css" />
    <style>
        
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />

    <div id="app" class="container">
        <h2>🐾 멍냥꽁냥 멤버십 가입 - 약관 동의</h2>

        <!-- STEP 1: 약관 동의 -->
        <div class="step-box">
            <h3>📄 아래 약관을 확인하고 동의해주세요</h3>
            <div class="checkbox-group">
                <label>
                    <input type="checkbox" v-model="allAgree" @change="toggleAll">
                    전체 약관에 동의합니다
                </label>

                <div v-for="term in termsList" :key="term.termId" class="term-box">
                    <label>
                        <input type="checkbox" v-model="agreeList[term.termId]">
                        <i class="fas fa-file-alt"></i>
                        {{ term.requiredYn === 'Y' ? '[필수]' : '[선택]' }} {{ term.title }}
                    </label>
                    <div class="term-content" v-html="term.content"></div>
                </div>
            </div>
        </div>

        <button class="btn-submit" @click="nextStep" :disabled="!isRequiredAgreed">다음</button>
    </div>

    <jsp:include page="/WEB-INF/common/footer.jsp" />
</body>
</html>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        termsList: [],
                        agreeList: {},
                        allAgree: false
                    };
                },
                computed: {
                    isRequiredAgreed() {
                        return this.termsList
                            .filter(t => t.requiredYn === 'Y')
                            .every(t => this.agreeList[t.termId]);
                    }
                },
                methods: {
                    loadTerms() {
                        const self = this;

                        $.ajax({
                            url: "/membership/termsList.dox",
                            type: "POST",
                            data: { category: 'M' },
                            dataType: "json",
                            success(data) {
                                if (data.list && Array.isArray(data.list)) {
                                    console.log("M 카테고리 약관 리스트:", data.list); 
                                    self.termsList = data.list;
                                    data.list.forEach(term => {
                                        self.agreeList[term.termId] = false;
                                    });
                                } else {
                                    alert("약관 정보를 불러올 수 없습니다.");
                                }
                            }
                        });
                    },
                    toggleAll() {
                        const checked = this.allAgree;
                        this.termsList.forEach(term => {
                            this.agreeList[term.termId] = checked;
                        });
                    },
                    nextStep() {
                        if (!this.isRequiredAgreed) {
                            alert("필수 약관에 모두 동의해주세요.");
                            return;
                        }
                        // 본인인증 단계 이동
                        location.href = "/membership/join.do";
                    }
                },
                mounted() {
                    this.loadTerms();
                }
            });

            app.mount("#app");
        });
    </script>
