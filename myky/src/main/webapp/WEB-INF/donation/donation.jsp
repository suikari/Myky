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
                            <h3>후원 약관</h3>
                            <p>본 후원 약관(이하 "약관")은 후원자(이하 "후원자")가 [회사명] (이하 "회사")의 후원 프로그램에 참여함에 있어 동의해야 할 조건을 규정합니다. 후원자는 본 약관을 충분히 읽고 이해한 후 후원 절차를 진행해 주시기 바랍니다. 후원자가 본 프로그램에 참여함으로써 본 약관에 동의한 것으로 간주됩니다.</p>

                            <h4>1. 후원 목적</h4>
                            <p>회사는 후원자를 통해 모은 후원금으로 [후원 대상 또는 목적 설명]을 지원합니다. 후원금은 [후원금의 사용 목적 또는 구체적인 사용 내역]에 사용되며, 후원자에게 이에 대한 상세한 정보를 제공할 수 있습니다.</p>

                            <h4>2. 후원자의 권리</h4>
                            <ul>
                                <li>후원자는 후원금의 사용내역 및 결과에 대해 정기적인 보고를 받을 권리가 있습니다.</li>
                                <li>후원자는 후원한 금액에 대해 세액 공제 혜택을 받을 수 있는 경우, 회사가 제공하는 세액 공제 관련 서류를 요청할 수 있습니다.</li>
                                <li>후원자는 후원금의 사용 방법에 대해 합리적인 질문을 할 수 있으며, 그에 대한 답변을 받을 권리가 있습니다.</li>
                            </ul>

                            <h4>3. 후원자의 의무</h4>
                            <ul>
                                <li>후원자는 후원 절차에서 요구하는 모든 정보를 정확하고 진실하게 제공해야 합니다.</li>
                                <li>후원자는 후원금이 [후원 대상 또는 목적]에 적합하게 사용될 수 있도록 협력해야 하며, 후원금이 부정확하거나 부적절하게 사용되지 않도록 주의해야 합니다.</li>
                            </ul>

                            <h4>4. 후원금 처리 및 방법</h4>
                            <p>후원자는 [결제 방법 예: 카드 결제, 계좌 이체 등]을 통해 후원금을 지불하며, 모든 후원금은 결제 후 즉시 처리됩니다.</p>
                            <p>후원금은 [후원 방법 및 처리 절차 설명]에 따라 처리되며, 후원자가 요청하는 경우 관련 영수증이나 후원 내역을 제공할 수 있습니다.</p>

                            <h4>5. 후원 취소 및 환불</h4>
                            <p>후원자는 후원 후 [취소 및 환불 정책]에 따라 후원금 취소 및 환불을 요청할 수 있습니다. 다만, 후원금이 이미 특정 목적에 사용된 경우, 환불이 불가능할 수 있습니다.</p>
                            <p>후원자의 요청에 의한 취소 및 환불은 회사의 정책에 따라 처리되며, 회사는 환불이 불가능한 경우 이에 대해 설명할 의무가 있습니다.</p>

                            <h4>6. 개인정보 보호</h4>
                            <p>후원자는 후원 과정에서 제공하는 개인정보가 회사의 개인정보 보호 정책에 따라 안전하게 처리될 것에 대해 동의합니다.</p>
                            <p>회사는 후원자의 개인정보를 제3자에게 제공하지 않으며, 오직 후원 프로그램에 필요한 범위 내에서만 사용합니다.</p>

                            <h4>7. 후원 약관 변경</h4>
                            <p>회사는 후원 약관을 언제든지 변경할 수 있으며, 변경된 약관은 회사의 웹사이트나 이메일을 통해 후원자에게 통지됩니다.</p>
                            <p>변경된 약관에 동의하지 않는 경우, 후원자는 후원 참여를 중단할 수 있으며, 이 경우 후원금의 반환 여부는 회사의 환불 정책에 따라 결정됩니다.</p>

                            <h4>8. 법적 책임</h4>
                            <p>후원자는 본 약관을 준수하여야 하며, 만약 이를 위반할 경우 회사는 후원자의 후원 참여를 취소하거나 법적 책임을 추궁할 수 있습니다.</p>
                            <p>후원과 관련된 분쟁이 발생한 경우, 관련 법률에 따라 해결됩니다.</p>

                            <h4>9. 기타</h4>
                            <p>본 약관에 명시되지 않은 사항은 [관련 법령 또는 회사의 다른 규정]에 따릅니다.</p>
                        </div>
                    </div>
                    <div class="sectionContents">
                        <label>
                            <input class="donationCheckbox" name="agree" type="checkbox">[필수] 개인정보 처리방침 동의 
                            <a href="javascript:void(0)" @click="togglePrivacyPolicy">{{ showPrivacyPolicy ? '[닫기]' : '[보기]' }}</a>
                          </label>

                        <div v-if="showPrivacyPolicy" class="privacy-policy">
                            <h3>개인정보 처리방침</h3>
                            
                            <p><strong>1. 개인정보의 수집 항목</strong><br>
                            회사는 서비스 제공을 위해 다음과 같은 개인정보를 수집합니다.<br>
                            - 이름, 이메일 주소, 전화번호, 주소, 생년월일 등 회원가입 시 입력한 정보<br>
                            - 결제 정보: 결제 시 제공되는 카드 정보 및 기타 결제 관련 정보<br>
                            - 서비스 이용 기록: 로그인 기록, 서비스 이용 내역, 접속 로그 등<br>
                            - 쿠키 및 접속 정보: 사용자의 웹사이트 이용 및 활동에 대한 정보</p>
                          
                            <p><strong>2. 개인정보의 수집 및 이용 목적</strong><br>
                            회사는 수집된 개인정보를 다음과 같은 목적으로 사용합니다.<br>
                            - 회원 관리: 회원가입, 서비스 제공 및 이용, 고객 문의 응대<br>
                            - 서비스 제공: 주문 및 결제 처리, 배송, 구매 내역 확인<br>
                            - 마케팅 및 광고: 맞춤형 광고 제공, 이벤트 참여, 프로모션</p>
                          
                            <p><strong>3. 개인정보의 보유 및 이용 기간</strong><br>
                            회사는 회원 탈퇴 시까지 또는 개인정보 처리 방침에 명시된 목적이 달성될 때까지 개인정보를 보유합니다. 단, 관계 법령에 의한 보유 의무가 있는 경우, 법정 보유 기간 동안 보관될 수 있습니다.</p>
                          
                            <p><strong>4. 개인정보의 제3자 제공</strong><br>
                            회사는 원칙적으로 이용자의 개인정보를 제3자에게 제공하지 않습니다. 다만, 법률에 의하거나 이용자가 동의한 경우에는 예외적으로 제공할 수 있습니다.</p>
                          
                            <p><strong>5. 개인정보의 안전성 확보 조치</strong><br>
                            회사는 개인정보의 안전성을 확보하기 위해 다음과 같은 조치를 취하고 있습니다.<br>
                            - 개인정보 암호화: 사용자의 개인정보는 암호화되어 안전하게 저장됩니다.<br>
                            - 접근 권한 관리: 개인정보에 접근할 수 있는 권한을 제한하며, 해당 권한을 가진 인원은 최소화합니다.<br>
                            - 보안 소프트웨어 설치: 개인정보 보호를 위한 보안 시스템을 구축하고 정기적으로 점검합니다.</p>
                          
                            <p><strong>6. 이용자의 권리와 행사 방법</strong><br>
                            이용자는 언제든지 자신의 개인정보를 열람하고 수정할 수 있으며, 개인정보 처리의 정지를 요청할 수 있습니다. 이를 위해 고객센터 또는 설정에서 요청하실 수 있습니다.</p>
                          
                            <p><strong>7. 개인정보 보호 책임자</strong><br>
                            회사는 개인정보 보호를 위해 다음과 같은 담당자를 지정하고 있습니다.<br>
                            - 개인정보 보호 책임자: [담당자 이름]<br>
                            - 연락처: [담당자 연락처]</p>
                          
                            <p><strong>8. 개인정보 처리방침의 변경</strong><br>
                            회사는 개인정보 처리방침을 변경할 수 있으며, 변경 시 웹사이트를 통해 공지할 것입니다. 변경된 개인정보 처리방침은 공지된 날로부터 효력이 발생합니다.</p>
                          
                            <p><strong>9. 동의 거부 및 불이익</strong><br>
                            이용자는 개인정보 제공에 동의하지 않을 수 있으며, 동의하지 않을 경우 일부 서비스 이용에 제한이 있을 수 있습니다.</p>
                          
                            <p>위 개인정보 처리방침에 동의합니다.</p>
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
                    donationId: null,
                    showTerms: false,
                    showPrivacyPolicy: false,
                    isMembership: false,
                    isMembershipDonation: false,
                    isAnonymous: false
                };
            },
            computed: {

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

                        }
                    });
                },
                fnMembership:function(){
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
                            console.log("membership >>> ", data.info);
                            if(data.result == "success"){
                                self.membership = data.info;
                                self.isMembership = true;
                            } 
                        }
                    });
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

            }
        });

        app.mount("#app");
    });
</script>