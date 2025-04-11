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
    <link rel="stylesheet" type="text/css" href="/css/donation/donation.css" />

    <style>
        
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />



    <div id="app" class="donationBody">
        <div class="donationContainer">
            <div class="donationTitle">
                <h2>후원하기</h2>
            </div>
            <div class="donationContents">
                <p>당신의 따뜻한 후원이</p>
                <p>고통받는 동물을 구해내는 힘이 됩니다.</p>
            </div>

            <div id="donationSections">
                <section>
                    <div class="donationTitleTitle">후원정보</div>
                    <div class="donationTable">
                        <table>
                            <tr>
                                <th>후원항목</th>
                                <td>
                                    <span>일시후원</span>
                                    <span v-if="isMembership">
                                        ::
                                        <label>
                                            <input type="radio" v-model="isMembershipDonation" :value="true"
                                                @change="checkMembershipDonation"> 멤버십 후원
                                        </label>
                                        <label>
                                            <input type="radio" v-model="isMembershipDonation" :value="false"> 일반 후원
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
                                        <button type="button" class="donateAmountBtn"
                                            :class="{'selected': donateAmount === 10000}"
                                            @click="selectAmount(10000)">10,000원</button>
                                        <button type="button" class="donateAmountBtn"
                                            :class="{'selected': donateAmount === 30000}"
                                            @click="selectAmount(30000)">30,000원</button>
                                        <button type="button" class="donateAmountBtn"
                                            :class="{'selected': donateAmount === 50000}"
                                            @click="selectAmount(50000)">50,000원</button>
                                        <input type="text" class="customAmountInput" v-model="customAmount"
                                            :class="{'selected': customAmount}" 
                                            @input="formatCustomAmount" @focus="clearSelection"
                                            @blur="validateCustomAmount" @keyup.enter="validateCustomAmount"
                                            placeholder="직접입력">
                                    </div>
                                </td>
                                <td v-else>
                                    <div>멤버십으로 후원이 진행됩니다.</div>
                                </td>
                            </tr>
                            <tr v-if="!isMembershipDonation" class="point-row">
                                <th>보유 포인트</th>
                                <td>{{ formattedUserPoints }} P</td>
                            </tr>
                            <tr v-if="!isMembershipDonation" class="point-row">
                                <th>사용 포인트</th>
                                <td class="point-input-wrap">
                                    <span class="point-button-group">
                                    <input type="text" ref="usedPoint" v-model="usedPoint" @input="validatePoints"
                                        @keyup.enter="applyPoints" class="point-input" placeholder="사용할 적립금 입력">
                                        <button @click="useAllPoints" class="point-btn">전체 사용</button>
                                        <button @click="applyPoints" class="point-btn">적용</button>
                                    </span>
                                    <span class="point-summary"> └　{{ formattedDiscountPoint }} P 사용</span>
                                    <div v-if="usedPoint != 0" class="point-remaining">포인트를 차감한 금액 {{ remainingAmount }} 원이 결제됩니다.</div>
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
                    <div class="donationSectionTitle">출금 정책</div>
                    <p class="donationSectionContents">[출금 정책 안내]</p>
                    <p class="donationSectionContents">※ 일시 납입은 신청 즉시 결제가 이루어집니다.</p>
                    <label class="donationTextColor">
                        <input class="donationCheckbox" name="policyCheck" type="checkbox"> 상기 출금 정책을 모두 이해함
                    </label>
                </section>
                <section>
                    <div class="donationTitle">
                        <label class="donationSectionTitle"><input type="checkbox" name="agreeAll" @change="fnToggleAllAgree"> 전체 동의하기</label>
                    </div>
                    <div>
                        <label class="donationTextColor">
                            <input class="donationCheckbox" name="agree" type="checkbox">[필수] 후원약관 동의
                            <a href="javascript:void(0);" @click="toggleTerms">{{ showTerms ? '[닫기]' : '[보기]' }}</a>
                        </label>

                        <div v-if="showTerms" class="donationTerms">
                            <div v-html="termsInfo[0].content"></div>
                        </div>
                    </div>
                    <div>
                        <label class="donationTextColor">
                            <input class="donationCheckbox" name="agree" type="checkbox">[필수] 개인정보 처리방침 동의
                            <a href="javascript:void(0)" @click="togglePrivacyPolicy">{{ showPrivacyPolicy ? '[닫기]'
                                : '[보기]' }}</a>
                        </label class="donationTextColor">

                        <div v-if="showPrivacyPolicy" class="privacy-policy">
                            <div v-html="termsInfo[1].content"></div>
                        </div>
                    </div>
                </section>
                <button class="donationButton" @click="fnPaymentCheck">다음</button>
            </div>
        </div>
    </div>


    <jsp:include page="/WEB-INF/common/footer.jsp" />


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
                    membership: {},
                    termsInfo: [],
                    donationId: null,
                    showTerms: false,
                    showPrivacyPolicy: false,
                    isMembership: false,
                    isMembershipDonation: false,
                    isAnonymous: false,
                    userPoint: 0,
                    usedPoint: 0,
                    discountPoint: 0,
                    remainingAmount: 0,
                    totalAmount: 0,
                    membershipAmount: 5000
                };
            },
            computed: {
                formattedUserPoints() {
                    return this.userPoint.toLocaleString();
                },
                formattedDiscountPoint() {
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
                            self.fnValidMembership();
                            self.fnGetPoint();

                        }
                    });
                },
                fnValidMembership: function () {
                    // 멤버십 활성화 여부 확인
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
                            if (data.result === "success") {
                                self.fnMembership();
                            }
                        }
                    });
                },
                fnMembership() {
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
                            if (data.result === "success") {
                                self.membership = data.info;
                                self.isMembership = true;
                            }
                        }
                    });
                },
                fnGetTerms() {
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
                            if (data.result === "success") {
                                self.termsInfo = data.list;
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
                            console.log("보유포인트 >>> ", data.result);
                        }
                    });
                },
                toggleAnonymous() {
                    this.isAnonymous = !this.isAnonymous;
                },
                checkMembershipDonation() {
                    if (this.membership.donationYn === 'Y') {
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
                    this.usedPoint = Number(this.usedPoint.toString().replace(/[^0-9]/g, ''));
                    if (this.usedPoint > this.userPoint) {
                        alert("보유 포인트를 초과할 수 없습니다.");
                        this.usedPoint = this.userPoint;
                    }
                    if (this.usedPoint > this.totalAmount) {
                        this.usedPoint = this.totalAmount;
                    }
                },
                validateCustomAmount() {
                    if (!this.customAmount) return;
                    
                    const amount = parseInt(this.customAmount.replace(/[^0-9]/g, ''));
                    
                    if (isNaN(amount) || amount < 1000) {
                        alert("최소 금액은 1,000원 이상입니다.");
                        this.donateAmount = 1000;
                        this.customAmount = "1,000원";
                        this.calculateTotal();
                    }
                },
                calculateTotal() {
                    this.totalAmount = this.donateAmount;
                    this.applyPoints();
                },
                applyPoints() {
                    this.validatePoints();
                    this.discountPoint = this.usedPoint;
                    this.remainingAmount = this.totalAmount - this.discountPoint;
                },
                useAllPoints() {
                    this.usedPoint = Math.min(this.userPoint, this.totalAmount);
                    this.applyPoints();
                },
                selectAmount(amount) {
                    this.donateAmount = amount;
                    this.customAmount = "";
                    this.calculateTotal();
                },
                clearSelection() {
                    this.donateAmount = 0;
                },
                formatCustomAmount() {
                    const raw = this.customAmount.replace(/[^0-9]/g, '');
                    
                    if (raw) {
                        this.customAmount = Number(raw).toLocaleString() + '원';
                        this.donateAmount = Number(raw);
                    } else {
                        this.customAmount = '';
                        this.donateAmount = 0;
                    }
                    
                    this.calculateTotal();
                },
                fnToggleAllAgree: function (event) {
                    let isChecked = event.target.checked;
                    document.querySelectorAll("input[name='agree']").forEach(checkbox => {
                        checkbox.checked = isChecked;
                    });
                },
                fnPaymentCheck: function () {
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

                    if (self.usedPoint != 0) {
                        self.fnPointCheck();
                    } else {
                        self.fnPayment();
                    }
                },
                fnPointCheck() {
                    let self = this;
                    let params = { userId: self.userInfo.userId };
                    $.ajax({
                        url: "/point/current.dox",
                        dataType: "json",
                        type: "POST",
                        data: params,
                        success: function (data) {
                            if (self.userPoint != data.point.currentPoint) {
                                alert("보유 포인트에 변동이 있습니다. 확인 후 다시 시도해주세요.");
                                self.fnGetPoint();
                                self.$nextTick(() => {
                                    self.$refs.usedPoint.focus();
                                });
                                return;
                            } else {
                                self.fnPayment();
                            }
                        }
                    });
                },
                fnPayment: function () {
                    let self = this;

                    let amount = self.totalAmount;

                    if (self.usedPoint > 0) {
                        amount = self.remainingAmount;
                    }

                    console.log("amount >>> ", amount);

                    let anonymousYn = self.isAnonymous ? "Y" : "N";

                    if (self.isMembershipDonation) {
                        let donation = {
                            centerId: self.centerId,
                            amount: self.membershipAmount,
                            message: self.donateMessage,
                            userId: self.userInfo.userId,
                            anonymousYn: anonymousYn,
                            donationYn: "Y",
                            option: "membership"
                        };
                        self.fnMembershipDonation(donation);

                    } else if (self.remainingAmount == 0) {
                        // 포인트 결제
                        let merchantUid = "point_donation_" + new Date().getTime();

                        let paymentData = {
                            merchant_uid: merchantUid,
                            name: self.info.centerName + " 후원 포인트 결제",
                            paid_amount: self.totalAmount,
                            pay_method: "point_only",
                            status: "paid",
                            card_quota: null
                        };
                        self.fnDonation(paymentData, self.totalAmount, anonymousYn);

                    } else {
                        // 결제 진행

                        if (typeof IMP === 'undefined') {
                            console.error('IMP is not initialized');
                            return;
                        }

                        console.log("결제 금액 >>> ", amount);

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
                                self.fnDonation(rsp, self.totalAmount, anonymousYn);
                                // 결제 > 후원히스토리DB에 저장 > 후원ID 가져오기 > 결제DB에 저장
                                console.log("결제 정보 >>> ", rsp);
                            } else {
                                alert("결제에 실패했습니다.");
                                console.log("결제 정보 >>> ", rsp.error_msg);
                            }
                        });
                    }
                },
                fnPaymentHistory: function (rsp, amount) {
                    let self = this;

                    let paymentMethod = "";
                    if (rsp.pay_method == "card" && self.usedPoint == 0) {
                        paymentMethod = rsp.pay_method + "-" + rsp.card_name;
                    } else if (rsp.pay_method == "card" && self.usedPoint > 0) {
                        paymentMethod = rsp.pay_method + "-" + rsp.card_name + " + point";
                    } else {
                        paymentMethod = rsp.pay_method;
                    }

                    console.log("paymentMethod >>> ", paymentMethod);
                    console.log("fnPaymentHistory >> self.donationId >>> ", self.donationId);

                    var nparmap = {
                        option: "donation",
                        paymentCode: rsp.merchant_uid,
                        description: rsp.name,
                        amount: amount,
                        paymentMethod: paymentMethod,
                        installment: rsp.card_quota,
                        subscriptionPeriod: null,
                        paymentStatus: rsp.status,
                        isCanceled: "N",
                        cancelDate: null,
                        orderId: null,
                        donationId: self.donationId,
                        userId: self.userInfo.userId,
                        usedPoint: self.usedPoint,
                        membershipId: null
                    };
                    $.ajax({
                        url: "/payment.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("결제 정보 저장 여부 >>> ", data.result);
                            self.fnUsePoint();
                            pageChange("/donation/complete.do", { userId: self.userInfo.userId, donationId: self.donationId });
                        }
                    });
                },
                fnDonation: function (rsp, amount, anonymousYn) {
                    var self = this;
                    var nparmap = {
                        option: "donation",
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
                            self.fnPaymentHistory(rsp, amount);

                        }
                    });
                },
                fnMembershipDonation: function (donation) {
                    var self = this;
                    let merchantUid = "membership_donation_" + new Date().getTime();
                    let paymentData = {
                        merchant_uid: merchantUid,
                        name: self.info.centerName + " 멤버십 후원 결제",
                        paid_amount: self.membershipAmount,
                        pay_method: "membership_donate",
                        status: "paid",
                        card_quota: null
                    };
                    var nparmap = donation;
                    $.ajax({
                        url: "/center/donate.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("후원 정보 저장 여부 >>> ", data.result);
                            self.donationId = data.donationId;
                            self.fnPaymentHistory(paymentData, self.membershipAmount);
                        }
                    });
                },
                fnUsePoint: function () {
                    let self = this;
                    let usedPoint = -Math.abs(parseInt(self.usedPoint));

                    console.log("사용 포인트 >> ", usedPoint);
                    if (usedPoint == 0) {
                        return;
                    }

                    var nparmap = {
                        usedPoint: usedPoint,
                        remarks: "후원 시 포인트 사용",
                        userId: self.userInfo.userId
                    };
                    $.ajax({
                        url: "/point/used.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("포인트 사용 내역 저장 >>> ", data.result);

                        }
                    });
                }
            },
            mounted() {
                let self = this;
                
                if (!self.centerId) {
                    alert("후원할 보호소를 선택해주세요. \n보호소 목록 페이지로 이동합니다.");
                    window.location.href = "/center.do";
                    return;
                }

                self.fnCenterInfo();
                self.fnUserInfo();
                self.fnGetTerms();
            }
        });

        app.mount("#app");
    });
</script>