<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" class="map">
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
   <script src="https://t1.kakaocdn.net/kakao_js_sdk/v1/kakao.js"></script> 
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800c01d76232f2ef59e7ddffd882cefb&libraries=services"></script>
    <script>
        Kakao.init('800c01d76232f2ef59e7ddffd882cefb'); // 사용하려는 앱의 JavaScript 키 입력
      </script>
      <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
      <link rel="stylesheet" type="text/css" href="/css/partner/partner.css">
    <title>첫번째 페이지</title>
   
</head>
<body>
    <jsp:include page="/WEB-INF/common/header.jsp" />
    <div id="app">
      <div class="map_wrap">
        <div
          id="map"
          style="width: 100%; height: 100%; position: relative; overflow: hidden;"
        ></div>
  
        <ul id="category">
          <li id="MT1" data-order="0" @click="filterByCategory(1)">
            <span class="category_bg accommodation">🏨</span> 숙소
          </li>
          <li id="MT1" data-order="1" @click="filterByCategory(2)">
            <span class="category_bg mart">🍽️</span> 식당
          </li>
          <li id="PM9" data-order="2" @click="filterByCategory(3)">
            <span class="category_bg pharmacy">📸</span> 관광지
          </li>
          <li id="OL7" data-order="3" @click="filterByCategory(4)">
            <span class="category_bg oil">🏪</span> 편의시설
          </li>
        </ul>
  
        <div id="menu_wrap" class="bg_white">
          <div class="option">
            <form @submit.prevent="updateMap">
              <div style="margin-bottom: 10px;">인천광역시</div>
  
              <select
                v-model="selectgu"
                @change="updateMap"
                class="selectBox"
                style="margin-right: 10px;"
              >
                <option value="">선택</option>
                <option v-for="item in gulist" :value="item">{{ item.GU }}</option>
              </select>
  
              <select v-model="selectdong" @change="updateMap" class="selectBox">
                <option value="">선택</option>
                <option v-for="item in donglist" :value="item">{{ item.DONG }}</option>
              </select>
  
              <div class="search-row">
                <label for="keyword" style="font-weight: bold;">검색 :</label>
                <input v-model="keyword" id="keyword" type="text" placeholder="병원 이름 검색" @keyup.enter="searchPlaces"/>
                <button @click="searchPlaces" class="search-btn">검색</button>
              </div>
  
              <div class="button-row">
                <button @click="toggleFavoritesList" class="favorites-toggle-btn">⭐ 즐겨찾기 목록</button>
                <button @click="moveToCurrentLocation(true)" class="nearby-btn">📍 근처 병원 보기</button>
              </div>
            </form>
          </div>
  
          <hr />
  
          <ul id="placesList">
            <!-- 검색된 병원 및 제휴사 수 -->
            <div v-if="visiblePartnerList.length > 0 && !isFavoritesVisible" class="count">
              총 {{ visiblePartnerList.length }}개 제휴사가 검색되었습니다.
            </div>
  
            <div v-if="currentView === 'hospital' && hoslist.length > 0 && !isFavoritesVisible" class="count">
              총 {{ hoslist.length }}개 병원이 검색되었습니다.
              <hr />
              <div v-if="currentView === 'hospital'">
                <button @click="prevPage" :disabled="pagination.currentPage === 1">이전</button>
                <span v-for="page in totalPages || 1" :key="page">
                  <button @click="goToPage(page)">{{ page }}</button>
                </span>
                <button @click="nextPage" :disabled="pagination.currentPage === totalPages">다음</button>
              </div>
            </div>
  
            <div v-if="visiblePartnerList.length > 0 || currentView === 'partner'">
              <button @click="prevPartnerPage" :disabled="partnerPagination.currentPage === 1">이전</button>
              <span v-for="page in partnerPaginationButtons" :key="'partner-page-' + page">
                <button @click="goToPartnerPage(page)" :class="{ active: page === partnerPagination.currentPage }">
                  {{ page }}
                </button>
              </span>
              <button @click="nextPartnerPage" :disabled="partnerPagination.currentPage === partnertotalPages">다음</button>
            </div>
  
            <ul v-if="currentView === 'hospital' && !isFavoritesVisible">
              <li v-for="(hospital, index) in paginatedHospitals" :key="'hos-' + hospital.hospitalNo" @click="moveToLocation(hospital)">
                <div>{{ hospital.hosName }}</div>
                <span>{{ hospital.hosAddress }}</span>
                <hr />
              </li>
  
              <li v-for="(partner, index) in paginatedPartners" :key="'partner-' + partner.partnerdetailId" @click="moveToLocation(partner)">
                <div>{{ partner.name }}</div>
                <span>{{ partner.address }}</span>
                <hr />
              </li>
            </ul>
  
            <div v-if="isFavoritesVisible" class="favorites-list">
              <h3>⭐ 내 즐겨찾기 목록</h3>
              <ul>
                <!-- 병원 즐겨찾기 -->
                <li v-for="favorite in favoritesList.filter(fav => fav.hospitalNo)" :key="'hospital-' + favorite.hospitalNo" @click="moveToLocation(favorite)">
                  <div>
                    <strong>{{ favorite.hosName }}</strong> - {{ favorite.hosAddress }}
                  </div>
                  <button @click="fnRemoveFavorite(favorite.hospitalNo, favorite.hosName, favorite.hosAddress, userId)">
                    ❌ 삭제
                  </button>
                  <hr />
                </li>
  
                <!-- 파트너 즐겨찾기 -->
                <li v-for="item in favoritesList.filter(fav => fav.partnerdetailId)" :key="'partner-' + item.partnerdetailId + '-' + item.userId" @click="moveToLocation(item)">
                  <div>
                    <strong>{{ item.name }}</strong> - {{ item.address }}
                  </div>
                  <button
                    @click="fnparRemoveFavorite(item.partnerdetailId, item.name, item.address, userId)"
                  >
                    ❌ 삭제
                  </button>
                  <hr />
                </li>
              </ul>
            </div>
          </ul>
        </div>
      </div>
    </div>
  </body>
  </html>
  

