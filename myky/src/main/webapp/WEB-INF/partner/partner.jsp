<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800c01d76232f2ef59e7ddffd882cefb&libraries=services"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.8.0/proj4.js"></script>
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
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/common/header.jsp"/>
    <div id="app">
        <div class="map_wrap">
            <div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
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
                        <div>
                            검색 : <input v-model="keyword" type="text" placeholder="병원 이름을 검색하세요" @keyup.enter="searchPlaces">
                        </div>
                        <button type="searchPlaces">검색하기</button> <!-- type="submit"으로 유지 -->
                    </form>
                    
                </div>
                
                <div v-if="hoslist.length > 0" class="count">
                    총 {{ hoslist.length }}개 병원이 검색되었습니다.
                </div>
                <hr>
                
                
                <ul id="placesList">
                    
                    <!-- <li v-if="hoslist.length === 0">로딩 중...</li> -->
                    
                    <li v-for="(hospital, index) in hoslist" :value="hospital.hospitalNo">
                        <div>{{ hospital.hosName }}</div>
                        <span>{{ hospital.hosAddress }}</span>
                        <hr>
                    </li>
                </ul>
                
                
                <!-- <div id="pagination">
                    <a v-for="page in totalPages" :key="page" href="#" :class="{ on: page === pagination.current }" @click="gotoPage(page)">
                        {{ page }}
                    </a>
                </div> -->
            </div>
        </div>
    </div>
</body>
</html>

