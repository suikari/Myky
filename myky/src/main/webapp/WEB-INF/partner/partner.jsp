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
                
                
                <button @click="moveToCurrentLocation(true)">내 주변 병원만 보기</button>
                <hr>
                
                
                
                <ul id="placesList">
                    
                    
                    <!-- 병원 목록이 있을 때만 표시 -->
                    <div v-if="hoslist.length > 0 && !isFavoritesVisible" class="count">
                        총 {{ hoslist.length }}개 병원이 검색되었습니다.
                        <hr>
                        <div>
                            <button @click="prevPage" :disabled="pagination.currentPage === 1">이전</button>
<span v-for="page in totalPages || 1" :key="page">
    <button @click="goToPage(page)">{{ page }}</button>
</span>
<button @click="nextPage" :disabled="pagination.currentPage === totalPages">다음</button>
                          </div>
                    </div>
                    
                    <ul v-if="!isFavoritesVisible">
                        <li v-for="(hospital, index) in paginatedHospitals" :key="hospital.hospitalNo" @click="moveToLocation(hospital)">
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
    const app = Vue.createApp({
    data() {
        
        return {
            allhoslist : [],
            favoritePartnerMarkers : [],
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
            allHospitals: [], // 전체 병원 리스트 저장
            partnerlist : [],
            selectgu: {
                GU: "",
            },
            selectdong: {
                DONG: "",
            },
            selectsi: "인천광역시",
         
            pagination: {
            currentPage: 1,  // ✅ 현재 페이지
            perPage: 10,      // ✅ 한 페이지당 표시할 아이템 수
            last: 1,          // ✅ 마지막 페이지 (일단 기본값 1)
        },    
           
        
        // pageSize : 5,
        // page : 1
        category : ""
    };
    },
    computed: {
        // 총 페이지 수 계산
    totalPages() {
        return Math.ceil(this.hoslist.length / this.pagination.perPage);
    },
    // ✅ 현재 페이지의 병원 목록만 가져오기
    paginatedHospitals() {
    console.log("📌 pagination.perPage 값:", this.pagination.perPage);
    
    const start = (this.pagination.currentPage - 1) * this.pagination.perPage;
    const result = this.hoslist.slice(start, start + this.pagination.perPage);

    console.log("📌 paginatedHospitals 계산됨! 결과:", JSON.stringify(result, null, 2));
    return result;
},


},
watch: {
    hoslist(newList, oldList) {
        console.log("🔍 [watch] hoslist 변경 감지!");
        console.log("📌 이전 길이:", oldList.length);
        console.log("📌 현재 길이:", newList.length);

        if (newList.length === 0 && oldList.length > 0) {
            console.warn("⚠️ hoslist 데이터가 사라짐! 어디에서 초기화되는지 확인 필요!");
        }
    }
},
    methods: {
        isUserLoggedIn() {
        return !!this.user;  // user 객체가 존재하면 로그인 상태
    },
    //페이징 
    
    // 특정 페이지로 이동
    prevPage() {
        if (this.pagination.currentPage > 1) {
            this.pagination.currentPage--;
        }
    },
    nextPage() {
        if (this.pagination.currentPage < this.totalPages) {
            this.pagination.currentPage++;
        }
    },
    goToPage(page) {
        this.pagination.currentPage = page;
    },


    //주변병원찾기
    showAllHospitals() {
    if (!this.allhoslist || this.allhoslist.length === 0) {
        console.warn("⚠️ 병원 데이터 없음! 마커를 추가하지 않음.");
        return;
    }

    console.log("🔄 전체 병원 마커 추가 시작! 기존 마커 삭제 중...");

    // ✅ 기존 마커 삭제 (데이터가 있을 때만!)
    if (this.markers.length > 0) {
        //this.clearMarkers();
    }

    this.allhoslist.forEach(hospital => {
        if (!hospital.NX || !hospital.NY) {
            console.warn("🚨 좌표 정보가 없는 병원:", hospital);
            return;
        }

        var position = new kakao.maps.LatLng(hospital.NY, hospital.NX);

        var marker = new kakao.maps.Marker({
            position: position,
            title: hospital.hosName || "이름 없음"
        });

        console.log("✅ 마커 추가됨:", marker, "병원 이름:", hospital.hosName);

        marker.setMap(this.map);
        this.markers.push(marker);

        kakao.maps.event.addListener(marker, "click", () => {
            this.showInfoWindowForSelect(marker, hospital);
        });
    });

    console.log("📍 모든 병원 마커 추가 완료! 총 개수:", this.markers.length);
}

,
    
    displayHospitals(data, hoslist) {
    console.log("displayHospitals" + hoslist); // hoslist의 내용 확인


    if (Array.isArray(hoslist) && hoslist.length > 0) {
        this.hoslist = hoslist; // hoslist에 데이터를 할당
    } 
}




,
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
addMarkersByCurrentLocation(latitude, longitude) {
    if (!this.hoslist || this.hoslist.length === 0) {
        console.warn("⚠ 병원 데이터가 없음! 마커 추가 중단");
        return;
    }
    console.log("🟢 내 주변 병원 마커 추가 시작");


    this.clearMarkers(); // 기존 마커 지우기
    console.log("clearMarkers4");

    this.hoslist.forEach(hospital => {
        const distance = this.calculateDistance(latitude, longitude, hospital.NY, hospital.NX);
        
        if (distance <= 1) {  // 1km 이내 병원만 표시
            const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
            const marker = new kakao.maps.Marker({
                position: position,
                title: hospital.hosName
            });

            marker.setMap(this.map);
            this.markers.push(marker);
            
            console.log("✅ 병원 마커 추가됨:", hospital.hosName, "거리:", distance);
        }
    });

    console.log("🔵 마커 추가 완료, 총 개수:", this.markers.length);
}
,

async getAddressFromCoords(latitude, longitude) {
    return new Promise((resolve, reject) => {
        var geocoder = new kakao.maps.services.Geocoder();
        
        var coord = new kakao.maps.LatLng(latitude, longitude);
        var callback = function(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                console.log("📌 현재 위치 주소 정보:", result);
                
                let guName = result[0].address.region_2depth_name;  // ✅ 구 이름 가져오기
                resolve(guName);
            } else {
                reject("주소 정보를 가져올 수 없습니다.");
            }
        };
        
        geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
    });
},
async moveToCurrentLocation(filterByDistance) {
    try {
        console.log("📍 현재 위치 가져오는 중...");
        const { latitude, longitude } = await this.getCurrentLocation();
        console.log("✅ 현재 위치 좌표:", latitude, longitude);

        const locPosition = new kakao.maps.LatLng(latitude, longitude);
        this.map.setCenter(locPosition);

        if (filterByDistance) {
            console.log("🔄 근처 병원 리스트 불러오는 중...");
            await this.fnMemberList();
        } else {
            console.log("🔄 전체 병원 리스트 불러오는 중...");
            await this.fnallhosList();
        }

        // ✅ 데이터 로딩 후 실행되도록 setTimeout 사용
        setTimeout(() => {
            console.log("📌 병원 리스트 불러오기 완료! 개수:", this.hoslist?.length);

            if (!this.hoslist || this.hoslist.length === 0) {
                console.warn("⚠️ 병원 데이터가 없음! 마커를 추가하지 않음.");
                return;
            }

            if (filterByDistance) {
                console.log("📌 1km 내 병원만 필터링 중...");
                this.addMarkersByCurrentLocation(latitude, longitude);
            } else {
                console.log("📌 모든 병원 마커 추가 실행!");
                this.showAllHospitals();  
            }
        }, 500); // 🔥 0.5초 뒤 실행 (데이터 로드 시간 확보)

    } catch (error) {
        console.error("🚨 오류 발생:", error);
        alert("병원 데이터를 가져오는 데 실패했습니다. 다시 시도해주세요! 🙏");
    }
}





,

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
    this.clearPartnerMarkers();
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
    this.clearPartnerMarkers(); // ✅ 기존 일반 마커 삭제

    console.log("Displaying partner places:", partnerlist);

    // 🎯 즐겨찾기된 제휴사 ID를 Set에 저장
    const favoritePartnerIds = new Set(this.favoritesList.map(fav => fav.partnerdetailId));

    // 🎯 카테고리별 마커 이미지 설정 함수
    const getMarkerImage = function(categoryCode, isFavorite) {
        if (isFavorite) {
            return "../img/3.png"; // 🎯 즐겨찾기된 제휴사 마커 이미지
        }

        switch (categoryCode) {
            case 1: return "../img/1.PNG";
            case 2: return "../img/medi.png";
            case 3: return "../img/2.PNG";
            case 4: return "../img/Amenities.png";
            default: return "../img/logo.png";
        }
    };

    // ✅ 각 제휴사에 대해 마커 생성
    partnerlist.forEach(partner => {
        if (!partner.NY || !partner.NX) return;

        const isFavorite = favoritePartnerIds.has(partner.partnerdetailId);
        
        // 🎯 즐겨찾기된 경우 일반 마커를 추가하지 않음
        if (isFavorite) {
            console.log(`🚀 ${partner.name || partner.hosName}은 즐겨찾기 되어 있음, 일반 마커 생략!`);
            return; 
        }

        var position = new kakao.maps.LatLng(partner.NY, partner.NX);
        var imageSrc = getMarkerImage(partner.categoryCode, false); // 🎯 일반 마커 이미지

        var markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(42, 42));

        var marker = new kakao.maps.Marker({
            position: position,
            image: markerImage,
            map: this.map
        });

        kakao.maps.event.addListener(marker, "click", () => {
            this.showInfoWindowForCategory(marker, partner);
        });

        this.partnerMarkers.push(marker);
    });

    // ✅ 지도 중심 이동
    if (partnerlist.length > 0) {
        var firstPartner = partnerlist[0];
        var centerPosition = new kakao.maps.LatLng(firstPartner.NY, firstPartner.NX);
        console.log("🗺 지도 중심 이동 →", centerPosition);
        this.map.setCenter(centerPosition);
    }
}



