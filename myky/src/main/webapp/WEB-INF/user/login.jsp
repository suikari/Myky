<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
			
			
		<title>Login Page</title>
		<link rel="stylesheet" href="/css/user/user.css" />
	</head>
	<style>

	</style>

	<body>

		<jsp:include page="../common/header.jsp" />

		<div id="app" class="container">

			<div class="login-container">
				<!-- 입력 영역 -->
				<div class="login-form-group">
					<input id="userId" v-model="userId" class="login-input" type="text" placeholder="아이디"
						@keyup.enter="fnLogin()" />
				</div>
				<div class="login-form-group">
					<input id="pwd" v-model="pwd" class="login-input" type="password" placeholder="비밀번호"
						@keyup.enter="fnLogin()" />
				</div>

				<!-- 기본 로그인 -->
				<button @click="fnLogin()" class="login-btn">로그인</button>

				<!-- 부가 기능 버튼 -->
				<div class="sub-links">
					<a href="javascript:;" @click="fnIdFind()">아이디 찾기</a> |
					<a href="javascript:;" @click="fnPasswordReset()">비밀번호 찾기</a> |
					<a href="javascript:;" @click="fnJoin()">회원가입</a>
				</div>
				<br>
				<br>
				<!-- 소셜 로그인 버튼들 -->

				<div class="social-login">
					<a :href="location" class="social-btn">
						<img src="../img/login/kakao_login_large_wide.png" alt="카카오 로그인" />
					</a>
				</div>
				<br>
				<div class="social-login">
					<a href="javascript:;" class="social-btn" @click="fnNaverLogin">
						<img src="../img/login/naver_login_m.png" alt="네이버 로그인" />
					</a>
					<div id="naverIdLogin" style="display: none;"></div>
	
				</div>
				<br>
				<div class="social-login">
					<a href="javascript:;" @click="fnGoogleLogin" class="social-btn">
						<img src="../img/login/google_login_m.png" alt="구글 로그인" />
					</a>
				</div>
			</div>
		</div>

		<jsp:include page="/WEB-INF/common/footer.jsp" />
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					userId: "",
					pwd: "",
					location: "${location}",
					reUrl: "",
					naverLogin : null,
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
							if (data.result == "success") {
								alert(data.user.userName + "님 환영해여!") //service에서 user로 정의 했으니 멤버로..
								location.href = self.reUrl;
							} else if (data.result == "suspended") {
								alert("정지 혹은 탈퇴한 회원입니다.")
							} else {
								alert("아이디/패스워드 확인하세요.")
							}
						}
					});
				},
				fnPasswordReset() {
					location.href = "/user/resetpwd.do";
				},

				fnIdFind() {
					location.href = "/user/findid.do";
				},

				fnJoin() {
					location.href = "/user/consent.do";
				},

				fnAdd() {
					var self = this;
					var nparmap = {

					};

				},
				fnGoogleLogin() {
					sessionStorage.removeItem("socialLoginConfirmed");
					location.href = "/googleLogin";
				},
				fnGoogleLogout() {
					// sessionStorage.removeItem("socialLoginConfirmed");
					window.location.href = "https://accounts.google.com/Logout?continue=https://appengine.google.com/_ah/logout?continue=http://localhost:80818081/main.do";
					// location.href = "/logout";
				},
				fnNaverLogin() {
					const loginAnchor = document.querySelector('#naverIdLogin a');
					if (loginAnchor) {
						loginAnchor.click(); // ✅ SDK가 만든 로그인 링크 클릭
					} else {
						alert("네이버 로그인 초기화에 실패했습니다.");
					}
				},
				onMessageFromNaver(event) {
					if (event.data?.type === "naverLogin") {
						const userInfo = event.data.data;

						var self = this;
						var nparmap = {
							email: userInfo.email
							
						};
						
						$.ajax({
							url: "/user/socialEmail.dox", // 얘한테 요청함 'controller'에게 요청
							dataType: "json",
							type: "POST",
							data: nparmap,
							success: function (data) {

								if((data.result == "fail1")){
									return;
								} else {
									if (data.count > 0) {
										alert(data.user.userName + "님 환영해요!");
										location.href = "/main.do";
									} else {
										if (confirm("이 사이트를 이용하시려면 회원가입이 필요합니다. 회원가입하시겠습니까?")) {
											//sessionStorage.setItem("socialLoginConfirmed", "true"); 
											//location.href = "/user/consent.do";

											pageChange("/user/consent.do", {email : userInfo.email, name : userInfo.name});
											
										}
									}
								}

							}
						});
						
						// 서버로 전달하여 로그인 처리
						/* $.ajax({
							url: "/user/naverLogin.dox", // 백엔드 주소
							type: "POST",
							dataType: "json",
							data: {
								email: userInfo.email,
								name: userInfo.name,
								naverId: userInfo.id
							},
							success: (res) => {
								if (res.result === "success") {
									alert(res.user.userName + "님, 환영합니다!");
									location.href = "/main.do";
								} else {
									alert("로그인 처리 실패: " + res.message);
								}
							},
							error: () => {
								alert("서버 통신 오류");
							}
						}); */
					}
				},


			},
			mounted() {
				var self = this;
				const params = new URLSearchParams(window.location.search); // 보드에서 로그인시 보드로
				self.reUrl = params.get("redirect") || "/main.do";
				
				this.naverLogin = new naver.LoginWithNaverId({
					clientId: "KNO8vM1qKPQjBDVj1gTv",
					callbackUrl: "http://localhost:8081/naverCallback.do",
					isPopup: true,
					loginButton: { color: "green", type: 3, height: 60 }
				});
				this.naverLogin.init();
				window.addEventListener("message", this.onMessageFromNaver);
			}
		});
		app.mount('#app');
	</script>