<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
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
                <li id="AD5" data-order="0" @click="filterByCategory('숙소')"> 
                    <span class="category_bg accommodation"></span>
                    숙소
                </li>       
                <li id="MT1" data-order="1" @click="filterByCategory('식당')"> 
                    <span class="category_bg mart"></span>
                    식당
                </li>  
                <li id="PM9" data-order="2" @click="filterByCategory('카페')"> 
                    <span class="category_bg pharmacy"></span>
                    카페
                </li>  
                <li id="OL7" data-order="3" @click="filterByCategory('공원')"> 
                    <span class="category_bg oil"></span>
                    공원
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
                        <button @click="toggleFavoritesList()" 
                            style="padding:10px; background:#FFD700; border:none; border-radius:5px; font-weight:bold; cursor:pointer;">
                            ⭐ 즐겨찾기 목록
                        </button>
                        <div>
                            검색 : <input v-model="keyword" type="text" placeholder="병원 이름을 검색하세요" @keyup.enter="searchPlaces" @click="searchPlaces">
                        </div>
                        <button type="searchPlaces">검색하기</button> <!-- type="submit"으로 유지 -->
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
                    <li v-if="!isFavoritesVisible" v-for="(hospital, index) in hoslist" :value="hospital.hospitalNo">
                        
                        <div>{{ hospital.hosName }}</div>
                        <span>{{ hospital.hosAddress }}</span>
                        <hr>
                    </li>
                    <ul id="search-results"></ul>
                    <!-- <ul v-if="hoslist.length > 0 && !isFavoritesVisible">
                        <li v-for="(hospital, index) in hoslist" :key="index">
                            <div>{{ hospital.place_name }}</div>
                            <span>{{ hospital.address_name }}</span>
                            <hr>
                        </li>
                        </ul> -->
                    <!-- 즐겨찾기 목록이 표시될 때 -->
                    <div v-if="isFavoritesVisible" class="favorites-list">
                        <h3>⭐ 내 즐겨찾기 목록</h3>
                        <ul>
                            <li v-for="hospital in favoritesList" :key="hospital.hospitalNo">
                                {{ hospital.hosName }} - {{ hospital.hosAddress }}
                                <button @click="fnRemoveFavorite(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, userId)">
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
            favoritesList: [],
            sessionId : "${sessionId}",
            userId: "${sessionId}",
            hosName : "",
            hosAddress : "",
            hospitalNo : "",
            keyword: "",
            places: [],
            isFavoritesVisible: false,
            isLoggedIn: false,
            markers: [],
            map: null,
            gulist: [],
            donglist: [],
            silist: [],
            hoslist: [],
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
        partnerlist : []
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

    async moveToCurrentLocation() {
          try {
            // 현재 위치를 가져옴
            const { latitude, longitude } = await this.getCurrentLocation();
            
            // 카카오맵의 LatLng 객체 생성
            const locPosition = new kakao.maps.LatLng(latitude, longitude);
            
            // 지도 중심을 현재 위치로 이동
            this.map.setCenter(locPosition);

            // 마커를 현재 위치에 표시
            // const marker = new kakao.maps.Marker({
            //   position: locPosition,
            // });
            // marker.setMap(this.map);

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
    toggleFavoritesList() {
        if (!this.userId) {
            alert("로그인이 필요합니다! 😊");
            return;
        }
        
        // 즐겨찾기 목록을 보여줄 때
        if (!this.isFavoritesVisible) {
            this.hoslist = [];  // 병원 목록을 아예 지움
            this.fnfavorList(); // 즐겨찾기 목록 불러오기
        } else {
            this.fnMemberList(); // 병원 목록 불러오기
        }

        // 즐겨찾기 목록 표시 상태를 토글
        this.isFavoritesVisible = !this.isFavoritesVisible;
    },
 // 카테고리별 필터링 함수
 filterByCategory(category) {
        // 1. partnerlist에서 해당 카테고리에 맞는 제휴사만 필터링
        const filteredList = this.partnerlist.filter(partner => partner.category === category);

        // 2. 기존 마커 삭제
        this.clearMarkers();

        // 3. 필터링된 리스트로 지도에 마커 표시
        this.displayMarkers(filteredList);
    },

    // 지도에 마커 표시하는 함수
    displayMarkers(partnerList) {
        partnerList.forEach(partner => {
            const marker = new kakao.maps.Marker({
                map: this.map,
                position: new kakao.maps.LatLng(partner.lat, partner.lng)
            });
            this.markers.push(marker);
        });
    },

    // 기존 마커 삭제
    clearMarkers() {
        this.markers.forEach(marker => marker.setMap(null));
        this.markers = [];
    }
,
        fnMemberList(keyword = "") {
            var self = this;
            console.log("전달된 검색어:", keyword);
            var nparmap = {
                selectgu: self.selectgu.GU,
                selectdong: self.selectdong.DONG,
                selectsi: self.selectsi,
                keyword:  self.keyword,
                userId : self.userId
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
                    console.log(data.partnerlist);
                    self.pagination.last = Math.ceil(data.count / self.pagination.perPage);  // ✅ 총 페이지 수 업데이트
                    
                    if (data && data.pagination) {
                        self.pagination.last = data.pagination.last;
                        self.displayPagination();                     
                    } else {
                        console.warn("서버 응답에 pagination 정보가 없음");
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
        this.fnMemberList(keyword);  // 서버에서 병원 리스트만 호출
    } else {
        this.fnMemberList();  // 기본 병원 리스트 호출
    }
    
    const ps = new kakao.maps.services.Places();
    const location = new kakao.maps.LatLng(37.4563, 126.7052);  // 인천의 중심 좌표 (위도, 경도)
    
    const options = {
        location: location,  // 검색 범위를 인천으로 설정
        radius: 10000  // 반경 10km 내의 장소만 검색
    };

    // 병원 이름 검색
    ps.keywordSearch(keyword, (data, status, pagination) => {
        if (status === kakao.maps.services.Status.OK) {
            // 중복 병원 제거
            const uniqueData = this.removeDuplicates(data);

            if (uniqueData.length > 0) {
                this.displayPlaces(uniqueData, pagination);
                
                // 첫 번째 검색 결과의 위치로 지도 이동
                const firstPlace = uniqueData[0];
                const position = new kakao.maps.LatLng(firstPlace.y, firstPlace.x);
                this.map.setCenter(position); // 지도 이동
            } else {
                alert('검색된 병원이 없습니다.');
            }
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            alert('검색 결과가 존재하지 않습니다.');
        } else if (status === kakao.maps.services.Status.ERROR) {
            alert('검색 결과 중 오류가 발생했습니다.');
        }
    }, options);
}
,

        

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
//카테고리
displayCategoryPlaces(data, pagination, category) {
    this.places = data;  // data를 places에 할당
    this.pagination.pages = Array.from({ length: pagination.last }, (_, i) => i + 1);
    this.clearMarkers(); // 기존 마커 제거

    const bounds = new kakao.maps.LatLngBounds();

    // 카테고리별 마커를 추가
    data.forEach((place) => {
        const position = new kakao.maps.LatLng(place.y, place.x);
        const marker = this.addMarker(position, place);

        // 📌 마커 클릭 이벤트 추가
        kakao.maps.event.addListener(marker, "click", () => {
            this.showInfoWindowForCategory(marker, place, category);
        });

        bounds.extend(position);

        // 여기에 `hoslist`에 병원 정보를 추가
        this.hoslist.push({
            hosName: place.place_name,
            hosAddress: place.address_name,
            phone: place.phone || '정보 없음',
            lat: place.y,
            lng: place.x,
            category: category // 카테고리 추가
        });
    });

    // 지도 범위 설정
    this.map.setBounds(bounds);
    setTimeout(() => {
        this.map.setLevel(4);
    }, 500);
},

    showInfoWindowForCategory(marker, place, category) {
        var content = "<div class='placeinfo'>" +
                        "<a class='title' href='" + place.place_url + "' target='_blank' title='" + place.place_name + "'>" + place.place_name + "</a>";

        if (place.road_address_name) {
            content += "<span title='" + place.road_address_name + "'>" + place.road_address_name + "</span>" +
                        "<span class='jibun' title='" + place.address_name + "'>(지번 : " + place.address_name + ")</span>";
        } else {
            content += "<span title='" + place.address_name + "'>" + place.address_name + "</span>";
        }

        content += "<span class='tel'>" + place.phone + "</span>" +
                    "<div class='category'>카테고리: " + category + "</div>" +
                    "</div>" +
                    "<div class='after'></div>";

        // 커스텀 오버레이로 장소 정보 표시
        this.placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
        this.placeOverlay.setContent(content);
        this.placeOverlay.setMap(this.map);
    }
    ,
    ///1
    
    displayPlaces(data, pagination) {
    if (!this.map) {
        console.error("지도 객체가 초기화되지 않았습니다.");
        return; // map이 초기화되지 않았다면 더 이상 진행하지 않음
    }

    const listContainer = document.getElementById('placesList');
    listContainer.innerHTML = ''; // 기존 내용 지우기

    data.forEach(place => {
        const listItem = document.createElement('li');
        
        // 병원 이름과 주소를 각각 다른 줄로 표시
        listItem.innerHTML = place.place_name + "<br>" + place.address_name; // <br>을 삽입

        listContainer.appendChild(listItem);

        // 마커 표시
        const position = new kakao.maps.LatLng(place.y, place.x);
        const marker = new kakao.maps.Marker({
            map: this.map,
            position: position
        });

        // 마커 클릭시, 해당 위치로 지도 이동
        kakao.maps.event.addListener(marker, 'click', () => {
            this.map.setCenter(position); // this.map을 참조
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
        this.clearMarkers(); // 이전 마커 제거

        if (this.hoslist.length === 0) {
            console.warn("병원 리스트가 비어 있습니다.");
            return;
        }

        //let bounds = new kakao.maps.LatLngBounds(); // 📌 지도 영역 조절 객체 생성

        this.hoslist.forEach((hospital) => {
            const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
            const marker = new kakao.maps.Marker({
                position: position,
                title: hospital.hosName
            });

            marker.setMap(this.map);
            //bounds.extend(position); // 📌 모든 마커를 포함하는 영역 확장

            kakao.maps.event.addListener(marker, "click", () => {
                this.showInfoWindowForSelect(marker, hospital);
            });

            this.markers.push(marker);
        });


    },

    // 단일 마커 추가(검색어 입력시)
    addMarker(position, place) {
        const marker = new kakao.maps.Marker({
            position: position,
            title: place.place_name
        });

        marker.setMap(this.map);

        // 📌 마커 클릭 시 병원 정보 표시 (키워드 검색 기반)
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
     showInfoWindowForSelect(marker, hospital) {
    favoritesList = this.favoritesList; // 현재 favoritesList 가져오기
    console.log("showInfoWindowForSelect 호출됨", hospital);
    console.log("현재 사용자 ID:", this.userId);
    console.log("favoritesList:", favoritesList); // favoritesList 확인
   
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
        // 즐겨찾기 버튼 클릭 시 이벤트 처리
        document.getElementById("favoritesButton").addEventListener("click", () => {
    console.log("현재 즐겨찾기 상태:", this.isFavorite ? "★ (즐겨찾기됨)" : "☆ (즐겨찾기 아님)");
    if (!this.userId) {  
        alert("로그인이 필요합니다! 😊");
        return; // 로그인 안된 상태에서는 더 이상 진행하지 않음
    }
    //document.getElementById("hoslist").innerHTML = '';
    if (isFavorite) {
        // 이미 즐겨찾기된 상태 → 삭제만 가능
        this.fnRemoveFavorite(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, this.userId, marker, hospital);
    } else {
        // 즐겨찾기 안 된 상태 → 추가만 가능
        this.fnfavorites(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, this.userId, marker, hospital);
    }

    // 상태 변경
    this.isFavorite = !this.isFavorite;

    // UI 업데이트 (별 색깔 & 인포창)
    setTimeout(() => {
        this.showInfoWindowForSelect(marker, hospital);
    }, 100); 
});
    });
}


,

        clearMarkers() {
            this.markers.forEach(marker => marker.setMap(null));
            this.markers = [];
        },

        gotoPage(page) {
            this.pagination.current = page;
            this.fnMemberList();
        },

        updateMap() {
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
                lat = this.selectdong.NX;
                lng = this.selectdong.NY;
                this.moveToLocation(this.selectdong);
                return;
            } else if (this.selectgu && this.selectgu.NX && this.selectgu.NY) {
                lat = this.selectgu.NX;
                lng = this.selectgu.NY;
                this.moveToLocation(this.selectgu);
                return;
            } else {
                lat = 37.4101013788811; // 기본값: 인천
                lng = 126.678274850516;
                console.warn("선택된 구/동이 없습니다. 기본 좌표 사용.");
            }
    
            this.map.setCenter(new kakao.maps.LatLng(lat, lng));
        },

        updateMapWithCoordinates(lat, lng) {
            if (this.map) {
                this.map.setCenter(new kakao.maps.LatLng(lat, lng));
            }
        },

        moveToLocation(data) {
            let self = this;

            if (!data.NX || !data.NY) {
                console.warn("좌표 값이 없습니다. 기본 좌표로 이동합니다.");
                self.updateMapWithCoordinates(37.566826, 126.9786567); // 서울 기본 좌표
                return;
            }

            const lat = data.NX;
            const lng = data.NY;
            self.updateMapWithCoordinates(lat, lng);
        },
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
                url: "/favorites/add.dox",
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
                        if (self.infoWindow) {
                            self.infoWindow.close();  // 기존 InfoWindow 닫기
                            self.infoWindow = null;   // InfoWindow 객체 초기화
                        }

                        // 잠시 기다린 후에 InfoWindow 다시 열기
                        setTimeout(() => {
                            self.showInfoWindowForSelect(marker, hospital);  // 'self'를 사용하여 올바르게 this 참조
                        }, 100); // 잠시 기다렸다가 InfoWindow 다시 열기
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
            url: "/favorites/remove.dox",
            dataType: "json",
            type: "POST",
            data: nparmap,
            success: function(data) {
                console.log("해제:" + data);
                if (data.result == "success") {
                    alert(hosName + " 즐겨찾기에서 해제되었습니다.");

                    // UI 업데이트
                    self.fnfavorList();

                    // 기존 InfoWindow 닫기 (100ms 지연)
                    if (self.infoWindow) {
                        self.infoWindow.close();
                        self.infoWindow = null;
                    }

                    // UI 반영을 위해 상태 변경 후 150ms 후에 InfoWindow 다시 열기
                    setTimeout(() => {
                        self.showInfoWindowForSelect(marker, hospital);
                    }, 150);
                }
            }
        });
    },
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
    fnfavorList () {
        var self = this;
        var nparmap = {
                userId : self.userId
        };
        $.ajax({
            url: "/favorites/list.dox",
            dataType: "json",
            type: "POST",
            data: nparmap,
            success: function (data) {
                console.log("제발",data);
                self.favoritesList = data.favorList;

                
            }
        });

        
    },
        
    },

    mounted() {
        this.initializeMap();
        this.updateMap(); // 기본 지도 설정
        this.fnMemberList();
        this.fnfavorList();

        
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