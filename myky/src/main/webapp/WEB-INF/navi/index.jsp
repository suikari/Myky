<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>   
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8.4.7/swiper-bundle.min.css" />
    <script src="https://unpkg.com/vue@3.2.47/dist/vue.global.js"></script> 
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38d0c3995bfe828613ade0d7e4b8248e"></script>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .container {
            display: flex;
            height: 100vh;
        }
        .sidebar {
            width: 300px;
            background-color: #2d2d2d;
            color: white;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .sidebar select, .sidebar input, .sidebar button {
            padding: 10px;
            border-radius: 5px;
            border: none;
            width: 100%;
        }
        .sidebar button {
            background-color: #e74c3c;
            color: white;
            cursor: pointer;
        }
        .map-container {
            flex: 1;
            height: 100%;
        }
        #map {
            width: 100%;
            height: 100%;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div id="app" class="container">
        <!-- 사이드바 -->
        <aside class="sidebar">
            <h2 class="text-xl font-bold text-center">병원/약국 찾기</h2>
            <select v-model="selectedCity">
                <option disabled value="">시/도 선택</option>
                <option v-for="city in cities" :key="city">{{ city }}</option>
            </select>

            <select v-model="selectedDistrict" :disabled="!selectedCity">
                <option disabled value="">시/군/구 선택</option>
                <option v-for="district in districts[selectedCity] || []" :key="district">{{ district }}</option>
            </select>

            <input v-model="searchQuery" type="text" placeholder="병원(약국)명 입력">
            <button @click="search">검색</button>
        </aside>

        <!-- 지도 -->
        <div class="map-container">
            <div id="map"></div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp"/>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        selectedCity: "",
                        selectedDistrict: "",
                        searchQuery: "",
                        map: null,
                        cities: ["서울", "부산", "대구", "인천"],
                        districts: {
                            "서울": ["강남구", "서초구", "송파구"],
                            "부산": ["해운대구", "서구"],
                            "대구": ["중구", "동구"],
                            "인천": ["남동구", "연수구"]
                        }
                    };
                },
                methods: {
                    search() {
                        console.log("검색:", this.selectedCity, this.selectedDistrict, this.searchQuery);
                        // 검색 결과를 바탕으로 마커 추가 가능
                    }
                },
                mounted() {
                    // 카카오맵 초기화
                    
                        let container = document.getElementById('map');
					    let options = { 
					        center: new kakao.maps.LatLng(37.490920171395985, 126.72078754716765), 
					        level: 3 
					        // disableClickZoom: true //
					    };
					
					    let map = new kakao.maps.Map(container, options); 
					    let markerPosition  = new kakao.maps.LatLng(37.490920171395985, 126.72078754716765); 
					
                }
            });

            app.mount("#app");
        });
    </script>
</body>
</html>