<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
   <script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.js"></script> 
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800c01d76232f2ef59e7ddffd882cefb&libraries=services"></script>
    <script>
        Kakao.init('800c01d76232f2ef59e7ddffd882cefb'); // 사용하려는 앱의 JavaScript 키 입력
      </script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script> -->
    <title>첫번째 페이지</title>
    <style>
        html, body { width: 100%; height: 100%; margin: 0; padding: 0; }
        .map_wrap { position: relative; overflow: hidden; width: 100%; height: 100%; }
        .radius_border { border: 1px solid #919191; border-radius: 5px; }
        .custom_typecontrol { position: absolute; top: 10px; right: 10px; overflow: hidden; width: 130px; height: 30px; margin: 0; padding: 0; z-index: 1; font-size: 12px; font-family: 'Malgun Gothic', '맑은 고딕', sans-serif; }
        .custom_typecontrol span { display: block; width: 65px; height: 30px; float: left; text-align: center; line-height: 30px; cursor: pointer; }
        .custom_typecontrol .btn { background: #fff; background: linear-gradient(#fff, #e6e6e6); }
        .custom_typecontrol .btn:hover { background: #f5f5f5; background: linear-gradient(#f5f5f5, #e3e3e3); }
        .custom_typecontrol .btn:active { background: #e6e6e6; background: linear-gradient(#e6e6e6, #fff); }
        .custom_typecontrol .selected_btn { color: #fff; background: #425470; background: linear-gradient(#425470, #5b6d8a); }
        .custom_typecontrol .selected_btn:hover { color: #fff; }
        .custom_zoomcontrol { position: absolute; top: 50px; right: 10px; width: 36px; height: 80px; overflow: hidden; z-index: 1; background-color: #f5f5f5; }
        .custom_zoomcontrol span { display: block; width: 36px; height: 40px; text-align: center; cursor: pointer; }
        .custom_zoomcontrol span img { width: 15px; height: 15px; padding: 12px 0; border: none; }
        .custom_zoomcontrol span:first-child { border-bottom: 1px solid #bfbfbf; }
        .map_wrap, .map_wrap * { margin: 0; padding: 0; font-family: 'Malgun Gothic', dotum, '돋움', sans-serif; font-size: 12px; }
        .map_wrap a, .map_wrap a:hover, .map_wrap a:active { color: #000; text-decoration: none; }
        .map_wrap { position: relative; width: 100%; height: 100%; }
        #menu_wrap { position: absolute; top: 0; left: 0; bottom: 0; width: 250px; margin: 10px 0 30px 10px; padding: 5px; overflow-y: auto; background: rgba(255, 255, 255, 0.7); z-index: 1; font-size: 12px; border-radius: 10px;  max-height: 500px;}
        .bg_white { background: #fff; }
        #menu_wrap hr { display: block; height: 1px; border: 0; border-top: 2px solid #5F5F5F; margin: 3px 0; }
        #menu_wrap .option { text-align: center; }
        #menu_wrap .option p { margin: 10px 0; }
        #menu_wrap .option button { margin-left: 5px; }
        #placesList li { list-style: none; }
        #placesList .item { position: relative; border-bottom: 1px solid #888; overflow: hidden; cursor: pointer; min-height: 65px; }
        #placesList .item span { display: block; margin-top: 4px; }
        #placesList .item h5, #placesList .item .info { text-overflow: ellipsis; overflow: hidden; white-space: nowrap; }
        #placesList .item .info { padding: 10px 0 10px 55px; }
        #placesList .info .gray { color: #8a8a8a; }
        #placesList .info .jibun { padding-left: 26px; background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat; }
        #placesList .info .tel { color: #009900; }
        #placesList .item .markerbg { float: left; position: absolute; width: 36px; height: 37px; margin: 10px 0 0 10px; background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat; }
        #placesList .item .marker_1 { background-position: 0 -10px; }
        #placesList .item .marker_2 { background-position: 0 -56px; }
        #placesList .item .marker_3 { background-position: 0 -102px; }
        #placesList .item .marker_4 { background-position: 0 -148px; }
        #placesList .item .marker_5 { background-position: 0 -194px; }
        #placesList .item .marker_6 { background-position: 0 -240px; }
        #placesList .item .marker_7 { background-position: 0 -286px; }
        #placesList .item .marker_8 { background-position: 0 -332px; }
        #placesList .item .marker_9 { background-position: 0 -378px; }
        #placesList .item .marker_10 { background-position: 0 -423px; }
        #placesList .item .marker_11 { background-position: 0 -470px; }
        #placesList .item .marker_12 { background-position: 0 -516px; }
        #placesList .item .marker_13 { background-position: 0 -562px; }
        #placesList .item .marker_14 { background-position: 0 -608px; }
        #placesList .item .marker_15 { background-position: 0 -654px; }
        #pagination { margin: 10px auto; text-align: center; }
        #pagination a { display: inline-block; margin-right: 10px; }
        #pagination .on { font-weight: bold; cursor: default; color: #777; }
        #app{ height : 100%;
            width: 100%;
        }
        #map {
    width: 100%;
    height: 100%; /* 지도 크기 100%로 설정 */
}
#category {
    position: absolute;
    top: 10px;
    right: 10px; /* 왼쪽에서 오른쪽으로 위치 변경 */
    border-radius: 5px;
    border: 1px solid #909090;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
    background: #fff;
    overflow: hidden;
    z-index: 2;
}

#category li {
    float: left;
    list-style: none;
    width: 50px;
    border-right: 1px solid #acacac;
    padding: 6px 0;
    text-align: center;
    cursor: pointer;
}

#category li.on {
    background: #eee;
}

#category li:hover {
    background: #ffe6e6;
    border-left: 1px solid #acacac;
    margin-left: -1px;
}

#category li:last-child {
    margin-right: 0;
    border-right: 0;
}

#category li span {
    display: block;
    margin: 0 auto 3px;
    width: 27px;
    height: 28px;
}

#category li .category_bg {
    background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;
}

#category li .accommodation  {
    background-position: -10px 0;
}

#category li .mart {
    background-position: -10px -36px;
}

#category li .pharmacy {
    background-position: -10px -72px;
}

#category li .oil {
    background-position: -10px -108px;
}

#category li .cafe {
    background-position: -10px -144px;
}

#category li .store {
    background-position: -10px -180px;
}

#category li.on .category_bg {
    background-position-x: -46px;
}
/* 즐겨찾기 추가된 상태 */
button#favoritesButton.favorite {
  color: gold;
}

