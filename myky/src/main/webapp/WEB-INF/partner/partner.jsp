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
  
              <select v-model="selectgu" @change="updateMap" class="selectBox">
                <option disabled :value="{ GU: '' }">구 선택</option>
                <option v-for="item in gulist" :key="item.GU" :value="item">
                  {{ item.GU }}
                </option>
              </select>
              
              
              
              
  
              <select v-model="selectdong" @click="checkGuSelected" @change="updateMap" class="selectBox">
                <option disabled :value="{ DONG: '' }">동 선택</option>
                <option v-for="item in donglist" :key="item.DONG" :value="item">
                    {{ item.DONG }}
                </option>
            </select>

  
            <div class="search-row">
                <label for="keyword" style="font-weight: bold;"></label>
               
                <select v-model="currentView" class="selectBox">
                    <option value="hospital">병원</option>
                    <option value="partner">제휴사</option>
                </select>
                <input 
                type="text" 
                v-model="keyword" 
                @keyup.enter="handleSearchEnter" 
                placeholder="검색어 입력"
            />
                <button @click="searchPlaces" class="search-btn">검색</button>
            </div>
            
  
              <div class="button-row">
                <button @click="toggleFavoritesList" class="favorites-toggle-btn" :class="{ active: isFavoritesVisible }">⭐ 즐겨찾기 목록</button>
                <button @click="toggleNearbySearch" class="nearby-btn" :class="{ active: isNearbyVisible }">📍 근처 병원 보기</button>
              </div>
            </form>
          </div>
  
          <hr />
  
          <ul id="placesList">
            <!-- 검색된 병원 및 제휴사 수 -->
            <!-- ✅ 제휴사 검색 결과 및 페이징 (currentView가 partner일 때만) -->
