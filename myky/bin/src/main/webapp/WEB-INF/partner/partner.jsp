<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=800c01d76232f2ef59e7ddffd882cefb&libraries=services"></script>
    <title>첫번째 페이지</title>
    <style>
        html, body { width: 100%; height: 100%; margin: 0; padding: 0; }
        .map_wrap { position: relative; overflow: hidden; width: 100%; height: 350px; }
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
        .map_wrap { position: relative; width: 100%; height: 500px; }
        #menu_wrap { position: absolute; top: 0; left: 0; bottom: 0; width: 250px; margin: 10px 0 30px 10px; padding: 5px; overflow-y: auto; background: rgba(255, 255, 255, 0.7); z-index: 1; font-size: 12px; border-radius: 10px; }
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
    </style>
</head>
<body>
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
                            <option v-for="item in gulist" :value="item.GU">{{ item.GU }}</option>
                        </select>
                        <select v-model="selectdong" @change="updateMap">
                            <option value="">선택</option>
                            <option v-for="item in donglist" :value="item.DONG">{{ item.DONG }}</option>
                        </select>
                        <div>
                            검색 : <input v-model="keyword" type="text" size="15">
                        </div>
                        <button type="submit">검색하기</button> <!-- type="submit"으로 유지 -->
                    </form>
                </div>
                <hr>
                <ul id="placesList">
                    <li v-for="(place, index) in places" :key="index" class="item">
                        <span :class="'markerbg marker_' + (index + 1)"></span>
                        <div class="info">
                            <h5>{{ place.place_name }}</h5>
                            <span v-if="place.road_address_name">{{ place.road_address_name }}</span>
                            <span class="jibun gray" v-if="place.address_name">{{ place.address_name }}</span>
                            <span v-else>{{ place.address_name }}</span>
                            <span class="tel">{{ place.phone }}</span>
                        </div>
                    </li>
                </ul>
                <div id="pagination">
                    <a v-for="page in pagination.pages" :key="page" href="#" :class="{ on: page === pagination.current }" @click="gotoPage(page)">
                        {{ page }}
                    </a>
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
                keyword: '부평',
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
                selectgu: "",
                selectdong: "",
                selectsi: "인천광역시"
            };
        },
        methods: {
            fnMemberList() {
                var self = this;
        var nparmap = {
            selectgu: self.selectgu,
            selectdong: self.selectdong,
            selectsi: self.selectsi
        };
        $.ajax({
            url: "/partner/list.dox",
            dataType: "json",
            type: "POST",
            data: nparmap,
            success: function(data) {
                console.log("데이터 확인:", data.gulist);
                console.log("데이터 확인:", data.donglist);
                console.log("데이터 확인:", data.silist);
                self.gulist = data.gulist;
                self.donglist = data.donglist;
                self.silist = data.silist;

                // 여기서 좌표를 받아와서 지도에 반영
                const selectedDong = self.donglist.find(item => item.dong === self.selectdong);
                const selectedGu = self.gulist.find(item => item.gu === self.selectgu);

                if (selectedDong) {
                    self.updateMapWithCoordinates(selectedDong.lat, selectedDong.lng);
                } else if (selectedGu) {
                    self.updateMapWithCoordinates(selectedGu.lat, selectedGu.lng);
                }
            }
        });
            },
            fnsi() {
                var self = this;
                self.selectgu = "";
                self.selectdong = "";
                self.fnMemberList();
            },
            setMapType: function(maptype) {
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
            zoomIn: function() {
                this.map.setLevel(this.map.getLevel() - 1);
            },
            zoomOut: function() {
                this.map.setLevel(this.map.getLevel() + 1);
            },
            initializeMap() {
                const mapContainer = document.getElementById('map');
                const mapOption = {
                    center: new kakao.maps.LatLng(37.566826, 126.9786567), // Default center is Seoul
                    level: 3
                };
                this.map = new kakao.maps.Map(mapContainer, mapOption);
            },
            searchPlaces() {
                if (!this.keyword.trim()) {
                    this.updateMap();
                    return;
                }
                const ps = new kakao.maps.services.Places();
                const keyword = this.keyword.trim();
                ps.keywordSearch(keyword, this.placesSearchCB);
            },
            placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    this.displayPlaces(data, pagination);
                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                    alert('검색 결과가 존재하지 않습니다.');
                } else if (status === kakao.maps.services.Status.ERROR) {
                    alert('검색 결과 중 오류가 발생했습니다.');
                }
            },
            displayPlaces(data, pagination) {
                this.places = data;
                this.pagination.pages = Array.from({ length: pagination.last }, (_, i) => i + 1);
                this.clearMarkers();
                const bounds = new kakao.maps.LatLngBounds();
                data.forEach((place, index) => {
                    const position = new kakao.maps.LatLng(place.y, place.x);
                    const marker = this.addMarker(position, index);
                    bounds.extend(position);
                });
                this.map.setBounds(bounds);
            },
            addMarker(position, index) {
                const imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png';
                const imageSize = new kakao.maps.Size(36, 37);
                const imgOptions = {
                    spriteSize: new kakao.maps.Size(36, 691),
                    spriteOrigin: new kakao.maps.Point(0, (index * 46) + 10),
                    offset: new kakao.maps.Point(13, 37)
                };
                const markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions);
                const marker = new kakao.maps.Marker({
                    position: position,
                    image: markerImage
                });
                marker.setMap(this.map);
                this.markers.push(marker);
                return marker;
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
                console.log("updateMap 호출됨");
                this.fnMemberList();

                if (!this.map) {
                    console.warn("지도 객체가 초기화되지 않았습니다.");
                    return;
                }

                const selectedDong = this.donglist.find(item => item.dong === this.selectdong);
                const selectedGu = this.gulist.find(item => item.gu === this.selectgu);

                let lat, lng;
                if (selectedDong) {
                    lat = selectedDong.lat;
                    lng = selectedDong.lng;
                    console.log("동 선택됨:", this.selectdong, "좌표:", `(${lat}, ${lng})`);
                } else if (selectedGu) {
                    lat = selectedGu.lat;
                    lng = selectedGu.lng;
                    console.log("구 선택됨:", this.selectgu, "좌표:", `(${lat}, ${lng})`);
                } else {
                    lat = 37.566826;
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
        // X, Y 좌표를 위도, 경도로 변환
        const transCoord = new kakao.maps.TransCoord();
        const latLng = transCoord.transCoordToLatLng(data.NX, data.NY);

        if (latLng) {
            // 지도 중심을 해당 위치로 이동
            this.map.setCenter(latLng);
        } else {
            console.warn("좌표 변환 실패");
        }
    }
        },
        mounted() {
            this.initializeMap();
            this.updateMap();
            this.fnMemberList();
        }
    });

    app.mount('#app');
</script>