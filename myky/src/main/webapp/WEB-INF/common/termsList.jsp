<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_1@1.0/font.css">
        <title>회사 정보</title>
        <style>
            .terms-box {
                font-family: 'NanumSquareRoundLight', sans-serif;
                border: 1px solid #ccc;
                /* 회색 테두리 */
                padding: 30px;
                margin: 50px auto;
                border-radius: 12px;
                background-color: #fdfdfd;
                max-width: 800px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }

            .terms-box h2 {
                margin-top: 0;
                color: #0b1551;
                font-size: 24px;
                margin-bottom: 20px;
                font-family: 'NanumSquareRoundLight', sans-serif;
            }
        </style>
    </head>

    <body>
        <jsp:include page="/WEB-INF/common/header.jsp" />

        <div id="app">
            <!-- 약관 제목 및 내용 출력 -->
            <div class="terms-box" v-if="selectedItem">
                <div v-html="selectedItem.content"></div>
            </div>
            <div v-else>
                해당 약관을 찾을 수 없습니다.
            </div>

        </div>

        <jsp:include page="/WEB-INF/common/footer.jsp" />
    </body>

    <script>
        const app = Vue.createApp({
            data() {
                return {
                    list: [],             // 전체 약관 리스트
                    selectedType: "",     // URL에서 가져온 type 값
                };
            },
            computed: {
                selectedItem() {
                    if (!this.list || this.list.length === 0) return null;

                    const type = this.selectedType;
                    let matched = [];

                    if (type === 'service') {
                        matched = this.list
                            .filter(item => item.category === 'J')
                            .sort((a, b) => new Date(b.regDate) - new Date(a.regDate)); // 최신순 정렬
                        return matched.length ? matched[0] : null;

                    } else if (type === 'privacy') {
                        matched = this.list
                            .filter(item => item.category === 'D')
                            .sort((a, b) => new Date(a.regDate) - new Date(b.regDate)); // 🔄 오래된 순
                        return matched.length ? matched[matched.length - 1] : null; // 🔚 제일 마지막
                    }
                    else if (type === 'guide') {
                        matched = this.list
                            .filter(item => item.category === 'D')
                            .sort((a, b) => new Date(a.regDate) - new Date(b.regDate)); // 🔼 오래된 순
                        return matched.length ? matched[0] : null; // 🔝 첫 번째
                    }

                    return null;
                }


            }



            ,
            methods: {
                fnView() {
                    const params = new URLSearchParams(window.location.search);
                    this.selectedType = params.get("type") || "";
                    //console.log("🌐 URL로부터 받은 selectedType:", this.selectedType);

                    $.ajax({
                        url: "/membership/termsList.dox",
                        type: "POST",
                        dataType: "json",
                        success: (data) => {
                            this.list = data.list;
                        }
                    });
                }
            },
            mounted() {
                const params = new URLSearchParams(window.location.search);
                this.selectedType = params.get("type") || "";

                this.fnView();
            }
        });

        app.mount('#app');
    </script>