<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회사 정보</title>
    <style>
.footer {
  background-color: #0b1551;
  color: white;
  font-family: 'Pretendard', sans-serif;
}

.footer-top {
    display: flex;
    justify-content: center; /* 중앙 정렬 */
    width: 100%; /* 부모의 크기를 100%로 설정 */
}

.footer-top-inner {
    max-width: 1200px; /* 최대 너비를 1200px로 설정 */
    width: 100%; /* 100% 너비로 설정해 부모의 너비에 맞추기 */
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 40px;
}





.footer-logo {
  height: 40px;
}

.footer-nav {
  display: flex;
  gap: 30px;
}

.footer-nav a {
  color: #ff6600;
  text-decoration: none;
  font-weight: 500;
}

.footer-divider {
  border: none;
  border-top: 2px solid #ff924d;
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
  background-color: #ffcba4;
  border-radius: 50%;
}




    </style>
</head>
<body>
    <div id="footer" class="footer">

		<div class="footer-top">
			<div class="footer-top-inner">
				<!-- <div class="footer-logo">
				  <img src="logo.png" />
				</div> -->
				<nav class="footer-nav">
				  <a href="#">회사 소개</a>
				  <a href="#">이용약관</a>
				  <a href="#"><strong>개인정보처리방침</strong></a>
				  <a href="#">이용안내</a>
				</nav>
			  </div>
			  
		  </div>
		  
		  <hr class="footer-divider" />
		
		  <div class="footer-bottom">
			<div class="footer-section">
			  <h4>쇼핑몰 기본정보</h4>
			  <p>상호명 :: 주식회사 맹냥콩냥 대표자명 :: 김맹냥</p>
			  <p>사업장 주소 :: 21404 인천광역시 부평구 경원대로 1366 스테이션 타워 7층</p>
			  <p>사업자 등록번호 :: 999-88-77777 개인정보보호책임자 :: 김맹냥</p>
			  <p>통신판매업 신고번호 :: 2025인천부평동1234 [사업자정보확인]</p>
			</div>
			<div class="footer-section">
			  <h4>결제정보</h4>
			  <p>무통장 계좌정보 :: 신한은행 123-456-789000</p>
			  <p>주식회사 맹냥콩냥 김맹냥</p>
			</div>
			<div class="footer-section">
			  <h4>고객센터 정보</h4>
			  <p>상담/주문 전화 :: 070-7777-9999</p>
			  <p>상담/주문 이메일 :: mnkn@naver.com</p>
			  <p>CS운영시간 :: 09:30 ~ 17:00</p>
			</div>
			<div class="footer-section">
			  <h4>SNS</h4>
			  <div class="sns-icons">
				<span class="circle"></span>
				<span class="circle"></span>
				<span class="circle"></span>
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

