<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Naver Callback</title>
	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"></script>
</head>
<body>
	<script>
		var naverLogin = new naver.LoginWithNaverId({
			clientId: "KNO8vM1qKPQjBDVj1gTv",
			callbackUrl: "http://localhost:8081/naverCallback.do",
			isPopup: true
		});
		naverLogin.init();

		naverLogin.getLoginStatus(function (status) {
			if (status) {
				var user = naverLogin.user;

				// 부모 창으로 로그인 결과 전달
				window.opener.postMessage({
					type: "naverLogin",
					data: {
						id: user.id,
						email: user.email,
						name: user.name
					}
				}, "*");

				window.close(); // 팝업 창 닫기
			} else {
				alert("네이버 로그인 실패");
				window.close();
			}
		});
	</script>
</body>
</html>