,
// 제휴사 마커만 삭제
clearPartnerMarkers() {
    console.log("🛑 clearPartnerMarkers() 실행됨! 기존 마커 개수:", this.partnerMarkers.length);
    this.partnerMarkers.forEach(marker => marker.setMap(null));
    this.partnerMarkers = [];
    console.log("✅ 모든 제휴사 마커 삭제 완료! 현재 개수:", this.partnerMarkers.length);
},
displayPartnerInfo(partner) {
    if (!partner || !partner.NY || !partner.NX) {
        console.error("🚨 올바른 위치 정보가 없습니다!", partner);
        return;
    }

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
    //this.clearMarkers(); 
    console.log("전달된 검색어:", keyword);
    var defaultGu = "인천광역시";
    var selectedGu = self.selectgu.GU || defaultGu; // 구 선택 없으면 '인천광역시' 사용
    var nparmap = {
        selectgu: self.selectgu.GU || "인천광역시",  // 기본값 인천광역시로 설정
        selectdong: self.selectdong.DONG || "",
        selectsi: self.selectsi || "인천광역시",
        keyword: self.keyword,
        userId: self.userId,
        categoryCode: self.categoryCode
    };
    console.log("🔍 서버 요청 파라미터 확인:", nparmap);
    $.ajax({
        url: "/partner/list.dox",
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: function(data) {
            console.log("📌 서버 응답 병원 리스트:", data.hoslist);

            // ✅ hoslist를 업데이트
            // ✅ hoslist 초기 업데이트
            if (data.hoslist && data.hoslist.length > 0) {
                self.hoslist = data.hoslist;
                console.log("✅ 병원 리스트 업데이트 완료! hoslist 길이:", self.hoslist.length);
            } else {
                console.warn("⚠️ 빈 병원 리스트 응답! 기존 리스트 유지!");
            }
        
console.log("✅ 병원 리스트 업데이트 완료! hoslist 길이:", self.hoslist.length);

// ✅ 병원 필터링 (있을 때만 적용)
if (self.selectdong.DONG) {
    const selectedDong = self.selectdong.DONG.replace(/[0-9]/g, "");
    const filteredList = self.hoslist.filter(hospital => hospital.hosAddress.includes(selectedDong));
    
    if (filteredList.length > 0) {
        self.hoslist = filteredList;
    }
    console.log("✅ 필터링 후 병원 리스트 길이:", self.hoslist.length);
}
            console.log("✅ 병원 리스트 업데이트 완료! hoslist 길이:", self.hoslist.length);
            self.addMarkers();
            // ✅ hoslist가 존재할 경우에만 showAllHospitals 호출
            if (self.hoslist.length > 0) {
                console.log("📢 showAllHospitals() 호출 직전!");
                self.showAllHospitals();  // hoslist로 마커 추가
            } else {
                console.warn("⚠️ 병원 데이터가 없어서 마커를 추가하지 않음!");
            }

            if (self.categoryCode) {
                nparmap.categoryCode = self.categoryCode;
            }

            if (self.selectdong.DONG) {
                self.hoslist = data.hoslist.filter(hospital => {
                    const hospitalAddress = hospital.hosAddress; 
                    const selectedDong = self.selectdong.DONG.replace(/[0-9]/g, ""); 
                    return hospitalAddress.includes(selectedDong);
                });
            } else {
                self.hoslist = data.hoslist;
                console.log("검색어:", self.keyword);
            }
            console.log("📌 서버 응답 전체 데이터:", data);
console.log("📌 서버 응답 병원 리스트:", data.hoslist);
            self.favoritesList = data.favoriteList;
            console.log("즐겨찾기 리스트:", self.favoritesList);

            // ✅ 마커 추가
            if (data) {
                self.gulist = Array.isArray(data.gulist) ? self.removeDuplicates(data.gulist, "GU") : [];
                self.donglist = Array.isArray(data.donglist) ? data.donglist : [];
                self.silist = Array.isArray(data.silist) ? data.silist : [];
                self.addMarkers();
            } else {
                console.warn("서버 응답이 비어 있습니다.");
            }
        },
        error: function(error) {
            console.error("🚨 병원 데이터 요청 실패:", error);
        }
    });
}

