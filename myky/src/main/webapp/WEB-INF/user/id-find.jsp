<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
    <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
		<link rel="stylesheet" href="/css/user/user.css" />
    <style>

    </style>
  </head>

  <body>
    <jsp:include page="/WEB-INF/common/header.jsp" />

    <div id="app" class="container">
      <div class="id-container">
        <div v-if="authFlg == false" class="id-form-section">
          <div class="id-form-group">
            <label for="userName" class="id-form-label">이름:</label>
            <input v-model="userName" class="id-form-input" type="text" id="userName" />
          </div>

          <div class="id-form-group">
            <label for="phone" class="id-form-label">연락처:</label>
            <div class="id-phone-input">
              <select v-model="selectNum" class="id-phone-select">
                <option value="010">010</option>
                <option value="011">011</option>
                <option value="017">017</option>
              </select>
              <span class="id-dash">-</span>
              <input v-model="num1" class="id-phone-part" maxlength="4" />
              <span class="id-dash">-</span>
              <input v-model="num2" class="id-phone-part" maxlength="4" />
            </div>

            <button @click="fnIdChecked()" class="id-btn id-btn-search">아이디 검색</button>
            <button @click="fnExit()" class="id-btn id-btn-cancel">취소</button>
          </div>
        </div>

        <div v-else class="id-result-section">
          <h3>{{ list.userName }}님의 아이디는 {{ list.userId }} 입니다.</h3>
          <div class="id-button-group">
            <button @click="fnPasswordReset()" class="id-btn id-reset-btn">비밀번호 찾기</button>
            <button @click="fnExit()" class="id-btn id-login-btn">로그인</button>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/common/footer.jsp" />


  </body>

  </html>
  <script>


    document.addEventListener("DOMContentLoaded", function () {
      const app = Vue.createApp({
        data() {
          return {
            list: [],
            userName: "",
            phoneNumber: "",
            selectNum: "010",
            num1: "",
            num2: "",
            authFlg: false


          };
        },
        computed: {

        },
        methods: {
          fnIdChecked: function () {
            var self = this;
            self.phoneNumber = self.selectNum + self.num1 + self.num2;
            var nparmap =
            {
              phoneNumber: self.phoneNumber,
              userName: self.userName
            };
            $.ajax({
              url: "/user/check.dox",
              dataType: "json",
              type: "POST",
              data: nparmap,
              success: function (data) {
                if (data.count == 0) {
                  alert("정보에 일치하는 아이디가 없습니다.");


                } else {
                  self.list = data.user;
                  self.authFlg = true;
                }
              }
            });
          },
          fnPasswordReset: function () {
            location.href = "/user/resetpwd.do";
          },

          fnExit: function () {
            location.href = "/user/login.do";
          }
        },
        mounted() {


        }
      });

      app.mount("#app");
    });
  </script>