<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회사 정보</title>
    <style>

    </style>
</head>
<body>
    <div id="footer" class="footer">
		<button class="scroll-top-btn" @click="scrollToTop">▲</button>

		
    	<div class="footer-con" >
	        <div class="footer-left">
	            <h2 class="footer-title">회사 정보</h2>
	            <div class="company-info">
	                <p class="company-detail"><strong>회사명:</strong> {{ company.name }}</p>
	                <p class="company-detail"><strong>대표:</strong> {{ company.ceo }}</p>
	                <p class="company-detail"><strong>대표전화:</strong> {{ company.phone }}</p>
	                <p class="company-detail"><strong>주소:</strong> {{ company.address }}</p>
	                <p class="company-detail"><strong>사업자 등록번호:</strong> {{ company.registrationNumber }}</p>
	                <p class="company-detail"><strong>이메일:</strong> {{ company.email }}</p>
	            </div>
	        </div>
	        <div class="footer-right">
	            <h3 class="section-title">고객센터</h3>
	            <p>MON-FRI 10:00 - 17:00</p>
	            <p>LUNCH 12:00 - 13:30</p>
	            <p>SAT, SUN, HOLIDAY OFF</p>
	            <h3 class="section-title">SNS SERVICE</h3>
	            <div class="sns-links">
	                <img src="" alt="Facebook" width="20">
	                <img src="" alt="Instagram" width="20">
	                <img src="" alt="YouTube" width="20">
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

