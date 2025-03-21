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
<body class="body">

    <div id="footer" class="footer">
        <div class="nav">
	        <a class="nav-link" href="#">회사소개</a>
	        <a class="nav-link" href="#">이용약관</a>
	        <a class="nav-link" href="#">쇼핑몰 이용안내</a>
	        <a class="nav-link" href="#">개인정보취급방침</a>
	        <a class="nav-link" href="#">고객센터</a>
	        <a class="nav-link" href="#">제휴/도매문의</a>
	        <a class="nav-link" href="#">채용정보</a>
   		</div>
   		
        <h2 class="title">회사 정보</h2>
        <div class="company-info">
            <p class="company-detail"><strong>회사명:</strong> {{ company.name }}</p>
            <p class="company-detail"><strong>대표:</strong> {{ company.ceo }}</p>
            <p class="company-detail"><strong>대표전화:</strong> {{ company.phone }}</p>
            <p class="company-detail"><strong>주소:</strong> {{ company.address }}</p>
            <p class="company-detail"><strong>사업자 등록번호:</strong> {{ company.registrationNumber }}</p>
            <p class="company-detail"><strong>이메일:</strong> {{ company.email }}</p>
        </div>
        <h3 class="section-title">결제 서비스</h3>
        <div class="image-container">
            <img src="image.png" alt="결제 서비스 이미지">
        </div>
    </div>

    <script>
        const footer = Vue.createApp({
            data() {
                return {
                    company: {
                        name: '주식회사 테디펫',
                        ceo: '박규태',
                        phone: '070-7537-0900',
                        address: '경기도 고양시 일산동구 강석길 89 (성석동) 가온데둥(대디펫)',
                        registrationNumber: '599-81-01930',
                        email: 'daddypetco@naver.com'
                    }
                };
            }
        });
        
        footer.mount('#footer');
    </script>
</body>
</html>
