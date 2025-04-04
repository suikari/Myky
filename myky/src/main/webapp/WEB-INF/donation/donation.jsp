<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후원 페이지</title>
    <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

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

        .sectionContents {
            color: #555;
            margin-bottom: 20px;
            margin-left: 30px;
        }

        .donationTable {
            width: 100%;
            margin-top: 10px;
            border-collapse: collapse;
            margin-left: 30px;

        }

        .donationTable table {
            width: 80%;
            border: 1px solid #ddd;
            background: #fff;
            border-radius: 5px;
            margin-left: 30px;

        }

        .donationTable th,
        .donationTable td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
            text-align: left;

        }

        .donationTable th {
            width: 100px;
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

        .privacy-policy, .terms {
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            margin-top: 10px;
            max-height: 400px;
            overflow-y: auto;
        }

    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />



    <div id="app" class="body">
        <div class="donationContainer">
            <div class="boardTitle">
                <h2>후원하기</h2>
            </div>
            <div class="boardContents">
                <p>당신의 따뜻한 후원,</p>
                <p>고통받는 동물을 구해내는 힘이 됩니다.</p>
            </div>

            <div id="sections">
                <section>
                    <div class="sectionTitle">후원정보</div>
                    <div class="donationTable">
                        <table>
                            <tr>
                                <th>후원항목</th>
                                <td>
                                    <span>일시후원</span>
                                    <span v-if="isMembership">
                                         :: 
                                        <label>
                                            <input type="radio" v-model="isMembershipDonation" :value="true" @change="checkMembershipDonation"> 멤버십 후원
                                        </label>
                                        <label>
                                            <input type="radio" v-model="isMembershipDonation" :value="false" > 일반 후원
                                        </label>
                                    </span>
                                </td>
                            </tr>
                            <tr>
                                <th>후원자 정보</th>
                                <td>
                                    <div>
                                        <label>
                                            <input type="radio" v-model="isAnonymous" :value="false"> 실명으로 후원
                                        </label>
                                        <label>
                                            <input type="radio" v-model="isAnonymous" :value="true"> 익명으로 후원
                                        </label>
                                    </div>
                                </td>
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
                                <td v-if="!isMembershipDonation">
                                    <div class="donateAmountContainer">
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 100}" @click="selectAmount(100)">10,000원</button>
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 300}" @click="selectAmount(300)">30,000원</button>
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 500}" @click="selectAmount(500)">50,000원</button>
                                        <input type="text" class="customAmountInput" v-model="customAmount" @input="formatCustomAmount" @focus="clearSelection" placeholder="직접입력">
                                    </div>
                                </td>
                                <td v-else>
                                    <div>멤버십으로 후원이 진행됩니다.</div>
                                </td>
                            </tr>
                            <tr>
                                <th>보유 포인트</th>
                                <td>{{ formattedUserPoints }} 원</td>
                            </tr>
                            <tr>
                                <th>사용할 포인트</th>
                                <td>
                                    <input type="text" ref="usedPoint" v-model="usedPoint" @input="validatePoints" placeholder="사용할 적립금 입력">
                                    <button @click="useAllPoints">전체 사용</button>
                                    <button @click="applyPoints">적용</button>
                                    <span>{{ formattedDiscountAmount }} 포인트 사용</span>
                                </td>
                            </tr>
                            <tr>
                                <th>후원 메세지</th>
                                <td><input class="donationMessage" name="donateMessage" v-model="donateMessage"
                                        placeholder="따듯한 마음을 전하세요"></td>
                            </tr>
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
                        <label>
                            <input class="donationCheckbox" name="agree" type="checkbox">[필수] 후원약관 동의
                            <a href="javascript:void(0);" @click="toggleTerms">{{ showTerms ? '[닫기]' : '[보기]' }}</a>
                        </label>

                        <div v-if="showTerms" class="terms">
                            
                        </div>
                    </div>
                    <div class="sectionContents">
                        <label>
                            <input class="donationCheckbox" name="agree" type="checkbox">[필수] 개인정보 처리방침 동의 
                            <a href="javascript:void(0)" @click="togglePrivacyPolicy">{{ showPrivacyPolicy ? '[닫기]' : '[보기]' }}</a>
                          </label>

                        <div v-if="showPrivacyPolicy" class="privacy-policy">
                            
                        </div>                          
                    </div>
                </section>
                <button class="donationButton" @click="fnPayment">다음</button>
            </div>
        </div>
    </div>


    <jsp:include page="/WEB-INF/common/footer.jsp"/>


</body>

