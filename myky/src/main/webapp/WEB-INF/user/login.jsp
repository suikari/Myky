<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html>

	<head>
		<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery-3.7.1.js"
			integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
		<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
		<title>첫번째 페이지</title>
	</head>
	<style>
	</style>

	<body>

		<jsp:include page="../common/header.jsp" />

		<div id="app">
			<div>
				아이디 : <input v-model="userId">
			</div>
			<div>
				비밀번호 : <input v-model="pwd" type="password">
			</div>
			<button @click="fnLogin">로그인</button>
			<button @click="fnPasswordReset">비밀번호 찾기</button>
			<div>
				<button>
					<a :href="location">
						<img src="../img/login/kakao_login_medium_narrow.png" alt="">
					</a>
				</button>
			</div>

			<div>
				<button>
					<a href="#">
						<img src="../img/login/naver_login.png" alt="" width=183px height="45px">
					</a>
				</button>
			</div>

			<div>
				<button>
					<a href="#">
						<img src="../img/login/google_login.png" alt="" width=183px height="45px">
					</a>
				</button>
			</div>

		</div>
	</body>

	</html>
	<script>
		const app = Vue.createApp({
			data() {
				return {
					userId: "",
					pwd: "",
					location: "${location}"

				};
			},
			methods: {
				fnLogin() {
					var self = this;
					var nparmap = {

					};

				},
				fnPasswordReset() {

				}

			},
			mounted() {
				var self = this;
			}
		});
		app.mount('#app');
	</script>