,
        

    
        removeDuplicates(arr, key) {
            return arr.filter((value, index, self) =>
                index === self.findIndex((t) => (
                    t[key] === value[key]
                ))
            );
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

    favoritesList = this.favoritesList; // 현재 favoritesList 가져오기
    console.log("🔍 전달된 partner 데이터:", partner);
   // console.log("showInfoWindowForSelect 호출됨", hospital);
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
    const textLength = partner.name.length * 10;
    const maxWidth = 300;
    const minWidth = 190;
    const dynamicWidth = Math.min(maxWidth, Math.max(minWidth, baseWidth + textLength));

    const baseHeight = 50;
    const addressLines = Math.ceil(partner.address.length / 20);
    const dynamicHeight = baseHeight + (addressLines * 18);

    let isFavorite = false;

    // 전달받은 favoritesList에서 hospitalNo에 해당하는 병원 찾기
    if (Array.isArray(favoritesList)) {  // favoritesList가 배열인지 확인
        for (let i = 0; i < favoritesList.length; i++) {
            if (favoritesList[i].partnerdetailId === partner.partnerdetailId) {
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
        "<strong>" + partner.name + "</strong><br>" +
        "<div style='white-space:pre-line;'>" + 
            (partner.address ? partner.address : "주소 정보 없음") + 
        "</div>" +
        (partner.phoneNumber  ? "<div style='margin-top:5px;'>📞 " + partner.phoneNumber   + "</div>" : "") +
        "<div style='display:flex; justify-content:space-between; margin-top:5px;'>" +
            "<a href='https://map.kakao.com/link/to/" + partner.name + "," + partner.NY + "," + partner.NX + 
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
            this.shareToKakao(partner.partnerdetailId, partner.name, partner.address, partner.phoneNumber);
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
                    await this.fnparRemoveFavorite(partner.partnerdetailId, partner.name, partner.address, this.userId, marker, partner);
                } else {
                    await this.fnparfavorites(partner.partnerdetailId, partner.name, partner.address, this.userId, marker, partner);
                }

                // 🟢 `this.favoritesList` 강제 업데이트
                this.favoritesList = [...this.favoritesList];  // Vue 반응성 유지

                // 🔄 최신 `isFavorite` 상태 다시 확인
                isFavorite = this.favoritesList.some(fav => fav.partnerdetailId === partner.partnerdetailId);

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
    const updatedPartnerList = [...this.partnerlist, ...this.favoritesList]; 
    this.addPartnerMarkers(updatedPartnerList);
}, 200);
            });
        }); // <-- ✅ 추가된 닫는 괄호!
    }); // <-- ✅ 추가된 닫는 괄호!
} // <


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
    // clearSearchResults() {
    //    // this.hoslist = [];
    //     this.keyword = '';
    // },


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
            console.log("clearMarkers1");
            this.addMarkers(selectedHospitals); // 선택된 구의 병원들만 마커로 추가

            // 선택된 구 내의 병원들을 포함하는 영역으로 지도 줌 조정
            this.map.setBounds(bounds); // 지도 영역을 해당 병원들이 모두 보이도록 설정
        }
    },
    // 📌 마커 추가 함수 (병원 리스트로 마커 업데이트)
    addMarkers() {
    // ✅ 이미 마커가 추가된 상태라면 실행 안 함!
    if (this.isMarkersAdded) {
        console.log("⚠️ 마커가 이미 추가되어 있어서 실행 안 함!");
        return;
    }

    console.log("✅ addMarkers 실행!");

    // 🎯 즐겨찾기 목록이 열려있으면 실행하지 않음
    if (this.isFavoritesVisible) {
        console.log("⏳ 즐겨찾기 목록이 열려 있어서 일반 마커 추가 안 함!");
        return;
    }

    // ✅ 마커가 있는 경우 `clearMarkers()` 실행 안 함!
    if (this.markers.length > 0) {
        console.log("⚠️ 기존 마커가 남아 있으므로 삭제 안 함!");
    } else {
        this.clearMarkers(); // 기존 마커 삭제
        console.log("🗑 마커 삭제 완료!");
    }

    if (this.hoslist.length === 0) {
        console.log("⚠️ 병원 데이터가 없어서 마커 추가 안 함!");
        return;
    }

    this.isMarkersAdded = true; // 마커 추가 플래그 설정

    const favoritePositions = new Map();
    this.favoritesList.forEach(fav => {
        favoritePositions.set(fav.NY + "," + fav.NX, fav);
    });

    this.hoslist.forEach(hospital => {
        var positionKey = hospital.NY + "," + hospital.NX;
        var position = new kakao.maps.LatLng(hospital.NY, hospital.NX);

        var marker;
        if (favoritePositions.has(positionKey)) {
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
            marker = new kakao.maps.Marker({
                position: position,
                title: hospital.hosName
            });
        }

        marker.setMap(this.map);

        kakao.maps.event.addListener(marker, "click", () => {
            this.showInfoWindowForSelect(marker, hospital);
        });

        this.markers.push(marker);
    });

    console.log("✅ 모든 병원 마커 추가 완료! 총 개수:", this.markers.length);
}



