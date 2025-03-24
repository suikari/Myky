package teamgyodong.myky.pay;

/*
 * 결제 완료 및 결제 DB 저장 확인
 * 
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
	             };
	        },
	        computed: {
	
	        },
	        methods: {
	        	fnPayment:function(){
	                var self = this;
	
	                if (typeof IMP === 'undefined') {
	                    console.error('IMP is not initialized');
	                    return;
	                }
	
	                IMP.request_pay({
	                    channelKey: "channel-key-ab7c2410-b7df-4741-be68-1bcc35357d9b",
	                    pg: "html5_inicis",
	                    pay_method: "card",
	                    merchant_uid: "merchant_" + new Date().getTime(),
	                    name: "결제 설명",
	                    amount: amount, // 결제 금액
	                    buyer_tel: self.userInfo.phoneNumber, //유저 휴대폰 번호
	                }, function (rsp) {
	                    if (rsp.success) {
	                        alert("결제 성공");
	                        console.log("결제 정보 >>> "+rsp);
	                    } else {
	                        alert("결제에 실패했습니다.");
	                        console.log("결제 정보 >>> "+rsp.error_msg);
	                    }
	                });
	            },
	            fnPaymentHistory:function(rsp){
	                let self = this;
	                
	                let paymentMethod = "";
	                if(rsp.pay_method == "card"){
	                    paymentMethod = rsp.pay_method+"-"+rsp.card_name;
	                } else {
	                    paymentMethod = rsp.pay_method;
	                }
	                
	                console.log("paymentMethod >>> "+paymentMethod);
					// ex) paymentMethod >>> card-우리카드
	
	                var nparmap = {
	                    paymentCode: rsp.merchant_uid,
	                    description: rsp.name,
	                    amount: rsp.paid_amount,
	                    paymentMethod: paymentMethod, // 결제 수단 정보
	                    installment: null, // 할부개월수
	                    subscriptionPeriod: null, // 구독개월수
	                    paymentStatus: rsp.status, // 결제 상태
	                    isCanceled: "N", // 결제 취소 여부
                    	cancelDate: null, // 결제 취소 일시
	                    productId: null, // 상품 코드
	                    donationId: null, // 후원 코드
	                    userId: userId // 유저ID (ex. self.userInfo.userId)
	                };
		            $.ajax({
		                url: "/payment.dox",
		                dataType: "json",
		                type: "POST",
		                data: nparmap,
		                success: function (data) {
	                    	console.log("결제 정보 저장 여부 >>> "+data.result);
	                	}
	            	});
            	}
       		},
	       	mounted() {
	       	}
		});

	    app.mount("#app");
	});
</script>
 *
 */