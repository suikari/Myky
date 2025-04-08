<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_1@1.0/font.css">
    <title>회사 정보</title>
    <style>
.footer {
  background-color: #0b1551;
  color: rgb(255, 255, 255);
  font-family: 'NanumSquareRoundLight', sans-serif; /* 나눔고딕 적용 */

}

.footer-top {
    display: flex;
    justify-content: center; /* 중앙 정렬 */
    width: 100%; /* 부모의 크기를 100%로 설정 */
}

.footer-top-inner {
	margin-top: 45px;
    max-width: 1200px; /* 최대 너비를 1200px로 설정 */
    width: 100%; /* 100% 너비로 설정해 부모의 너비에 맞추기 */
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 40px;
}


.footer-con {
    display: flex;
    justify-content: space-between;
    align-items: flex-end; /* 아래로 정렬 */
    gap: 20px;
}


.footer-logo {
  height: 40px;
}

.footer-nav {
  display: flex;
  gap: 30px;
}

.footer-nav a {
  margin-right: 50px;	
  color: #FFC107;;
  text-decoration: none;
  font-weight: 500;
}

.footer-divider {
  border: none;
  border-top: 2px solid #FFC107;
  margin: 10px auto;
  width: 90%;
}

.footer-bottom {
	text-align: left;
  max-width: 1200px;
  margin: 30px auto;
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 20px;
  color: #fff;
  font-size: 14px;
}

.footer-section h4 {
  text-align: left;
  margin-bottom: 10px;
  color: #fff;
}

.footer-section p {
  margin: 4px 0;
}

.sns-icons {
  display: flex;
  gap: 10px;
}

.circle {
  width: 15px;
  height: 15px;
  background-color: #faffa4;
  border-radius: 50%;
}
.footer-logo {
    height: 75px;
    margin-left: -200px; /* 로고를 왼쪽으로 20px 이동 */
}
.sns-links img{
	height: 40px; /* 로고의 높이를 조정 */
    width: auto; /* 비율을 유지하며 너비는 자동으로 조정 */
}

.footer-logo img {
    height: 75px; /* 로고의 높이를 조정 */
    width: auto; /* 비율을 유지하며 너비는 자동으로 조정 */
}

.footer-left {
    text-align: left;
    position: relative;
    left: -270px; /* 원하는 만큼 왼쪽으로 이동 */
}
.footer-main {
	margin-bottom: 50px;
    text-align: left;
    flex-grow: 1; /* 남은 공간을 모두 차지하게 해서 가운데 배치 */
    margin-left: 40px; /* 왼쪽 여백을 추가하여 오른쪽으로 이동 */
}
.footer-right {
    text-align: right;
    position: relative;
    flex-shrink: 0; /* 오른쪽 정렬되도록 고정 */
    right: -210px;
	margin-bottom: 120px;
}


.Support-title{
	text-align: left;
}
    </style>
</head>
<body>
    <div id="footer" class="footer">
		<div class="footer-top">
			<div class="footer-top-inner">
				<nav class="footer-nav">
				  <a href="#">회사 소개</a>
				  <a href="#">이용약관</a>
				  <a href="#"><strong>개인정보처리방침</strong></a>
				  <a href="#">이용안내</a>
				</nav>
			  </div>
			  
		  </div>
		<button class="scroll-top-btn" @click="scrollToTop">▲</button>

		
    	<div class="footer-con" >
	        <div class="footer-left">
	            <h2 class="footer-title">{{ company.name }}</h2>
	            <div class="footer-company-info">
	                <p class="company-detail"><strong>대표:</strong> {{ company.ceo }}</p>
	                <p class="company-detail"><strong>대표전화:</strong> {{ company.phone }}</p>
	                <p class="company-detail"><strong>주소:</strong> {{ company.address }}</p>
	                <p class="company-detail"><strong>사업자 등록번호:</strong> {{ company.registrationNumber }}</p>
	                <p class="company-detail"><strong>이메일:</strong> {{ company.email }}</p>
	            </div>
	        </div>
	        <div class="footer-main">
	            <h3 class="Support-title" style="color:#FFC107 ;">C/S CENTER</h3>
	            <p>MON-FRI 10:00 - 17:00</p>
	            <p>LUNCH 12:00 - 13:30</p>
	            <p>SAT, SUN, HOLIDAY OFF</p>
	        </div>
			<div class="footer-right">
				<h3 class="section-title" style="margin-left: 140px;">SNS SERVICE</h3>
	            <div class="sns-links">
	                <img src="/img/facebook.png" alt="Facebook" width="75">
	                <img src="/img/instagram.png" alt="Instagram" width="80">
	                <img src="/img/youtube.png" alt="YouTube" width="70">
	            </div>
			</div>
	    </div>
	     
		
    </div>
    
    <script>
        const footer = Vue.createApp({
            data() {
                return {
                    company: {
                        name: '주식회사 멍냥꽁냥',
                        ceo: '이 율',
                        phone: '070-1234-5678',
                        address: '인천광역시 부평구 부평동 534-48 상록스테이션타워 7층',
                        registrationNumber: '101-20-012345',
                        email: 'tester@naver.com'
                    }
                };
            },
			methods: {
				scrollToTop() {
				    window.scrollTo({ top: 0, behavior: 'smooth' });
				},
			},
			mounted() {
				let self = this;
				const scrollBtn = document.querySelector('.scroll-top-btn');

				window.addEventListener('scroll', () => {
				    if (window.scrollY > 200) {
				        scrollBtn.classList.add('show');
				    } else {
				        scrollBtn.classList.remove('show');
				    }
				});

			}
			
        });
        
        footer.mount('#footer');
		



		
    </script>
</body>
</html>