/* 즐겨찾기 안 된 상태 */
button#favoritesButton.not-favorite {
  color: grey;
}
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="app">
        <div class="map_wrap">
            <div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
            <ul id="category">
                <li id="MT1" data-order="0" @click="filterByCategory(1)"> 
                    <span class="category_bg accommodation"></span>
                    숙소
                </li>       
                <li id="MT1" data-order="1" @click="filterByCategory(2)"> 
                    <span class="category_bg mart"></span>
                    식당
                </li>  
                <li id="PM9" data-order="2" @click="filterByCategory(3)"> 
                    <span class="category_bg pharmacy"></span>
                    관광지
                </li>  
                <li id="OL7" data-order="3" @click="filterByCategory(4)"> 
                    <span class="category_bg oil"></span>
                    편의시설
                </li>   
            </ul>
            <div id="menu_wrap" class="bg_white">
                
                <div class="option">
                    <form @submit.prevent="updateMap"> <!-- form의 submit 이벤트를 updateMap으로 변경 -->
                        시 : 
                        <select v-model="selectsi" @change="fnsi">
                            <option value="">선택</option>
                            <option v-for="item in silist" :value="item.SI">{{ item.SI }}</option>
                        </select>
                        <select v-model="selectgu" @change="updateMap">
                            <option value="">선택</option>
                            <option v-for="item in gulist" :value="item">{{ item.GU }}</option>
                        </select>
                        <select v-model="selectdong" @change="updateMap">
                            <option value="">선택</option>
                            <option v-for="item in donglist" :value="item">{{ item.DONG }}</option>
                        </select>
                        <button @click="toggleFavoritesList" 
                            style="padding:10px; background:#FFD700; border:none; border-radius:5px; font-weight:bold; cursor:pointer;">
                            ⭐ 즐겨찾기 목록
                        </button>
                        <div>
                            검색 : <input v-model="keyword" type="text" placeholder="병원 이름을 검색하세요" @keyup.enter="searchPlaces" >
                        </div>
                        <button @click="searchPlaces">검색하기</button> <!-- type="submit"으로 유지 -->
                    </form>
                    
                </div>
                
                <button @click="moveToCurrentLocation">근처 병원 찾기</button>
                <hr>
                
                
                
                <ul id="placesList">
                    
                    
                    <!-- 병원 목록이 있을 때만 표시 -->
                    <div v-if="hoslist.length > 0 && !isFavoritesVisible" class="count">
                        총 {{ hoslist.length }}개 병원이 검색되었습니다.
                        <hr>
                    </div>
                    
                    <ul v-if="!isFavoritesVisible">
                        <li v-for="(hospital, index) in hoslist" :key="hospital.hospitalNo" @click="moveToLocation(hospital)">
                            <div>{{ hospital.hosName }}</div>
                            <span>{{ hospital.hosAddress }}</span>
                            <hr>
                        </li>
                    </ul>
                    
                    <div v-if="isFavoritesVisible" class="favorites-list">
                        <h3>⭐ 내 즐겨찾기 목록</h3>
                        <ul>
                            <!-- ✅ 병원 즐겨찾기 리스트 -->
                            <li v-for="favorite in favoritesList.filter(fav => fav.hospitalNo)" 
                                :key="'hospital-' + favorite.hospitalNo"  
                                @click="moveToLocation(favorite)">
                                <div>
                                    <strong>{{ favorite.hosName }}</strong> - {{ favorite.hosAddress }}
                                </div>
                                <button @click="fnRemoveFavorite(favorite.hospitalNo, favorite.hosName, favorite.hosAddress, userId)">
                                    ❌ 삭제
                                </button>
                                <hr>
                            </li>
                    
                            <!-- ✅ 파트너 즐겨찾기 리스트 -->
                            <li v-for="item in favoritesList.filter(fav => fav.partnerdetailId)" 
                                :key="'partner-' + item.partnerdetailId + '-' + item.userId"  
                                @click="moveToLocation(item)">
                                <div>
                                    <strong>{{ item.name }}</strong> - {{ item.address }}
                                </div>
                                <button @click="fnparRemoveFavorite(item.partnerdetailId, item.name, item.address, userId)">
                                    ❌ 삭제
                                </button>
                                <hr>
                            </li>
                        </ul>
                    </div>
                    
                    
                </ul>
                
                <div id="pagination">
                        
                </div>
                
                
            </div>
        </div>
    </div>
</body>
</html>

