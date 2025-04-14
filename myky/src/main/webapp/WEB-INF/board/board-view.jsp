<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>자유게시판</title>
        <!-- <script src="https://unpkg.com/vue@3/dist/vue.global.js"></script> -->
        <link rel="stylesheet" href="/css/board/board.css"/>

        <style>
   
        </style>

    </head>

    <body>
        <jsp:include page="../common/header.jsp" />

        <div id="fb-app" class="fb-container">

            <div id="fb-viewPage">
                <div class="fb-section-header" v-if="category == 'F'">
                    VIEW
                </div>
                <div class="fb-section-header" v-if="category == 'A'">
                    NOTICE VIEW
                </div>
                <div class="fb-section-headerDown" v-if="category == 'F'">
                    여러분의 이야기를 들려주세요.
                </div>
                <div class="fb-section-headerDown" v-if="category == 'A'">
                    새 소식을 알려드립니다<div class="f"></div>
                </div>
                <hr class="fb-custom-hr">
                
                <div class="fb-post-wrapper">
                    <div class="fb-post-header">
                      <div class="fb-post-title">{{ info.title }}</div>
                      <div class="fb-post-meta">
                        <span class="fb-nickname">{{ info.nickName }}</span>
                        <span class="fb-date">🕒 {{ info.createdAt }}</span>
                        <span class="fb-views">조회수 {{ info.cnt }}</span>
                      </div>
                    </div>
                  
                    <div class="fb-post-content" v-html="info.content"></div>
                  </div>

                <!-- 좋아요, 싫어요 버튼 -->
                <div class="like-button-wrapper">
                    <template v-if="likeStatus">
                        <button @click="likeButton('like','M')" class="likeButton">
                            <span class="like-button-margin" :style="{ opacity: info.likes > 0 ? 1 : 0 }">{{ info.likes }}</span>
                            <img src="../img/buttonImg/like2.png" class="likeButton2" alt="좋아요" />
                        </button>
                    </template>
                    <template v-else>
                        <button @click="likeButton('like','P')" class="likeButton">
                            <span class="like-button-margin" :style="{ opacity: info.likes > 0 ? 1 : 0 }">{{ info.likes }}</span>
                            <img src="../img/buttonImg/like.png" class="likeButton2" alt="좋아요" />
                        </button>
                    </template>

                    <template v-if="dislikeStatus">
                        <button @click="likeButton('dislike','M')" class="likeButton">
                            <img src="../img/buttonImg/dislike2.png" class="likeButton2" alt="싫어요" />
                            <span class="like-button-margin" :style="{ opacity: info.dislikes > 0 ? 1 : 0 }">{{ info.dislikes }}</span>
                        </button>
                    </template>
                    <template v-else>
                        <button @click="likeButton('dislike','P')" class="likeButton">
                            <img src="../img/buttonImg/dislike.png" class="likeButton2" alt="싫어요" />
                            <span class="like-button-margin" :style="{ opacity: info.dislikes > 0 ? 1 : 0 }">{{ info.dislikes }}</span>
                        </button>
                    </template>
                </div>
                <div v-if="fileList.length > 0">
                    <div class="fb-title-label">첨부파일</div>
                    <div class="fb-view-files">
                        <div v-for="item in fileList">
                            <div class="fb-link-container">
                                <div  @click="fnDownload(item.filePath, item.fileName, item.fileSize)" class="FileDownload">
                                    <span class="fb-FileDownload"> {{ item.fileName }} ({{ Math.ceil(item.fileSize/1024)}} kb) </span></div>
                                <div v-if="isImageFile(item.fileName)">
                                    <img :src="item.filePath" :alt="item.fileName" class="fb-preview-image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <table>
                </table>
                <!-- 댓글 입력 -->
                <div v-if="category == 'F'">
                    <table>
                        <tr v-if="cmtList.commentId != null">
                            <div v-for="item in cmtList" :key="item.commentId">
                                <div class="fb-cmtTextBox"   :id="'comment-' + item.commentId"                                      
                                     :style="item.userId === sessionId ? 'background-color: #f8f8f8;' : ''">

                                    <!-- 수정 중인 경우 -->
                                    <div v-if="editCommentId == item.commentId">
                                        <div style="font-weight: bold; margin-bottom: 3px;">{{ sessionNickName }}</div>
                                        <div>
                                        <input v-model="editContent" class="fb-cmtInput" />
                                            <button class="fb-cmtButton2"
                                                @click="fnCommentUpdate(item.commentId)">저장</button>
                                            <button class="fb-cmtButton2" @click="editCommentId = ''">취소</button>
                                        </div>
                                    </div>
                                    <!-- 일반 댓글 보기 -->
                                    <div v-else>
                                        <!-- 유저 아이디 -->
                                        <template v-if="item.isDeleted == 'Y'">
                                            <div style="font-weight: bold; margin-bottom: 3px;"></div>
                                            <!-- 댓글 내용 -->
                                            <div style="margin-bottom: 5px;">삭제된 댓글입니다.</div>
                                        </template>
                                        <template v-else>
                                            <div class="fb-profile-container">
                                            <img :src="item.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                                                alt="프로필 이미지"
                                                class="fb-top-profile-img1">
                                            <span class="fb-nickname">{{ item.nickName }}
                                            </span>
                                        </div>

                                            <!-- 댓글 내용 -->
                                            <div style="margin-bottom: 5px;">{{ item.content }}</div>
                                        </template>
                                    </div>


                                    <!-- 날짜 / 버튼들 -->
                                    <div
                                        style="display: flex; align-items: center; gap: 10px; font-size: 13px; color: #888;">
                                        <span>{{ item.updatedTime }}</span>

                                        <!-- 답글 -->
                                        <div v-if="sessionId">
                                            <a class="fb-cmt2button" @click="fnReply(item.commentId)">답글 달기</a>

                                            <!-- 수정/삭제 -->
                                            <template v-if="item.isDeleted == 'N'&& editCommentId !== item.commentId">
                                                <template v-if="sessionId == item.userId">
                                                        <button class="fb-cmtButton2" @click="fnCommentEdit(item)">수정</button>
                                                </template>
                                                <template v-if="sessionId == item.userId || sessionRole == 'ADMIN'">
                                                    <button class="fb-cmtButton2" @click="fnCommentRemove(item.commentId)">삭제</button>
                                                </template>
                                            </template>
                                        </div>
                                    </div>
                                </div>

                                <!-- 대댓글 입력창 -->
                                <div v-if="replyFormId === item.commentId" style="margin-left: 30px;">
                                    <input class="fb-cmtInput" v-model="replyContent" placeholder="대댓글 입력" />
                                    <button class="fb-cmtButton2" @click="fnReplySave(item.commentId)">등록</button>
                                    <button class="fb-cmtButton2" @click="replyFormId = ''">취소</button>
                                </div>

                                <!-- 대댓글 반복 -->
                                <div v-for="reply in item.replies || []" :key="reply.commentId" :id="'comment-' + reply.commentId"   
                                :style="{backgroundColor: reply.userId === sessionId ? '#f8f8f8' : ''}"   style="margin-left: 40px; padding: 10px;">
                                    <div v-if="editCommentId === reply.commentId" class="fb-cmtTextBox">
                                        <div class="fb-profile-container">
                                            <img :src="item.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                                                alt="프로필 이미지"
                                                class="fb-top-profile-img1">
                                            <span class="fb-nickname">{{ item.nickName }}
                                            </span>
                                        </div>
                                        <input class="fb-cmtInput" v-model="editContent"/>
                                        <button class="fb-cmtButton2" @click="fnCommentUpdate(reply.commentId)">저장</button>
                                        <button class="fb-cmtButton2" @click="editCommentId = ''">취소</button>
                                    </div>
                                    <div v-else>
                                        <div v-if="reply.isDeleted == 'Y'">
                                            <div style="margin: 20px;">삭제된 댓글입니다.</div>
                                        </div>
                                        <div v-else>
                                            <div class="fb-profile-container">
                                                <img :src="item.profileImage || '/img/userProfile/Default-Profile-Picture.jpg'"
                                                    alt="프로필 이미지"
                                                    class="fb-top-profile-img1">
                                                <span class="fb-nickname">{{ item.nickName }}
                                                </span>
                                            </div>

                                            <div style="margin-bottom: 5px;">{{ reply.content }}</div>
                                            <div
                                                style="display: flex; align-items: center; font-size: 13px; color: #888;">
                                                <span>{{ reply.updatedTime }}</span>
                                                <template v-if="sessionId === reply.userId">
                                                    <button class="fb-cmtButton2" @click="fnCommentEdit(reply) ">수정</button>
                                                </template>
                                                <template v-if="sessionId === reply.userId || sessionRole === 'ADMIN'">
                                                    <button class="fb-cmtButton2" @click="fnCommentRemove(reply.commentId)">삭제</button>
                                                </template>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </tr>
                        </table>
                            <div class="fb-cmtButtonBox" v-if="sessionId">
                                <div></div>
                                <div class="replyNickName"> {{sessionNickName}} </div>
                                <div class="reply-input-cell">
                                    <div class="reply-box">
                                        <textarea class="clean-textarea" v-model="content" cols="60" rows="5" placeholder="댓글을 입력하세요"></textarea>
                                        <div class="reply-button-cell">
                                            <button class="fb-buttonReply" @click="fnCommentSave">저장</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>

                <div class="fb-buttonMargin">
                    <template v-if="sessionId == info.userId">
                        <button class="fb-button" @click="fnEdit()">수정</button>
                    </template>
                    <template v-if="sessionId == info.userId || sessionRole == 'ADMIN'">    
                        <button class="fb-button" @click="fnRemove()">삭제</button>
                    </template>
                    <button class="fb-button" @click="fnBack(info)">뒤로가기</button>
                </div>
                
                <div class="fb-mini-board">
                    <table class="fb-mini-table">
                        <tr class="fb-mini-table-th fb-mini-th">
                            <th colspan="4">전체글</th>
                        </tr>
                        <tr class="fb-mini-td" v-for="list2 in list.slice(0,5)"  @click="fnGetBoardList(list2.boardId)"
                            :style="list2.boardId === info.boardId ? 'font-weight: bold; background-color: #f8f8f8' : ''">
                            <td style="width: 600px;">{{list2.title}}</td>
                            <td>{{list2.nickName}}</td>
                            <td>{{list2.createdAt}}</td>
                            <td>{{list2.cnt}}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        </div>

        <jsp:include page="../common/footer.jsp" />


    </body>

    </html>
    <script>


        document.addEventListener("DOMContentLoaded", function () {
            const app = Vue.createApp({
                data() {
                    return {
                        boardId: "${map.boardId}",
                        info: {},
                        page: "${param.page}",
                        sessionId: "${sessionId}",
                        sessionRole: "${sessionRole}",
                        sessionName : "${sessionName}",
                        sessionNickName : "${sessionNickName}",
                        userId: {},
                        nickName: "",
                        content: "",
                        commentId: "",
                        cmtList: [],
                        editCommentId: "",
                        editContent: "",
                        fileList: [],
                        category: "",
                        imageExtensions: [
                            // 일반적으로 많이 쓰는 확장자
                            'jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp',

                            // 벡터 이미지
                            'svg', 'eps', 'ai',

                            // 고화질/전문 이미지
                            'tiff', 'tif', 'heic', 'heif', 'raw', 'cr2', 'nef', 'orf', 'sr2',

                            // 애니메이션/움짤
                            'apng', 'mng',

                            // 아이콘/스프라이트 등
                            'ico', 'icns',

                            // 기타/특수 확장자
                            'jfif', 'pjpeg', 'pjp', 'avif', 'emf', 'wmf'
                        ],
                        replyFormId: "",       // 어떤 댓글에 답글을 다는지
                        replyContent: "",      // 대댓글 내용
                        editReplyId: "",
                        editReplyContent: "",
                        updatedTime: "",
                        createdTime: "",
                        likeStatus: false,  // 좋아요 상태
                        dislikeStatus: false,  // 싫어요 상태
                        status: "",
                        likes: "",
                        dislikes: "",
                        list: [],
                        index: 0,
                        pageSize: 5,
                    };
                },
                computed: {
                    size(fileSize) {
                        let size = Math.ceil(parseInt(fileSize) / 1024);

                        return parseInt(size);

                    }
                },
                methods: {
                    fnView() {
                        var self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            option: "View",
                            category: self.category,
                        };
                        $.ajax({
                            url: "/board/view.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if (data.result != 'success') {
                                    alert("잘못된 주소입니다.");
                                    location.href = "/board/boardList.do";
                                }
                                self.info = data.info
                                self.cmtList = data.cmtList;
                                self.fileList = data.fileList;
                                self.nickName = data.info.nickName;
                                console.log("어디써",data);
                            }
                        });
                        self.fnlikestatus();
                    },
                    fnlikestatus() {
                        var self = this;

                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                        };
                        $.ajax({
                            url: "/board/likeStatus.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {

                                if (data.result == "success") {

                                    if (data.listStatus.status == "like") {
                                        self.likeStatus = true;
                                    } else {
                                        self.likeStatus = false;
                                    }

                                    if (data.listStatus.status == "dislike") {
                                        self.dislikeStatus = true;
                                    } else {
                                        self.dislikeStatus = false;
                                    }
                                } else {
                                    self.likeStatus = false;
                                    self.dislikeStatus = false;
                                }

                            }
                        });
                    },
                    fnBack: function (info) {
                        let self = this;
                        location.href = "/board/list.do?category=" + self.category;

                    },
                    fnEdit: function () {
                        var self = this;
                        location.href = "/board/edit.do?boardId=" + self.boardId + "&category=" + self.category;
                    },
                    fnRemove: function () {
                        var self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            category: self.category,
                        };

                        if (!confirm("정말 삭제하시겠습니까?")) {
                            alert("취소되었습니다.");
                            return;
                        }

                        $.ajax({
                            url: "/board/remove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                location.href = "/board/list.do?category=" + self.category;
                                alert("삭제되었습니다");
                            }
                        });
                    },
                    fnCommentEdit(item) {
                        let self = this;
                        self.editCommentId = item.commentId;
                        self.editContent = item.content;

                        var nparmap = {
                            commentId: item.commentId
                        };
                        $.ajax({
                            url: "/board/CommentEdit.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                
                                alert("수정되었습니다");
                            }
                        });
                    },
                    fnCommentUpdate(commentId) {
                        var self = this;
                        self.editCommentId = null;  
                        var nparmap = {
                            commentId: commentId,
                            boardId: self.boardId,
                            userId: self.userId,
                            content: self.editContent,

                        };
                        $.ajax({
                            url: "/board/comment/update.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if(!confirm("수정하시겠습니까?")){
                                    alert("취소되었습니다.");
                                    return;                                    
                                }
                                alert("수정되었습니다");
                                self.editCommentId = "";
                                self.fnView();
                            }
                        });
                    },
                    fnCommentRemove(commentId) {
                        let self = this;

                        var nparmap = {
                            commentId: commentId
                        };
                        if (!confirm("정말 삭제하시겠습니까?")) {
                            alert("취소되었습니다.");
                            return;
                        }
                        $.ajax({
                            url: "/board/CommentRemove.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {

                                alert("삭제되었습니다");
                                self.fnView();
                            }
                        });
                    },
                    fnCommentSave() {
                        let self = this;
                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            content: self.content,
                            message : "게시글에 댓글이 등록되었습니다."
                        };
                        $.ajax({
                            url: "/board/CommentAdd.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {

                                alert("등록되었습니다");
                                self.fnView();
                                self.content = "";
                            }
                        });
                    },
                    isImageFile(fileName) {
                        let self = this;

                        const ext = fileName.split('.').pop().toLowerCase();
                        return self.imageExtensions.includes(ext);
                    },
                    fnReplySave(parentCommentId) {
                        let self = this;
                        let nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            content: self.replyContent,
                            parentCommentId: parentCommentId,
                            message : "대댓글이 등록되었습니다."
                        };
                        $.ajax({
                            url: "/board/ReplyAdd.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function () {
                                alert("등록되었습니다");
                                self.replyContent = "";
                                self.replyFormId = "";
                                self.fnView(); // 다시 댓글 전체 불러오기
                            }
                        });
                    },
                    fnReply(commentId) {
                        let self = this;
                        if (self.replyFormId === commentId) {
                                self.replyFormId = "";
                                self.replyContent = ""; // 내용도 초기화
                        } else {
                            // 다른 입력창이 열려있었다면 닫기
                            if (self.replyFormId) {
                                self.replyContent = ""; // 이전 내용 초기화
                            }
                            self.replyFormId = commentId;
                        }                  
                    },
                    likeButton(status, PM) {
                        let self = this;
                        let finalstatus = 0;
                        if (PM == 'M') {
                            finalstatus = -1;
                        } else {
                            finalstatus = 1;
                        }
                        var nparmap = {
                            boardId: self.boardId,
                            userId: self.sessionId,
                            status: status,
                            likes: self.likes,
                            dislikes: self.dislikes,
                            finalstatus: finalstatus
                        };

                        if (self.sessionId == null || self.sessionId == "") {
                            alert("로그인후 이용해 주세요.");
                            return;
                        }

                        if (self.likeStatus) {
                            if (status == 'dislike') {
                                // alert("");
                                return;
                            }
                        }

                        if (self.dislikeStatus) {
                            if (status == 'like') {
                                // alert("");
                                return;
                            }
                        }

                        if (PM == 'M') {

                            $.ajax({
                                url: "/board/removelikeCnt.dox",
                                dataType: "json",
                                type: "POST",
                                data: nparmap,
                                success: function (data) {

                                    self.fnlikestatus();
                                }
                            });

                        } else {

                            $.ajax({
                                url: "/board/addlikeCnt.dox",
                                dataType: "json",
                                type: "POST",
                                data: nparmap,
                                success: function (data) {

                                    self.fnlikestatus();
                                }
                            });

                        }

                        $.ajax({
                            url: "/board/addlikeCntBoard.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {

                                self.fnView();

                            }
                        });

                    },
                    fnDownload(filePath, fileName, fileSize) {
                        const confirmMsg = fileName + " ( " + Math.ceil(fileSize/1024) +  "KB ) 파일을 다운로드하시겠습니까?";
                        if (confirm(confirmMsg)) {
                        // 다운로드를 강제로 트리거
                        const link = document.createElement('a');
                        link.href = filePath;
                        link.download = fileName;
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
                        }
                    },
                    fnBoardList() {
                        let self = this;
                        let nparmap = {
                            boardId: self.boardId,
                            category: self.category,
                        };
                        $.ajax({
                            url: "/board/list.dox",
                            dataType: "json",
                            type: "POST",
                            data: nparmap,
                            success: function (data) {
                                if(data.result != 'success'){
                                    alert("잘못된 주소입니다.");
                                    location.href="/board/list.do";
                                }
                                
                                // 현재 게시글의 인덱스 찾기
                                let currentIndex = data.board.findIndex(item => item.boardId === self.boardId);
                                
                                // 현재 게시글 기준 앞뒤 2개씩 총 5개 게시글 추출
                                let start = Math.max(0, currentIndex - 2);
                                let end = Math.min(start + 5, data.board.length);
                                
                                // start가 끝에서부터 5개 미만일 경우 앞에서부터 조정
                                if (end - start < 5) {
                                    start = Math.max(0, end - 5);
                                }
                                
                                self.list = data.board.slice(start, end);

                                // 나머지 코드는 그대로 유지
                                if (data.count && data.count.cnt !== undefined) {
                                    self.index = Math.ceil(data.count.cnt / self.pageSize);
                                } else {
                                    self.index = 0;
                                }
                            }
                        });
                    },
                    fnGetBoardList(boardId){
                        let self = this;
                        localStorage.setItem("page", self.page);
                        location.href="/board/view.do?boardId=" + boardId + "&category="+self.category;
                    },   
                },
                watch: {
					cmtList(newVal) {
					    const params = new URLSearchParams(window.location.search);
					    const commentId = params.get("commentId");

					    if (commentId) {
					        this.$nextTick(() => {
					            const element = document.getElementById('comment-' + commentId);
					            if (element) {
					                console.log('찾은 요소:', element);

					                // 원래 배경색 저장
					                const originalBackgroundColor = getComputedStyle(element).backgroundColor;

					                element.scrollIntoView({ behavior: 'smooth', block: 'center' });

					                // 하이라이트 효과
					                element.style.transition = 'background-color 0.5s';
					                element.style.backgroundColor = 'rgb(255, 147, 0)';

					                setTimeout(() => {
					                    element.style.backgroundColor = originalBackgroundColor;
					                }, 3000);
					            } else {
					                console.warn('댓글 요소를 찾지 못했습니다:', commentId);
					            }
					        });
					    }
					}
                },
                mounted() {
                    let self = this;
                    const params = new URLSearchParams(window.location.search);
                    self.boardId = params.get("boardId") || "";
                    self.category = params.get("category") || "F";

                    self.fnBoardList();
                    self.fnView();

                    
                }
            });

            app.mount("#fb-app");
        });
    </script>