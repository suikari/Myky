<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후원 페이지</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	
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

.donateAmountContainer {
    display: flex;
    gap: 10px;
    align-items: center;
}

.donateAmountBtn {
    background: #f5f5f5;
    border: 1px solid #ccc;
    padding: 10px 15px;
    border-radius: 5px;
    font-size: 16px;
    cursor: pointer;
    transition: 0.2s;
}

.donateAmountBtn.selected {
    background: #FFBC7B;
    color: white;
    font-weight: bold;
    border: 1px solid #FF8C42;
}

.customAmountInput {
    width: 120px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
    text-align: center;
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
                                <th rowspan="3">후원처 정보</th>
                                <td>{{info.centerName}}</td>
                            </tr>
                            <tr>
                                <td>{{info.address}}</td>
                            </tr>
                            <tr>
                                <td>{{info.tel}}</td>
                            </tr>
                            <tr>
                                <th>후원금액</th>
                                <td>
                                    <div class="donateAmountContainer">
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 10000}" @click="selectAmount(10000)">10,000원</button>
                            
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 30000}" @click="selectAmount(30000)">30,000원</button>
                            
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 50000}" @click="selectAmount(50000)">50,000원</button>
                            
                                        <input type="text" class="customAmountInput" v-model="customAmount" @input="formatCustomAmount" @focus="clearSelection" placeholder="직접입력">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>후원 메세지</th>
                                <td><input class="donationMessage" name="donateMessage" v-model="donateMessage" placeholder="따듯한 마음을 전하세요"></td>
                            </tr>
                            <!-- 250322 >> 다음에 익명후원 여부 선택 만들기 -->
                        </table>
                    </div>
                </section>
                <section>
                    <div class="sectionTitle">출금 정책</div>
                    <p class="sectionContents"><strong>[출금 정책 안내]</strong></p>
                    <p class="sectionContents">※ 일시 납입은 신청 즉시 결제가 이루어집니다.</p>
                    <label class="sectionContents">
                        <input class="donationCheckbox" name="policyCheck" type="checkbox"> 상기 출금 정책을 모두 이해함
                    </label>
                </section>
                <section>
                    <div class="sectionTitle">
                        <label><input type="checkbox" name="agreeAll" @change="fnToggleAllAgree"> 전체 동의하기</label>
                    </div>
                    <div class="sectionContents">
                        <label><input class="donationCheckbox" name="agree" type="checkbox">[필수] 가입약관 동의 <a>[보기]</a></label>
                    </div>
                    <div class="sectionContents">
                        <label><input class="donationCheckbox" name="agree" type="checkbox">[필수] 개인정보처리방침 동의 <a>[보기]</a></label>
                    </div>
                </section>
                <button class="donationButton" @click="fnPayment">다음</button>
                <!-- 250322 >> 결제 서비스 미완성 -->
            </div>
        </div>
    </div>


     <jsp:include page="../common/footer.jsp"/>

    
</body>
</html>
<script>
    const userCode = "imp40283074";
    
    document.addEventListener("DOMContentLoaded", function () {

        if (typeof IMP !== 'undefined') {
            IMP.init(userCode);  // 결제 시스템 초기화
        } else {
            console.error('IMP is not loaded properly');
        }

        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    info:{},
                    centerId:"${map.centerId}",
                    donateAmount:null,
                    donateMessage:"",
                    customAmount:null
                };
            },
            computed: {

            },
            methods: {
                fnCenterInfo(){
                    var self = this;
                    console.log(self.centerId);
                    var nparmap = {
                        centerId : self.centerId
                    };
                    $.ajax({
                        url:"/center/info.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) { 
                            console.log(data);
                            self.info = data.info;
                            
                        }
                    });
                },
                selectAmount(amount) {
                    this.donateAmount = amount;
                    this.customAmount = "";
                },

                clearSelection() {
                    this.donateAmount = null;
                },

                formatCustomAmount() {
                    let rawValue = this.customAmount.replace(/[^0-9]/g, "");

                    if (rawValue) {
                        this.customAmount = parseInt(rawValue, 10).toLocaleString();
                    } else {
                        this.customAmount = "";
                    }
                },
                fnToggleAllAgree:function(event){
                    let isChecked = event.target.checked;
                    document.querySelectorAll("input[name='agree']").forEach(checkbox => {
                        checkbox.checked = isChecked;
                    });
                },
                fnPayment:function(){
                    var self = this;

                    var policyChecked = document.querySelector("input[name='policyCheck']").checked;
                    var checkboxes = document.querySelectorAll("input[name='agree']");
                    var allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);

                    if (!policyChecked) {
                        alert("출금 정책에 동의해야 합니다.");
                        return;
                    }
                    if (!allChecked) {
                        alert("모든 필수 항목에 동의해야 합니다.");
                        return;
                    }

                    // 결제 페이지로 이동

                    IMP.request_pay({
                    channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
                    pay_method: "card",
                    merchant_uid: "merchant_"+ new Date().getTime(),
                    name: self.info.centerName + " 후원 테스트 결제",
                    amount: 1,
                    buyer_tel: "010-0000-0000",

                }, function (rsp) { // callback
                    if (rsp.success) {
                        alert("성공");
                        console.log(rsp);
                    } else {
                        alert("실패");
                        console.log(rsp);
                    }
                });
                },
                fnDonation:function(){
                    var self = this;
                    var nparmap = {

                    };
                    $.ajax({
                        url:"/center/donate.dox",
                        dataType:"json",	
                        type : "POST", 
                        data : nparmap,
                        success : function(data) { 
                            console.log(data);
                            
                        }
                    }); 
                }
            },
            mounted() {
                let self = this;
                self.fnCenterInfo();
                
            }
        });

        app.mount("#app");
    });
    </script>
