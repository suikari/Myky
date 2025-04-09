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
  justify-content: space-between; /* 좌우로 최대로 벌어짐 */
  align-items: flex-start;
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 20px;
  gap: 0; /* 필요하다면 줄이기 */
}



.footer-logo {
  height: 40px;
}

.footer-nav {
  font-family: 'NanumSquareRoundLight', sans-serif;
  display: flex;
  gap: 30px;
}

.footer-nav a {
  margin-right: 50px;	
  color: #e8bb33;;
  text-decoration: none;
  font-weight: 500;
}

.footer-divider {
  border: none;
  border-top: 2px solid #e8bb33;
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

.footer-section{
  text-align: left;
  margin-bottom: 10px;
  color: #a80b0b;
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
	height: 37px; /* 로고의 높이를 조정 */
    width: auto; /* 비율을 유지하며 너비는 자동으로 조정 */
}

.footer-logo img {
    height: 75px; /* 로고의 높이를 조정 */
    width: auto; /* 비율을 유지하며 너비는 자동으로 조정 */
}

.footer-left,
.footer-main,
.footer-right {
  flex: 1; /* 각 영역이 같은 비율로 배치됨 */
  min-width: 250px;
}

.footer-left {
  flex: 1;
  transform: translateX(-150px); /* 이전보다 더 왼쪽으로 이동 */
  text-align: left;
}

.footer-main {
  transform: translate(150px,45px);
  text-align: left;       /* 내부 텍스트는 왼쪽 정렬 유지 */
  flex-grow: 1;           /* 가운데 영역 채우기 */
}

.footer-right {
  flex: 1;
  text-align: right;
  transform: translate(100px,25px);
}


.Support-title {
    font-size: 24px;
    font-weight: bold;
    color: #e8bb33;
    padding: 0;

    text-align: left;
}
.Support-detail {
    color: #dfe0e4;
    font-size: 14px;
    font-family: 'NanumSquareRoundLight', sans-serif;
    padding: 0;
    margin: 0;
    text-align: left;
}
.company-detail strong {
    font-size: 14px;
    color: #e8bb33;
}
.company-detail {
    line-height: 1.6;  /* 기본은 1.4~1.6 추천 */
    white-space: nowrap; 
    color: #dfe0e4;
    font-size: 14px;
    font-family: 'NanumSquareRoundLight', sans-serif;
}
.section-title {
    font-size: 24px;
    transform: translateX(-0px);
    color: #e8bb33;
    font-family: 'NanumSquareRoundLight', sans-serif;

}
.footer-company-title{
    font-size: 24px;
    font-weight: bold;
    color: #e8bb33;
}
.scroll-top-btn{
    background-color: #f1c338;
}
    </style>
</head>
<body>
    <div id="footer" class="footer">
		<div class="footer-top">
			<div class="footer-top-inner">
				<nav class="footer-nav">
				  <a href="#">회사 소개</a>
				  <a href="">이용약관</a>
				  <a href="#"><strong>개인정보처리방침</strong></a>
				  <a href="#">이용안내</a>
				</nav>
			  </div>
			  
		  </div>
		<button class="scroll-top-btn" @click="scrollToTop">▲</button>

		
    	<div class="footer-con" >
	        <div class="footer-left">
	            <div class="footer-company-title">{{ company.name }}</div>
	            <div class="footer-company-info">
	                <div class="company-detail"><strong>대표:</strong> {{ company.ceo }}</div>
	                <div class="company-detail"><strong>대표전화:</strong> {{ company.phone }}</div>
	                <div class="company-detail"><strong>주소:</strong> {{ company.address }}</div>
	                <div class="company-detail"><strong>사업자 등록번호:</strong> {{ company.registrationNumber }}</div>
	                <div class="company-detail"><strong>이메일:</strong> {{ company.email }}</div>
	            </div>
	        </div>
	        <div class="footer-main">
	            <div class="Support-title" >C/S CENTER</div>
	            <div class="Support-detail">MON-FRI 10:00 - 17:00</div>
	            <div class="Support-detail">LUNCH 12:00 - 13:30</div>
	            <div class="Support-detail">SAT, SUN, HOLIDAY OFF</div>
	        </div>
			<div class="footer-right">
				<div class="section-title" style="margin-left: 140px;">SNS SERVICE</div>
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

