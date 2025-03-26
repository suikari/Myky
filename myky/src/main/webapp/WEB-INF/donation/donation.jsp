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

        .donationTable th,
        .donationTable td {
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

        .privacy-policy, .terms {
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            margin-top: 10px;
            max-height: 400px;
            overflow-y: auto;
        }

        .membershipDonationBtn {
            background-color: #ff6347;
            color: white;
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
        }

        .membershipDonationBtn.selected {
            background-color: #4caf50;
        }

    </style>
</head>

<body>
    <jsp:include page="../common/header.jsp" />



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
                                    <button v-if="!isMember" @click="goToMembershipPage" class="membershipDonationBtn">
                                        멤버십으로 후원
                                    </button>
                                    <button v-if="isMember" :class="{'selected': isMembershipDonation}" @click="toggleMembershipDonation">
                                        멤버십으로 후원
                                    </button>
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
                            <tr v-if="!isMembershipDonation">
                                <th>후원금액</th>
                                <td>
                                    <div class="donateAmountContainer">
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 100}" @click="selectAmount(100)">10,000원</button>
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 300}" @click="selectAmount(300)">30,000원</button>
                                        <button type="button" class="donateAmountBtn" :class="{'selected': donateAmount === 500}" @click="selectAmount(500)">50,000원</button>
                                        <input type="text" class="customAmountInput" v-model="customAmount" @input="formatCustomAmount" @focus="clearSelection" placeholder="직접입력">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <th>후원 메세지</th>
                                <td><input class="donationMessage" name="donateMessage" v-model="donateMessage"
                                        placeholder="따듯한 마음을 전하세요"></td>
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
                        <label>
                            <input class="donationCheckbox" name="agree" type="checkbox">[필수] 가입약관 동의
                            <a href="javascript:void(0);" @click="toggleTerms">{{ showTerms ? '[닫기]' : '[보기]' }}</a>
                        </label>

                        <div v-if="showTerms" class="terms">
                            <h3>가입약관</h3>
                            <p><strong>제1조 (목적)</strong><br>
                                본 약관은 '회사명' (이하 "회사"라 한다)와 회원 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.</p>

                            <p><strong>제2조 (이용계약의 체결)</strong><br>
                                회원가입은 회사가 제공하는 가입신청서에 필요한 정보를 기입하여 제출함으로써 체결됩니다.</p>

                            <p><strong>제3조 (회원의 의무)</strong><br>
                                1. 회원은 본 약관을 준수하여야 하며, 제공되는 서비스의 규정을 따라야 합니다.<br>
                                2. 회원은 개인정보 보호 및 안전을 위해 계정 정보를 적절히 관리해야 하며, 타인에게 유출되지 않도록 해야 합니다.</p>

                            <p><strong>제4조 (서비스의 제공)</strong><br>
                                1. 회사는 회원에게 다양한 서비스를 제공합니다.<br>
                                2. 회사는 서비스의 제공을 중단할 수 있으며, 서비스 제공 여부는 회사의 재량에 따릅니다.</p>

                            <p><strong>제5조 (개인정보의 처리)</strong><br>
                                1. 회사는 회원의 개인정보를 보호하기 위해 노력하며, 개인정보 처리 방침에 따라 회원 정보를 수집, 이용합니다.<br>
                                2. 회원은 언제든지 자신의 개인정보를 열람, 수정하거나 삭제를 요청할 수 있습니다.</p>

                            <p><strong>제6조 (서비스 이용의 제한)</strong><br>
                                회사는 다음의 경우에 서비스 이용을 제한하거나 중지할 수 있습니다.<br>
                                1. 회원이 본 약관을 위반한 경우<br>
                                2. 서비스 제공에 큰 장애가 발생한 경우</p>

                            <p><strong>제7조 (면책사항)</strong><br>
                                1. 회사는 천재지변 또는 불가항력적인 사유로 서비스를 제공할 수 없는 경우 책임을 지지 않습니다.<br>
                                2. 회사는 회원이 서비스를 이용하며 발생한 손해에 대해 책임을 지지 않습니다.</p>

                            <p><strong>제8조 (분쟁해결)</strong><br>
                                본 약관과 관련된 분쟁은 회사의 본사 소재지를 관할하는 법원을 제1심 법원으로 합니다.</p>

                            <p><strong>제9조 (약관의 개정)</strong><br>
                                1. 회사는 필요에 따라 본 약관을 변경할 수 있습니다.<br>
                                2. 변경된 약관은 회사의 웹사이트에 공지됩니다.</p>

                            <p><strong>제10조 (기타)</strong><br>
                                본 약관에 명시되지 않은 사항은 관련 법령 및 회사의 정책에 따릅니다.</p>

                            <p>위 약관에 동의합니다.</p>
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


    <jsp:include page="../common/footer.jsp" />


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
                    isMember: true,
                    // 멤버십 가입 여부 가져와야함
                    sessionId: "${sessionId}",
                    info: {},
                    centerId: "${map.centerId}",
                    donateAmount: null,
                    donateMessage: "",
                    customAmount: null,
                    userInfo: {},
                    donationId: null,
                    showTerms: false,
                    showPrivacyPolicy: false,
                    isMembershipDonation: false
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


                        }
                    });
                },
                toggleMembershipDonation() {
                    this.isMembershipDonation = !this.isMembershipDonation;
                },
                goToMembershipPage() {
                    alert("멤버십에 가입해 주세요.");
                    window.location.href = "/membership/signup";
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
                selectMembershipDonation() {
                    this.isMembershipDonation = true;
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
                            self.fnDonation(rsp, amount);
                            // 결제 > 후원히스토리DB에 저장 > 후원ID 가져오기 > 결제DB에 저장
                            console.log("결제 정보 >>> ", rsp);
                        } else {
                            alert("결제에 실패했습니다.");
                            console.log("결제 정보 >>> ", rsp.error_msg);
                        }
                    });
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
                        paymentCode: rsp.merchant_uid,
                        description: rsp.name,
                        amount: rsp.paid_amount,
                        paymentMethod: paymentMethod,
                        installment: null,
                        subscriptionPeriod: null,
                        paymentStatus: rsp.status,
                        isCanceled: "N",
                        cancelDate: null,
                        productId: null,
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
                fnDonation: function (rsp, amount) {
                    var self = this;
                    var nparmap = {
                        centerId: self.centerId,
                        amount: amount,
                        message: self.donateMessage,
                        userId: self.userInfo.userId
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