<script>
    const app = Vue.createApp({
    data() {
        return {
            keyword: "",
            places: [],
            markers: [],
            map: null,
            pagination: {
                current: 1,
                pages: []
            },
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
                current: 1,
                perPage: 5
            }
        };
    },
    methods: {
        fnMemberList(keyword = "") {
            var self = this;
            console.log("전달된 검색어:", keyword);
            var nparmap = {
                selectgu: self.selectgu.GU,
                selectdong: self.selectdong.DONG,
                selectsi: self.selectsi,
                keyword:  self.keyword
            };

            $.ajax({
                url: "/partner/list.dox",
                dataType: "json",
                type: "POST",
                data: nparmap,
                success: function(data) {
                    console.log("서버 응답 데이터:", data);
                    console.log("검색어 : " + self.keyword);
                    self.displayHospitals("t" + data.hoslist);
                    

                    if (data) {
                        self.hoslist = Array.isArray(data.hoslist) ? data.hoslist : [];
                        self.gulist = Array.isArray(data.gulist) ? self.removeDuplicates(data.gulist, "GU") : [];
                        self.donglist = Array.isArray(data.donglist) ? data.donglist : [];
                        self.silist = Array.isArray(data.silist) ? data.silist : [];
                        self.addMarkers();

                    } else {
                        console.warn("서버 응답이 비어 있습니다.");
                    }

                    
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

        displayHospitals(data, hoslist) {
    console.log("displayHospitals" + hoslist); // hoslist의 내용 확인

    if (Array.isArray(hoslist) && hoslist.length > 0) {
        this.hoslist = hoslist; // hoslist에 데이터를 할당
    } else {
        console.error("병원 리스트가 비어 있습니다.");
    }
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

        searchPlaces() {
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
        radius: 10000  // 반경 5km 내의 장소만 검색
    };

    // 병원 이름 검색
    ps.keywordSearch(keyword, (data, status, pagination) => {
        if (status === kakao.maps.services.Status.OK) {
            // "동물병원"이라는 키워드를 포함하는 장소만 필터링
            const filteredData = data.filter(place => place.place_name.includes("동물병원"));
            if (filteredData.length > 0) {
                this.displayPlaces(filteredData, pagination);
            } else {
                alert('동물병원에 해당하는 결과가 없습니다.');
            }
        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
            alert('검색 결과가 존재하지 않습니다.');
        } else if (status === kakao.maps.services.Status.ERROR) {
            alert('검색 결과 중 오류가 발생했습니다.');
        }
    }, options);
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
},

displayPlaces(data, pagination) {
    this.places = data;  // data를 places에 할당
    this.pagination.pages = Array.from({ length: pagination.last }, (_, i) => i + 1);
    this.clearMarkers(); // 기존 마커 제거

    const bounds = new kakao.maps.LatLngBounds();

    data.forEach((place) => {
        const position = new kakao.maps.LatLng(place.y, place.x);
        const marker = this.addMarker(position, place);

        // 📌 마커 클릭 이벤트 추가
        kakao.maps.event.addListener(marker, "click", () => {
            this.showInfoWindowForSearch(marker, place);
        });

        bounds.extend(position);

        // 여기에 `hoslist`에 병원 정보를 추가
        this.hoslist.push({
            hosName: place.place_name,
            hosAddress: place.address_name,
            phone: place.phone || '정보 없음',
            lat: place.y,
            lng: place.x
        });
    });

    this.map.setBounds(bounds);
    setTimeout(() => {
        this.map.setLevel(4);
    }, 500);
}
,
 // 리스트에서 병원 클릭 시 지도 위치 이동
 moveToHospital(hospital) {
        const latLng = new kakao.maps.LatLng(hospital.lat, hospital.lng);
        this.map.setCenter(latLng);  // 지도 위치 이동
        this.addMarker(latLng, hospital);  // 해당 병원에 마커 추가
    },
        // 📌 키워드 검색 기반 병원 정보 표시
        showInfoWindowForSearch(marker, place) {
    if (this.infoWindow) {
        this.infoWindow.close();
    }

    let phoneContent = place.phone ? "<br>📞 " + place.phone : "";

    const content =
        "<div style='padding:10px; font-size:14px;'>" +
        "<strong>" + place.place_name + "</strong><br>" +
        (place.address_name ? place.address_name : "주소 정보 없음") +
        phoneContent +
        "<br><a href='https://map.kakao.com/link/to/" + place.place_name + "," + place.y + "," + place.x + 
        "' target='_blank'>길찾기</a>" +
        "</div>";

    this.infoWindow = new kakao.maps.InfoWindow({
        content: content,
        removable: true,
    });

    this.infoWindow.open(this.map, marker);
},

//         showInfoWindow(marker, hospital) {
//     if (this.infoWindow) {
//         this.infoWindow.close();
//     }

//     let phoneContent = '';
//     if (hospital.PHONE && hospital.PHONE.trim() !== '') {
//         phoneContent = '<br>' + "전화번호: " + hospital.PHONE;
//     }

//     const content = 
//         '<div style="padding:10px; font-size:14px;">' +
//         '<strong>' + hospital.place_name + '</strong><br>' +
//         hospital.address_name + '<br>' + 
//         phoneContent + 
//         '<br><a href="https://map.kakao.com/link/to/' + hospital.place_name + ',' + hospital.y + ',' + hospital.x + '" target="_blank">길찾기</a>' +
//         '</div>';

//     this.infoWindow = new kakao.maps.InfoWindow({
//         content: content,
//         removable: true,
//     });

//     this.infoWindow.open(this.map, marker);
// },
// 키워드 검색 시 병원 목록 초기화
clearSearchResults() {
        this.hoslist = [];
        this.keyword = '';
    },
        // 마커 추가 함수
    addMarkers() {
        this.clearMarkers();

        if (this.hoslist.length === 0) {
            console.warn("병원 리스트가 비어 있습니다.");
            return;
        }

        this.hoslist.forEach((hospital) => {
            const position = new kakao.maps.LatLng(hospital.NY, hospital.NX);
            const marker = new kakao.maps.Marker({
                position: position,
                title: hospital.hosName
            });

            marker.setMap(this.map);

            // 📌 마커 클릭 시 병원 정보 표시 (셀렉트 기반)
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
            this.showInfoWindowForSelect(marker, place);
        });

        return marker;
    },
     // 📌 셀렉트(구/동 선택) 기반 병원 정보 표시
     showInfoWindowForSelect(marker, hospital) {
    if (this.infoWindow) {
        this.infoWindow.close();
    }

    let phoneContent = hospital.PHONE ? "<br>📞 " + hospital.PHONE : "";

    const content =
        "<div style='padding:10px; font-size:14px;'>" +
        "<strong>" + hospital.hosName + "</strong><br>" +
        (hospital.hosAddress ? hospital.hosAddress : "주소 정보 없음") +
        phoneContent +
        "<br><a href='https://map.kakao.com/link/to/" + hospital.hosName + "," + hospital.NY + "," + hospital.NX + 
        "' target='_blank'>길찾기</a>" +
        "</div>";

    this.infoWindow = new kakao.maps.InfoWindow({
        content: content,
        removable: true,
    });

    this.infoWindow.open(this.map, marker);
},
        clearMarkers() {
            this.markers.forEach(marker => marker.setMap(null));
            this.markers = [];
        },

        gotoPage(page) {
            this.pagination.current = page;
            this.searchPlaces();
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
                lat = 37.566826; // 기본값: 서울
                lng = 126.9786567;
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
        }
    },

    mounted() {
        this.initializeMap();
        this.updateMap(); // 기본 지도 설정
        this.fnMemberList();
    }
});

app.mount('#app');

</script>