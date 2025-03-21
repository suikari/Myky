<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후원 페이지</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<script src="js/swiper8.js"></script>
	
    <link rel="stylesheet" href="css/main.css">
    <style>
    
.body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    text-align: center;
    background-color: #fff;
}

.donationContainer {
    max-width: 1280px;
    margin: 30px auto;
    padding: 20px;
}

.boardTitle {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    margin-bottom: 10px;
}

.boardContents {
    font-size: 16px;
    color: #555;
}

#sections section {
    text-align: left;
    padding: 20px;
    border-bottom: 1px dotted #FFA145;
}

.sectionTitle {
    font-size: 20px;
    font-weight: bold;
    color: #444;
    margin-bottom: 20px;
    margin-left: 30px;

}
.sectionContents{
    color: #555;
    margin-bottom: 20px;
    margin-left: 30px;
}

.donationTable {
    width: 60%;
    margin-top: 10px;
    border-collapse: collapse;
    margin-left: 30px;

}

.donationTable table {
    width: 100%;
    border: 1px solid #ddd;
    background: #fff;
    border-radius: 5px;
    margin-left: 30px;

}

.donationTable th, .donationTable td {
    padding: 10px;
    border-bottom: 1px solid #ddd;
    text-align: left;
    
}

.donationTable th {
    background: #FFBC7B;
    font-weight: bold;
}

.donationInput {
    margin-right: 10px;
}

.donationInput input[type="number"] {
    width: 100px;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.donationCheckbox {
    margin-right: 5px;
    margin-left: 30px;

}

.donationButton {
    width: 30%;
    padding: 10px;
    background: #FFBC7B;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin: 30px auto;
}

.donationButton:hover {
    background: #FFA145;
}

.donationMessage {
    width: 90%;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
    margin-top: 5px;
}


    </style>
</head>
<body>
     <jsp:include page="../common/header.jsp"/>
 


    <div id="app" class="body">
        <div class="donationContainer">
            <div class="boardTitle"><h2>후원하기</h2></div>
            <div class="boardContents"><p>당신의 따뜻한 후원,</p><p>고통받는 동물을 구해내는 힘이 됩니다.</p></div>
    
            <div id="sections">
                <section>
                    <div class="sectionTitle">후원정보</div>
                    <div class="donationTable">
                        <table>
                            <tr>
                                <th>후원항목</th>
                                <td>일시후원</td>
                            </tr>
                            <tr>
                                <th>후원주기</th>
                                <td>일시</td>
                            </tr>
                            <tr>
                                <th>후원금액</th>
                                <td>
                                    <label class="donationInput"><input name="donateAmount" type="radio" v-model="donateAmount" value="10000">10,000원</label>
                                    <label class="donationInput"><input name="donateAmount" type="radio" v-model="donateAmount" value="30000">30,000원</label>
                                    <label class="donationInput"><input name="donateAmount" type="radio" v-model="donateAmount" value="50000">50,000원</label>
                                    <label class="donationInput"><input name="donateAmount" type="number" v-model="customAmount" placeholder="직접입력">원</label>
                                    <!-- 직접 입력 시 천단위마다 ',' 찍어 출력하는 기능 -->
                                </td>
                            </tr>
                            <tr>
                                <th>후원 메세지</th>
                                <td><input class="donationMessage" name="donateMessage" v-model="donateMessage" placeholder="따듯한 마음을 전하세요"></td>
                            </tr>
                        </table>
                    </div>
                </section>
                <section>
                    <div class="sectionTitle">출금 정책</div>
                    <p class="sectionContents"><strong>[출금 정책 안내]</strong></p>
                    <p class="sectionContents">※ 일시 납입은 신청 즉시 결제가 이루어집니다.</p>
                    <label class="sectionContents">
                        <input class="donationCheckbox" name="agree" type="checkbox"> 상기 출금 정책을 모두 이해함
                    </label>
                </section>
                <section>
                    <div class="sectionTitle">
                        <label><input type="checkbox" name="agree"> 전체 동의하기</label>
                    </div>
                    <div class="sectionContents">
                        <label><input class="donationCheckbox" name="agree" type="checkbox">[필수] 가입약관 동의 <a>[보기]</a></label>
                    </div>
                    <div class="sectionContents">
                        <label><input class="donationCheckbox" name="agree" type="checkbox">[필수] 개인정보처리방침 동의 <a>[보기]</a></label>
                    </div>
                </section>
                <button class="donationButton" @click="">다음</button>
                <!-- 결제로 이동 -->
            </div>
        </div>
    </div>


     <jsp:include page="../common/footer.jsp"/>

    
</body>
</html>
<script>
    
    
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        donateAmount:"",
                        donateMessage:"",
                        customAmount:""
                    };
                },
                computed: {

                },
                methods: {

                },
                mounted() {
                	
                	
                }
            });

            app.mount("#app");
        });
    </script>
