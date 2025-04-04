<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vue3 레이아웃 예제</title>
           
     <style>
     /* 전체 대시보드 배경 */
		.dashboard-container {
		    background-color: #f8fafd;
		    min-height: 100vh;
		    padding: 30px 20px;
		    font-family: 'Segoe UI', sans-serif;
		    
		}
		
		/* 메인 콘텐츠 */
		.main-content {
		    padding: 10px 30px;
		}
		
		/* 카드 공통 */
		.card {
		    border: none;
		    border-radius: 20px;
		    box-shadow: 0 6px 16px rgba(0, 0, 0, 0.04);
		    background-color: #ffffff;
		    margin-bottom: 10px;
		}
		
		.card-header {
		    background-color: transparent;
		    font-weight: 600;
		    font-size: 18px;
		    border-bottom: none;
		    padding: 20px;
		}
		
        .input-group {
            margin-bottom: 15px;
            display: flex;
            flex-direction: column;
        }
        .input-group label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .input-group input,
        .input-group textarea,
        .input-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }
        .button-container {
            display: flex;
            justify-content: flex-end;
        }
        .submit-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }
        .submit-button:hover {
            background-color: #45a049;
        }
        .editor-control {
		    height: 200px;
		    width: 100%;
        }
        
    </style>
    
</head>
<body>

   <div id="app" class="dashboard-container col-9 container mt-4">
        <div class="main-content card p-4 shadow-sm">
            <h2 class="mb-4">{{ isEdit ? '상품 수정' : '상품 추가' }}</h2>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="name" class="form-label">상품명</label>
                    <input v-model="product.productName" id="name" type="text" class="form-control">
                </div>
        		<div class="col-auto">
                   <label class="form-label">카테고리1:</label>
                   <select v-model="category1" class="form-select" @change="updateCategory">
                       <option value="">카테고리1</option>
                       <option value="강아지">강아지</option>
                       <option value="고양이">고양이</option>
                       <option value="기타">기타</option>
                   </select>
               </div>
               <div class="col-auto">
                   <label class="form-label">카테고리2:</label>
                   <select v-model="category2" class="form-select" @change="updateCategory">
                       <option value="">카테고리2</option>
                       <option value="장난감">장난감</option>
                       <option value="용품">용품</option>
                       <option value="사료">사료</option>
                       <option value="간식">간식</option>
                       <option value="영양제">영양제</option>
                   </select>
               </div>		          
                    <input type="hidden" v-model="product.categoryId" id="category" type="text" class="form-control">
                <div class="col-md-6">
                    <label for="price" class="form-label">가격</label>
                    <input v-model="product.price" id="price" type="text" class="form-control">
                </div>
                <div class="col-md-6">
                    <label for="quantity" class="form-label">수량</label>
                    <input v-model="product.quantity" id="quantity" type="text" class="form-control">
                </div>
                <div class="col-md-6">
                    <label for="manufacturer" class="form-label">제조사</label>
                    <input v-model="product.manufacturer" id="manufacturer" type="text" class="form-control">
                </div>
                <div class="col-12">
                    <label for="description" class="form-label">상품 설명</label>
                    <div id="editor" class="editor-control"></div>
                </div>
                <div class="col-md-6">
                    <label for="code" class="form-label">상품 코드</label>
                    <input v-model="product.productCode" id="code" type="text" class="form-control">
                </div>
                <div class="col-md-6">
                    <label for="discountRate" class="form-label">할인율</label>
                    <input v-model="product.discount" id="discountRate" type="text" class="form-control">
                </div>
                <div class="col-md-6">
                    <label for="shippingFee" class="form-label">배송비</label>
                    <input v-model="product.shippingFee" id="shippingFee" type="text" class="form-control">
                </div>
                <div class="col-md-6">
                    <label for="freeShippingThreshold" class="form-label">배송비 면제 가격</label>
                    <input v-model="product.shippingFreeMinimum" id="freeShippingThreshold" type="text" class="form-control">
                </div>
                <div class="col-md-6">
                    <label for="thumbnail" class="form-label">썸네일 이미지</label>
                    
                    <div v-if="thumbnailUrl">
                        <img :src="thumbnailUrl" alt="썸네일" class="img-thumbnail mb-2" style="max-width: 150px;">
                        <button class="btn btn-danger btn-sm" @click="removeThumbnail">삭제</button>
                    </div>
                    
                    <div v-if="prev_thumbnail">
                        <img :src="prev_thumbnail.filePath" alt="썸네일" class="img-thumbnail mb-2" style="max-width: 150px;">
                        <button class="btn btn-danger btn-sm" @click="removePrevThumbnail(prev_thumbnail.fileId)">삭제</button>
                    </div>     
                    <input type="file" class="form-control" @change="handleFileUpload($event, 'thumbnail')" :disabled="prev_thumbnail !== null" >
                </div>
                <div class="col-md-6">
                    <label for="extraImages" class="form-label">추가 이미지</label>
                    <div v-if="extraImagesUrls.length">
                        <div v-for="(img, index) in extraImagesUrls" :key="index" class="d-inline-block me-2">
                            <img :src="img" alt="추가 이미지" class="img-thumbnail mb-2" style="max-width: 100px;">
                            <button class="btn btn-danger btn-sm" @click="removeExtraImage(index)">삭제</button>
                        </div>
                    </div>
                    <div v-if="prev_extraImages.length">
                        <div v-for="(img, index) in prev_extraImages" :key="index" class="d-inline-block me-2">
                            <img :src="img.filePath" alt="추가 이미지" class="img-thumbnail mb-2" style="max-width: 100px;">
                            <button class="btn btn-danger btn-sm" @click="removePrevExtraImage(index,img.fileId)">삭제</button>
                        </div>
                    </div>
                    
                    <input type="file" multiple class="form-control" @change="handleFileUpload($event, 'extraImages')">
                </div>
                
            </div>
            <div class="mt-4 text-end">
                <button v-if="isEdit" class="btn btn-success px-4" @click="fnUpdate">수정</button>
                <button v-else-if="!isEdit" class="btn btn-success px-4" @click="fnAddProduct">추가</button>
                
            </div>
        </div>
    </div>
    