</html>
<script>
    const userCode = "imp40283074";

    document.addEventListener("DOMContentLoaded", function () {

        if (typeof IMP !== 'undefined') {
            IMP.init(userCode);
        } else {
            console.error('IMP is not loaded properly');
        }

        const app = Vue.createApp({
            data() {
                return {
                    sessionId: "${sessionId}",
                    info: {},
                    centerId: "${map.centerId}",
                    donateAmount: null,
                    donateMessage: "",
                    customAmount: null,
                    userInfo: {},
                    membership:{},
                    termsInfo:[],
                    donationId: null,
                    showTerms: false,
                    showPrivacyPolicy: false,
                    isMembership: false,
                    isMembershipDonation: false,
                    isAnonymous: false,
                    userPoint:0,
                    usedPoint:0,
                    discountPoint:0,
                    remainingAmount:0
                };
            },
            computed: {
                formattedUserPoints() {
                    return this.userPoint.toLocaleString();
                },
                totalAmount() {
                    return this.totalAmount = (this.donateAmount != null) ? this.donateAmount : this.customAmount;
                },
                formattedDiscountAmount() {
                    return this.discountPoint.toLocaleString();
                },
            },
            methods: {
                fnCenterInfo() {
                    var self = this;
                    console.log("centerId >>> ", self.centerId);
                    var nparmap = {
                        centerId: self.centerId
                    };
                    $.ajax({
                        url: "/center/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("info >>> ", data.info);
                            self.info = data.info;

                        }
                    });
                },
                fnUserInfo() {
                    var self = this;
                    console.log("sessionId >>> ", self.sessionId);
                    var nparmap = {
                        userId: self.sessionId
                    };
                    $.ajax({
                        url: "/user/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("userInfo >>> ", data.user);
                            self.userInfo = data.user;
                            self.fnMembership();
                            self.fnGetPoint();

                        }
                    });
                },
                fnValidMembership:function(){
                    var self = this;
                    var nparmap = {
                        userId: self.userInfo.userId
                    };
                    $.ajax({
                        url: "/membership/active.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("validMembership >>> ", data.result);
                            if(data.result === "success"){
                                self.fnMembership();
                                self.isMembership = true;
                            } 
                        }
                    });
                },
                fnMembership(){
                    var self = this;
                    var nparmap = {
                        userId: self.userInfo.userId
                    };
                    $.ajax({
                        url: "/membership/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("membershipInfo >>> ", data.info);
                            if(data.result === "success"){
                                self.membership = data.info;
                            } 
                        }
                    });
                },
                fnGetTerms(){
                    var self = this;
                    var nparmap = {
                        category: "D"
                    };
                    $.ajax({
                        url: "/membership/termsList.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("termsInfo >>> ", data.list);
                            if(data.result === "success"){
                                self.membership = data.list;
                            } 
                        }
                    });
                },
                fnGetPoint: function () {
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/point/current.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            self.userPoint = parseInt(data.point.currentPoint);
                            console.log("보유포인트 >>> ",data.result);
                        }
                    });
                },
                GetTotalAmount() {
                    this.totalAmount = (this.donateAmount != null) ? this.donateAmount : this.customAmount;
                },
                toggleAnonymous() {
                    this.isAnonymous = !this.isAnonymous;
                },
                checkMembershipDonation() {
                    if(this.membership.donationYn === 'Y'){
                        alert("이번달은 이미 멤버십 후원 기능을 이용하셨습니다. \n후원자님의 따듯한 마음에 감사드립니다.");
                        
                        setTimeout(() => {
                            this.isMembershipDonation = false;
                        }, 0);
                    }
                },
                toggleTerms() {
                    this.showTerms = !this.showTerms;
                },
                togglePrivacyPolicy() {
                    this.showPrivacyPolicy = !this.showPrivacyPolicy;
                },
                validatePoints() {
                    this.usedPoint = parseInt(this.usedPoint) || 0;
                },
                calculateRemaining() {
                    if (this.usedPoint < 0) {
                        this.usedPoint = 0;
                    } else if (this.usedPoint > this.totalAmount) {
                        this.usedPoint = this.totalAmount;
                    } else if (this.usedPoint > this.userPoint) {
                        this.usedPoint = this.userPoint;
                    }

                    this.remainingAmount = this.totalAmount - this.usedPoint;
                },
                applyPoints() {
                    let self = this;
                    let usedPoints = parseInt(self.usedPoint) || 0;
                    let userPoints = parseInt(self.userPoint) || 0;
                    let totalAmount = parseInt(self.totalAmount) || 0;
                    
                    if (usedPoints > totalAmount) {
                        alert("총 결제 금액보다 많은 포인트를 사용할 수 없습니다.");
                        self.usedPoint = totalAmount;
                    } else if (usedPoints > userPoints) {
                        alert("보유한 포인트보다 많은 포인트를 사용할 수 없습니다.");
                        self.usedPoint = userPoints;
                    } else {
                        self.usedPoint = usedPoints;
                    }
                    self.discountPoint = self.usedPoint;
                    self.$nextTick(() => {
                        self.$refs.usedPoint.focus();
                    });
                    return;
                },
                useAllPoints() {
                    this.usedPoint = Math.min(this.userPoint, this.totalAmount);
                    this.discountPoint = this.usedPoint;
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
                fnToggleAllAgree: function (event) {
                    let isChecked = event.target.checked;
                    document.querySelectorAll("input[name='agree']").forEach(checkbox => {
                        checkbox.checked = isChecked;
                    });
                },
                fnPayment: function () {
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

                    let amount = (self.donateAmount != null) ? self.donateAmount : self.customAmount;
                    
                    console.log("amount >>> ", amount);

                    let anonymousYn = self.isAnonymous ? "Y" : "N";
                    
                    if(self.isMembershipDonation){
                        let donation = {
                            centerId: self.centerId,
                            amount: 5000,
                            message: self.donateMessage,
                            userId: self.userInfo.userId,
                            anonymousYn: anonymousYn,
                            donationYn:"Y",
                            option:"membership"
                        };
                        self.fnMembershipDonation(donation);
                        return;
                    } else {
                        // 결제 진행
    
                        if (typeof IMP === 'undefined') {
                            console.error('IMP is not initialized');
                            return;
                        }
    
                        IMP.request_pay({
                            channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
                            pg: "html5_inicis",
                            pay_method: "card",
                            merchant_uid: "merchant_" + new Date().getTime(),
                            name: self.info.centerName + " 후원 결제",
                            amount: amount,
                            buyer_tel: self.userInfo.phoneNumber,
                        }, function (rsp) {
                            if (rsp.success) {
                                alert("\'" + self.info.centerName + "\'에 후원해 주셔서 감사합니다! \n당신의 따뜻한 마음이 소중한 생명을 살립니다.");
                                self.fnDonation(rsp, amount, anonymousYn);
                                // 결제 > 후원히스토리DB에 저장 > 후원ID 가져오기 > 결제DB에 저장
                                console.log("결제 정보 >>> ", rsp);
                            } else {
                                alert("결제에 실패했습니다.");
                                console.log("결제 정보 >>> ", rsp.error_msg);
                            }
                        });
                    }
                },
                fnPaymentHistory: function (rsp) {
                    let self = this;

                    let paymentMethod = "";
                    if (rsp.pay_method == "card") {
                        paymentMethod = rsp.pay_method + "-" + rsp.card_name;
                    } else {
                        paymentMethod = rsp.pay_method;
                    }

                    console.log("paymentMethod >>> ", paymentMethod);
                    console.log("fnPaymentHistory >> self.donationId >>> ", self.donationId);

                    var nparmap = {
                        option:"donation",
                        paymentCode: rsp.merchant_uid,
                        description: rsp.name,
                        amount: rsp.paid_amount,
                        paymentMethod: paymentMethod,
                        installment: rsp.card_quota,
                        subscriptionPeriod: null,
                        paymentStatus: rsp.status,
                        isCanceled: "N",
                        cancelDate: null,
                        orderId: null,
                        donationId: self.donationId,
                        userId: self.userInfo.userId
                    };
                    $.ajax({
                        url: "/payment.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("결제 정보 저장 여부 >>> ", data.result);
                        }
                    });
                },
                fnDonation: function (rsp, amount, anonymousYn) {
                    var self = this;
                    var nparmap = {
                        centerId: self.centerId,
                        amount: amount,
                        message: self.donateMessage,
                        userId: self.userInfo.userId,
                        anonymousYn: anonymousYn
                    };
                    $.ajax({
                        url: "/center/donate.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("후원 정보 저장 여부 >>> ", data.result);
                            self.donationId = data.donationId;
                            console.log("fnDonation >> self.donationId >>> ", self.donationId);
                            // DB 저장 후 후원ID 가져오기
                            self.fnPaymentHistory(rsp);

                        }
                    });
                },
                fnMembershipDonation: function (donation) {
                    var self = this;
                    var nparmap = donation;
                    $.ajax({
                        url: "/center/donate.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("후원 정보 저장 여부 >>> ", data.result);
                            alert("\'" + self.info.centerName + "\'에 후원해 주셔서 감사합니다! \n당신의 따뜻한 마음이 소중한 생명을 살립니다.");
                        }
                    });
                }
            },
            mounted() {
                let self = this;
                self.fnCenterInfo();
                self.fnUserInfo();
                self.fnGetTerms();

            }
        });

        app.mount("#app");
    });
</script>