<script>
    const app = Vue.createApp({
    data() {
        
        return {
            currentView : 'hospital',
            favoritePartnerMarkers : [],
            partnerMarkers: [],  // 제휴사 마커 배열 초기화
            favoriteMarkers: [], // 즐겨찾기 마커 배열 초기화
            visiblePartnerList: [],
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
            partnerKeyword: '',
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
         
            pagination: 
            {
            currentPage: 1,  // ✅ 현재 페이지
            perPage: 10,      // ✅ 한 페이지당 표시할 아이템 수
            last: 1,          // ✅ 마지막 페이지 (일단 기본값 1)
            },    
         // 제휴사용
            partnerPagination: 
            {
                currentPage: 1,
                itemsPerPage: 10
            },   
            category : "",
            filteredPartnerlist: []
    };
},
    computed: {
        // 총 페이지 수 계산
        totalPages() {
            return Math.ceil(this.hoslist.length / this.pagination.perPage);
        },
        paginatedHospitals() {
            const start = (this.pagination.currentPage - 1) * this.pagination.perPage;
            return this.hoslist.slice(start, start + this.pagination.perPage);
        },
        partnertotalPages() {
            return Math.ceil(this.visiblePartnerList.length / this.partnerPagination.itemsPerPage);
        },
        paginatedPartners() {
            const start = (this.partnerPagination.currentPage - 1) * this.partnerPagination.itemsPerPage;
            return this.visiblePartnerList.slice(start, start + this.partnerPagination.itemsPerPage);
        },

        partnerPaginationButtons() {
            const total = this.partnertotalPages;
            const current = this.partnerPagination.currentPage;

            const groupSize = 5;
            const groupStart = Math.floor((current - 1) / groupSize) * groupSize + 1;
            const groupEnd = Math.min(groupStart + groupSize - 1, total);

            const buttons = [];
            for (let i = groupStart; i <= groupEnd; i++) {
            buttons.push(i);
            }
            return buttons;
        }
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
    
     // 병원용
        goToPage(page) {
            this.pagination.currentPage = page;
        },
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

        // 제휴사용
        goToPartnerPage(page) {
            this.partnerPagination.currentPage = page;
        },
        prevPartnerPage() {
            if (this.partnerPagination.currentPage > 1) {
            this.partnerPagination.currentPage--;
            }
        },
        nextPartnerPage() {
            if (this.partnerPagination.currentPage < this.partnertotalPages) {
            this.partnerPagination.currentPage++;
            }
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
            this.clearMarkers();
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
        },
    
        displayHospitals(data, hoslist) {
        console.log("displayHospitals" + hoslist); // hoslist의 내용 확인


        if (Array.isArray(hoslist) && hoslist.length > 0) {
            this.hoslist = hoslist; // hoslist에 데이터를 할당
        } 
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
        addMarkersByCurrentLocation(latitude, longitude) {
            if (!this.hoslist || this.hoslist.length === 0) {
                console.warn("⚠ 병원 데이터가 없음! 마커 추가 중단");
                return;
            }

            console.log("🟢 마커 추가 시작");

            this.clearMarkers(false); // 기존 마커 지우기

            this.hoslist.forEach(hospital => {
                const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
                const marker = new kakao.maps.Marker({
                    position: position,
                    title: hospital.hosName
                });

                // ✅ 인포윈도우 표시 함수 연결
                kakao.maps.event.addListener(marker, 'click', () => {
                    this.showInfoWindowForSelect(marker, hospital);  // <-- 여기서 연결!
                });

                marker.setMap(this.map);
                this.markers.push(marker);

                console.log("✅ 마커 + 인포윈도우 연결됨:", hospital.hosName);
            });

            console.log("🔵 마커 추가 완료, 총 개수:", this.markers.length);
        },

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

                navigator.geolocation.getCurrentPosition(async (position) => {
                    const latitude = position.coords.latitude;
                    const longitude = position.coords.longitude;
                    console.log("✅ 현재 위치 좌표:", latitude, longitude);

                    const locPosition = new kakao.maps.LatLng(latitude, longitude);
                    this.map.setCenter(locPosition);

                    // 🧭 좌표 → 행정구 이름 변환 (selectgu 자동 설정)
                    const geocoder = new kakao.maps.services.Geocoder();
                    geocoder.coord2RegionCode(longitude, latitude, async (result, status) => {
            if (status === kakao.maps.services.Status.OK) {
                // 여기 고침!
                const gu = result.find(r => r.region_type === "B")?.region_2depth_name;
                console.log("🧭 현재 위치의 행정구 이름:", gu);
                this.selectgu.GU = gu || "";

                this.currentLat = latitude;
                this.currentLng = longitude;

                // 병원 리스트 불러오기
                if (filterByDistance) {
                    console.log("🔄 근처 병원 리스트 불러오는 중...");
                    await this.fnPartnerList("", latitude, longitude);
                } else {
                    console.log("🔄 전체 병원 리스트 불러오는 중...");
                    await this.fnallhosList();
                }

                setTimeout(() => {
                    if (!this.hoslist || this.hoslist.length === 0) {
                        console.warn("⚠️ 병원 데이터 없음!");
                        return;
                    }

                    if (filterByDistance) {
                        this.addMarkersByCurrentLocation(latitude, longitude);
                    } else {
                        this.showAllHospitals();
                    }
                }, 500);
            } else {
                console.error("🚨 주소 변환 실패:", status);
            }
        });

                }, (error) => {
                    console.error("🚨 위치 가져오기 실패:", error);
                    alert("위치 정보를 가져오지 못했습니다. 위치 권한을 확인해주세요.");
                });

            } catch (error) {
                console.error("🚨 오류 발생:", error);
                alert("병원 데이터를 가져오는 데 실패했습니다. 다시 시도해주세요!");
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
        },

        displayPartnerPlaces(partnerlist) {
            console.log("✅ 전달된 partnerlist:", partnerlist);
            this.hoslist = [];        
            //this.clearMarkers();
            
            this.clearPartnerMarkers(); // 기존 마커 제거
            
            this.visiblePartnerList = partnerlist; // ✅ 리스트에도 표시하기 위해 저장
            console.log("✅ 저장된 visiblePartnerList:", this.visiblePartnerList);
            //this.currentView = 'partner'; // 👉 현재 뷰를 제휴사로 변경
            console.log("✅ currentView:", this.currentView);
            const favoritePartnerIds = new Set(this.favoritesList.map(fav => fav.partnerdetailId));

            const getMarkerImage = (categoryCode, isFavorite) => {
                if (isFavorite) return "../img/partner/star.png";
                switch (categoryCode) {
                    case 1: return "../img/partner/11.png";
                    case 2: return "../img/partner/food.png";
                    case 3: return "../img/partner/22.png";
                    case 4: return "../img/partner/44.png";
                    default: return "../img/partner/logo.png";
                }
            };

            partnerlist.forEach(partner => {
                if (!partner.NY || !partner.NX) return;

                const isFavorite = favoritePartnerIds.has(partner.partnerdetailId);
                if (isFavorite) return;

                const position = new kakao.maps.LatLng(partner.NY, partner.NX);
                const imageSrc = getMarkerImage(partner.categoryCode, false);
                const markerImage = new kakao.maps.MarkerImage(imageSrc, new kakao.maps.Size(42, 42));

                const marker = new kakao.maps.Marker({
                    position,
                    image: markerImage,
                    map: this.map
                });

                kakao.maps.event.addListener(marker, "click", () => {
                    this.showInfoWindowForCategory(marker, partner);
                });

                this.partnerMarkers.push(marker);
            });

            if (partnerlist.length > 0) {
                const center = new kakao.maps.LatLng(partnerlist[0].NY, partnerlist[0].NX);
                this.map.setCenter(center);
            }
        },

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
        },

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

        fnPartnerList(keyword = "", latitude = null, longitude = null, isSearch = false) {
            var self = this;
            var alertShown = false;
            
            //this.clearMarkers(); 
            console.log("전달된 검색어:", keyword);
            var defaultGu = "인천광역시";
            var selectedGu = self.selectgu.GU || defaultGu; // 구 선택 없으면 '인천광역시' 사용
            var nparmap = {
                selectgu: self.selectgu.GU || "인천광역시",
                selectdong: self.selectdong.DONG || "",
                selectsi: self.selectsi || "인천광역시",
                keyword: self.keyword,
                userId: self.userId,
                categoryCode: self.categoryCode,
                latitude: self.currentLat,   // ✅ 추가
                longitude: self.currentLng   // ✅ 추가
            };
            console.log("🔍 서버 요청 파라미터 확인:", nparmap);
            $.ajax({
                url: "/partner/list.dox",
                dataType: "json",
                type: "POST",
                data: nparmap,
                success: function(data) {
                    const hoslist = data.hoslist || [];
                    console.log("📌 서버 응답 병원 리스트:", data.hoslist);
                    if (isSearch && hoslist.length === 0 && !self.alertShown ) {
                       
                        alert("🔍 검색 결과가 없습니다. 다른 키워드를 입력해보세요.");
                        self.alertShown = true;
                    }
                    // ✅ hoslist를 업데이트
                    // ✅ hoslist 초기 업데이트
                    if (data.hoslist && data.hoslist.length > 0) {
                        self.hoslist = data.hoslist;
                        console.log("✅ 병원 리스트 업데이트 완료! hoslist 길이:", self.hoslist.length);
                    } else {
                        self.hoslist = [];
                    
                }
                
        console.log("✅ 병원 리스트 업데이트 완료! hoslist 길이:", self.hoslist.length);
        self.filterByCategory("c" + self.categoryCode);
                            self.partnerlist = data.partnerlist || [];
                            console.log(data.partnerlist);
        // ✅ 병원 필터링 (있을 때만 적용)
        if (self.selectdong.DONG) {
            const selectedDong = self.selectdong.DONG.replace(/[0-9]/g, "");
            const filteredList = self.hoslist.filter(hospital => hospital.hosAddress.includes(selectedDong));
            
            // if (filteredList.length > 0) {
            //     self.hoslist = filteredList;
            // }
        }
        
                    self.addMarkers();
                    // ✅ hoslist가 존재할 경우에만 showAllHospitals 호출
                    if (self.hoslist.length > 0) {
                        console.log("📢 showAllHospitals() 호출 직전!");
                        self.showAllHospitals();  // hoslist로 마커 추가
                    } 
                    
                    // 🔍 hoslist와 partnerlist 모두 비어 있을 경우에만 알림
                    

                    
                
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

                    self.favoritesList = data.favoriteList;

                    const keywordText = keyword.trim().toLowerCase();
console.log("🔍 검색용 keywordText:", keywordText);

const filteredPartner = (data.partnerlist || []).filter(partner => {
  return (
    (partner.name && partner.name.toLowerCase().includes(keywordText)) ||
    (partner.partnerDesc && partner.partnerDesc.toLowerCase().includes(keywordText)) ||
    (partner.address && partner.address.toLowerCase().includes(keywordText))
  );
});

// console.log("📌 필터링된 제휴사 리스트:", filteredPartner);
// console.log("✅ partnerlist 원본 데이터 샘플:", data.partnerlist[0]);
 self.partnerlist = filteredPartner;

// console.log("📌 필터링된 제휴사 리스트:", filteredPartner);

// console.log("📌 필터링된 제휴사 리스트:", self.partnerlist);

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
                
            });
        },
        

    
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
            self.fnPartnerList();
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
            this.alertShown = false; // ✅ 새 검색마다 알림 초기화
            this.isFavoritesVisible = false;
            const keyword = this.keyword.trim();

            this.isSearch = true; // 🔥 여기 추가!

            if (keyword) {
                this.fnPartnerList(keyword, null, null, true);  // ✅ 검색 모드
            } else {
                this.fnPartnerList("", null, null, true);  // ✅ 검색 모드
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

            // 🌐 웹사이트 링크 추가
            (partner.websiteUrl ? 
                "<div style='margin-top:5px;'>🌐 <a href='" + partner.websiteUrl + "' target='_blank' style='color:#007BFF; text-decoration:underline;'>" + partner.websiteUrl + "</a></div>" : "") +(partner.phoneNumber ? "<div>📞 " + partner.phoneNumber + "</div>" : "") +
            (partner.openingHours ? "<div>🕒 영업시간: " + partner.openingHours + "</div>" : "") +
            (partner.regularHoliday ? "<div>🚫 휴무일: " + partner.regularHoliday + "</div>" : "") +

            "<div style='display:flex; justify-content:space-between; margin-top:5px;'>" +
                "<a href='https://map.kakao.com/link/to/" + partner.name + "," + partner.NY + "," + partner.NX + 
                "' target='_blank' style='flex:1; text-align:center; padding:5px; background:#007BFF; " +
                "color:white; border-radius:5px; text-decoration:none; font-weight:bold; font-size:12px; margin-right:5px;'>🗺 길찾기</a>" +

                "<button id='shareButton' " +
                "style='flex:1; padding:5px; background:#FFEB00; border:none; " +
                "border-radius:5px; font-weight:bold; font-size:12px; cursor:pointer; margin-right:5px;'>📢 공유</button>"+ 

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
        },


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
            //this.clearMarkers(); // 이전 마커 삭제
            console.log("clearMarkers1");
            this.addMarkers(selectedHospitals); // 선택된 구의 병원들만 마커로 추가

            // 선택된 구 내의 병원들을 포함하는 영역으로 지도 줌 조정
            this.map.setBounds(bounds); // 지도 영역을 해당 병원들이 모두 보이도록 설정
        }
    },

        // 📌 마커 추가 함수 (병원 리스트로 마커 업데이트)
        addMarkers() {
        if (this.isFavoritesVisible) {
            console.log("⏳ 즐겨찾기 목록이 열려 있어서 일반 마커 추가 안 함!");
            return;
        }

        this.clearMarkers(); // 일반 마커 제거
        this.clearPartnerMarkers(); // 제휴사 마커 제거
        this.clearFavoriteMarkers(); // ⭐ 추가: 즐겨찾기 마커도 초기화
        this.currentView = 'hospital';

        if (this.hoslist.length === 0) return;

        const favoritePositions = new Map();
        this.favoritesList.forEach(fav => {
            favoritePositions.set(fav.NY + "," + fav.NX, fav);
        });

        this.hoslist.forEach(hospital => {
            const positionKey = hospital.NY + "," + hospital.NX;
            const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
            let marker;

            if (favoritePositions.has(positionKey)) {
                const favoriteMarkerImage = new kakao.maps.MarkerImage(
                    '/img/partner/star.png',
                    new kakao.maps.Size(40, 40),
                    { offset: new kakao.maps.Point(20, 40) }
                );
                marker = new kakao.maps.Marker({
                    position,
                    title: hospital.hosName,
                    image: favoriteMarkerImage
                });
                this.favoriteMarkers.push(marker);
            } else {
                marker = new kakao.maps.Marker({
                    position,
                    title: hospital.hosName
                });
                this.markers.push(marker);
            }

            marker.setMap(this.map);
            kakao.maps.event.addListener(marker, "click", () => {
                this.showInfoWindowForSelect(marker, hospital);
            });
        });
    },


    clearMarkers() {
    this.markers.forEach(marker => marker.setMap(null)); // 지도에서 제거
    this.markers = []; // 배열 비우기
    },



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
                '../img/partner/star.png',
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
    },

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
                    '../img/partner/star.png',
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
        },

        clearFavoriteMarkers() {
            this.favoriteMarkers.forEach(marker => marker.setMap(null));
            this.favoriteMarkers = [];
        },

        toggleFavoritesList() {


            this.isFavoritesVisible = !this.isFavoritesVisible;

            if (this.isFavoritesVisible) {

                this.clearMarkers();  // 기존 병원 마커 삭제

                this.clearPartnerMarkers();  // 기존 제휴사 마커 삭제 (이제 삭제해도 됨!)

                this.addHospitalMarkers();
                
                this.addPartnerMarkers();  // 🎯 즐겨찾기 제휴사 마커 추가!

            } else {

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
                    "' target='_blank' style='display:inline-block; width:80px; text-align:center; padding:4px; background:#007BFF; " +
                    "color:white; border-radius:4px; text-decoration:none; font-weight:bold; font-size:11px; margin-right:5px;'>🗺 길찾기</a>" +

                    "<button id='shareButton' " +
                    "style='display:inline-block; width:80px; padding:4px; background:#FFEB00; border:none; " +
                    "border-radius:4px; font-weight:bold; font-size:11px; cursor:pointer;'>📢 공유</button>"+
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
                    });
                }); // <-- ✅ 추가된 닫는 괄호!
            }); // <-- ✅ 추가된 닫는 괄호!
        },

        updateMap() {
            if (!this.selectgu) {
            console.warn("구가 선택되지 않았습니다.");
            return;
            }

            console.log("donglist:", this.donglist);
            console.log("gulist:", this.gulist);
            this.fnPartnerList();

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
                }
            },
            error: function(xhr, status, error) {
                console.error("❌ 즐겨찾기 삭제 오류:", error);
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
    },

    mounted() {
    
    this.isFavoritesVisible = false;
    this.initializeMap();  
    this.updateMap();      
    this.fnfavorList();  // 즐겨찾기 목록 로드
 
    }
});

app.mount('#app');
</script>