</body>
</html>

<script>
    
   
            const app = Vue.createApp({
            	 data() {
                     return {
						isEdit: false,
						productId  : "",
	                    product: {
	                    	productId : null,
	                    	productName: '',
	                    	productType : '',
	                    	productCode : '',
	                    	categoryId: '',
	                        price: '',
	                        quantity: '',
	                        manufacturer: '',
	                        description: '',
	                        code: '',
	                        discount: '',
	                        shippingFee: '',
	                        shippingFreeMinimum: '',
	                        deleteYn: 'N',
	                    },
                        thumbnail: null,
                        thumbnailUrl: null,
                        extraImages: [],
                        extraImagesUrls: [],
                        prev_thumbnail: null,
                        prev_thumbnailUrl: null,
                        prev_extraImages: [],
                        prev_extraImagesUrls: [],
						menu : '' , 
						submenu : '' ,  
						
                     };
                 },
                computed: {
                    category1() {
                        return this.product.categoryId && this.product.categoryId.includes(',')
                            ? this.product.categoryId.split(',')[0].trim()
                            : (this.product.categoryId || '').trim();
                    },
                    category2() {
                        return this.product.categoryId && this.product.categoryId.includes(',')
                            ? (this.product.categoryId.split(',')[1] || '').trim()
                            : '';
                    }
                },
                methods: {
                	fnMainList : function() {
                    	var self = this;
                    	var nparmap = self.product;
                    	
                    	$.ajax({
                    		url: "/admin/insertProduct.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
        						
        						alert("등록 완료");

        						 let uploadCount = 0; // 업로드할 총 파일 개수
        			             let completedUploads = 0; // 업로드 완료된 파일 개수

	       			                function checkAndRedirect() {
	       			                    completedUploads++; // 업로드 완료될 때마다 증가
	       			                    if (completedUploads === uploadCount) {
	       			                        location.href = "/manager/main.do?menu=product&submenu=1";
	       			                    }
	       			                }
	
	       			                // 업로드할 파일 개수 확인
	       			                if (self.thumbnail) uploadCount++;
	       			            	if (self.extraImages.length > 0) uploadCount++; // 추가 이미지 한 번에 처리
	
	       			                // 업로드할 파일이 없으면 즉시 이동
	       			                if (uploadCount === 0) {
	       			                    location.href = "/manager/main.do?menu=product&submenu=1";
	       			                    return;
	       			                }
	
	       			                // 썸네일 업로드
	       			                if (self.thumbnail) {
	       			                    var form = new FormData();
	       			                    form.append("file1", self.thumbnail );
	       			                    form.append("productId", data.productId);
	       			                    form.append("thumbYn", "Y");
	
	       			                    self.upload(form, checkAndRedirect);
	       			                }
	
		       			          	// 추가 이미지 한 번에 업로드
		       			             if (self.extraImages.length > 0) {
		       			                 var imgForm = new FormData();
		       			                 self.extraImages.forEach(file => {
		       			                     imgForm.append("file1", file); // 여러 파일 추가
		       			                 });
		       			                 imgForm.append("productId", data.productId);
		       			                 imgForm.append("thumbYn", "N");
	
		       			                 self.upload(imgForm, checkAndRedirect);
		       			             }

                    		}
                    	});
                    },
                    fnUpdate : function() {
                    	var self = this;
                    	var nparmap = self.product;
                    	$.ajax({
                    		url: "/admin/updateProduct.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log(data);
        						
        						alert("수정 완료");

        						 let uploadCount = 0; // 업로드할 총 파일 개수
        			             let completedUploads = 0; // 업로드 완료된 파일 개수

	       			                function checkAndRedirect() {
	       			                    completedUploads++; // 업로드 완료될 때마다 증가
	       			                    if (completedUploads === uploadCount) {
	       			                        location.href = "/manager/main.do?menu=product&submenu=1";
	       			                    }
	       			                }
	
	       			                // 업로드할 파일 개수 확인
	       			                if (self.thumbnail) uploadCount++;
	       			            	if (self.extraImages.length > 0) uploadCount++; // 추가 이미지 한 번에 처리
	
	       			                // 업로드할 파일이 없으면 즉시 이동
	       			                if (uploadCount === 0) {
	       			                    location.href = "/manager/main.do?menu=product&submenu=1";
	       			                    return;
	       			                }
	
	       			                // 썸네일 업로드
	       			                if (self.thumbnail) {
	       			                    var form = new FormData();
	       			                    form.append("file1", self.thumbnail );
	       			                    form.append("productId", self.product.productId);
	       			                    form.append("thumbYn", "Y");
	
	       			                    self.upload(form, checkAndRedirect);
	       			                }
	
		       			          	// 추가 이미지 한 번에 업로드
		       			             if (self.extraImages.length > 0) {
		       			                 var imgForm = new FormData();
		       			                 self.extraImages.forEach(file => {
		       			                     imgForm.append("file1", file); // 여러 파일 추가
		       			                 });
		       			                 imgForm.append("productId", self.product.productId);
		       			                 imgForm.append("thumbYn", "N");
	
		       			                 self.upload(imgForm, checkAndRedirect);
		       			             }

                    		}
                    	});
                    },
                    fnAddProduct (){
                    	this.fnMainList();
                    },
                    updateCategory() {
                        this.product.categoryId = this.category1+ "," + this.category2;
                    },
                    upload(form, callback) {
                        $.ajax({
                            url: "/manager/fileUpload.dox",
                            type: "POST",
                            processData: false,
                            contentType: false,
                            data: form,
                            success: function(response) {
                                callback(); // 업로드 완료 후 호출
                            }
                        });
                    },
        			handleFileUpload(event, type) {
                        const files = event.target.files;
                        if (type === 'thumbnail') {
                            this.thumbnail = files[0];
                            this.thumbnailUrl = URL.createObjectURL(files[0]);
                        } else if (type === 'extraImages') {
                            this.extraImages = Array.from(files);
                            this.extraImagesUrls = this.extraImages.map(file => URL.createObjectURL(file));
                        }
                    },
                    removeThumbnail() {
                        this.thumbnail = null;
                        this.thumbnailUrl = '';
                    },
                    // 이전 썸네일 삭제
                    removePrevThumbnail(fileId) {
                        if(!confirm('썸네일을 삭제하시겠습니까?')){
                            return false;
                        }
                        
                        this.prev_thumbnail = null;
                        this.prev_thumbnailUrl = '';
                        this.removeImg(fileId);

                    },
                    // 현재 추가 이미지 삭제
                    removeExtraImage(index) {
                        this.extraImages.splice(index, 1);
                        this.extraImagesUrls.splice(index, 1);
                    },
                    // 이전 추가 이미지 삭제
                    removePrevExtraImage(index,fileId) {
                    	if(!confirm('해당 이미지를 삭제하시겠습니까?')){
                            return false;
                        }
                    	
                        this.prev_extraImages.splice(index, 1);
                        this.prev_extraImagesUrls.splice(index, 1);
                        this.removeImg(fileId);
                    },
                    removeImg(fileId) {
                    	let self = this;
                    	var nparmap = {
                    			fileId : fileId,
                    	};
                    	$.ajax({
                    		url: "/admin/deleteProductImg.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("main1",data);
                    			
                    		}
                    	});
                    	
                    },                    
                	fnEditList () {
                    	let self = this;
                    	var nparmap = {
                    			productId : self.productId,
                    	};
                    	$.ajax({
                    		url: "/admin/selectProduct.dox",
                    		dataType: "json",
                    		type: "POST",
                    		data: nparmap,
                    		success: function (data) {
                    			console.log("main11",data);
                    			self.product = data.Product;
                    			
                    			
                                // ✅ 썸네일 정보 설정
                                if (data.ThumImg) {
                                    self.prev_thumbnail = data.ThumImg;  
                                    self.prev_thumbnailUrl = data.ThumImg.filePath;
                                } else {
                                    self.prev_thumbnail = null;
                                    self.prev_thumbnailUrl = null;
                                }

                                // ✅ 추가 이미지 리스트 설정
                                if (data.ImgList && data.ImgList.length > 0) {
                                    self.prev_extraImages = data.ImgList;
                                    self.prev_extraImagesUrls = data.ImgList.map(img => img.filePath);
                                } else {
                                    self.prev_extraImages = [];
                                    self.prev_extraImagesUrls = [];
                                }
                                
                            	var quill = new Quill('#editor', {
                                    theme: 'snow',
                                    modules: {
                                        toolbar: [
                                            [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                            ['bold', 'italic', 'underline'],
                                            [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                                            ['link', 'image'],
                                            ['clean'],
                                            [{ 'color': [] }, { 'background': [] }],  
                                        ]
                                    }
                                	});
                            	
                    			quill.root.innerHTML = data.Product.description;

                    			
                             	quill.on('text-change', function() {
                             	    self.product.description = quill.root.innerHTML;
                             	});
                    		}
                    	});
                    	
                    	
                    }
                    
                	
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
                    self.productId = params.get("productId") || "";

                    


                	if ( self.productId != '') {
                		self.isEdit = true;
                		self.fnEditList();
                	} else {
                    	var quill = new Quill('#editor', {
                            theme: 'snow',
                            modules: {
                                toolbar: [
                                    [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
                                    ['bold', 'italic', 'underline'],
                                    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
                                    ['link', 'image'],
                                    ['clean'],
                                    [{ 'color': [] }, { 'background': [] }],  
                                ]
                            }
                        	});
                     	quill.on('text-change', function() {
                     	    self.product.description = quill.root.innerHTML;
                     	});
                		
                	}
                	
                	
                	
                }
            });
            
            app.mount("#app");
            
    </script>