<div v-if="currentView === 'partner' && visiblePartnerList.length > 0 && !isFavoritesVisible" class="count">
    총 {{ visiblePartnerList.length }}개 제휴사가 검색되었습니다.
    <hr />
    <div class="pagination-container">
      <button @click="goToPartnerPage(1)" :disabled="partnerPagination.currentPage === 1"><<</button>
      <button @click="prevPartnerPage" :disabled="partnerPagination.currentPage === 1"><</button>
  
      <span v-for="page in partnerPaginationButtons" :key="'partner-page-' + page">
        <button @click="goToPartnerPage(page)" :class="{ active: page === partnerPagination.currentPage }">
          {{ page }}
        </button>
      </span>
  
      <button @click="nextPartnerPage" :disabled="partnerPagination.currentPage === partnertotalPages">></button>
      <button @click="goToPartnerPage(partnertotalPages)" :disabled="partnerPagination.currentPage === partnertotalPages">>></button>
    </div>
  </div>

  <div v-if="currentView === 'hospital' && hoslist.length > 0 && !isFavoritesVisible" class="count">
    총 {{ hoslist.length }}개 병원이 검색되었습니다.
    <hr />
    <div class="pagination-container">
      <button @click="goToPage(1)" :disabled="pagination.currentPage === 1"><<</button>
      <button @click="prevPage" :disabled="pagination.currentPage === 1"><</button>
  
      <span v-for="page in totalPages || 1" :key="page">
        <button
          @click="goToPage(page)"
          :class="{ active: page === pagination.currentPage }"
        >
          {{ page }}
        </button>
      </span>
  
      <button @click="nextPage" :disabled="pagination.currentPage === totalPages">></button>
      <button @click="goToPage(totalPages)" :disabled="pagination.currentPage === totalPages">>></button>
    </div>
  </div>
              
  
              <ul v-if="currentView === 'hospital' && !isFavoritesVisible">
                <li v-for="(hospital, index) in paginatedHospitals" :key="'hos-' + hospital.hospitalNo" @click="moveToLocation(hospital)">
                  <div>{{ hospital.hosName }}</div>
                  <span>{{ hospital.hosAddress }}</span>
                  <hr />
                </li>
              </ul>
  
              <ul v-else-if="currentView === 'partner' && !isFavoritesVisible">
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
                <li v-for="favorite in favoritesList.filter(fav => fav.hospitalNo)" :key="'hospital-' + favorite.hospitalNo + '-' + favorite.userId" @click="moveToLocation(favorite)">
                  <div>
                    <strong>{{ favorite.hosName }}</strong> - {{ favorite.hosAddress }}
                  </div>
                 <!-- <button @click="fnRemoveFavorite(favorite.hospitalNo, favorite.hosName, favorite.hosAddress, userId)">
                    ❌ 삭제
                  </button>-->
                  <hr />
                </li>
  
                <!-- 파트너 즐겨찾기 -->
                <li v-for="item in favoritesList.filter(fav => fav.partnerdetailId)" :key="'partner-' + item.partnerdetailId + '-' + item.userId"
                    @click="moveToLocation(item)">
                  <div>
                    <strong>{{ item.name }}</strong> - {{ item.address }}
                  </div>
                <!--  <button
                    @click="fnparRemoveFavorite(item.partnerdetailId, item.name, item.address, userId)"
                  >
                    ❌ 삭제
                  </button> -->
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
            isNearbyVisible: false,
            nearbyMarkers: [],
            selectedCategoryCode: null,
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
            searchResults : [],
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
            // selectgu : "",
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
  currentView: {
    immediate: true,
    handler(newView) {
      console.log("🔄 현재 뷰 변경:", newView);
      
      // 모든 마커 제거
      this.removeAllMarkers();

      // 뷰에 따라 적절한 마커 표시
      if (newView === 'hospital') {
        this.$nextTick(() => {
          if (this.hoslist && this.hoslist.length > 0) {
            this.addMarkers();
          }
        });
      } else if (newView === 'partner') {
        this.$nextTick(() => {
          if (this.filteredPartnerlist && this.filteredPartnerlist.length > 0) {
            this.displayPartnerPlaces(this.filteredPartnerlist, {
              includeFavorites: true,
              clear: true
            });
          }
        });
      }
    }
  },

  hospitalMarkers(newMarkers) {
    if (this.currentView === 'hospital') {
      this.showHospitalMarkers();
    }
  },

  partnerMarkers(newMarkers) {
    if (this.currentView === 'partner') {
      this.showPartnerMarkers();
    }
  }
}
,
    methods: {
        isUserLoggedIn() {
        return !!this.user;  // user 객체가 존재하면 로그인 상태
    },
    removeAllMarkers() {
  if (this.hospitalMarkers && Array.isArray(this.hospitalMarkers)) {
    this.hospitalMarkers.forEach(marker => marker.setMap(null));
    this.hospitalMarkers = [];
  }

  if (this.partnerMarkers && Array.isArray(this.partnerMarkers)) {
    this.partnerMarkers.forEach(marker => marker.setMap(null));
    this.partnerMarkers = [];
  }
}
,
showHospitalMarkers() {
  if (!this.hospitalMarkers || !Array.isArray(this.hospitalMarkers)) return;
  this.hospitalMarkers.forEach(marker => marker.setMap(this.map));
},

showPartnerMarkers() {
  if (!this.partnerMarkers || !Array.isArray(this.partnerMarkers)) return;
  this.partnerMarkers.forEach(marker => marker.setMap(this.map));
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
        async toggleNearbySearch() {
        if (this.isNearbyVisible) {
            // 이미 활성화된 상태면 마커와 검색 결과 제거
            this.clearNearbyMarkers();
            this.isNearbyVisible = false; // isNearbySearchActive 대신 isNearbyVisible 사용
            
            // 선택된 구/동 초기화
            this.selectgu = { GU: "" };
            this.selectdong = { DONG: "" };
            
            return;
        }

        // 근처 병원 검색 실행
        try {
            this.isNearbyVisible = true;
            await this.moveToCurrentLocation(true);
        } catch (error) {
            console.error("근처 병원 검색 실패:", error);
            this.isNearbyVisible = false;
        }
    },
    clearNearbyMarkers() {
        if (this.nearbyMarkers && this.nearbyMarkers.length > 0) {
            this.nearbyMarkers.forEach(marker => {
                marker.setMap(null);
            });
            this.nearbyMarkers = [];
        }
    },
        checkGuSelected() {
    if (!this.selectgu || !this.selectgu.GU) {
      alert("⚠️ 구를 먼저 선택해주세요!");
    }
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
                console.log("🔍 필터 상태 확인");
console.log("selectgu:", this.selectgu.GU);
console.log("selectdong:", this.selectdong.DONG);
console.log("currentLat:", this.currentLat);
console.log("currentLng:", this.currentLng);

                console.log("📍 현재 위치 가져오는 중...");
console.log("현재 위치:", this.currentLat, this.currentLng);
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
        const gu = result.find(r => r.region_type === "B")?.region_2depth_name;
        console.log("🧭 현재 위치의 행정구 이름:", gu);

        // ✅ "근처 병원 찾기"일 때만 구 설정
        if (filterByDistance) {
  const matchedGu = this.gulist.find(item => item.GU === gu);
  if (matchedGu) {
    this.selectgu = matchedGu;
  } else {
    this.selectgu = { GU: gu }; // 혹시 gulist에 없을 때 대비
  }
}


        this.currentLat = latitude;
        this.currentLng = longitude;

        if (filterByDistance) {
            console.log("🔄 근처 병원 리스트 불러오는 중...");
            await this.fnPartnerList("", latitude, longitude, false, true);
        } else {
            console.log("🔄 전체 병원 리스트 불러오는 중...");
            await this.fnallhosList();
        }

        setTimeout(() => {
            if (!this.hoslist || this.hoslist.length === 0) {
                console.warn("⚠️ 병원 데이터 없음!");
                return;
            }

            const dong = result.find(r => r.region_type === "B")?.region_3depth_name;

            if (filterByDistance) {
    const matchedGu = this.gulist.find(item => item.GU === gu);
    this.selectgu = matchedGu || { GU: gu };
    
    // ✅ 동 필터 제거
    this.selectdong = { DONG: "" };
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
            console.log("현재 GU:", this.selectgu.GU);
console.log("현재 DONG:", this.selectdong.DONG);
console.log("병원 수:", this.hoslist.length);
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



        // 카테고리별 필터링 함수f
        filterByCategory(categoryCode) {
    if (!categoryCode) {
        console.error("❌ 카테고리가 유효하지 않습니다.");
        return;
    }

    this.selectedCategoryCode = Number(categoryCode);
    this.clearPartnerMarkers();
    
        this.currentView = 'partner';
    

    // 카테고리에 따른 제휴사 필터링
    this.filteredPartnerlist = this.partnerlist.filter(
        partner => partner.categoryCode === this.selectedCategoryCode
    );

    // ✅ 페이징 초기화
    this.partnerPagination = {
        currentPage: 1,
        itemsPerPage: 10
    };

    // 필터링된 리스트로 화면 업데이트
    this.displayPartnerPlaces(this.filteredPartnerlist, {
        includeFavorites: true
    });
}




,

displayPartnerPlaces(partnerlist, options = { includeFavorites: true, clear: true }) {
    console.log("🏢 제휴사 마커 표시 시작");
    console.log("즐겨찾기 모드:", this.isFavoritesVisible);
    
    // ⭐ 즐겨찾기 모드일 때는 마커 표시하지 않음
    if (this.isFavoritesVisible) {
        console.log("⭐ 즐겨찾기 모드 - 제휴사 마커 표시 중단");
        return;
    }

    if (options.clear) {
        this.clearPartnerMarkers();
        this.favoriteMarkers.forEach(marker => marker.setMap(null));
        this.favoriteMarkers = [];
    }

    this.visiblePartnerList = partnerlist;
    this.lastDisplayedPartnerList = partnerlist;

    const favoriteIds = new Set(this.favoritesList.map(fav => fav.partnerdetailId));
    const markersToShow = [];

    partnerlist.forEach(partner => {
        if (!partner.NY || !partner.NX) return;

        const isFavorite = favoriteIds.has(partner.partnerdetailId);
        let marker;

        // 즐겨찾기인 경우에만 별 마커, 아닌 경우 일반 마커
        if (isFavorite && options.includeFavorites) {
            marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(partner.NY, partner.NX),
                image: new kakao.maps.MarkerImage(
                    "/img/partner/star.png",
                    new kakao.maps.Size(42, 42)
                )
            });
            marker.partnerdetailId = partner.partnerdetailId;
            marker.categoryCode = partner.categoryCode;
            this.favoriteMarkers.push(marker);
        } else if (!this.isFavoritesVisible) { // ⭐ 즐겨찾기 모드가 아닐 때만 일반 마커 추가
            marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(partner.NY, partner.NX),
                image: new kakao.maps.MarkerImage(
                    this.getCategoryImg(partner.categoryCode),
                    new kakao.maps.Size(42, 42)
                )
            });
            marker.partnerdetailId = partner.partnerdetailId;
            marker.categoryCode = partner.categoryCode;
            this.partnerMarkers.push(marker);
        }

        if (marker) {
            marker.setMap(this.map);
            kakao.maps.event.addListener(marker, "click", () => {
                this.showInfoWindowForCategory(marker, partner);
            });
            markersToShow.push(marker);
        }
    });

    if (markersToShow.length > 0) {
        this.map.setCenter(markersToShow[0].getPosition());
    }
}

,

        // 제휴사 마커만 삭제
        clearPartnerMarkers() {
            console.log("🧹 마커 제거 시작");
            
            // 일반 마커 제거
            this.partnerMarkers.forEach(marker => marker.setMap(null));
            this.partnerMarkers = [];
            
            // 즐겨찾기 마커도 제거
            this.favoriteMarkers.forEach(marker => marker.setMap(null));
            this.favoriteMarkers = [];
            
            console.log("✅ 모든 마커 제거 완료");
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

        fnPartnerList(keyword = "", latitude = null, longitude = null, isSearch = false, filterByDistance = false) {
    var self = this;
    var alertShown = false;

    console.log("전달된 검색어:", keyword);

    var defaultGu = "인천광역시";
    var selectedGu = self.selectgu.GU || defaultGu;  // 구 선택 없으면 '인천광역시' 사용
    var nparmap = {
        selectgu: self.selectgu.GU || "인천광역시",
        selectdong: self.selectdong.DONG || "",
        selectsi: self.selectsi || "인천광역시",
        keyword: self.keyword,
        userId: self.userId,
        categoryCode: self.categoryCode,
        latitude: self.currentLat,  // 현재 위치
        longitude: self.currentLng  // 현재 위치
    };

    console.log("🔍 서버 요청 파라미터 확인:", nparmap);

    $.ajax({
        url: "/partner/list.dox",
        dataType: "json",
        type: "POST",
        data: nparmap,
        success: function(data) {
            const hoslist = data.hoslist || [];
            console.log("📌 서버 응답 병원 리스트:", hoslist);
            const keywordText = self.keyword.trim().toLowerCase();

            // 병원 뷰일 때만 병원 검색 처리
if (self.currentView === 'hospital' && isSearch) {
    const filteredHospitals = (data.hoslist || []).filter(hospital =>
        hospital.hosName.toLowerCase().includes(keywordText)
    );

    if (filteredHospitals.length > 0) {
        console.log('🏥 병원 검색 결과 처리 시작');
        self.hoslist = filteredHospitals;
        self.clearPartnerMarkers();  // 제휴사 마커 제거
        self.addMarkers();  // 병원 마커만 표시

        self.moveToLocation(filteredHospitals[0]);
    } else {
        alert("검색된 병원이 없습니다.");
    }
}

// 제휴사 뷰일 때만 제휴사 검색 처리
else if (self.currentView === 'partner' && isSearch) {
    const filteredPartner = (data.partnerlist || []).filter(partner =>
        partner.name.toLowerCase().includes(keywordText)
    );

    if (filteredPartner.length > 0) {
        console.log('🏢 제휴사 검색 결과 처리 시작');
        self.partnerlist = filteredPartner;
        self.visiblePartnerList = filteredPartner;
        self.clearMarkers();  // 병원 마커 제거

        self.displayPartnerPlaces(filteredPartner, {
            includeFavorites: true,
            clear: true,
        });

        self.moveToLocation(filteredPartner[0]);
    } else {
        // alert("검색된 제휴사가 없습니다.");
    }
}

            // hoslist 업데이트 및 필터링
            if (data.hoslist && data.hoslist.length > 0) {
                self.hoslist = data.hoslist;
                console.log("✅ 병원 리스트 업데이트 완료! hoslist 길이:", self.hoslist.length);
            } else {
                self.hoslist = [];
            }

            // 병원 리스트 필터링 (거리 기반 검색일 경우)
            if (filterByDistance && (!self.currentLat || !self.currentLng)) {
                console.warn("📍 근처 병원 검색인데 현재 위치 좌표가 없습니다.");
                return;
            }

            // 카테고리 필터 적용
            if (self.categoryCode) {
                nparmap.categoryCode = self.categoryCode;
            }

            // 병원 주소 필터링
            if (!filterByDistance && self.selectdong.DONG) {
                const selectedDong = self.selectdong.DONG.replace(/[0-9]/g, "");
                self.hoslist = data.hoslist.filter(hospital => 
                    hospital.hosAddress.includes(selectedDong)
                );
            } else {
                self.hoslist = data.hoslist;
            }

            // 제휴사 리스트 업데이트
            self.partnerlist = data.partnerlist || [];
            console.log("📌 partnerlist:", self.partnerlist);

            // 마커 추가 후 화면 갱신
            if (self.hoslist.length > 0) {
                self.addMarkers();
                self.showAllHospitals();  // 병원 마커 모두 표시
            } else {
                console.log("🚫 병원 마커가 없습니다.");
            }

            // 구 목록 및 동/시 목록 설정
            self.gulist = Array.isArray(data.gulist) ? self.removeDuplicates(data.gulist, "GU") : [];
            if (!self.selectgu || self.selectgu === "") {
                if (self.gulist.length > 0) {
                    self.selectgu = self.gulist[0].GU;
                    console.log("✅ 초기 GU 설정됨:", self.selectgu);
                }
            }

            self.donglist = Array.isArray(data.donglist) ? data.donglist : [];
            self.silist = Array.isArray(data.silist) ? data.silist : [];

            // 마커 업데이트
            self.addMarkers();
        },
        error: function(err) {
            console.error("❌ AJAX 요청 실패:", err);
        }
    });
}


,
        

    
        removeDuplicates(arr, key) {
  console.log("📦 중복 제거 전:", arr);
  const result = arr.filter((value, index, self) =>
    index === self.findIndex((t) => t[key] === value[key])
  );
  console.log("✅ 중복 제거 후:", result);
  return result;
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
        handleSearchEnter(event) {
        if (event.key === 'Enter') {
            // 현재 뷰 상태를 변경하지 않고, 단지 검색만 수행
            this.searchPlaces();
        }
    },
    async searchPlaces() {
    console.log("🔍 검색 시작 - 현재 뷰:", this.currentView);
    console.log("검색어:", this.keyword);

    const keyword = this.keyword.trim();
    if (!keyword) {
        alert("검색어를 입력해주세요.");
        return;
    }

    // 검색 전 현재 뷰 상태를 저장
    const currentViewBeforeSearch = this.currentView;

    try {
        this.isSearching = true;

        // 마커 초기화
        this.clearMarkers();
        this.clearPartnerMarkers();

        // 뷰에 따라 병원/제휴사 구분하여 처리
        if (currentViewBeforeSearch === 'hospital') {
            console.log("🏥 병원 검색 시작");

            // 병원 전용 검색 처리 (AJAX 요청이나 병원 리스트 호출)
            await this.fnPartnerList(keyword);  // 병원 리스트 로드 함수

            if (this.hoslist && this.hoslist.length > 0) {
                console.log("🏥 병원 검색 결과:", this.hoslist.length);
                this.addMarkers();  // 병원 마커 추가

                // 첫 번째 병원으로 지도 이동
                if (this.hoslist[0]) {
                    this.moveToLocation(this.hoslist[0]);
                }
            } else {
                alert("검색된 병원이 없습니다.");
            }
        } 
        // 제휴사 뷰일 경우
        else if (currentViewBeforeSearch === 'partner') {
            console.log("🏢 제휴사 검색 시작");

            const keywordText = keyword.toLowerCase();
            const filteredPartner = (this.partnerlist || []).filter(partner =>
                partner.name.toLowerCase().includes(keywordText)
            );

            if (filteredPartner.length > 0) {
                console.log("✅ 제휴사 검색 결과:", filteredPartner.length);
                this.visiblePartnerList = filteredPartner;
                this.clearMarkers();
                
                // 제휴사 마커 표시 후 이동
                await this.displayPartnerPlaces(filteredPartner, { clear: true, includeFavorites: true });

                // 첫 번째 제휴사로 지도 이동
                if (filteredPartner[0]) {
                    this.moveToLocation(filteredPartner[0]);
                }
            } else {
                console.log("🚫 검색된 제휴사가 없습니다.");
                this.visiblePartnerList = [];
                //alert("검색된 제휴사가 없습니다.");
            }
        } else {
            console.error("❌ 현재 뷰가 병원도 아니고 제휴사도 아닙니다.");
        }

    } catch (err) {
        console.error("❌ 검색 중 오류 발생:", err);
        alert("검색 중 문제가 발생했습니다!");
    } finally {
        this.isSearching = false;
    }
}








,
  moveToLocation(data) {
    // 이미 네가 만든 moveToLocation 함수 여기에 포함
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
        const that = this;
        const favoritesList = this.favoritesList;
        let isFavorite = false;
        
        const safeCategoryCode  = partner.categoryCode ?? 1;    

    

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

  
    if (Array.isArray(favoritesList)) {
        isFavorite = favoritesList.some(fav => fav.partnerdetailId === partner.partnerdetailId);
    }
console.log("⭐ 즐겨찾기 여부 (isFavorite):", isFavorite);
    console.log("🪧 마커 ID:", partner.partnerdetailId, "이름:", partner.name);
    const markerImage = new kakao.maps.MarkerImage(
    isFavorite ? "/img/partner/clear.png" : this.getCategoryImg(safeCategoryCode),
    new kakao.maps.Size(38, 38)

);
    //marker.setImage(markerImage);

    const starIcon = isFavorite ? "★" : "☆";

    let content = 
        "<div style='padding:10px; font-size:13px; width:" + dynamicWidth + "px; " +
        "min-height:" + dynamicHeight + "px; word-wrap:break-word; white-space:pre-line; " +
        "max-width:100%; overflow: visible;'>" + 
        "<strong>" + partner.name + "</strong><br>" +
        "<div style='white-space:pre-line;'>" + 
            (partner.address ? partner.address : "주소 정보 없음") + 
        "</div>" +
        (partner.websiteUrl ? 
            "<div style='margin-top:5px;'>🌐 <a href='" + partner.websiteUrl + "' target='_blank' style='color:#007BFF; text-decoration:underline;'>" + partner.websiteUrl + "</a></div>" : "") +
        (partner.phoneNumber ? "<div>📞 " + partner.phoneNumber + "</div>" : "") +
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

    this.infoWindow = new kakao.maps.InfoWindow({
        content: content,
        removable: true
    });

    this.infoWindow.open(this.map, marker);

    this.$nextTick(() => {
        const shareButton = document.getElementById("shareButton");
        const newShareButton = shareButton.cloneNode(true);
        shareButton.parentNode.replaceChild(newShareButton, shareButton);
        newShareButton.addEventListener("click", () => {
            this.shareToKakao(partner.partnerdetailId, partner.name, partner.address, partner.phoneNumber);
        });

        const favButton = document.getElementById("favoritesButton");
        if (!favButton) {
            console.error("⚠️ 즐겨찾기 버튼이 없음!");
            return;
        }

        const newFavButton = favButton.cloneNode(true);
        favButton.parentNode.replaceChild(newFavButton, favButton);

        newFavButton.addEventListener("click", async () => {
    if (!this.userId) {
        alert("로그인이 필요합니다! 😊");
        return;
    }

    try {
        if (isFavorite) {
    console.log("🚫 즐겨찾기 해제 요청", partner.partnerdetailId);

    await this.fnparRemoveFavorite(partner.partnerdetailId, partner.name, partner.address, this.userId);
    console.log("✅ [REMOVE] 서버 응답 완료");

    // 현재 마커가 어떤 상태인지 확인
    console.log("🔍 마커 제거 전 상태: ", marker);
    marker.setMap(null); // 기존 별 마커는 맵에서 제거
    console.log("🗑 마커 setMap(null) 실행됨 → 맵에서 제거됨");

    // 기본 카테고리 이미지로 변경
    const normalMarkerImage = new kakao.maps.MarkerImage(
        this.getCategoryImg(safeCategoryCode),
        new kakao.maps.Size(42, 42)
    );
    console.log("🎨 기본 마커 이미지 객체 생성 완료");

    marker.setImage(normalMarkerImage);
    console.log("🖼 마커 이미지 → 기본 카테고리 이미지로 설정 완료");

    isFavorite = false;

    // 마커를 다시 맵에 표시
    marker.setMap(this.map);
    console.log("📌 마커 다시 맵에 추가됨");

    // 즐겨찾기 마커 배열에서 제거
    this.favoriteMarkers = this.favoriteMarkers.filter(m => m !== marker);
    console.log("📉 favoriteMarkers 배열에서 마커 제거 완료");

    // partnerMarkers에 다시 추가
    this.partnerMarkers.push(marker);
    console.log("📈 partnerMarkers 배열에 마커 추가 완료");
}

 else {
            console.log("⭐ 즐겨찾기 추가 요청", partner.partnerdetailId);
            await this.fnparfavorites(partner.partnerdetailId, partner.name, partner.address, this.userId);
            console.log("✅ 즐겨찾기 추가 완료");

            const starMarkerImage = new kakao.maps.MarkerImage(
                "/img/partner/star.png",
                new kakao.maps.Size(38, 38)
            );
            marker.setImage(starMarkerImage);
            isFavorite = true;

            this.favoriteMarkers.push(marker);
            marker.setMap(this.map);
            console.log("🎨 마커 이미지 → 별 이미지로 변경");
        }

        const starElement = document.getElementById("favoriteStar");
        if (starElement) {
            starElement.textContent = isFavorite ? "★" : "☆";
            starElement.setAttribute('data-favorite', isFavorite);
            console.log("🌟 별 아이콘 갱신됨:", isFavorite ? "★" : "☆");
        }

        await this.fnfavorList();
        console.log("📥 즐겨찾기 리스트 최신화 완료");

    } catch (error) {
        console.error("❌ 즐겨찾기 처리 중 오류:", error);
    }
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
    setTimeout(() => {
  const firstPartner = filteredPartner[0];
  if (firstPartner && firstPartner.NX && firstPartner.NY) {
    this.moveToLocation(firstPartner);
  }
}, 200);
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

    this.clearMarkers(); // 병원 마커 제거
    this.clearFavoriteMarkers(); // 즐겨찾기 마커 제거

    // ❗ 현재 뷰가 'partner'면 제휴사 마커는 유지!
    if (this.currentView !== 'partner') {
        console.log("🧹 병원 마커 갱신용 clearPartnerMarkers 실행");
        this.clearPartnerMarkers();
    } else {
        console.log("🛑 currentView가 partner라서 clearPartnerMarkers 안 함");
    }

	if (this.isSearchingHospitals) {
		//  this.currentView = 'hospital';
		}

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
                new kakao.maps.Size(38, 38),
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
}



,


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
                new kakao.maps.Size(38, 38),
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
                    new kakao.maps.Size(38, 38),
                    { offset: new kakao.maps.Point(20, 40) }
                );

                var marker = new kakao.maps.Marker({
                    position: position,
                    title: partner.name || partner.hosName,
                    image: favoriteMarkerImage
                });
                marker.partnerdetailId = partner.partnerdetailId;
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
            
            if(this.infoWindow){
                this.infoWindow.close();
            }
    this.isFavoritesVisible = !this.isFavoritesVisible;

    if (this.isFavoritesVisible) {
        // 🔄 partnerlist 기준으로 최신 favoritePartners 만들어줌
        this.favoritePartners = this.partnerlist.filter(partner =>
            this.favoritesList.some(fav => fav.partnerdetailId === partner.partnerdetailId)
        );

        this.clearMarkers();  
        this.clearPartnerMarkers();  
        this.clearFavoriteMarkers();  
        
        this.addHospitalMarkers();  
        this.addPartnerMarkers();  // ⬅️ 이제 최신화된 favoritePartners로 별 마커 잘 나와야 함
    } else {
        this.clearFavoriteMarkers();  

        if (this.hoslist.length > 0) {
            this.addMarkers();  
        } else {
            console.log("📭 병원 리스트가 없어서 마커 추가 안 함!");
        }

        if (this.selectedCategoryCode) {
            this.filterByCategory(this.selectedCategoryCode);  
        }
    }
}



,

        clearFavoritePartnerMarkers() {
  console.log("⭐ 즐겨찾기 파트너 마커 제거!");
  this.partnerMarkers.forEach(marker => {
    // 즐겨찾기 마커만 필터링해서 제거 (예: star.png로 구분)
    const markerImageSrc = marker.getImage().getImageSrc();
    if (markerImageSrc.includes("star.png")) {
      marker.setMap(null);
    }
  });

  // 제거 후 즐겨찾기 마커 리스트 초기화
  this.partnerMarkers = this.partnerMarkers.filter(marker => {
    const markerImageSrc = marker.getImage().getImageSrc();
    return !markerImageSrc.includes("star.png");
  });
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
                removable: true,
            });

            this.infoWindow.open(this.map, marker);

    // 버튼 이벤트 리스너 설정
    this.$nextTick(() => {
    // 공유 버튼 처리
    const shareButton = document.getElementById("shareButton");
    if (shareButton) {
        const newShareButton = shareButton.cloneNode(true);
        shareButton.parentNode.replaceChild(newShareButton, shareButton);
        newShareButton.addEventListener("click", () => {
            this.shareToKakao(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, hospital.phone);
        });
    } else {
        console.warn("공유 버튼이 존재하지 않음!");
    }

    // 즐겨찾기 버튼 처리
   // 즐겨찾기 버튼 처리
const favButton = document.getElementById("favoritesButton");
if (!favButton) {
    console.error("⚠️ 즐겨찾기 버튼이 없음! newFavButton 정의 못 함");
    return;
}

// newFavButton을 실제로 정의하고 cloneNode 후, 이벤트 리스너 추가
const newFavButton = favButton.cloneNode(true);
favButton.parentNode.replaceChild(newFavButton, favButton);

newFavButton.addEventListener("click", async () => {
    console.log("💡 즐겨찾기 버튼 클릭됨!");

    if (!this.userId) {
        alert("로그인이 필요합니다! 😊");
        return;
    }

    if (!hospital.hospitalNo || !hospital.hosName) {
        console.error("hospital.hospitalNo 또는 hospital.hosName 값이 없습니다!");
        return; // 값이 없으면 더 이상 진행하지 않음
    }

    try {
        if (isFavorite) {
            await this.fnRemoveFavorite(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, this.userId);

            // 기본 병원 마커로 변경
            const defaultMarkerImage = new kakao.maps.MarkerImage(
                "http://t1.daumcdn.net/mapjsapi/images/marker.png", // 카카오 기본 마커
                new kakao.maps.Size(29, 42)
            );
            marker.setImage(defaultMarkerImage);  // 기본 마커로 변경
            isFavorite = false;

            // favoriteMarkers에서 제거하고 markers에 추가
            this.favoriteMarkers = this.favoriteMarkers.filter(m => m !== marker);
            this.markers.push(marker);

            console.log("⭐ 기본 파란 마커로 변경 완료");
        } else {
            await this.fnfavorites(hospital.hospitalNo, hospital.hosName, hospital.hosAddress, this.userId);

            const starMarkerImage = new kakao.maps.MarkerImage(
                "/img/partner/star.png", // 별 마커 이미지 경로
                new kakao.maps.Size(38, 38)
            );
            marker.setImage(starMarkerImage);  // 별 마커 이미지로 변경
            isFavorite = true;

            // markers에서 제거하고 favoriteMarkers에 추가
            this.markers = this.markers.filter(m => m !== marker);
            this.favoriteMarkers.push(marker);

            console.log("⭐ 즐겨찾기 별 이미지로 변경 완료");
        }

        const starElement = document.getElementById("favoriteStar");
        if (starElement) {
            starElement.textContent = isFavorite ? "★" : "☆";
            starElement.setAttribute('data-favorite', isFavorite);
        }

        await this.fnfavorList();

    } catch (error) {
        console.error("❌ 즐겨찾기 처리 중 오류 발생:", error);
    }
});





});

},

updateMap() {
    if (!this.selectgu) {
        console.warn("구가 선택되지 않았습니다.");
        return;
    }

    // 구 선택 시 항상 병원 뷰로 변경

    //this.currentView = 'hospital';
  
    
    // 제휴사 관련 데이터 초기화
    this.partnerlist = [];
    this.visiblePartnerList = [];
    this.filteredPartnerlist = [];
    this.selectedCategoryCode = null;
    
    // 제휴사 마커 제거
    this.clearPartnerMarkers();

    console.log("donglist:", this.donglist);
    console.log("gulist:", this.gulist);
    
    this.fnPartnerList();

    console.log("selectgu:", this.selectgu);
    console.log("selectdong:", this.selectdong);

    if (!this.map) {
        console.warn("지도 객체가 초기화되지 않았습니다.");
        return;
    }

    const selectedGuData = this.gulist.find(item => item.GU === this.selectgu);
    if (selectedGuData && selectedGuData.NX && selectedGuData.NY) {
        this.moveToLocation(selectedGuData);
        return;
    }

    if (this.selectdong && this.selectdong.NX && this.selectdong.NY) {
        this.moveToLocation(this.selectdong);
    } else if (this.selectgu && this.selectgu.NX && this.selectgu.NY) {
        this.moveToLocation(this.selectgu);
    } else {
        const position = new kakao.maps.LatLng(37.4101013788811, 126.678274850516);
        this.map.setCenter(position);
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
 
    fnfavorites(hospitalNo, hosName, hosAddress, userId) {
    var self = this;
    return new Promise((resolve, reject) => {
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
                if (data.result === "success") {
                    // 현재 지도에 표시된 마커들 중에서 해당 병원의 마커를 찾아 이미지 변경
                    self.markers.forEach(marker => {
                        if (marker.getTitle() === hosName) {
                            const starMarkerImage = new kakao.maps.MarkerImage(
                                "/img/partner/star.png",
                                new kakao.maps.Size(38, 38)
                            );
                            marker.setImage(starMarkerImage);
                            
                            // markers 배열에서 제거하고 favoriteMarkers 배열에 추가
                            self.markers = self.markers.filter(m => m !== marker);
                            self.favoriteMarkers.push(marker);
                        }
                    });
                    
                    alert(hosName + " 즐겨찾기에 추가되었습니다! ⭐");
                    resolve(data);
                } else {
                    reject("서버 응답이 예상과 다릅니다");
                }
            },
            error: function(xhr, status, error) {
                reject(error);
            }
        });
    });
},

fnRemoveFavorite(hospitalNo, hosName, hosAddress, userId) {
           var self = this;
           var nparmap = {
               hospitalNo: hospitalNo,
               hosName: hosName,
               hosAddress: hosAddress,
               userId: userId,
           };

           return new Promise((resolve, reject) => {
               $.ajax({
                   url: "/favorites/hospital/remove.dox",
                   dataType: "json",
                   type: "POST",
                   data: nparmap,
                   success: function(data) {
                       if (data.result === "success") {
                           alert(hosName + " 즐겨찾기에서 해제되었습니다.");
                           resolve(data);
                       } else {
                           reject("서버 응답이 예상과 다릅니다");
                       }
                   },
                   error: function(xhr, status, error) {
                       reject(error);
                   }
               });
           });
       },




        fnparfavorites(partnerdetailId, name, address, userId) {
    var self = this;
    var nparmap = { 
        partnerdetailId : partnerdetailId,
        name : name,
        address : address,
        userId : userId
    };

    return new Promise((resolve, reject) => {
        $.ajax({
            url: "/favorites/partner/add.dox",
            dataType: "json",
            type: "POST",
            data: nparmap,
            success: function(data) {  
                console.log(data);
                if (data.result === "success") {
                    // 현재 지도에 표시된 마커들 중에서 해당 제휴사의 마커를 찾아 이미지 변경
                    self.partnerMarkers.forEach(marker => {
                        if (marker.partnerdetailId === partnerdetailId) {
                            const starMarkerImage = new kakao.maps.MarkerImage(
                                "/img/partner/star.png",
                                new kakao.maps.Size(38, 38)
                            );
                            marker.setImage(starMarkerImage);
                            
                            // markers 배열에서 제거하고 favoriteMarkers 배열에 추가
                            self.partnerMarkers = self.partnerMarkers.filter(m => m !== marker);
                            self.favoriteMarkers.push(marker);
                        }
                    });

                    alert(name + " 즐겨찾기에 추가되었습니다! ⭐");
                    document.getElementById("favoriteStar").innerText = "★";  // 별을 채운 별로 변경

                    // 즐겨찾기 목록 갱신
                    self.fnfavorList();
                    resolve(data);
                } else {
                    console.log("서버 응답이 예상과 다릅니다:", data.result);
                    reject("서버 응답이 예상과 다릅니다");
                }
                console.log("서버로 전송된 데이터:", nparmap);
            },
            error: function(xhr, status, error) {
                console.error("즐겨찾기 추가 중 오류 발생:", error);
                reject(error);
            }
        });
    });
}
,
fnparRemoveFavorite(partnerdetailId, name, address, userId) {
    var self = this;
    return new Promise((resolve, reject) => {
        $.ajax({
            url: "/favorites/partner/remove.dox",
            dataType: "json",
            type: "POST",
            data: { userId, partnerdetailId },
            success: function(data) {
                console.log("✅ [REMOVE] 서버 응답:", data);

                if (data.result === "success") {
                    // 1. 즐겨찾기 마커 제거
                    const favoriteMarker = self.favoriteMarkers.find(marker =>
                        marker.partnerdetailId === partnerdetailId
                    );

                    if (favoriteMarker) {
                        favoriteMarker.setMap(null);
                        self.favoriteMarkers = self.favoriteMarkers.filter(m => m !== favoriteMarker);
                    }

                    // 2. 기존 일반 마커 제거 (겹침 방지용)
                    const existingNormalMarker = self.partnerMarkers.find(marker =>
                        marker.partnerdetailId === partnerdetailId
                    );

                    if (existingNormalMarker) {
                        existingNormalMarker.setMap(null);
                        self.partnerMarkers = self.partnerMarkers.filter(m => m !== existingNormalMarker);
                    }

                    // 3. 일반 마커 다시 생성
                    const partner = self.partnerlist.find(p => p.partnerdetailId === partnerdetailId);
                    if (partner) {
                        const normalMarkerImage = new kakao.maps.MarkerImage(
                            self.getCategoryImg(partner.categoryCode),
                            new kakao.maps.Size(42, 42)
                        );

                        const newMarker = new kakao.maps.Marker({
                            position: new kakao.maps.LatLng(partner.NY, partner.NX), // ✅ lat,lng 대신 NY,NX 사용
                            image: normalMarkerImage,
                            map: self.map
                        });

                        newMarker.partnerdetailId = partnerdetailId;
                        newMarker.categoryCode = partner.categoryCode;

                        kakao.maps.event.addListener(newMarker, 'click', () => {
                            self.showInfoWindowForCategory(newMarker, partner);
                        });

                        self.partnerMarkers.push(newMarker);
                    }

                    alert(name + " 즐겨찾기에서 해제되었습니다.");

                    self.fnfavorList(); // 즐겨찾기 목록 새로고침
                    resolve(data);
                } else {
                    reject("서버 응답이 실패했습니다");
                }
            },
            error: function(xhr) {
                console.error("❌ [REMOVE] AJAX 요청 실패!", xhr.responseText);
                reject(xhr.responseText);
            }
        });
    });
}
,

// 제휴사 목록에서 카테고리 코드를 찾는 헬퍼 함수 추가
getCategoryCodeFromPartnerList(partnerdetailId) {
    const partner = this.partnerlist.find(p => p.partnerdetailId === partnerdetailId);
    return partner ? partner.categoryCode : 1; // 기본값 1 (숙소)
}
,
closeFavorites() {
    this.isFavoritesVisible = false;

    if (this.currentView === 'hospital') {
        this.addMarkers();
    } else if (this.currentView === 'partner') {
        // ✅ 카테고리 필터가 있었으면 다시 필터링된 목록으로
        if (this.selectedCategoryCode) {
            this.filterByCategory(this.selectedCategoryCode);
        } else {
            // 아니면 전체 제휴사 다시 표시
            this.displayPartnerPlaces(this.partnerlist, { includeFavorites: false, clear: true });
        }
    }
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
                    // 병원이면 hosName / hosAddress, 제휴사면 name / address 강제 할당
                    name: fav.name || fav.hosName || "",
                    address: fav.address || fav.hosAddress || "",
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
        getCategoryImg(categoryCode) {
    const code = Number(categoryCode);
    console.log("🧩 categoryCode =", categoryCode, "→ code =", code);

    switch (code) {
        case 1: return "/img/partner/11.png";
        case 2: return "/img/partner/food.png";
        case 3: return "/img/partner/22.png";
        case 4: return "/img/partner/44.png";
        default:
            console.warn("❗알 수 없는 categoryCode:", categoryCode);
            return "/img/partner/clear.png";
    }
}
,
        // getCategoryImg(categoryCode) {
        //     switch (Number(categoryCode)) {
        //         case 1: return "/img/partner/11.png";
        //         case 2: return "/img/partner/food.png";
        //         case 3: return "/img/partner/22.png";
        //         case 4: return "/img/partner/44.png";
        //         //default: return "/img/logo.png";
        //     }
        // },
    },

    mounted() {
    this.isFavoritesVisible = false;
    this.initializeMap();  
    this.updateMap();      
    this.fnfavorList();  // 즐겨찾기 목록 로드
    
    // 지도 초기화 후 근처병원찾기 자동 실행
    this.$nextTick(() => {
        this.toggleNearbySearch();
        this.isNearbyVisible = true;
    });
 }
});

app.mount('#app');
</script> 