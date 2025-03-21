<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
	<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	<title>search password page</title>
    <!-- 비밀번호를 찾을 아이디 입력 받기
 비밀번호 찾기 버튼 클릭 시 인증 페이지 호출
인증 성공 시 새로운 비밀번호 입력받아서 db에 저장
-> 비밀번호 확인까지
인증 실패 시 '인증실패 했습니다' -->
</head>
<style>
</style>
<body>
    <!-- 오류 '//' 해결필요 -->
	<div id="app"> 
        <div v-if="authFlg==false">
            <div> 
                아이디:<input v-model="userId">
                <button @click="fnAuth()">비밀번호 찾기</button>
            </div>
        </div>
        <div v-else>
            <div> 
                새로운 비밀번호:<input v-model="pwd">
            </div>
            <div> 
                새로운 비밀번호 확인:<input v-model="pwdCheck">
            </div>
            <div>
                <button @click="fnNewPwd()">수정 저장</button>
            </div>
        </div>


	</div>
</body>
</html>
<script>
    	const userCode = "imp05720184"; 
	// userCode = 나(사업자)를 인증할 수 있는 코드
	IMP.init(userCode);
    const app = Vue.createApp({
        data() {
            return {
                userId:"",
                authFlg : false,
                pwd:"",
                pwdCheck:""

            };
        },
        methods: {
            fnNewPwd(){
				var self = this;
                if(self.authFlg==false){
                    alert("인증하셈");
                    return;
                }
                if(self.pwd!=self.pwdCheck ||self.pwd==""){
                    alert("비밀번호 확인바람");
                    return;
                }
				var nparmap = {
                    userId : self.userId, //보낼떄 qqq로 보내면 sql-user.xml에서도 qqq로 받아야함
					pwd : self.pwd
                };
				$.ajax({
					url:"/user/searchPwd.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        alert("수정저장");
                        location.href="/user/login.do";
					}
				});
            },
            fnAuth : function(){
                var self = this;
				IMP.certification({
    				channelKey: "channel-key-0fe7e059-c386-47fa-bf62-63f6bf973879",
    				merchant_uid: "merchant" + new Date().getTime(),
  				},function(rsp){
					if(rsp.success){
						alert("인증성공");
						console.log(rsp);
                        console.log(self.authFlg);
                        self.authFlg = true;
					}else{
						alert(rsp.error_msg);
						console.log(rsp);

					}
					
				});
			}
        },
        mounted() {
            var self = this;
        }
    });
    app.mount('#app');
</script>