<script>
     var currentInfoWindow = null;
    const app = Vue.createApp({
    data() {
        
        return {
            partnerMarkers: [],  // 제휴사 마커 배열 초기화
            favoriteMarkers: [], // 즐겨찾기 마커 배열 초기화
            favoritesList: [],
            sessionId : "${sessionId}",
            userId: "${sessionId}",
            categoryCode : "",
            hosName : "",
            hosAddress : "",
            hospitalNo : "",
            partnerdetailId : "",
            keyword: "",
            websiteUrl : "",
            openingHours : "",
            places: [],
            isFavoritesVisible: false,
            isLoggedIn: false,
            markers: [],
            map: null,
            gulist: [],
            donglist: [],
            silist: [],
            hoslist: [],
            partnerlist : [],
            selectgu: {
                GU: "",
            },
            selectdong: {
                DONG: "",
            },
            selectsi: "인천광역시",
            pagination: {
            current: 1,  // 현재 페이지
            perPage: 5,  // 페이지당 아이템 수
            last: 1,     
           
        },
        // pageSize : 5,
        // page : 1
        category : ""
    };
    },
    methods: {
        isUserLoggedIn() {
        return !!this.user;  // user 객체가 존재하면 로그인 상태
    },
    //현재위치~
    getCurrentLocation() {
        return new Promise((resolve, reject) => {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(
            (position) => {
                const { latitude, longitude } = position.coords;
                resolve({ latitude, longitude });
            },
            (error) => {
                reject('위치 정보를 가져올 수 없습니다.');
            },
            {
                enableHighAccuracy: true, // 고정밀도 모드 사용
                timeout: 10000, // 타임아웃 설정 (10초)
                maximumAge: 0, // 이전 위치 정보를 사용할 수 없게 설정
            }
            );
        } else {
            reject('Geolocation은 이 브라우저에서 지원되지 않습니다.');
        }
        });
    },
// 📌 현재 위치를 기준으로 1km 이내의 병원만 마커로 추가하는 함수
addMarkersByCurrentLocation(currentLat, currentLng) {
    this.clearMarkers(); // 이전 마커 제거

    if (this.hoslist.length === 0) {
        console.warn("병원 리스트가 비어 있습니다.");
        return;
    }

    const radius = 1000; // 1km (1000미터)

    // 📌 병원 리스트 필터링 (1km 이내의 병원들만)
    const nearbyHospitals = this.hoslist.filter(hospital => {
        const hospitalLat = hospital.NY;
        const hospitalLng = hospital.NX;
        
        // 📌 위도 경도 거리 계산 (단순히 직선거리로 계산)
        const distance = this.calculateDistance(currentLat, currentLng, hospitalLat, hospitalLng);
        
        // 1km 이내의 병원만 필터링
        return distance <= radius;
    });

    if (nearbyHospitals.length === 0) {
        console.warn("1km 이내에 병원이 없습니다.");
        return;
    }

    nearbyHospitals.forEach((hospital) => {
        const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
        const marker = new kakao.maps.Marker({
            position: position,
            title: hospital.hosName
        });

        marker.setMap(this.map);

        kakao.maps.event.addListener(marker, "click", () => {
            this.showInfoWindowForSelect(marker, hospital);
        });

        this.markers.push(marker);
    });
},

// 📌 두 좌표 간 거리 계산 함수 (단위: 미터)
calculateDistance(lat1, lng1, lat2, lng2) {
    const radian = Math.PI / 180;
    const R = 6371e3; // 지구의 반지름 (미터 단위)
    
    const φ1 = lat1 * radian;
    const φ2 = lat2 * radian;
    const Δφ = (lat2 - lat1) * radian;
    const Δλ = (lng2 - lng1) * radian;

    const a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
              Math.cos(φ1) * Math.cos(φ2) *
              Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    return R * c; // 미터 단위로 반환
},
async moveToCurrentLocation() {
        try {
        // 현재 위치를 가져옴
        const { latitude, longitude } = await this.getCurrentLocation();
        
        // 카카오맵의 LatLng 객체 생성
        const locPosition = new kakao.maps.LatLng(latitude, longitude);
        
        // 지도 중심을 현재 위치로 이동
        this.map.setCenter(locPosition);

        // 현재 위치를 기준으로 1km 이내의 병원만 마커로 추가
        this.addMarkersByCurrentLocation(latitude, longitude);

    } catch (error) {
        alert(error);
    }
        },

    searchNearbyHospitals(latitude, longitude) {
    const ps = new kakao.maps.services.Places(); // Places API
    const location = new kakao.maps.LatLng(latitude, longitude); // 현재 위치

    const options = {
        location: location,
        radius: 5000, // 반경 5km
        sort: kakao.maps.services.PlacesSortType.DISTANCE, // 가까운 순으로 정렬
    };

    ps.keywordSearch("병원", (data, status, pagination) => {
        if (status === kakao.maps.services.Status.OK) {
        // 병원 목록 data에 저장
        console.log(data);
        // 데이터 처리 로직 추가
        } else {
        console.error('병원 검색 실패:', status);
         }
    });
    },
    async findNearbyHospitals() {
        try {
            const { latitude, longitude } = await this.getCurrentLocation();
            this.searchNearbyHospitals(latitude, longitude);
        } catch (error) {
            console.error("현재 위치를 가져오는 데 실패했습니다:", error);
        }   
    },
   
    removeMarkers() {
    // 마커들을 제거하는 로직 추가
    this.markers.forEach(marker => marker.setMap(null));
    this.markers = [];  // 마커 배열 초기화
    },



 // 카테고리별 필터링 함수
 filterByCategory(categoryCode) {
    console.log("선택된 카테고리:", categoryCode);  // 여기서 선택된 category 값을 확인

    if (!categoryCode) {
        console.error("❌ 카테고리가 유효하지 않습니다.");
        return;
    }

    // 카테고리 코드로 partnerlist 필터링
    this.filteredPartnerlist = this.partnerlist.filter(partner => {
        return partner.categoryCode && partner.categoryCode === categoryCode;
    });

    if (this.filteredPartnerlist.length === 0) {
        console.log("🚫 해당 카테고리에 대한 제휴사가 없습니다.");
    } else {
        console.log("✅ 필터링된 제휴사 목록:", this.filteredPartnerlist);
    }

    // 필터링된 제휴사 목록을 지도에 표시
    this.displayPartnerPlaces(this.filteredPartnerlist);
}
,

displayPartnerPlaces(partnerlist) {
    // 제휴사 마커 삭제
    this.clearPartnerMarkers(); // 제휴사 마커만 삭제

    console.log("Displaying partner places:", partnerlist);

    // 카테고리별 마커 이미지 설정 함수
    const getMarkerImage = function(categoryCode) {
        let imageSrc = "";
        switch (categoryCode) {
            case 1:
                imageSrc = "../img/1.PNG";
                break;
            case 2:
                imageSrc = "../img/medi.png";
                break;
            case 3:
                imageSrc = "../img/2.PNG";
                break;
            case 4:
                imageSrc = "../img/Amenities.png";
                break;
            default:
                imageSrc = "../img/logo.png";
        }

        const img = new Image();
        img.src = imageSrc;

        img.onload = function() {
            console.log("✅ 이미지 로드 성공: " + imageSrc);
        };
        img.onerror = function() {
            console.error("❌ 이미지 로드 실패: " + imageSrc);
        };

        return imageSrc;
    };

    // 각 제휴사에 대해 마커 생성
    partnerlist.forEach(partner => {
        if (partner.NY && partner.NX) {  // 좌표가 존재하는 경우만 처리
            var position = new kakao.maps.LatLng(partner.NY, partner.NX);

            // 🖼 마커 이미지 설정 (카테고리별 마커 이미지 URL)
            var imageSrc = getMarkerImage(partner.categoryCode); // 카테고리별 마커 이미지 URL
            var imageSize = new kakao.maps.Size(42, 42); // 마커 크기 설정 32기본
            var imageOption = { offset: new kakao.maps.Point(16, 32) }; // 마커 중심 조정

            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

            // 🔥 마커 생성
            var marker = new kakao.maps.Marker({
                position: position,
                image: markerImage,  // 카테고리별 PNG 이미지 적용
                map: this.map
            });
     
            // 클릭 이벤트 등록
            kakao.maps.event.addListener(marker, "click", () => {
                console.log("🧐 클릭된 마커의 제휴사 정보:", partner);
                this.showInfoWindowForCategory(marker, partner);  // 글로벌 함수 호출
            });

            // 마커를 partnerMarkers 배열에 추가
            this.partnerMarkers.push(marker);
        } else {
            //console.warn(`⚠️ 제휴사 ${partner.name} (${partner.partnerId}) 좌표 없음`);
        }
    });

    // ✅ 첫 번째 마커 기준으로 지도 이동
    if (partnerlist.length > 0) {
        var firstPartner = partnerlist[0];
        var centerPosition = new kakao.maps.LatLng(firstPartner.NY, firstPartner.NX);
        console.log("🗺 지도 중심 이동 →", centerPosition);
        this.map.setCenter(centerPosition);
    }
},
// 제휴사 마커만 삭제
clearPartnerMarkers() {
    console.log("❌ 제휴사 마커 삭제됨!!");
    this.partnerMarkers.forEach(marker => marker.setMap(null));
    this.partnerMarkers = []; // 배열 초기화
},
displayPartnerInfo(partner) {
    if (!partner || !partner.NY || !partner.NX) {
        console.error("🚨 올바른 위치 정보가 없습니다!", partner);
        return;
    }

    // 🔍 인포 창이 들어갈 HTML 요소 가져오기
    // const contentNode = document.getElementById("infoWindow");
    // if (!contentNode) {
    //     console.error("❌ contentNode를 찾을 수 없습니다! HTML에 <div id='infoWindow'></div> 추가하세요.");
    //     return;
    // }

    // 📝 정보창 HTML 설정
    const content =
        '<div style="padding:5px; font-size:12px; background:white; border-radius:5px;">' +
        '<strong>' + partner.name + '</strong><br>' +
        '<p>카테고리: ' + partner.category + '</p>' +
        '<p>위치: ' + partner.NY + ', ' + partner.NX + '</p>' +
        '<a href="#" onclick="alert(\'더 자세한 정보\')">자세히 보기</a>' +
        '</div>';

    contentNode.innerHTML = content;

    // 📌 마커 위치로 정보창 위치 지정
    const position = new kakao.maps.LatLng(partner.NY, partner.NX);

    if (!placeOverlay || !this.map) {
        console.error("🚨 placeOverlay 또는 지도(map)가 정의되지 않았습니다!", placeOverlay, this.map);
        return;
    }

    // 🏷 인포창 내용 설정 및 지도에 표시
    placeOverlay.setContent(contentNode);
    placeOverlay.setPosition(position); // 🚀 **마커 위치에 맞게 위치 지정**
    placeOverlay.setMap(this.map); // **지도에 인포 창 표시**

    console.log("✅ 인포창이 뜰 위치:", position);
}
,
addCategoryClickEvent() {
    const category = document.getElementById('category');
    const children = category.children;

    for (let i = 0; i < children.length; i++) {
        children[i].onclick = onClickCategory;
    }
},
onClickCategory() {
    const id = this.id;
    const className = this.className;

    placeOverlay.setMap(null);

    if (className === 'on') {
        currCategory = '';
        changeCategoryClass();
        removeMarker();
    } else {
        currCategory = id;
        changeCategoryClass(this);
        filterByCategory(currCategory);  // 카테고리 필터링
    }
},
    // 지도에 마커 표시하는 함수
    displayMarkers(partnerlist) {
        partnerlist.forEach(partner => {
            const marker = new kakao.maps.Marker({
                map: this.map,
                position: new kakao.maps.LatLng(partner.NX, partner.NY)
            });
            this.markers.push(marker);
        });
    },

        fnMemberList(keyword = "") {
            var self = this;
            console.log("전달된 검색어:", keyword);
          
            var nparmap = {
                selectgu: self.selectgu.GU,
                selectdong: self.selectdong.DONG,
                selectsi: self.selectsi,
                keyword:  self.keyword,
                userId : self.userId,
                categoryCode : self.categoryCode
                // page: self.pagination.current,  // ✅ 현재 페이지 추가
                // perPage: self.pagination.perPage,  // ✅ 한 페이지당 개수 추가
                // pageSize : self.pageSize,
                // page : (self.page-1) * self.pageSize
            };

            $.ajax({
                url: "/partner/list.dox",
                dataType: "json",
                type: "POST",
                data: nparmap,
                success: function(data) {
                    console.log("서버 응답 데이터1:", data);
                    console.log("검색어2 : " + self.keyword);
                    console.log("아이디 테스트3" + self.sessionId);
                    self.displayHospitals("t" + data.hoslist);
                   
                    self.filterByCategory("c" + self.categoryCode);
                    self.partnerlist = data.partnerlist || [];
                    console.log(data.partnerlist);
                    self.pagination.last = Math.ceil(data.count / self.pagination.perPage);  // ✅ 총 페이지 수 업데이트
                    
                    if (data && data.pagination) {
                        self.pagination.last = data.pagination.last;
                        self.displayPagination();                     
                    } else {
                        console.warn("서버 응답에 pagination 정보가 없음");
                    }
                    if (self.categoryCode) {
                         nparmap.categoryCode = self.categoryCode;
                    }

                if (self.selectdong.DONG) {
                    self.hoslist = data.hoslist.filter(hospital => {
                        const hospitalAddress = hospital.hosAddress; // 병원 주소
                        const selectedDong = self.selectdong.DONG.replace(/[0-9]/g, ""); // 숫자 제거 (ex: "계산1동" → "계산동")

    
                        return hospitalAddress.includes(selectedDong);
                    });
                } else {
                    self.hoslist = data.hoslist;
                    console.log("검색어5 : " , self.keyword);
                    console.log("검색어5 : " ,  data);

                    console.log("검색어5 : " ,  data.hoslist);

                    if (data.hoslist.length == 1) {
                        const position = new kakao.maps.LatLng(data.hoslist[0].NY, data.hoslist[0].NX);
                    
                        // 지도 이동
                        if (self.map) {
                            console.log("123123" ,  data.hoslist);

                            self.map.setCenter(position);
                        }

                    }
                    


                }

                self.favoritesList = data.favoriteList;
                console.log("즐겨찾기 리스트 : " +  self.favoritesList);

                console.log("필터링된 병원 리스트:", self.hoslist);
                    if (data) {
                       
                        //self.hoslist = Array.isArray(data.hoslist) ? data.hoslist : [];
                        self.gulist = Array.isArray(data.gulist) ? self.removeDuplicates(data.gulist, "GU") : [];
                        self.donglist = Array.isArray(data.donglist) ? data.donglist : [];
                        self.silist = Array.isArray(data.silist) ? data.silist : [];
                        
                        self.addMarkers();

                    } else {
                        console.warn("서버 응답이 비어 있습니다.");
                    }
                    console.log("총 페이지 수 업데이트:", self.pagination.last);
                },
                error: function(error) {
                    console.error("데이터 요청 실패:", error);
                }
            });
        },
        

    
        removeDuplicates(arr, key) {
            return arr.filter((value, index, self) =>
                index === self.findIndex((t) => (
                    t[key] === value[key]
                ))
            );
        },
        
        displayPagination(pagination) {
            console.log("displayPagination 실행됨! 현재 페이지:", pagination.current);
    var paginationEl = document.getElementById('pagination'), // 페이징을 표시할 요소
        fragment = document.createDocumentFragment(), // 페이징 요소를 담을 문서 조각
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
    }

    // 페이징 번호를 생성합니다
    for (i = 1; i <= pagination.last; i++) {
        console.log("displayPagination 함수 실행됨!");
        var el = document.createElement('a');
        el.href = "#"; // 링크 클릭 시 페이지 번호로 이동
        el.innerHTML = i; // 페이지 번호 표시

        // 현재 페이지는 'on' 클래스를 추가하여 스타일 적용
        if (i === pagination.current) {
            el.className = 'on';
        } else {
            // 클릭했을 때 해당 페이지로 이동
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i); // 해당 페이지로 이동
                }
            })(i);
        }

        // fragment에 페이지 링크 추가
        fragment.appendChild(el);
    }

    // 최종적으로 fragment를 paginationEl에 추가
    paginationEl.appendChild(fragment);
},
        fnsi() {
            var self = this;
            self.selectgu = "";
            self.selectdong = "";
            self.fnMemberList();
        },

        setMapType(maptype) {
            var roadmapControl = document.getElementById('btnRoadmap');
            var skyviewControl = document.getElementById('btnSkyview');
            if (maptype === 'roadmap') {
                this.map.setMapTypeId(kakao.maps.MapTypeId.ROADMAP);
                roadmapControl.className = 'selected_btn';
                skyviewControl.className = 'btn';
            } else {
                this.map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);
                skyviewControl.className = 'selected_btn';
                roadmapControl.className = 'btn';
            }
        },

        zoomIn() {
            this.map.setLevel(this.map.getLevel() - 1);
        },

        zoomOut() {
            this.map.setLevel(this.map.getLevel() + 1);
        },

        initializeMap() {
            const mapContainer = document.getElementById('map');
            const mapOption = {
                center: new kakao.maps.LatLng(37.4896, 126.7326), // Default center is Seoul
                level: 3
            };
            this.map = new kakao.maps.Map(mapContainer, mapOption);
             // 지도 리사이즈 시에도 화면에 꽉 차도록 조정
        // kakao.maps.event.addListener(this.map, 'resize', () => {
        //     this.map.relayout();  // 지도 리사이즈 후 재배치
        // });
        },
 // 검색한 병원 리스트 화면에 표시하는 함수
 displaySearchResults(results) {
    console.log(paginatedResults);
    // 검색된 병원 목록을 화면에 표시하는 로직
    // 예시로, 병원 이름과 주소를 화면에 표시한다고 가정
    const resultsContainer = document.getElementById('search-results');
    
    // 기존에 표시된 결과를 클리어
    resultsContainer.innerHTML = '';

    // 검색된 병원 목록을 하나씩 화면에 추가
    results.forEach(hospital => {
        const listItem = document.createElement('li');
        listItem.textContent = hospital.hosName + " - " + hospital.hosAddress;
        resultsContainer.appendChild(listItem);
    });
},