,
clearMarkers(clearAll = true) {
    if (this.markers.length === 0) {
        console.log("⚠️ 마커가 없어서 clearMarkers 실행 안 함!");
        return;
    }

    console.log("❌ clearMarkers() 실행됨!! 마커 삭제!");

    if (clearAll) {
        this.markers.forEach(marker => marker.setMap(null));
        this.markers = [];
        console.log("모든 마커 삭제 완료");
    }
}

,



// 📌 마커 추가 함수 (병원 리스트로 마커 업데이트)
addHospitalMarkers() {
    console.log("📍 즐겨찾기 병원 마커 추가 시작!");

    if (this.favoritesList.length === 0) {
        console.warn("⚠️ 즐겨찾기 병원이 없음!");
        return;
    }

    this.favoritesList.forEach(hospital => {
        var position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
        var favoriteMarkerImage = new kakao.maps.MarkerImage(
            '../img/3.png',
            new kakao.maps.Size(40, 40),
            { offset: new kakao.maps.Point(20, 40) }
        );

        var marker = new kakao.maps.Marker({
            position: position,
            title: hospital.hosName,
            image: favoriteMarkerImage
        });

        marker.setMap(this.map);
        this.markers.push(marker);

        console.log("✅ 병원 마커 추가됨:", hospital.hosName, position);

        // ⭐ 마커 클릭 시 인포윈도우 표시
        kakao.maps.event.addListener(marker, "click", () => {
            console.log("💡 마커 클릭됨!", hospital);
            this.showInfoWindowForSelect(marker, hospital);
        });
    });

    console.log("📍 병원 마커 추가 완료! 총 개수:", this.markers.length);
}





