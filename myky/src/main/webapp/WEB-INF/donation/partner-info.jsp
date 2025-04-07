<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>멍냥꽁냥 제휴처 소개</title>
	<!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
	<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b11d0cfc04c4c20450d241190fb11da0"></script> -->
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
    .partner-container {max-width: 1280px;margin: 0 auto;padding: 20px;}
    .partner-list {padding: 20px;text-align: center;}
    .partner-list__title {font-size: 24px;margin-bottom: 40px;}
    .partner-grid {display: grid;grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));gap: 15px;}
    .partner-card {background: #fffcfa;padding: 15px;border-radius: 10px;box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);text-align: left;}
    .partner-name {font-size: 18px;font-weight: bold;margin-bottom: 5px;}
    .partner-address, .partner-phone, .partner-hours, .partner-holiday {font-size: 14px;color: #555;}
    .map-modal {position: fixed;top: 0;left: 0;width: 100%;height: 100%;background: rgba(0,0,0,0.5);display: flex;align-items: center;justify-content: center;z-index: 999;}
    .map-container {background: #fff;border-radius: 12px;overflow: hidden;width: 80%;max-width: 500px;position: relative;padding-top: 40px;}
    .map-close-button {position: absolute;top: 10px;right: 10px;width: 35px;height: 35px;background: white;color: black;font-size: 24px;border: 2px solid #ccc;border-radius: 50%;cursor: pointer;display: flex;align-items: center;justify-content: center;z-index: 1000;box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);}
    .map-close-button:hover {background: #dadada;border-color: #575757;color: #575757;}
    .map-button {margin-top: 10px;padding: 6px 12px;background: #FF8C42;color: white;border: none;border-radius: 6px;cursor: pointer;}
    .map-button:hover {background: #e07b3e;}
    .pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-wrap: wrap;
    gap: 8px;
    margin-top: 30px;
}

.pagination button {
    background-color: #fff6f2;
    border: 1px solid #ffcdb2;
    color: #d46a3d;
    padding: 8px 14px;
    border-radius: 12px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s ease-in-out;
    box-shadow: 0 2px 4px rgba(0,0,0,0.06);
}

.pagination button:hover:not(:disabled) {
    background-color: #ffe4d3;
    border-color: #ffa878;
    color: #b4552a;
}

.pagination button.active {
    background-color: #FF8C42;
    color: white;
    font-weight: bold;
    border-color: #ff8c42;
    box-shadow: 0 2px 6px rgba(255, 140, 66, 0.4);
}

.pagination button:disabled {
    background-color: #f5f5f5;
    color: #aaa;
    border-color: #ddd;
    cursor: not-allowed;
    box-shadow: none;
}
.partner-website a {
    text-decoration: none;
    color: #FF8C42;
    font-weight: bold;
}
.partner-website a:hover {
    color: #e07b3e;
}
.no-result {
    margin-top: 30px;
    font-size: 16px;
    color: #888;
}
.category-buttons {
    margin: 20px 0;
    text-align: center;
}

.category-buttons button {
    margin: 5px;
    padding: 8px 14px;
    background-color: #FF8C42;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 14px;
}

.category-buttons button:hover {
    background-color: #e07b3e;
}

.category-buttons button.active {
    background-color: #d16d2e;
    font-weight: bold;
}

.partner-search-input {
    padding: 8px 14px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 6px;
    width: 220px;
    outline: none;
    transition: border-color 0.3s;
    flex-shrink: 0;
}

.partner-search-button {
    padding: 8px 16px;
    font-size: 14px;
    background-color: #FF8C42;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    transition: background-color 0.3s;
    flex-shrink: 0;
    z-index: 2;
}

.partner-search-input:focus {
    border-color: #FF8C42;
}

.partner-search-button:hover {
    background-color: #e07b3e;
}
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/common/header.jsp"/>
 


    <div id="app" class="partner-container">
        <div class="partner-list">
            <h2 class="partner-list__title">제휴처 소개</h2>
            <div>
                <input type="text" v-model="searchKeyword" @keyup.enter="fnPartnerSearch" class="partner-search-input" placeholder="검색어 입력..." />
                <button @click="fnPartnerSearch" class="partner-search-button">검색</button>
            </div>
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
                        🔗 <a :href="partner.websiteUrl" target="_blank">웹사이트 방문</a>
                    </p>
                    <p class="partner-hours">🕒 운영시간: {{ partner.openingHours }}</p>
                    <p class="partner-holiday">🚫 휴무일: {{ partner.regularHoliday || '없음' }}</p>
                    <button @click="showMap(partner)" class="map-button">지도에서 보기</button>
                </div>
            </div>
            <div class="no-result" v-else>
                😿 검색 결과가 없습니다.
            </div>
            <div class="pagination">
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
                    <div id="map" style="width:100%;height:300px;"></div>
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
                filterByCategory(code) {
                    this.categoryCode = code;
                    this.page = 1;
                    this.fnPartnerInfo();
                },
                showMap(partner) {
                    this.showingMap = true;
                    this.$nextTick(() => {
                        const container = document.getElementById("map");
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
