<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <!DOCTYPE html>
  <html lang="ko">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
    <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

    <style>
      .container {
        max-width: 500px;
        margin: 50px auto;
        padding: 30px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      }

      /* 폼 섹션 스타일 (아이디 검색 전) */
      .form-section {
        display: flex;
        flex-direction: column;
      }

      .form-group {
        margin-bottom: 20px;
      }

      .form-label {
        display: block;
        font-size: 14px;
        font-weight: bold;
        color: #333;
        margin-bottom: 8px;
      }

      .form-input {
        width: 100%;
        padding: 10px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
      }

      .form-input:focus {
        border-color: #007BFF;
        outline: none;
      }

      /* 연락처 입력 필드 스타일 */
      .phone-input {
        display: flex;
        align-items: center;
      }

      .phone-select {
        padding: 5px;
        font-size: 14px;
        margin-right: 8px;
        border-radius: 4px;
        border: 1px solid #ccc;
      }

      .phone-dash {
        font-size: 18px;
        margin: 0 5px;
      }

      .phone-input-part {
        padding: 5px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        margin-left: 5px;
      }

      .search-btn {
        width: 45%;
        margin-left: 5px;
        padding: 12px;
        font-size: 16px;
        color: #fff;
        border: none;
        background-color: #28a745;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .search-btn:hover {
        background-color: #218838;
      }

      /* 결과 섹션 스타일 */
      .result-section {
        display: flex;
        flex-direction: column;
        align-items: center;
      }

      .result-section h3 {
        font-size: 18px;
        color: #333;
        margin-bottom: 20px;
      }

      /* 버튼 그룹 스타일 */
      .button-group {
        display: flex;
        justify-content: center;
        gap: 10px;
      }

      .reset-btn,
      .login-btn {
        padding: 12px 20px;
        font-size: 16px;
        color: #fff;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      .reset-btn {
        background-color: #f0ad4e;
      }

      .reset-btn:hover {
        background-color: #ec971f;
      }

      .login-btn {
        background-color: #007bff;
      }

      .login-btn:hover {
        background-color: #0056b3;
      }

      /* 반응형 스타일 */
      @media (max-width: 500px) {
        .container {
          padding: 20px;
        }

        .form-label {
          font-size: 12px;
        }

        .form-input {
          font-size: 14px;
        }

        .search-btn,
        .reset-btn,
        .login-btn {
          font-size: 14px;
        }

        .phone-select,
        .phone-input-part {
          font-size: 14px;
        }
      }
    </style>
  </head>

  <body>
    <jsp:include page="/WEB-INF/common/header.jsp" />

    <div id="app" class="container">
      <div v-if="authFlg == false" class="form-section">
        <div class="form-group">
          <label for="userName" class="form-label">이름:</label>
          <input v-model="userName" class="form-input" type="text" id="userName">
        </div>

        <div class="form-group">
          <label for="phone" class="form-label">연락처:</label>
          <div class="phone-input">
            <select v-model="selectNum" class="phone-select">
              <option value="010">010</option>
              <option value="011">011</option>
              <option value="017">017</option>
            </select>
            <span class="phone-dash">-</span>
            <input v-model="num1" class="phone-input-part" style="width: 40px;">
            <span class="phone-dash">-</span>
            <input v-model="num2" class="phone-input-part" style="width: 40px;">
          </div>
          <br>
          <br>
          <button @click="fnIdChecked()" class="search-btn">아이디 검색</button>
          <button @click="fnExit()" class="search-btn">취소</button>
        </div>
      </div>

      <div v-else class="result-section">
        <div>
          <h3>{{ list.userName }}님의 아이디는 {{ list.userId }} 입니다.</h3>
        </div>
        <div class="button-group">
          <button @click="fnPasswordReset()" class="reset-btn">비밀번호 찾기</button>
          <button @click="fnExit()" class="login-btn">로그인</button>
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
            console.log(self.phoneNumber);
            console.log(self.userName);
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
                console.log(data);
                if (data.count == 0) {
                  alert("정보에 일치하는 아이디가 없습니다.");


                } else {
                  self.list = data.user;
                  console.log(self.list);
                  self.authFlg = true;
                }
              }
            });
          },
          fnPasswordReset: function () {
            location.href = "/user/resetPwd.do";
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