searchPlaces() {
    this.isFavoritesVisible = false;  // 즐겨찾기 목록 숨기기
    const keyword = this.keyword.trim();  // 검색어 입력 받기
    if (keyword) {
        console.log("1111",keyword );
        this.fnMemberList(keyword);  // 서버에서 병원 리스트만 호출
    } else {
        console.log("2222",keyword );

        this.fnMemberList();  // 기본 병원 리스트 호출
    }
    

    
},

        

    // 검색어에 맞는 병원만 필터링 (서버에서 처리해야 할 수도 있음)
    filterHospitalsByKeyword(hoslist, keyword) {
        return hoslist.filter(hospital => hospital.hosName.toLowerCase().includes(keyword.toLowerCase()));
    },
    placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        // 카카오 데이터를 필터링해서 병원만 선택
        const filteredData = data.filter(place => place.category_name && place.category_name.includes("병원"));
        if (filteredData.length > 0) {
            this.displayPlaces(filteredData, pagination);
        } else {
            alert('병원에 해당하는 결과가 없습니다.');
        }
    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
        alert('검색 결과가 존재하지 않습니다.');
    } else if (status === kakao.maps.services.Status.ERROR) {
        alert('검색 결과 중 오류가 발생했습니다.');
    }
    displayPagination(pagination);
},


