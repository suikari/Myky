<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>consent page</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />

        <style>
            .container {
                width: 600px;
                margin: 50px auto;
            }

            .clb {
                font-size: 16px;
                color: #4a90e2;
                padding: 10px 20px;
                border-radius: 5px;
                margin-right: 10px;
                border: 1px solid #4a90e2;
                transition: all 0.3s ease;
            }

            /* 링크 버튼 hover 효과 */
            .clb:hover {
                background-color: #4a90e2;
                color: white;
                border-color: #4a90e2;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app" class="container">
            <h1 style="text-align: center;">회원 가입</h1>
            <br>
            <br>
            <div style="font-size: 24px;">전체 동의서 <input type="checkbox" id="" @click="fnAllCheck()"></div>
            <hr>
            <br>
            <br>
            <div>
                이용 약관 동의(필수) <input type="checkbox" :checked="agree1 === 'Y'" @change="updateAgree('agree1', $event)">
            </div>
            <div class="box">
                <textarea style="resize: none;" name="" id="" cols="100" rows="15" disabled>
제1조(목적)
이 약관은 OO 회사(전자상거래 사업자)가 운영하는 OO 사이버 몰(이하 "몰"이라 한다)에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.
※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다.」
                
제2조(정의)
① "몰"이란 OO 회사가 재화 또는 용역(이하 "재화 등"이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버 몰을 운영하는 사업자의 의미로도 사용합니다.
② "이용자"란 "몰"에 접속하여 이 약관에 따라 "몰"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.
③ '회원'이라 함은 "몰"에 회원등록을 한 자로서, 계속적으로 "몰"이 제공하는 서비스를 이용할 수 있는 자를 말합니다.
④ '비회원'이라 함은 회원에 가입하지 않고 "몰"이 제공하는 서비스를 이용하는 자를 말합니다.
⑤ "서비스"란 "몰"이 제공하는 전자상거래 관련 모든 서비스를 의미하며, 이는 웹사이트를 통한 재화 구매, 회원가입, 고객 지원 등의 기능을 포함합니다.
⑥ "이용계약"이란 "몰"과 이용자 간에 이 약관에 따라 체결되는 계약을 말합니다.
                
제3조(약관의 게시 및 개정)
① "몰"은 이 약관을 "몰"의 초기 화면에 게시하여 언제든지 이용자가 쉽게 확인할 수 있도록 합니다.
② "몰"은 관련 법률을 위배하지 않는 범위 내에서 이 약관을 변경할 수 있으며, 변경된 약관은 "몰"의 초기 화면에 공지하거나 이용자에게 개별 통지함으로써 효력을 발생합니다.
③ 변경된 약관의 효력 발생일자 및 변경사항에 대한 구체적인 내용은 "몰"의 공지사항을 통해 사전에 공지됩니다.
                
제4조(이용계약의 체결)
① 이용계약은 이용자가 "몰"에서 제공하는 회원가입 양식에 따라 필요한 정보를 입력하고, "몰"이 이를 승인함으로써 체결됩니다.
② 이용자는 이용계약 체결 시 정확하고, 진실된 정보를 제공해야 하며, 이를 위반한 경우 "몰"은 이용계약을 해지할 수 있습니다.
③ "몰"은 이용자의 회원가입 신청을 승낙하는 것을 원칙으로 하며, 다음 각 호의 경우에는 승낙을 하지 않거나, 이후 승낙을 취소할 수 있습니다:
                
이용자가 이 약관을 위반한 사실이 있는 경우
                
타인의 명의를 도용한 경우
                
기타 "몰"의 서비스 제공에 부적합한 사유가 있는 경우
                
제5조(서비스의 제공)
                
① "몰"은 이용자에게 아래와 같은 서비스를 제공합니다.
                
재화의 구매 및 결제 서비스
                
상품에 대한 정보 제공 서비스
                
이용자 문의 및 고객 지원 서비스
                
기타 전자상거래와 관련된 서비스
                
② "몰"은 서비스를 제공함에 있어 이용자의 요청에 따라 재화 등의 배송, 결제 및 환불 등의 서비스 지원을 제공합니다.
                
제6조(이용자의 의무)
                
① 이용자는 "몰"을 통해 제공되는 서비스 이용 시, 다음 각 호의 의무를 이행하여야 합니다:
                
"몰"에 제공하는 정보는 사실에 근거해야 하며, 허위 정보 제공을 금지합니다.
                
"몰"의 운영을 방해하거나 불법적인 활동을 하지 않아야 합니다.
                
타인의 개인정보를 침해하지 않아야 합니다.
                
"몰"의 이용과 관련된 법적 의무를 준수해야 합니다.
            </textarea>
            </div>
            <br>
            <br>
            <div>
                개인정보 수집 및 이용 동의(필수) <input type="checkbox" :checked="agree2 === 'Y'"
                    @change="updateAgree('agree2', $event)">
            </div>
            <div class="box">
                <textarea style="resize: none;" name="" id="" cols="100" rows="15" disabled>
개인정보 수집 및 이용 동의서

[쇼핑몰 이름]은(는) 이용자의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호 등에 관한 법률" 및 "개인정보 보호법"을 준수하고 있습니다. 당사는 이용자의 개인정보를 수집 및 이용하기 전에 아래와 같은 목적과 항목을 안내드리오니, 동의 여부를 결정해 주시기 바랍니다.

1. 개인정보 수집목적 및 이용목적
가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금 정산
이용자는 [쇼핑몰 이름]이 제공하는 서비스 이용을 위해 개인정보를 제공해야 하며, 수집된 개인정보는 서비스 제공과 관련된 다음과 같은 목적에 사용됩니다:

콘텐츠 제공

구매 및 요금 결제 처리

물품 배송, 청구서 및 기타 관련 문서 발송

금융 거래 본인 인증 및 금융 서비스 제공

나. 회원 관리
회원제로 제공되는 서비스 이용에 따라, 다음과 같은 회원 관리 업무를 처리하기 위해 개인정보가 수집됩니다:

회원 본인 확인 및 개인 식별

불량 회원의 부정 이용 방지 및 비인가 사용 방지

가입 의사 확인 및 연령 확인

만 14세 미만 아동 개인정보 수집 시, 법정 대리인 동의여부 확인

불만 처리 등 민원 처리

고지사항 전달

2. 수집하는 개인정보 항목
[쇼핑몰 이름]은(는) 서비스 제공을 위해 아래와 같은 개인정보 항목을 수집합니다:

필수 항목: 이름, 생년월일, 성별, 로그인ID, 비밀번호, 자택 전화번호, 휴대전화번호, 이메일

선택 항목: 배송지 주소, 결제 정보, 선호하는 상품 및 서비스 관련 정보 등

만 14세 미만 가입자의 경우: 법정대리인의 정보(법정대리인의 이름, 생년월일, 연락처 등)

3. 개인정보 보유 및 이용 기간
수집된 개인정보는 이용자가 회원 탈퇴를 요청하거나 서비스 제공을 중단하는 경우, 해당 서비스 제공과 관련된 법적 의무를 다하기 위해 필요한 기간 동안만 보유 및 이용됩니다.

회원 탈퇴 시: 탈퇴한 이용자의 개인정보는 관련 법률에 의해 요구되는 기간 동안 보관 후 파기됩니다.

법적 의무에 따른 보유 기간: 상법, 전자상거래법 등 관련 법령에 의해 일정 기간 동안 보유가 필요한 경우, 해당 기간 동안 보유됩니다.

4. 개인정보의 제3자 제공
[쇼핑몰 이름]은(는) 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다. 단, 아래의 경우에는 예외적으로 개인정보를 제공할 수 있습니다:

이용자의 동의가 있는 경우

법적 의무를 준수하기 위해 필요한 경우

서비스 제공을 위한 계약 체결 등 이용자가 동의한 목적을 위해 필요한 경우

5. 개인정보 처리 위탁
[쇼핑몰 이름]은(는) 서비스 제공을 위해 필요한 업무를 외부 전문업체에 위탁할 수 있습니다. 위탁 대상자와 위탁 업무는 아래와 같습니다:

위탁 대상자: [위탁 업체명]

위탁 업무 내용: 배송, 결제 처리, 고객 서비스 등

위탁된 개인정보는 위탁 계약에 따라 보호되며, 위탁업체가 개인정보를 안전하게 처리하도록 관리됩니다.

6. 이용자의 권리와 행사 방법
이용자는 언제든지 본인의 개인정보를 조회하거나 수정할 수 있으며, 개인정보의 처리에 대한 동의를 철회할 수 있습니다. 또한, 이용자는 다음과 같은 권리를 행사할 수 있습니다:

개인정보 열람, 정정, 삭제, 처리 정지 요구

동의 철회 및 회원 탈퇴

개인정보 제공에 대한 동의 거부 가능 (단, 일부 서비스 이용에 제한이 있을 수 있습니다)

7. 개인정보 보호를 위한 안전조치
[쇼핑몰 이름]은(는) 이용자의 개인정보를 보호하기 위해 다음과 같은 안전 조치를 취하고 있습니다:

개인정보 암호화 및 보안 프로토콜을 이용한 보호

접근 권한 제한 및 개인정보 처리 담당자 지정

정기적인 보안 점검 및 해킹 방지 시스템 도입

8. 개인정보에 관한 문의처
[쇼핑몰 이름]은(는) 개인정보 보호와 관련된 문의를 접수하고 있으며, 개인정보 관련 문제나 문의 사항은 아래의 연락처로 접수하실 수 있습니다:

개인정보 보호 담당자: [담당자 이름]

이메일: [이메일 주소]

전화번호: [전화번호]

주소: [쇼핑몰 주소]

9. 동의 및 철회
본 개인정보 수집 및 이용에 대해 동의하시면 "동의합니다" 버튼을 클릭하여 주십시오. 동의하지 않으실 경우 일부 서비스의 이용이 제한될 수 있습니다.
            </textarea>
            </div>
            <hr>
            <br>
            <div>
                <span>SMS 수신 동의(선택) <input type="checkbox" :checked="agree3 === 'Y'"
                        @change="updateAgree('agree3', $event)"></span>
                <span>이메일 수신 동의(선택) <input type="checkbox" :checked="agree4 === 'Y'"
                        @change="updateAgree('agree4', $event)"></span>
            </div>
            <hr>
            <br>
            <a href="/main.do" style="text-decoration: none"><span class="clb">취소</span></a>
            <a href="javascript:;" style="text-decoration: none"><span class="clb" @click="fnJoin()">회원가입하기</span></a>


        </div>


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        // Y ,N 형식으로
                        agree1: "N",
                        agree2: "N",
                        agree3: "N",
                        agree4: "N",
                        checked: false, //체크 온오프 용

                    };
                },
                computed: {

                },
                methods: {
                    updateAgree(agreeField, event) {
                        // 체크박스가 체크되면 'Y', 아니면 'N'
                        this[agreeField] = event.target.checked ? 'Y' : 'N';
                    },
                    fnAllCheck: function () {
                        let self = this;
                        self.checked = !self.checked;
                        if (self.checked) {
                            self.agree1 = "Y";
                            self.agree2 = "Y";
                            self.agree3 = "Y";
                            self.agree4 = "Y";

                        } else {
                            self.agree1 = "N";
                            self.agree2 = "N";
                            self.agree3 = "N";
                            self.agree4 = "N";
                        }

                    },
                    fnJoin: function(){
                        let self = this;
                        if(self.agree1=="N" || self.agree2=="N"){
                            alert("필수 동의란을 체크해주십시오.")
                            reurn;
                        }

                pageChange("/user/join.do", {agree1 : self.agree1 , agree2 : self.agree2, agree3 : self.agree3 , agree4 : self.agree4});
                // pageChange ("보낼 주소" / 키:밸류)
            }
                },
                mounted() {
                    

                }
            });

            app.mount("#app");
        });
    </script>