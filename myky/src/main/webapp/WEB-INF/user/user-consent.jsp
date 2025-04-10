<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>회원가입 약관 동의</title>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/css/user/user.css" />
    <style>

    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />

    <div id="app" class="con-container">
        <h1 style="text-align: center;">🐾 멍냥꽁냥 회원 가입</h1>
        <br>
        <div style="font-size: 20px;">
            전체 동의 <input type="checkbox" @click="fnAllCheck()">
        </div>
        <hr><br>

        <div v-for="term in termsList" :key="term.termId">
            <div style="margin-top: 20px;">
                {{ term.title }} <span v-if="term.requiredYn === 'Y'">(필수)</span><span v-else>(선택)</span>
                <input type="checkbox" :checked="agreeList[term.termId] === 'Y'" @change="updateTermAgree(term.termId, $event)">
            </div>
            <div class="box" v-html="term.content"></div>
        </div>

        <br>
        <div>
            SMS 수신 동의(선택)
            <input type="checkbox" :checked="agreeSms === 'Y'" @change="agreeSms = $event.target.checked ? 'Y' : 'N'">
            &nbsp;&nbsp;
            이메일 수신 동의(선택)
            <input type="checkbox" :checked="agreeEmail === 'Y'" @change="agreeEmail = $event.target.checked ? 'Y' : 'N'">
        </div>

        <hr><br>
        <a href="/main.do" style="text-decoration: none"><span class="clb">취소</span></a>
        <a href="javascript:;" style="text-decoration: none"><span class="clb" @click="fnJoin()">회원가입하기</span></a>
    </div>

    <jsp:include page="/WEB-INF/common/footer.jsp" />
</body>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const app = Vue.createApp({
            data() {
                return {
                    termsList: [],
                    agreeList: {}, // termId: 'Y' or 'N'
                    agreeSms: "N",
                    agreeEmail: "N",
                    checked: false,
                    email: "${map.email}",
                    name: "${map.name}"
                };
            },
            methods: {
                loadTerms() {
                    const self = this;
                    $.ajax({
                        url: "/membership/termsList.dox",
                        type: "POST",
                        data: { category: 'J' },
                        dataType: "json",
                        success(data) {
                            if (data.list && Array.isArray(data.list)) {
                                self.termsList = data.list;
                                data.list.forEach(term => {
                                    self.agreeList[term.termId] = "N";
                                });
                            } else {
                                alert("약관 정보를 불러올 수 없습니다.");
                            }
                        }
                    });
                },
                updateTermAgree(termId, event) {
                    this.agreeList[termId] = event.target.checked ? 'Y' : 'N';
                },
                fnAllCheck() {
                    const self = this;
                    self.checked = !self.checked;
                    const value = self.checked ? 'Y' : 'N';

                    self.termsList.forEach(term => {
                        self.agreeList[term.termId] = value;
                    });

                    self.agreeSms = value;
                    self.agreeEmail = value;
                },
                fnJoin() {
                    const self = this;

                    // 필수 약관 체크 여부 확인
                    const requiredUnchecked = self.termsList
                        .filter(term => term.requiredYn === 'Y')
                        .some(term => self.agreeList[term.termId] !== 'Y');
                    if (requiredUnchecked) {
                        alert("필수 약관에 모두 동의해 주세요.");
                        return;
                    }

                    pageChange("/user/join.do", {
                        email: self.email,
                        name: self.name,
                        agreeSms: self.agreeSms,
                        agreeEmail: self.agreeEmail,
                        agreeList: self.agreeList.T008
                    });
                }
            },
            mounted() {
                this.loadTerms();
            }
        });

        app.mount("#app");
    });
</script>

</html>