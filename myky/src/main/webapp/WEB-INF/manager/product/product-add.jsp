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
                       <option value="강아지">강아지</option>
                       <option value="고양이">고양이</option>
                       <option value="기타">기타</option>
                   </select>
               </div>
               <div class="col-auto">
                   <label class="form-label">카테고리2:</label>
                   <select v-model="category2" class="form-select" @change="updateCategory">
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
                    <textarea v-model="product.description" id="editor" class="editor-control"></textarea>
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
                    <div v-if="product.thumbnailUrl">
                        <img :src="product.thumbnailUrl" alt="썸네일" class="img-thumbnail mb-2" style="max-width: 150px;">
                        <button class="btn btn-danger btn-sm" @click="removeThumbnail">삭제</button>
                    </div>
                    <input type="file" class="form-control" @change="handleFileUpload($event, 'thumbnail')">
                </div>
                <div class="col-md-6">
                    <label for="extraImages" class="form-label">추가 이미지</label>
                    <div v-if="product.extraImagesUrls.length">
                        <div v-for="(img, index) in product.extraImagesUrls" :key="index" class="d-inline-block me-2">
                            <img :src="img" alt="추가 이미지" class="img-thumbnail mb-2" style="max-width: 100px;">
                            <button class="btn btn-danger btn-sm" @click="removeExtraImage(index)">삭제</button>
                        </div>
                    </div>
                    <input type="file" multiple class="form-control" @change="handleFileUpload($event, 'extraImages')">
                </div>
            </div>
            <div class="mt-4 text-end">
                <button class="btn btn-success px-4" @click="fnAddProduct">{{ isEdit ? '수정' : '추가' }}</button>
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
	                        thumbnail: null,
	                        thumbnailUrl: '',
	                        extraImages: [],
	                        extraImagesUrls: []
	                    },
						category1 : '',
						category2 : '',
						menu : '' , 
						submenu : '' ,  
						
                     };
                 },
                computed: {

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
                    			console.log("main",data);
                    			                    				
                    		}
                    	});
                    },
                    fnAddProduct (){
                    	this.fnMainList();
                    },
                    updateCategory() {
                        this.product.categoryId = this.category1+ "," + this.category2;
                    }
                	
                	
                },
                mounted() {
                	let self = this;
                	const params = new URLSearchParams(window.location.search);
                    
                    self.menu = params.get("menu") || "stat";
                    self.submenu = params.get("submenu") || "1";
                    
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
                           self.content = quill.root.innerHTML;
                       });

                	
                }
            });
            
            app.mount("#app");
            
    </script>
