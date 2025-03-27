<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회사 정보</title>
    <style>
        #footer {
            background-color: #0D1A56;
            color: white;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 5px;
        }
        .footer {
            padding: 40px;
            background-color: #0D1A56;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
        }
        .footer-con {
	         max-width:1024px;
	         margin: auto;
	         width:100%;
        }
        
        .footer-left {
            flex: 1;
            min-width: 300px;
            display : inline-block;    
            width:60%;
        }
        .footer-right {
            text-align: right;
            flex: 1;
            min-width: 300px;
            display : inline-block;
            width:40%;
        }
        .footer-nav {
            margin-bottom: 20px;
        }
        .footer-nav .nav-link {
            color: #FFC107;
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }
        .footer-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #FFC107;
        }
        .company-info {
            font-size: 14px;
        }
        .company-detail strong {
            color: #FFC107;
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            margin-top: 20px;
            color: #FFC107;
        }
        .image-container {
            margin-top: 15px;
        }
        .image-container img {
            max-width: 150px;
            display: block;
            margin: 10px auto;
        }
        .footer-right p {
            margin: 5px 0;
            font-size: 14px;
        }
        .footer-right .sns-links {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
        
        
        /**/

		.footer {
		    padding: 20px;
		    text-align: center;
		    background-color: #ffffff;
		    border-top: 2px solid #ddd;
		}
		
		.company-info { border: 1px solid #ddd; padding: 15px; border-radius: 5px; }
		
		.company-info p { margin: 5px 0; }
				
		.image-container img { max-width: 100%; height: auto; }
		
		.nav { margin-bottom: 20px; }
		
		.nav a { margin-right: 15px; text-decoration: none; color: #333; font-weight: bold; }
		
		/**/

		.scroll-top-btn {
		    position: fixed;
		    bottom: 20px;
		    right: 20px;
		    width: 50px;
		    height: 50px;
		    background-color: #e76f51;
		    color: white;
		    border: none;
		    border-radius: 50%;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    cursor: pointer;
		    display: none;
		    justify-content: center;
		    align-items: center;
		    font-size: 16px;
		    transition: opacity 0.3s ease, transform 0.3s ease;
		}

		.scroll-top-btn.show {
		    display: flex;
		    opacity: 1;
		    transform: translateY(0);
		}
		
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

