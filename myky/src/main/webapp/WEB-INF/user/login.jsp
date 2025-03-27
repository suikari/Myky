<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<title>Login Page</title>
	</head>
	<style>
		/* 로그인 컨테이너 스타일 */
.login-container {
  max-width: 400px;
  margin: 50px auto;
  padding: 30px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.login-form-group {
  margin-bottom: 20px;
}

.login-label {
  display: block;
  font-size: 14px;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}

.login-input {
  width: 100%;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

.login-input:focus {
  border-color: #007BFF;
  outline: none;
}

/* 버튼 스타일 */
.login-btn, .reset-btn, .login-btn2, .reset-btn2 {
  width: 100%;
  padding: 12px;
  font-size: 16px;
  color: #fff;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.login-btn {
  background-color: #007BFF;
}

.login-btn:hover {
  background-color: #0056b3;
}

.reset-btn {
  background-color: #f0ad4e;
  margin-top: 10px;
}

.reset-btn:hover {
  background-color: #ec971f;
}

.reset-btn2 {
  background-color: pink;
  margin-top: 10px;
}

.reset-btn2:hover {
  background-color: rgb(207, 117, 130);
}

/* 소셜 로그인 버튼 스타일 */
.social-login {
  margin-top: 20px;
  text-align: center;
}

.social-btn img {
  width: 100%;
  max-width: 200px;
  height: auto;
  border-radius: 4px;
}

.social-btn {
  display: inline-block;
}

/* 작은 화면에서 더 나은 가독성을 위해 글자 크기 조정 */
@media (max-width: 500px) {
  .login-container {
    padding: 20px;
  }

  .login-label {
    font-size: 12px;
  }

  .login-input {
    font-size: 14px;
  }

  .login-btn, .reset-btn {
    font-size: 14px;
  }
}
	</style>

<body>

	<jsp:include page="../common/header.jsp" />

	<div id="app" class="container login-container">
		<div class="login-form-group">
			<label for="userId" class="login-label">아이디 :</label>
			<input id="userId" v-model="userId" class="login-input" type="text" @keyup.enter="fnLogin()">
		</div>
		<div class="login-form-group">
			<label for="pwd" class="login-label">비밀번호 :</label>
			<input id="pwd" v-model="pwd" class="login-input" type="password" @keyup.enter="fnLogin()">
		</div>
		<button @click="fnLogin()" class="login-btn">로그인</button>
		<button @click="fnIdFind()" class="reset-btn">아이디 찾기</button>
		<button @click="fnPasswordReset()" class="reset-btn2">비밀번호 찾기</button>

		<div class="social-login">
			<a :href="location" class="social-btn">
				<img src="../img/login/kakao_login_medium_narrow.png" alt="">
			</a>
		</div>

		<div class="social-login">
			<a href="#" class="social-btn">
				<img src="../img/login/naver_login.png" alt="" width="183px" height="45px">
			</a>
		</div>

		<div class="social-login">
			<a href="#" class="social-btn">
				<img src="../img/login/google_login.png" alt="" width="183px" height="45px">
			</a>
		</div>

	</div>

	<jsp:include page="/WEB-INF/common/footer.jsp"/>
</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					userId: "",
					pwd: "",
					location: "${location}",
					reUrl : "",
				};
			},
			methods: {
				fnLogin() {
					var self = this;
					var nparmap = {
						userId: self.userId,
						pwd: self.pwd,
					};
					$.ajax({
						url: "/user/login.dox", // 얘한테 요청함 'controller'에게 요청
						dataType: "json",
						type: "POST",
						data: nparmap,
						success: function (data) {
							console.log(self);
							if (data.result == "success") {
								alert(data.user.userName + "님 환영해여!") //service에서 user로 정의 했으니 멤버로..
								location.href = self.reUrl;
							} else {
								alert("아이디/패스워드 확인하세요.")
							}
						}
					});
				},
				fnPasswordReset() {
					location.href="/user/resetPwd.do";
				},

				fnIdFind() {
					location.href="/user/findId.do";
				},

				fnAdd() {
					var self = this;
					var nparmap = {

					};

				}

			},
			mounted() {
				var self = this;
				const params = new URLSearchParams(window.location.search);
				self.reUrl = params.get("redirect") || "/main.do";
			}
		});
		app.mount('#app');
	</script>