showInfoWindowForCategory(marker, partner) {
    let favoritesList = this.favoritesList; // 현재 즐겨찾기 리스트

    console.log("⭐ [INFO] 즐겨찾기 버튼 확인 시작:", partner.partnerdetailId);
    
    let isFavorite = favoritesList.some(fav => fav.partnerdetailId === partner.partnerdetailId);
    let starIcon = isFavorite ? "★" : "☆";

    console.log("✅ 현재 상태:", isFavorite ? "★ 즐겨찾기 O" : "☆ 즐겨찾기 X");

    let content = 
        "<div class='placeinfo'>" +
            "<a class='title' href='#' style='font-weight:bold; color:#007BFF;'>" + partner.name + "</a><br>" +
            "<span class='tel'>" + (partner.phoneNumber || "전화번호 없음") + "</span><br>" +
            "<div style='display:flex; justify-content:space-between; margin-top:5px;'>" +
                "<button id='favoritesButton' class='btn btn-light'>" +
                    "<span id='favoriteStar'>" + starIcon + "</span>" +
                "</button>" +
            "</div>" +
        "</div>";

    this.infoWindow = new kakao.maps.InfoWindow({
        content: content,
        removable: true
    });

    this.infoWindow.open(this.map, marker);

    this.$nextTick(async () => {
    const favButton = document.getElementById("favoritesButton");

    if (!favButton) {
        console.error("❌ [ERROR] 즐겨찾기 버튼이 존재하지 않음!");
        return;
    }

    console.log("✅ [SUCCESS] 즐겨찾기 버튼 찾음! 이벤트 추가 시작!");

    favButton.addEventListener("click", async () => {
        console.log("⭐ 즐겨찾기 버튼 클릭됨!");

        if (!this.userId) {  
            alert("로그인이 필요합니다! 😊");
            return;
        }

        if (isFavorite) {
            console.log("🗑 [REMOVE] 즐겨찾기 해제 요청");
            await this.fnparRemoveFavorite(partner.partnerdetailId, partner.name, partner.address, this.userId, marker, partner);
        } else {
            console.log("✨ [ADD] 즐겨찾기 추가 요청");
            await this.fnparfavorites(partner.partnerdetailId, partner.name, partner.address, this.userId, marker, partner);
        }

        // ✅ 최신 즐겨찾기 목록 불러오기
        await this.fnfavorList();  // `await` 사용해서 최신 데이터 가져오기
        console.log("📌 [UPDATE] 즐겨찾기 리스트 갱신 완료!");

        // ⭐ UI 즉시 업데이트
        this.$nextTick(() => {
            const starElement = document.getElementById("favoriteStar");
            if (starElement) {
                isFavorite = this.favoritesList.some(fav => fav.partnerdetailId === partner.partnerdetailId);
                starElement.textContent = isFavorite ? "★" : "☆";
                console.log("✅ [SUCCESS] 별 상태 변경 즉시 반영!", isFavorite ? "★" : "☆");
            }
        });
    });
});

}


,


    ///1
    
    displayPlaces(data, pagination) {
    if (!this.map) {
        console.error("지도 객체가 초기화되지 않았습니다.");
        return;
    }

    const listContainer = document.getElementById('placesList');
    listContainer.innerHTML = ''; // 기존 내용 지우기

    data.forEach(place => {
        const listItem = document.createElement('li');
        listItem.innerHTML = place.place_name + "<br>" + place.address_name;
        listContainer.appendChild(listItem);

        const position = new kakao.maps.LatLng(place.y, place.x);
        const marker = new kakao.maps.Marker({
            map: this.map,
            position: position
        });

        // 마커 클릭 시, 해당 위치로 지도 이동
        kakao.maps.event.addListener(marker, 'click', () => {
            this.map.setCenter(position);
            this.showInfoWindowForCategory(marker, place, category); // 인포창 표시
        });
    });
}




,
    // 키워드 검색 시 병원 목록 초기화
    clearSearchResults() {
        this.hoslist = [];
        this.keyword = '';
    },


        // 📌 구 선택 시 병원 마커들을 한 번에 보기 위해 지도 줌 아웃
    handleGuSelection(selectedGu) {
        // 선택된 구에 해당하는 병원들을 필터링
        const selectedHospitals = this.hoslist.filter(hospital => hospital.selectedGu === selectedGu);

        if (selectedHospitals.length > 0) {
            // 구에 해당하는 병원의 좌표로 마커를 생성
            let bounds = new kakao.maps.LatLngBounds(); // 영역 객체

            // 모든 병원의 위치를 포함하는 영역을 확장
            selectedHospitals.forEach(hospital => {
                const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
                bounds.extend(position); // 병원의 좌표를 포함하는 범위 확장
            });

            // 병원 마커 추가
            this.clearMarkers(); // 이전 마커 삭제
            this.addMarkers(selectedHospitals); // 선택된 구의 병원들만 마커로 추가

            // 선택된 구 내의 병원들을 포함하는 영역으로 지도 줌 조정
            this.map.setBounds(bounds); // 지도 영역을 해당 병원들이 모두 보이도록 설정
        }
    },
    // 📌 마커 추가 함수 (병원 리스트로 마커 업데이트)
    addMarkers() {
    // 🎯 즐겨찾기 목록이 열려있으면 실행하지 않음
    if (this.isFavoritesVisible) {
        console.log("⏳ 즐겨찾기 목록이 열려 있어서 일반 마커 추가 안 함!");
        return;
    }

    this.clearMarkers(); // 이전 마커 제거

    if (this.hoslist.length === 0) {
        return;
    }

    // ⭐ 즐겨찾기 병원의 좌표를 Map으로 저장 (빠른 조회용)
    const favoritePositions = new Map();
    this.favoritesList.forEach(function(fav) {
        favoritePositions.set(fav.NY + "," + fav.NX, fav);
    });

    this.hoslist.forEach(function(hospital) {
        var positionKey = hospital.NY + "," + hospital.NX; // 병원의 위치 정보
        var position = new kakao.maps.LatLng(hospital.NY, hospital.NX);

        var marker;
        if (favoritePositions.has(positionKey)) {
            // 🎯 즐겨찾기 병원은 즐겨찾기 마커 사용
            var favoriteMarkerImage = new kakao.maps.MarkerImage(
                '../img/3.png',
                new kakao.maps.Size(40, 40),
                { offset: new kakao.maps.Point(20, 40) }
            );

            marker = new kakao.maps.Marker({
                position: position,
                title: hospital.hosName,
                image: favoriteMarkerImage
            });
        } else {
            // 일반 병원 마커
            marker = new kakao.maps.Marker({
                position: position,
                title: hospital.hosName
            });
        }

        marker.setMap(this.map);

        kakao.maps.event.addListener(marker, "click", function() {
            this.showInfoWindowForSelect(marker, hospital);
        }.bind(this));

        this.markers.push(marker);
    }.bind(this));
}

,
    clearMarkers(clearAll = true) {

    console.log("❌ clearMarkers() 실행됨!! 마커 삭제!");

    if (clearAll) {
        // 전체 마커 삭제
        this.markers.forEach(marker => marker.setMap(null));
        this.markers = [];
        console.log("모든 마커 삭제 완료");
    } else {
        // 특정 조건에 맞는 마커만 삭제 (예: 즐겨찾기 마커만 삭제)
        this.markers.forEach(marker => {
            // 조건에 맞는 마커만 삭제
            if (marker.isFavorite) {  // 예시: isFavorite 속성으로 구분
                marker.setMap(null);
            }
        });
        // 삭제한 마커만 제거
        this.markers = this.markers.filter(marker => !marker.isFavorite);
        console.log("즐겨찾기 마커만 삭제 완료");
    }
},



// 📌 마커 추가 함수 (병원 리스트로 마커 업데이트)
addHospitalMarkers() {
    console.log("🚀 addHospitalMarkers 실행됨!");

    this.clearFavoriteMarkers(); // 기존 마커 삭제
    console.log("🗑 기존 마커 삭제 완료");

    if (!this.map) {
        console.error("⚠️ 지도 객체가 없습니다!");
        return;
    }

    console.log("📌 현재 favoritesList:", this.favoritesList);

    const hospitalMarkerImage = new kakao.maps.MarkerImage(
        '../img/3.png',
        new kakao.maps.Size(40, 40),
        { offset: new kakao.maps.Point(20, 40) }
    );

    this.favoritesList
        .filter(fav => fav.hospitalNo) // 병원만 필터링
        .forEach(hospital => {
            const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
            console.log("📍 병원 마커 위치:", position);

            const marker = new kakao.maps.Marker({
    position: position,
    map: this.map,
    image: hospitalMarkerImage
});

console.log("🟢 마커 생성 완료:", marker);

this.favoriteMarkers.push(marker);

// ✅ 혹시 모를 지도 등록 문제 해결!
marker.setMap(this.map);
console.log("🟢 마커 지도에 추가됨!");

            this.favoriteMarkers.push(marker);
        });

    console.log("✅ 마커 추가 완료, 총 개수:", this.favoriteMarkers.length);
}

,

