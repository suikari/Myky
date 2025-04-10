<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_1@1.0/font.css">
    <title>회사 정보</title>
    <style>
    .footer-top-inner {
        width: 100%; /* 전체 너비 사용 */
        margin-top: 5px; /* 아래쪽 여백 추가 */
    }

    .footer-con {
        max-width: 1280px; /* 최대 너비를 1280px로 설정 */
        margin: 0 auto; /* 가운데 정렬 */
        display: flex; /* 플렉스 박스로 설정하여 가로로 배치 */
        justify-content: space-between; /* 좌우로 최대로 벌어짐 */
        align-items: flex-start;
        padding: 20px 20px;
    }

    .footer-left,
    .footer-main,
    .footer-right {
        flex: 1; /* 각 영역이 같은 비율로 배치됨 */
        min-width: 300px; /* 최소 너비 설정 */
    }

    .footer-top-inner {
      max-width: 1280px;
      margin: 0px auto;
      display: flex;
      font-size: 14px;
    }

    .footer-nav a {
        margin: 0 15px; /* 좌우 여백 추가 */
        color: #555; /* 텍스트 색상 */
        text-decoration: none; /* 밑줄 제거 */
        font-weight: bold; /* 글자 두께 */
        transition: color 0.3s; /* 색상 전환 효과 */
    }

    .footer-nav a:hover {
        color: #007bff; /* 호버 시 색상 변경 */
    }

    .footer-bottom {
      background-color: rgb(176, 225, 255);
      width : 100%;
      color : #272727 !important;
    }

    .footer-main,
    .footer-right {
        display: flex; /* 플렉스 박스로 설정 */
        flex-direction: column; /* 세로 방향으로 정렬 */
        justify-content: center; /* 수직 중앙 정렬 */
        align-items: center; /* 가로 중앙 정렬 */
        text-align: center; /* 텍스트 중앙 정렬 */
        height: 100%; /* 부모 요소의 전체 높이 사용 */
    }

    .footer-content-title {
      margin-bottom: 10px;
      color : rgb(0,80,255) !important;
      font-size : 22px;
      font-weight: bold;
    }

    .sns-links {
        display: flex; /* 플렉스 박스로 설정 */
        gap: 20px; /* 요소 간의 간격 설정 */
        justify-content: center; /* 가로 중앙 정렬 */
        align-items: center; /* 수직 중앙 정렬 */
    }

    .footer-top {
        box-shadow: 0 -4px 8px rgba(0, 0, 0, 0.1); /* 위쪽에 그림자 추가 */
        padding: 10px 0; /* 패딩 추가 */
    }

    .footer-main-top{
      background-color: rgb(176, 225, 255);
    }

    </style>
</head>
<body>
    <div id="footer" class="footer">
		<div class="footer-main-top">

		<button class="scroll-top-btn" @click="scrollToTop">▲</button>
      
      <div class="footer-top">
        <div class="footer-top-inner">
          <div id="footer-nav" class="footer-nav">
                      <a href="#" @click.prevent="goToIntro()">회사 소개</a>
                      <a href="#" @click.prevent="goToTermsPage('service')">이용약관</a>
                      <a href="#" @click.prevent="goToTermsPage('privacy')">개인정보처리방침</a>
                      <a href="#" @click.prevent="goToTermsPage('guide')">이용안내</a>                                
          </div>
        </div>
      </div>

      <div class="footer-bottom">
        <div class="footer-con" >
            <div class="footer-left">
                <div class="footer-company-title footer-content-title">{{ company.name }}</div>
                <div class="footer-company-info">
                    <div class="company-detail"><strong>대표:</strong> {{ company.ceo }}</div>
                    <div class="company-detail"><strong>주소:</strong> {{ company.address }} </div>
                    <div class="company-detail"><strong>대표전화:</strong> {{ company.phone }} </div>
                    <div class="company-detail"><strong>사업자 등록번호:</strong> {{ company.registrationNumber }} <strong>이메일:</strong> {{ company.email }}</div>
                </div>
            </div>
            <div class="footer-main">
                <div class="Support-title footer-content-title" >C/S CENTER</div>
                <div class="Support-detail">MON-FRI 10:00 - 17:00</div>
                <div class="Support-detail">LUNCH 12:00 - 13:30</div>
                <div class="Support-detail">SAT, SUN, HOLIDAY OFF</div>
            </div>
        <div class="footer-right">
          <div class="section-title footer-content-title">SNS SERVICE</div>
                <div class="sns-links">
                  <i class="bi bi-facebook" style="font-size: 2rem; color: #3b5998;"></i>
                  <i class="bi bi-instagram" style="font-size: 2rem; color: #E4405F;"></i>
                  <i class="bi bi-youtube" style="font-size: 2rem; color: #FF0000;"></i>
                </div>
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
              },
              termsList: [
                { type: 'terms', label: '이용약관' },
                { type: 'privacy', label: '개인정보처리방침' },
                { type: 'guide', label: '이용안내' }
              ]
            };
          },
          methods: {
            goToIntro() {
              window.location.href = "/common/companyIntro.do";
            },
            goToTermsPage(type) {
              //if (type === 'intro') return; // 회사소개는 클릭만 되고 이동 X
              window.location.href = "/common/termsList.do?type=" + type;
            },
            scrollToTop() {
              window.scrollTo({ top: 0, behavior: 'smooth' });
            },
            
          },
          mounted() {
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