,

addPartnerMarkers() {
    console.log("📍 즐겨찾기 제휴사 마커 추가 시작! favoritePartners 개수:", this.favoritePartners.length);

    if (!this.favoritePartners || this.favoritePartners.length === 0) {
        console.warn("⚠️ 즐겨찾기 제휴사 목록이 없음!");
        return;
    }

    this.favoritePartners.forEach(partner => {
        if (!partner.NX || !partner.NY || partner.NX === "0" || partner.NY === "0") {
            console.warn("🚨 좌표가 없음!", partner);
            return;
        }

        var position = new kakao.maps.LatLng(parseFloat(partner.NY), parseFloat(partner.NX));
        var favoriteMarkerImage = new kakao.maps.MarkerImage(
            '../img/3.png',
            new kakao.maps.Size(40, 40),
            { offset: new kakao.maps.Point(20, 40) }
        );

        var marker = new kakao.maps.Marker({
            position: position,
            title: partner.name || partner.hosName,
            image: favoriteMarkerImage
        });

        marker.setMap(this.map);
        this.favoritePartnerMarkers.push(marker);

        // 🎯 **클릭 시 인포윈도우 띄우기**
        kakao.maps.event.addListener(marker, "click", () => {
    console.log("🎯 마커 클릭됨!", partner);

    this.showInfoWindowForCategory(marker, {
        name: partner.hosName, // name 필드 맞춰서 전달
        address: partner.hosAddress, // address 필드 맞추기
        phoneNumber: partner.phone, // phone 필드 맞추기
        NX: partner.NX,
        NY: partner.NY,
        partnerdetailId: partner.partnerdetailId // ID도 포함
    });
});


        console.log("✅ 즐겨찾기 마커 추가됨:", partner.hosName, position);
    });

    console.log("📍 즐겨찾기 마커 추가 완료! 총 개수:", this.favoritePartnerMarkers.length);
}