addPartnerMarkers() {
    this.clearFavoriteMarkers(); // 기존 마커 삭제
    console.log("🏥 병원 즐겨찾기 마커 추가!");

    if (!this.map) {
        console.error("⚠️ 지도 객체가 없습니다!");
        return;
    }

    const partnerMarkerImage = new kakao.maps.MarkerImage(
        '../img/3.png',  
        new kakao.maps.Size(40, 40),  
        { offset: new kakao.maps.Point(20, 40) }
    );

    this.favoritesList
        .filter(fav => fav.partnerdetailId) // 병원만 필터링
        .forEach(partner => {
            if (!partner.NX || !partner.NY) {
                console.warn("🚨 좌표가 없음! partnerlist에서 찾는 중...", partner.partnerdetailId);
                let matchedPartner = this.partnerlist.find(p => p.partnerdetailId === partner.partnerdetailId);
                
                if (matchedPartner) {
                    console.log("✅ partnerlist에서 좌표 찾음!", matchedPartner);
                    partner.NX = matchedPartner.NX;
                    partner.NY = matchedPartner.NY;
                } else {
                    console.error("❌ 좌표를 찾을 수 없음. 기본 위치로 이동");
                    partner.NX = 126.9786567; // 기본 서울 좌표
                    partner.NY = 37.566826;
                }
            }

            const lat = parseFloat(partner.NY);
            const lng = parseFloat(partner.NX);

            if (isNaN(lat) || isNaN(lng)) {
                console.warn("⚠️ 유효하지 않은 좌표, 마커 추가 안됨:", partner);
                return;
            }

            const position = new kakao.maps.LatLng(lat, lng);
            console.log("📍 제휴사 마커 위치:", position);

            const marker = new kakao.maps.Marker({
                position: position,
                map: this.map,
                image: partnerMarkerImage
            });

            this.favoriteMarkers.push(marker);
            
            kakao.maps.event.addListener(marker, 'click', () => {
                // 🔥 기존 `infoWindow` 닫기
                if (this.infoWindow) {
                    this.infoWindow.close();
                }
                // const baseWidth = 100;
                // const textLength = partner.name.length * 10;
                // const maxWidth = 300;
                // const minWidth = 190;
                // const dynamicWidth = Math.min(maxWidth, Math.max(minWidth, baseWidth + textLength));

                // const baseHeight = 50;
                // const addressLines = Math.ceil(partner.address.length / 20);
                // const dynamicHeight = baseHeight + (addressLines * 18);

                const content =
                    "<div style='padding:10px; font-size:14px;'>" +
                        "<strong>" + partner.name + "</strong><br>" +
                        "<div>" + (partner.address || "주소 정보 없음") + "</div>" +
                        "<a href='https://map.kakao.com/link/to/" + partner.name + "," + lat + "," + lng +
                        "' target='_blank' style='color:#007BFF;'>🗺 길찾기</a>" +
                    "</div>";

                this.infoWindow = new kakao.maps.InfoWindow({ content: content, removable: true });
                this.infoWindow.open(this.map, marker);
            });
        });
}
,

// 즐겨찾기 마커만 삭제
clearFavoriteMarkers() {
    console.log("🗑 기존 마커 삭제 시작, 총 개수:", this.favoriteMarkers.length);
    this.favoriteMarkers.forEach(marker => {
        marker.setMap(null);
        console.log("❌ 마커 삭제됨:", marker);
    });
    this.favoriteMarkers = [];
    console.log("✅ 기존 마커 삭제 완료");
},

// clearMarkers() {
// // 기존 마커들 삭제
// this.markers.forEach(marker => marker.setMap(null));
// this.markers = [];
// },

toggleFavoritesList() {
    console.log("🟢 toggleFavoritesList() 실행됨! 현재 상태:", this.isFavoritesVisible);
    
    this.isFavoritesVisible = !this.isFavoritesVisible;

    if (this.isFavoritesVisible) {
        console.log("⭐ 즐겨찾기 목록 열림");

        // 🔥 일반 병원 마커 삭제 (병원 마커가 날아감!)
        this.clearMarkers(); 

        // 🔥 즐겨찾기 마커만 표시 (병원 마커를 다시 추가해야 함!)
        this.addHospitalMarkers();
        
        console.log("🚀 addPartnerMarkers() 호출 직전!");
        this.addPartnerMarkers();
        console.log("✅ addPartnerMarkers() 호출 완료!");
    } else {
        console.log("❌ 즐겨찾기 목록 닫힘");
        
        // 즐겨찾기 마커 삭제
        this.clearFavoriteMarkers();

        // ❌ 여기서 일반 병원 마커를 다시 표시해야 하는데 빠졌을 가능성 있음!!
        this.addMarkers(); // 병원 마커 다시 표시 추가!
    }
}

,

    // 단일 마커 추가(검색어 입력시)
    addMarker(position, place) {
    const marker = new kakao.maps.Marker({
        position: position,
        title: place.hosName
    });

    console.log("마커 추가됨:", marker); // 마커 정보 확인

    marker.setMap(this.map);
    kakao.maps.event.addListener(marker, "click", () => {
        this.showInfoWindowForSearch(marker, place);
    });

    return marker;
},
    
    displayHospitals(data, hoslist) {
    console.log("displayHospitals" + hoslist); // hoslist의 내용 확인


    if (Array.isArray(hoslist) && hoslist.length > 0) {
        this.hoslist = hoslist; // hoslist에 데이터를 할당
    } else {
        console.error("병원 리스트가 비어 있습니다.");
    }
},
     // 📌 셀렉트(구/동 선택) 기반 병원 정보 표시
     // 📌 셀렉트(구/동 선택) 기반 병원 정보 표시
