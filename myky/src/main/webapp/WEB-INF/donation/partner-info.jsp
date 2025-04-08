<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" class="partner-page">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 제휴처 소개</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b11d0cfc04c4c20450d241190fb11da0"></script> -->
    <link rel="stylesheet" type="text/css" href="/css/partner/partner.css" />

    <script>
        function loadKakaoMapScript() {
            if (window.kakao && window.kakao.maps) {
                return;
            }
            const script = document.createElement("script");
            script.src =
                "https://dapi.kakao.com/v2/maps/sdk.js?appkey=b11d0cfc04c4c20450d241190fb11da0&autoload=false";
            script.async = true;
            script.onload = () => {
                kakao.maps.load(() => {
                console.log("✅ 카카오맵 로드 완료!");
                });
            };
            document.head.appendChild(script);
        }
      
        loadKakaoMapScript();
    </script>

    <style>
    
    </style>
</head>
<body class="partner-body">
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 

    <div id="app" class="partner-container">
        <div class="partner-list">
            <h2 class="partner-list__title">제휴처 소개</h2>
            <input type="text" v-model="searchKeyword" @keyup.enter="fnPartnerSearch" class="partner-search-input" placeholder="검색어 입력..." />
            <button @click="fnPartnerSearch" class="partner-search-button">검색</button>
            <div class="category-buttons">
                <button @click="filterByCategory(null)">전체</button>
                <button @click="filterByCategory(1)" :class="{ active: categoryCode === 1 }">숙소</button>
                <button @click="filterByCategory(2)" :class="{ active: categoryCode === 2 }">식당</button>
                <button @click="filterByCategory(3)" :class="{ active: categoryCode === 3 }">관광지</button>
                <button @click="filterByCategory(4)" :class="{ active: categoryCode === 4 }">편의시설</button>
            </div>
            <div class="partner-grid" v-if="partners.length > 0">
                <div v-for="partner in partners" :key="partner.partnerdetailId" class="partner-card">
                    <h2 class="partner-name">{{ partner.name }}</h2>
                    <p class="partner-address">📍 {{ partner.address }}</p>
                    <p class="partner-phone">📞 {{ partner.phoneNumber }}</p>
                    <p v-if="partner.websiteUrl"  class="partner-website">
                        🔗 <a :href="normalizedUrl(partner.websiteUrl)" target="_blank">웹사이트 방문</a>
                    </p>
                    <p class="partner-hours">🕒 운영시간: {{ partner.openingHours }}</p>
                    <p class="partner-holiday">🚫 휴무일: {{ partner.regularHoliday || '없음' }}</p>
                    <button @click="showMap(partner)" class="map-button">지도에서 보기</button>
                </div>
            </div>
            <div class="no-result" v-else>
                😿 검색 결과가 없습니다.
            </div>
            <div class="partner-pagination">
                <button @click="fnPageMove('prev')" :disabled="page === 1">이전</button>
                <button @click="fnBlockMove('prev')" :disabled="pageBlocks[0] === 1">«</button>
          
                <button v-for="num in pageBlocks" :key="num" @click="fnPage(num)" :class="{ active: num === page }">
                  {{ num }}
                </button>
          
                <button @click="fnBlockMove('next')" :disabled="pageBlocks[pageBlocks.length - 1] === index">»</button>
                <button @click="fnPageMove('next')" :disabled="page === index">다음</button>
            </div>
        
            <!-- 카카오맵 모달 -->
            <div v-if="showingMap" class="map-modal" @click.self="closeMap">
                <div class="map-container">
                    <button @click="closeMap" class="map-close-button">&times;</button>
                    <div id="partner-map" style="width:100%;height:350px;"></div>
                </div>
            </div>
        </div>

    </div>


	<jsp:include page="/WEB-INF/common/footer.jsp"/>

    
</body>
</html>
<script>

    document.addEventListener("DOMContentLoaded", function () {
        const app = Vue.createApp({
            data() {
                return {
                    partners: [],
                    showingMap: false,
                    currentPartner: null,
                    searchKeyword:"",
                    categoryCode: null,
                    page: 1,
                    pageSize: 8,
                    index: 1,
                    blockSize: 5
                };
            },
            computed: {
                pageBlocks() {
                    const start = Math.floor((this.page - 1) / this.blockSize) * this.blockSize + 1;
                    const end = Math.min(start + this.blockSize - 1, this.index);
                    let pages = [];
                    for (let i = start; i <= end; i++) {
                        pages.push(i);
                    }
                    return pages;
                },
            },
            methods: {
                fnPartnerInfo:function(){
                    var self = this;
                    var nparmap = {
                        searchKeyword: self.searchKeyword,
                        categoryCode: self.categoryCode,
                        page: (self.page - 1) * self.pageSize,
                        pageSize: self.pageSize,
                    };
                    $.ajax({
                        url: "/partner/info.dox",
                        dataType: "json",
                        type: "POST",
                        data: nparmap,
                        success: function (data) {
                            console.log("제휴처 정보 >>> ",data);
                            if(data.result == "success"){
                                self.partners = data.partnerList;
                                if (data.count !== undefined) {
                                    self.index = data.count ? Math.ceil(data.count / self.pageSize) : 0;
                                    console.log("index >>> ",self.index);
                                } else {
                                    self.index = 0;
                                    console.log("count 정보 없음!", data);
                                }
                            }
                        }
                    });
                },
                fnPartnerSearch:function(){
                    this.page = 1;
                    this.fnPartnerInfo();
                },
                fnPage(num) {
                    this.page = num;
                    this.fnPartnerInfo();
                },
                fnPageMove(direction) {
                    if (direction === "next" && this.page < this.index) this.page++;
                    else if (direction === "prev" && this.page > 1) this.page--;
                    this.fnPartnerInfo();
                },
                fnBlockMove(direction) {
                    const currentBlock = Math.floor((this.page - 1) / this.blockSize);
                    if (direction === "prev" && currentBlock > 0) {
                        this.page = (currentBlock - 1) * this.blockSize + 1;
                    } else if (direction === "next" && (currentBlock + 1) * this.blockSize < this.index) {
                        this.page = (currentBlock + 1) * this.blockSize + 1;
                    }
                    this.fnPartnerInfo();
                },
                normalizedUrl(url) {
                    if (!url) return '#';
                    url = url.trim();
                    if (url.startsWith('http://') || url.startsWith('https://')) {
                    return url;
                    }
                    if (url.startsWith('www.')) {
                    return 'https://' + url;
                    }
                    return 'https://' + url;
                },
                filterByCategory(code) {
                    this.categoryCode = code;
                    this.page = 1;
                    this.fnPartnerInfo();
                },
                showMap(partner) {
                    this.showingMap = true;
                    this.$nextTick(() => {
                        const container = document.getElementById("partner-map");
                        const options = {
                        center: new kakao.maps.LatLng(partner.NY, partner.NX),
                        level: 3
                        };
                        const map = new kakao.maps.Map(container, options);

                        new kakao.maps.Marker({
                        map: map,
                        position: new kakao.maps.LatLng(partner.NY, partner.NX)
                        });
                    });
                },
                closeMap() {
                    this.showingMap = false;
                }
            },
            mounted() {
                let self = this;

                self.fnPartnerInfo();
                
            }
        });

        app.mount("#app");
    });
</script>