,

// 즐겨찾기 마커만 삭제
clearFavoriteMarkers() {
    if (!this.favoritePartnerMarkers) {
        //console.warn("⚠️ favoritePartnerMarkers가 undefined! 초기화함.");
        this.favoritePartnerMarkers = [];
    }

    //console.log("🛑 clearFavoriteMarkers() 실행됨! 기존 마커 개수:", this.favoritePartnerMarkers.length);

    this.favoritePartnerMarkers.forEach(marker => marker.setMap(null));
    this.favoritePartnerMarkers = [];

    //console.log("✅ 모든 즐겨찾기 마커 삭제 완료! 현재 개수:", this.favoritePartnerMarkers.length);
},

toggleFavoritesList() {
    //console.log("🟢 toggleFavoritesList() 실행됨! 현재 상태:", this.isFavoritesVisible);
    //console.log("📢 현재 즐겨찾기 목록:", this.favoritesList);

    this.isFavoritesVisible = !this.isFavoritesVisible;

    if (this.isFavoritesVisible) {
        //console.log("🎯 즐겨찾기 모드 활성화!");

        this.clearMarkers();  // 기존 병원 마커 삭제
        console.log("clearMarkers3");
        this.clearPartnerMarkers();  // 기존 제휴사 마커 삭제 (이제 삭제해도 됨!)

        this.addHospitalMarkers();
        // this.favoritePartners = this.favoritesList.filter(fav => fav.partnerdetailId);
        
        //console.log("✅ 즐겨찾기 제휴사 필터링 완료! 개수:", this.favoritePartners.length);
        
        this.addPartnerMarkers();  // 🎯 즐겨찾기 제휴사 마커 추가!

    } else {
        //console.log("❌ 즐겨찾기 목록 닫힘");

        this.clearFavoriteMarkers();  // 즐겨찾기 마커 삭제

        this.addMarkers();  // 일반 병원 마커 다시 표시

        // ✅ 여기서 현재 선택한 카테고리 필터링해서 제휴사 마커 다시 표시!
        this.filterByCategory(this.selectedCategory);
    }
},

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
//                 setTimeout(() => {
//     console.log("🔄 즐겨찾기 변경 후 마커 다시 추가!");

//     // 기존 병원 리스트 + 즐겨찾기 병원 리스트 합쳐서 마커 추가
//     const updatedHospitalList = [...this.partnerlist, ...this.favoritesList]; 

//     this.addHospitalMarkers(updatedHospitalList);
// }, 200);
            });
        }); // <-- ✅ 추가된 닫는 괄호!
    }); // <-- ✅ 추가된 닫는 괄호!
} // <-- ✅ 함수 닫는 괄호!

    