showInfoWindowForSelect(marker, hospital) {
    favoritesList = this.favoritesList; // 현재 favoritesList 가져오기
    
    console.log("showInfoWindowForSelect 호출됨", hospital);
    console.log("현재 사용자 ID:", this.userId);
    console.log("selectfavoritesList:", this.favoritesList); // favoritesList 확인
   
    if (!favoritesList || favoritesList.length === 0) {
        console.log("favoritesList가 비어있거나 존재하지 않음.");
    }

    // 기존 infoWindow 닫기
    if (this.infoWindow) {
        this.infoWindow.close();
        this.infoWindow = null;
    }

    const baseWidth = 100;
    const textLength = hospital.hosName.length * 10;
    const maxWidth = 300;
    const minWidth = 190;
    const dynamicWidth = Math.min(maxWidth, Math.max(minWidth, baseWidth + textLength));

    const baseHeight = 50;
    const addressLines = Math.ceil(hospital.hosAddress.length / 20);
    const dynamicHeight = baseHeight + (addressLines * 18);

    let isFavorite = false;

    // 전달받은 favoritesList에서 hospitalNo에 해당하는 병원 찾기
    if (Array.isArray(favoritesList)) {  // favoritesList가 배열인지 확인
        for (let i = 0; i < favoritesList.length; i++) {
            if (favoritesList[i].hospitalNo === hospital.hospitalNo) {
                isFavorite = true;
                break;
            }
        }
    } else {
        console.error("favoritesList는 배열이 아닙니다.");
    }

    let starIcon = isFavorite ? "★" : "☆"; // 즐겨찾기 되어 있으면 채운 별, 아니면 빈 별
    console.log("isFavorite:", isFavorite);  // isFavorite 값 확인
    console.log("starIcon:", starIcon);  // starIcon 값 확인

    let content = 
    "<div style='padding:10px; font-size:13px; width:" + dynamicWidth + "px; " +
    "min-height:" + dynamicHeight + "px; word-wrap:break-word; white-space:pre-line; " +
    "max-width:100%; overflow: visible;'>" + 
        "<strong>" + hospital.hosName + "</strong><br>" +
        "<div style='white-space:pre-line;'>" + 
            (hospital.hosAddress ? hospital.hosAddress : "주소 정보 없음") + 
        "</div>" +
        (hospital.phone ? "<div style='margin-top:5px;'>📞 " + hospital.phone  + "</div>" : "") +
        "<div style='display:flex; justify-content:space-between; margin-top:5px;'>" +
            "<a href='https://map.kakao.com/link/to/" + hospital.hosName + "," + hospital.NY + "," + hospital.NX + 
            "' target='_blank' style='flex:1; text-align:center; padding:5px; background:#007BFF; " +
            "color:white; border-radius:5px; text-decoration:none; font-weight:bold; margin-right:5px;'>🗺 길찾기</a>" +
            
            "<button id='shareButton'" +
            "style='flex:1; padding:5px; background:#FFEB00; border:none; " +
            "border-radius:5px; font-weight:bold; cursor:pointer; margin-right:5px;'>📢 공유</button>" + 

            "<button id='favoritesButton'" +
            "style='padding:5px; background:none; border:none; font-size:20px; cursor:pointer;'>" +
            "<span id='favoriteStar' data-favorite='" + isFavorite + "'>" + starIcon + "</span>" +
            "</button>" +
        "</div>" +
    "</div>";

    // 새로운 InfoWindow 생성 및 열기
    this.infoWindow = new kakao.maps.InfoWindow({
        content: content,
        removable: true
    });

    this.infoWindow.open(this.map, marker);

    // 버튼 이벤트 리스너 설정
    this.$nextTick(() => {
        // 공유 버튼 클릭 시 이벤트 처리
        document.getElementById("shareButton").addEventListener("click", () => {
            this.shareToKakao(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, hospital.phone);
        });

        // 즐겨찾기 버튼 클릭 시 이벤트 처리
        this.$nextTick(() => {
            const favButton = document.getElementById("favoritesButton");
            console.log("⭐ 즐겨찾기 버튼 찾음:", favButton);

            if (!favButton) {
                console.error("⚠️ 즐겨찾기 버튼이 없음! 버튼이 생성되지 않았을 수도 있음!");
                return;
            }

            favButton.addEventListener("click", async () => {
                console.log("💡 즐겨찾기 버튼 클릭됨!");  // 클릭 이벤트 확인용 로그

                if (!this.userId) {  
                    alert("로그인이 필요합니다! 😊");
                    return;
                }

                let wasFavorite = isFavorite; // 기존 상태 저장

                if (isFavorite) {
                    await this.fnRemoveFavorite(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, this.userId, marker, hospital);
                } else {
                    await this.fnfavorites(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, this.userId, marker, hospital);
                }

                // 🟢 `this.favoritesList` 강제 업데이트
                this.favoritesList = [...this.favoritesList];  // Vue 반응성 유지

                // 🔄 최신 `isFavorite` 상태 다시 확인
                isFavorite = this.favoritesList.some(fav => fav.hospitalNo === hospital.hospitalNo);

                console.log("🔄 업데이트 후 isFavorite:", isFavorite ? "★ (즐겨찾기됨)" : "☆ (즐겨찾기 아님)");

                // ⭐ UI 즉시 업데이트
                this.$nextTick(() => {
                    const starElement = document.getElementById("favoriteStar");
                    if (starElement) {
                        console.log("✅ 별 UI 변경:", isFavorite ? "★" : "☆");
                        starElement.textContent = isFavorite ? "★" : "☆";
                    }
                });

                // 🏥 **즐겨찾기 마커 다시 추가**
                setTimeout(() => {
    console.log("🔄 즐겨찾기 변경 후 마커 다시 추가!");

    // 기존 병원 리스트 + 즐겨찾기 병원 리스트 합쳐서 마커 추가
    const updatedHospitalList = [...this.partnerlist, ...this.favoritesList]; 

    this.addHospitalMarkers(updatedHospitalList);
}, 200);
            });
        }); // <-- ✅ 추가된 닫는 괄호!
    }); // <-- ✅ 추가된 닫는 괄호!
} // <-- ✅ 함수 닫는 괄호!

    

,



        gotoPage(page) {
            this.pagination.current = page;
            this.fnMemberList();
        },

        updateMap() {
            if (!this.selectgu) {
        console.warn("구가 선택되지 않았습니다.");
        return;
    }
            console.log("donglist:", this.donglist);
            console.log("gulist:", this.gulist);
            this.fnMemberList();

            console.log("selectgu:", this.selectgu);
            console.log("selectdong:", this.selectdong);

            if (!this.map) {
                console.warn("지도 객체가 초기화되지 않았습니다.");
                return;
            }

            let lat, lng;
            if (this.selectdong && this.selectdong.NX && this.selectdong.NY) {
                console.log("789789", this.selectdong);
                this.moveToLocation(this.selectdong);
                return;
            } else if (this.selectgu && this.selectgu.NX && this.selectgu.NY) {
                console.log("234234", this.selectgu);
                this.moveToLocation(this.selectgu);
                return;
            } else {
                lat = 37.4101013788811; // 기본값: 인천
                lng = 126.678274850516;
                console.warn("선택된 구/동이 없습니다. 기본 좌표 사용.");
            }
    
            //this.map.setCenter(new kakao.maps.LatLng(lat, lng));
        },

        updateMapWithCoordinates(lat, lng) {
            if (this.map) {
                this.map.setCenter(new kakao.maps.LatLng(lat, lng));
            }
        },

        moveToLocation(data) {
    let self = this;

    console.log("📍 이동할 데이터:", data);

    // 🔥 좌표가 없을 경우 partnerlist에서 찾아보기
    if (!data.NX || !data.NY) {
        console.warn("🚨 좌표가 없음! partnerlist에서 찾는 중...");
        
        let matchedPartner = self.partnerlist.find(p => p.partnerdetailId === data.partnerdetailId);
        
        if (matchedPartner) {
            console.log("✅ partnerlist에서 좌표 찾음!", matchedPartner);
            data.NX = matchedPartner.NX;
            data.NY = matchedPartner.NY;
        } else {
            console.error("❌ 좌표를 찾을 수 없음. 기본 위치로 이동");
            data.NX = 126.9786567; // 기본 서울 좌표
            data.NY = 37.566826;
        }
    }

    // 📍 지도 이동
    const position = new kakao.maps.LatLng(data.NY, data.NX);
    if (self.map) {
        self.map.setCenter(position);
    }
}
,
        fnPage : function(hospitalNo) {
                let self = this;
                self.page = hospitalNo;
                self.fnMemberList();
            },
        fnPageMove : function(direction) {
                let self = this;
                if(direction == "next") {
                    self.page++;
                    

                } else {
                    self.page--;
                }
                self.fnMemberList();
            },
            //select 공유기능
            shareToKakao(hospitalNo,hosName,hosAddress) {
         console.log(hospitalNo);
     if (!Kakao.isInitialized()) {
         alert("카카오 SDK가 초기화되지 않았습니다!");
         return;
     }
 
     Kakao.Link.sendDefault({
         objectType: "text",
         text: "📍 병원이름: " + hosName + "\n🏠 주소: " + hosAddress + "\n🚑 병원 정보를 공유합니다!",
         link: {
             mobileWebUrl: "https://m.search.naver.com/search.naver?query="+hosName,
             webUrl: "https://search.naver.com/search.naver?query="+hosName
         }
     });
 },
 fnfavorites(hospitalNo, hosName, hosAddress, userId, marker, hospital) {
            // 로그인 안 되어 있으면 알림
        //     if (!this.userId) {
        //     alert("로그인이 필요합니다! 😊");
        //     return;
        // }

            var self = this;
            var nparmap = {
                hospitalNo: hospitalNo,
                hosName: hosName,
                hosAddress: hosAddress,
                userId: userId,
            };

            $.ajax({
                url: "/favorites/hospital/add.dox",
                dataType: "json",    
                type: "POST", 
                data: nparmap,
                success: function(data) {  
                    console.log(data);
                    if (data.result === "success") {
                        alert(hosName + " 즐겨찾기에 추가되었습니다! ⭐");
                        document.getElementById("favoriteStar").innerText = "★";  // 별을 채운 별로 변경

                        self.fnfavorList();
                        // InfoWindow 닫기
                        // if (self.infoWindow) {
                        //     self.infoWindow.close();  // 기존 InfoWindow 닫기
                        //     self.infoWindow = null;   // InfoWindow 객체 초기화
                        // }

                        // 잠시 기다린 후에 InfoWindow 다시 열기
                        // setTimeout(() => {
                        //     self.showInfoWindowForSelect(marker, hospital);  // 'self'를 사용하여 올바르게 this 참조
                        // }, 100); // 잠시 기다렸다가 InfoWindow 다시 열기
                    } else {
                        console.log("서버 응답이 예상과 다릅니다:", data.result);
                    }
                    console.log("서버로 전송된 데이터:", nparmap);
                },
                error: function(xhr, status, error) {
                    // 에러 처리
                }
            });
        },

        fnparfavorites(partnerdetailId, name, address, userId) {
    var self = this;
    var nparmap = { partnerdetailId, name, address, userId };

    $.ajax({
        url: "/favorites/partner/add.dox",
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: async function(data) {
            console.log("✅ [ADD] 서버 응답:", data);

            if (data.result === "success") {
                alert(name + " 즐겨찾기에 추가되었습니다! ⭐");

                // ✅ 최신 즐겨찾기 리스트 불러오기
                await self.fnfavorList();
            } else {
                console.log("⚠️ [ADD] 서버 응답 실패:", data);
            }
        },
        error: function(xhr) {
            console.error("❌ [ADD] AJAX 요청 실패!", xhr.responseText);
        }
    });
}
,







    fnRemoveFavorite(hospitalNo, hosName, hosAddress, 
    userId, marker, hospital) {
    
    var self = this;
    var nparmap = {
        hospitalNo: hospitalNo,
        hosName: hosName,
        hosAddress: hosAddress,
        userId: userId,
    };

    $.ajax({
        url: "/favorites/hospital/remove.dox",
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: function(data) {
            console.log("해제:", data);
            if (data.result === "success") {
                alert(hosName + " 즐겨찾기에서 해제되었습니다.");

                // UI 업데이트
                self.fnfavorList();
                console.log("즐겨찾기 목록 갱신 완료");

                // 기존 InfoWindow 닫기
                if (self.infoWindow) {
                    self.infoWindow.close();
                    self.infoWindow = null;
                }

                // **현재 페이지 상태에 따라 다른 함수 호출**
                setTimeout(() => {
                    if (hospital) {
                        // 카테고리 기반 조회라면 해당 인포창 다시 표시
                        self.showInfoWindowForSelect(marker, hospital);
                  
                    } 
                    
                }, 150);
            }
        },
        error: function(xhr, status, error) {
            console.error("즐겨찾기 삭제 오류:", error);
        }
    });
},


