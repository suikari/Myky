<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>멍냥꽁냥 후원완료</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
        <link rel="stylesheet" type="text/css" href="/css/donation/donation.css" />

        <style>
            
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />



        <div id="app" class="container">

            <div class="donation-summary-container">
                <h2 class="donation-summary-title">후원이 완료되었습니다!</h2>

                <div class="donation-summary-card">
                    <div class="donation-summary-item">
                        <span class="donation-summary-label">후원자명</span>
                        <span class="donation-summary-value">{{ summary.anonymousYn === 'Y' ? '익명' : summary.nickName
                            }}</span>
                    </div>
                    <div class="donation-summary-item">
                        <span class="donation-summary-label">후원 센터</span>
                        <span class="donation-summary-value">{{ summary.centerName }}</span>
                    </div>
                    <div class="donation-summary-item">
                        <span class="donation-summary-label">후원 금액</span>
                        <span class="donation-summary-value">{{ formatPrice(summary.amount) }}원</span>
                    </div>
                    <div class="donation-summary-item">
                        <span class="donation-summary-label">후원 일시</span>
                        <span class="donation-summary-value">{{ summary.donationDate }}</span>
                    </div>
                    <div class="donation-summary-item" v-if="summary.message">
                        <span class="donation-summary-label">남긴 메시지</span>
                        <span class="donation-summary-value">"{{ summary.message }}"</span>
                    </div>
                </div>

                <div class="donation-summary-thanks">
                    진심으로 감사드립니다.
                    소중한 후원이 큰 힘이 됩니다!
                </div>

                <div class="donation-summary-buttons">
                    <button @click="goToHome">홈으로 가기</button>
                    <button @click="goToHistory">후원 내역 보기</button>
                </div>
            </div>

        </div>
        <!-- app 종료 -->


        <jsp:include page="/WEB-INF/common/footer.jsp" />


    </body>

    </html>
    <script>

        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        userId: "${map.userId}",
                        donationId: "${map.donationId}",
                        summary: {}

                    };
                },
                computed: {

                },
                methods: {

                    fnGetDonationInfo: function () {
                        let self = this;
                        let params = { userId: self.userId, donationId: self.donationId };
                        $.ajax({
                            url: "/donation/complete.dox",
                            dataType: "json",
                            type: "POST",
                            data: params,
                            success: function (data) {
                                self.summary = data.info;
                            }
                        });
                    },
                    formatPrice(value) {
                        return Number(value).toLocaleString();
                    },
                    goToHome() {
                        window.location.href = "/main.do";
                    },
                    goToHistory() {
                        pageChange("/user/mypage.do",{paramsTab: "donation"});
                    },
                    initTinkerbellSparkle() {
                        const sparkles = 80;
                        let x = 400, y = 300, ox = 400, oy = 300;
                        let swide = window.innerWidth, shigh = window.innerHeight;
                        let sdown = 0, sleft = 0;
                        let tiny = [], star = [], starv = [], tinyv = [], starx = [], stary = [], tinyx = [], tinyy = [];

                        function createDiv(height, width, className = "") {
                            const div = document.createElement("div");
                            div.style.position = "absolute";
                            div.style.height = height + "px";
                            div.style.width = width + "px";
                            div.style.overflow = "hidden";
                            div.style.zIndex = "9999";
                            if (className) div.className = className;
                            return div;
                        }

                        function newColour() {
                            const c = [255, Math.floor(Math.random() * 256), Math.floor(Math.random() * 128)];
                            c.sort(() => 0.5 - Math.random());
                            return "rgb(" + c[0] + ", " + c[1] + ", " + c[2] + ")";
                        }

                        function setScroll() {
                            sdown = window.scrollY || document.documentElement.scrollTop || document.body.scrollTop || 0;
                            sleft = window.scrollX || document.documentElement.scrollLeft || document.body.scrollLeft || 0;
                        }

                        function setWidth() {
                            swide = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth || 800;
                            shigh = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight || 600;
                        }
                        
                        function sparkle() {
                            if (Math.abs(x - ox) > 1 || Math.abs(y - oy) > 1) {
                                ox = x; oy = y;
                                for (let c = 0; c < sparkles; c++) {
                                    if (!starv[c]) {
                                        star[c].style.left = (starx[c] = x) + "px";
                                        star[c].style.top = (stary[c] = y + 1) + "px";
                                        star[c].style.clip = "rect(0px, 5px, 5px, 0px)";
                                        const color = newColour();
                                        star[c].childNodes[0].style.backgroundColor = star[c].childNodes[1].style.backgroundColor = color;
                                        star[c].style.visibility = "visible";
                                        starv[c] = 80;
                                        break;
                                    }
                                }
                            }

                            for (let c = 0; c < sparkles; c++) {
                                if (starv[c]) update_star(c);
                                if (tinyv[c]) update_tiny(c);
                            }

                            requestAnimationFrame(sparkle);
                        }

                        function update_star(i) {
                            if (--starv[i] === 25)
                                star[i].style.clip = "rect(1px, 4px, 4px, 1px)";
                            if (starv[i]) {
                                stary[i] += 0.5 + Math.random() * 1;
                                starx[i] += (i % 5 - 2) / 5;
                                if (stary[i] < shigh + sdown) {
                                    star[i].style.top = stary[i] + "px";
                                    star[i].style.left = starx[i] + "px";
                                } else {
                                    star[i].style.visibility = "hidden";
                                    starv[i] = 0;
                                }
                            } else {
                                tinyv[i] = 80;
                                tiny[i].style.top = (tinyy[i] = stary[i]) + "px";
                                tiny[i].style.left = (tinyx[i] = starx[i]) + "px";
                                tiny[i].style.width = "2px";
                                tiny[i].style.height = "2px";
                                tiny[i].style.backgroundColor = star[i].childNodes[0].style.backgroundColor;
                                tiny[i].style.visibility = "visible";
                                star[i].style.visibility = "hidden";
                            }
                        }

                        function update_tiny(i) {
                            if (--tinyv[i] === 25) {
                                tiny[i].style.width = "1px";
                                tiny[i].style.height = "1px";
                            }
                            if (tinyv[i]) {
                                tinyy[i] += 0.5 + Math.random() * 1;
                                tinyx[i] += (i % 5 - 2) / 5;
                                if (tinyy[i] < shigh + sdown) {
                                    tiny[i].style.top = tinyy[i] + "px";
                                    tiny[i].style.left = tinyx[i] + "px";
                                } else {
                                    tiny[i].style.visibility = "hidden";
                                    tinyv[i] = 0;
                                }
                            } else {
                                tiny[i].style.visibility = "hidden";
                            }
                        }

                        function init() {
                            for (let i = 0; i < sparkles; i++) {
                                let tinyDiv = createDiv(3, 3, "sparkle-tiny");
                                tinyDiv.style.visibility = "hidden";
                                document.body.appendChild(tiny[i] = tinyDiv);

                                let starDiv = createDiv(5, 5, "sparkle-star");
                                starDiv.style.visibility = "hidden";
                                let rlef = createDiv(1, 5);
                                let rdow = createDiv(5, 1);
                                rlef.style.top = "2px"; rlef.style.left = "0px";
                                rdow.style.top = "0px"; rdow.style.left = "2px";
                                starDiv.appendChild(rlef);
                                starDiv.appendChild(rdow);
                                document.body.appendChild(star[i] = starDiv);

                                starv[i] = 0; tinyv[i] = 0;
                            }

                            document.addEventListener("mousemove", function (e) {
                                x = e.pageX;
                                y = e.pageY;
                            });

                            setWidth();
                            setScroll();
                            window.onresize = setWidth;
                            window.onscroll = setScroll;

                            sparkle();
                        }

                        init();
                    }
                },
                mounted() {
                    this.fnGetDonationInfo();

                    this.initTinkerbellSparkle();
                }
            });

            app.mount("#app");
        });
    </script>