,



        

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
            }
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
    var nparmap = { 
        partnerdetailId : partnerdetailId,
        name : name ,
        address : address,
        userId : userId
    };

    $.ajax({
        url: "/favorites/partner/add.dox",
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: function(data) {  
                    console.log(data);
                    if (data.result === "success") {
                        alert(name + " 즐겨찾기에 추가되었습니다! ⭐");
                        document.getElementById("favoriteStar").innerText = "★";  // 별을 채운 별로 변경

                        self.fnfavorList();
                        
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







        fnRemoveFavorite(hospitalNo, hosName, hosAddress, userId, marker, hospital) {
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

                // ⭐ 즉시 UI 업데이트 (빈 별로 변경)
                const starElement = document.getElementById("favoriteStar");
                if (starElement) {
                    starElement.innerText = "☆";  
                    console.log("⭐ 별 아이콘 빈 별로 변경 완료!");
                }

                // ✅ 최신 즐겨찾기 목록 불러오기
                self.fnfavorList();
                console.log("🎯 즐겨찾기 목록 갱신 완료");

                // 기존 InfoWindow 닫기
                // if (self.infoWindow) {
                //     self.infoWindow.close();
                //     self.infoWindow = null;
                // }

                // **현재 페이지 상태에 따라 다른 함수 호출**
                // setTimeout(() => {
                //     if (hospital) {
                //         // 카테고리 기반 조회라면 해당 인포창 다시 표시
                //         self.showInfoWindowForSelect(marker, hospital);
                //     } 
                // }, 150);
            }
        },
        error: function(xhr, status, error) {
            console.error("❌ 즐겨찾기 삭제 오류:", error);
        }
    });
}
,


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

                // ⭐ 즉시 UI 업데이트
                const starElement = document.getElementById("favoriteStar");
                if (starElement) {
                    starElement.innerText = "☆";  // 빈 별로 변경
                }

                // ✅ 최신 즐겨찾기 리스트 불러오기
                self.fnfavorList();
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

            self.favoritesList = data.favorList.map(fav => ({
                ...fav,
                NX: fav.NX ? parseFloat(fav.NX) : null,
                NY: fav.NY ? parseFloat(fav.NY) : null
            }));

            console.log("🔍 변환된 favoritesList:", self.favoritesList);

            self.favoritePartners = self.favoritesList.filter(fav => fav.partnerdetailId);
            console.log("✅ 즐겨찾기 파트너 필터링 완료:", self.favoritePartners);
        },
        error: function (xhr, status, error) {
            console.error("❌ 즐겨찾기 목록 가져오기 실패:", xhr.responseText);
        }
    });
},


fnallhosList() {
    var self = this;
    var nparmap = {};  // 모든 병원 조회할 때는 필터 없이 요청

    $.ajax({
        url: "/partner/alllist.dox",  // 서버에서 전체 병원 리스트 반환해야 함
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: function (data) {
            console.log("⭐ 전체 병원 리스트 응답 데이터:", data);

            // ✅ 데이터가 없을 경우 대비 (기존 데이터 유지!)
            if (data.allhoslist && data.allhoslist.length > 0) {
                self.allhoslist = data.allhoslist;
                self.hoslist = data.allhoslist;
                console.log("✅ 전체 병원 리스트 저장 완료! 개수:", self.allhoslist.length);
            } else {
                console.warn("⚠️ 서버에서 빈 병원 리스트 응답! 기존 리스트 유지!");
            }

            console.log("📌 최종 병원 리스트 길이:", self.hoslist.length);
        
            // ✅ 병원 데이터 있을 때만 마커 추가!
            if (self.hoslist.length > 0) {
                self.showAllHospitals();
            } else {
                console.warn("⚠️ 병원 데이터가 없어서 마커 추가 안 함!");
            }
        },
        error: function (error) {
            console.error("🚨 병원 데이터 불러오기 실패:", error);
        }
    });
}

,
    },

    mounted() {
    console.log("🚀 초기 지도 로딩 시작!");

    console.log("🚀 초기 지도 로딩 시작!");
    this.isFavoritesVisible = false;
    this.initializeMap();  
    this.updateMap();      

    // ✅ 병원 리스트 가져온 후 실행!
    this.fnallhosList().then(() => {
        console.log("🏥 전체 병원 리스트 로드 완료!");
        this.showAllHospitals(); // 마커 추가!
    });

    this.fnfavorList();  // 즐겨찾기 목록 로드
    this.moveToCurrentLocation(false);    
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