fnparRemoveFavorite(partnerdetailId, name, address, userId) {
    var self = this;

    $.ajax({
        url: "/favorites/partner/remove.dox",
        dataType: "json",
        type: "POST",
        data: { userId, partnerdetailId },
        success: async function(data) {
            console.log("✅ [REMOVE] 서버 응답:", data);

            if (data.result === "success") {
                alert(name + " 즐겨찾기에서 해제되었습니다.");

                // ✅ 최신 즐겨찾기 리스트 불러오기
                await self.fnfavorList();
            } else {
                console.warn("⚠️ [REMOVE] 서버 응답 실패:", data);
            }
        },
        error: function(xhr) {
            console.error("❌ [REMOVE] AJAX 요청 실패!", xhr.responseText);
        }
    });
}


,
// 📌 키워드 검색 기반 병원 정보 표시
showInfoWindowForSearch(marker, place) {
    if (!place || !place.place_name) {
        console.error("⚠️ place 객체가 없거나 place_name이 없음:", place);
        return; // 함수 실행 중단 (오류 방지)
    }

    console.log("place 객체:", place); // 디버깅 로그 추가

    // 이전 인포윈도우가 열려 있으면 닫기
    if (this.infoWindow) {
        this.infoWindow.close();
    }

    // 동적 크기 계산
    const baseWidth = 100;
    const textLength = (place.place_name ? place.place_name.length : 0) * 10;
    const maxWidth = 300;
    const minWidth = 190;
    const dynamicWidth = Math.min(maxWidth, Math.max(minWidth, baseWidth + textLength));

    const baseHeight = 50; // 기본 높이
    const addressLines = Math.ceil(place.address_name.length / 20); // 주소가 길어질수록 높이 증가
    const dynamicHeight = baseHeight + (addressLines * 18); // 한 줄당 약 18px씩 증가

    let phoneContent = place.phone ? "<br>📞 " + place.phone : "";

    // 인포윈도우 내용 설정
    const content =
        "<div style='padding:10px; font-size:14px;'>" +
        "<strong>" + place.place_name + "</strong><br>" +
        (place.address_name ? place.address_name : "주소 정보 없음") +
        phoneContent +
        "<br><a href='https://map.kakao.com/link/to/" + place.place_name + "," + place.y + "," + place.x + 
        "' target='_blank'>길찾기</a>" +
        "<div style='padding:10px; font-size:13px; width:" + dynamicWidth + "px; " +
        "min-height:" + dynamicHeight + "px; word-wrap:break-word;'>" +
            "<strong>" + place.place_name + "</strong><br>" +
            "<div style='white-space:normal;'>" + 
                (place.address_name ? place.address_name : "주소 정보 없음") + 
            "</div>" +
            phoneContent +
            "<div style='display:flex; justify-content:space-between; margin-top:5px;'>" +
                "<a href='https://map.kakao.com/link/to/" + place.place_name + "," + place.y + "," + place.x + 
                "' target='_blank' style='flex:1; text-align:center; padding:5px; background:#007BFF; " +
                "color:white; border-radius:5px; text-decoration:none; font-weight:bold; margin-right:5px;'>🗺 길찾기</a>" +
                "<button onclick='shareToKakao1(\"" + place.place_name + "\", \"" + place.address_name + "\")' " +
                "style='flex:1; padding:5px; background:#FFEB00; border:none; " +
                "border-radius:5px; font-weight:bold; cursor:pointer;'>📢 공유</button>" +
            "</div>" +
        "</div>";

    // 인포윈도우 객체 생성
    this.infoWindow = new kakao.maps.InfoWindow({
        content: content,
        removable: true,
    });

    // 인포윈도우 열기
    this.infoWindow.open(this.map, marker);
},
fnfavorList() {
    var self = this;
    var nparmap = { userId: self.userId };

    $.ajax({
        url: "/favorites/list.dox",
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: function (data) {
            console.log("⭐ 즐겨찾기 응답 데이터:", data);

            // 🛠 NX, NY가 없는 경우 partnerlist에서 찾아서 추가!
            

            console.log("🔄 최종 즐겨찾기 목록:", JSON.stringify(self.favoritesList, null, 2));
        }
    });
}

,




// ,
    },

    mounted() {
        this.initializeMap();
        this.updateMap(); // 기본 지도 설정
        this.fnMemberList();
        this.fnfavorList();
        //this.searchPlaces();
        
    }
});

app.mount('#app');




//검색 공유기능
function shareToKakao1(place_name,address_name) {
        
    if (!Kakao.isInitialized()) {
        alert("카카오 SDK가 초기화되지 않았습니다!");
        return;
    }

    Kakao.Link.sendDefault({
        objectType: "text",
        text: "📍 병원이름: " + place_name + "\n🏠 주소: " + address_name + "\n🚑 병원 정보를 공유합니다!",
        link: {
            mobileWebUrl: "https://m.search.naver.com/search.naver?query="+place_name,
            webUrl: "https://search.naver.com/search.naver?query="+address_name
        }
    });
}

//즐겨찾기 추가


//         function checkAndAddToFavorites(hospitalNo, hosName, hosAddress, phone, userId) {
//     console.log("현재 로그인한 사용자 ID:", userId); // 콘솔에서 userId 확인
    
//     if (!userId) {  // 로그인 안 되어있으면 알림
//         alert("로그인이 필요합니다! 😊");
//         return;
//     }
//     fnfavorites(hospitalNo, hosName, hosAddress, phone, userId);
// }
</script>