<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> --> 
    <script src="/js/page-change.js"></script>    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
    <style>
    


    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="container">
        <div>
			아이디 : <input v-model="user.userId"> 
            <button @click="fnView(user.userId)">상세정보가기(임시)</button> 
            <button @click="fnIdChecked()">중복체크</button> 
		</div>
		<div>
			비밀번호 : <input type="password" v-model="user.pwd">  
		</div>
        <div>
			비밀번호 확인 : <input type="password" v-model="user.pwdCheck">  
		</div>
		<div>
			이름 : <input v-model="user.userName">  
		</div>

        <div>
			닉네임 : <input v-model="user.nickName"> 
            <button @click="fnNickChecked()">중복체크</button> 
		</div>
		<div>
			주소 : <input v-model="user.address">
            <button @click ="fnSearchAddr()">주소검색</button>  
		</div>

        <div v-if="authFlg">
            <div v-if="joinFlg" style="color: red;">
                문자 인증 완료!
            </div>
            <div v-else>
                <input v-model="authInputNum" :placeholder="timer">
                <button @click="fnNumAuth()">인증</button>
                <!-- :를 붙이면 문자열이 아닌 변수로 취급한다 -->
            </div>
        </div>

        <div>
            성별:
            <input type="radio" name="gender" value="M" v-model="user.gender">남성
            <input type="radio" name="gender" value="F" v-model="user.gender">여성
            <input type="radio" name="gender" value="N" v-model="user.gender">비공개
        </div>

        <button @click="fnJoin1()">정보 저장</button>
    </div>


	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        user : { // 이렇게 맵으로 선언해서 한꺼번에 갖고 가기 쉽다
                                userId : "",
                                userName : "",
				                pwd : "",
				                address : "",
                                nickName : "",
                                phoneNumber : "",
                                birthDate : "",
                                gender : "M"
                },
                                idFlg : false,
                                pwdCheck : ""
                    
                    };
                },
                computed: {

                },
                methods: {
                    fnJoin1(){
				var self = this;
                if(self.idFlg == false){
                    alert("아이디 중복체크 해주십시오");
                    return;
                } 

                if(self.user.pwd.length < 8 || self.user.pwd.length > 20){
                    alert("비밀번호는 최소 8~20글짜로 입력바랍니다(특수문자,영문,숫자 포함)");
                    return;
                }
                if(self.user.pwd!=self.user.pwdCheck || self.user.pwd==""){
                    alert("비밀번호가 일치하지 않습니다.");
                    return;
                }
                alert("임시 완료(저장x)");
				var nparmap = self.user; // 파라미터에 해쉬맵(user)로 묶어서 보내는 방법도 있다
				// $.ajax({
				// 	url:"/user/join.dox",
				// 	dataType:"json",	
				// 	type : "POST", 
				// 	data : nparmap,
				// 	success : function(data) { 
				// 		console.log(data);
                //         alert("가입을 축하드립니다");
                //         // location.href="/main.do";
				// 	}
				// });
            },
            fnIdChecked : function(){
                var self = this;
                if(self.user.userId.length < 4 || self.user.userId.length > 16){
                    alert("아이디는 최소 4~16글짜로 입력바랍니다.");
                    return;
                }
				var nparmap = 
                {
                    userId : self.user.userId
                    }; // 유저아이디 하나만 보내기
                $.ajax({
					url:"/user/check.dox",
					dataType:"json",	
					type : "POST", 
					data : nparmap,
					success : function(data) { 
						console.log(data);
                        if(data.count == 0){ //문제 확인 필요
                            alert("사용 가능한 아이디입니다");
                            self.idFlg = true;
                        }else{
                            alert("중복된 아이디입니다");
                        }
					}
				});
            },
            fnView : function(userId){
                console.log(userId);
                pageChange("/user/info.do",{userId : userId});

            }
                },
                mounted() {
                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
