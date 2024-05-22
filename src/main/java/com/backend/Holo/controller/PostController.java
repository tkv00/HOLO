package com.backend.Holo.controller;

import com.backend.Holo.entity.PostEntity;
import com.backend.Holo.service.PostService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/post")
public class PostController {

    private final PostService postService;
    private static final Logger logger = LoggerFactory.getLogger(PostController.class);

    @GetMapping("/list")
    public ResponseEntity<List<PostEntity>> postList() {
        List<PostEntity> posts = postService.postList();
        return ResponseEntity.ok(posts);
    }

    @PostMapping("/write")
    public ResponseEntity<PostEntity> writePost(@Validated @RequestBody PostEntity postEntity, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            // 바인딩 오류가 있는 경우 로그 출력
            logger.error("게시글 작성 중 오류가 발생했습니다. 오류: {}", bindingResult.getAllErrors());
            return ResponseEntity.badRequest().body(null);
        }
        PostEntity savedPost = postService.write(postEntity);
        return ResponseEntity.ok(savedPost);
    }

    // 게시물 상세페이지 표시 Api
    @GetMapping("/{postId}")
    public ResponseEntity<?> getPostById(@PathVariable Long postId) {
        try {
            postService.incrementViewCount(postId);
            PostEntity post = postService.getPostById(postId);
            if (post != null) {
                return ResponseEntity.ok(post);
            } else {
                // 콘솔에 로그 출력
                logger.info("해당 게시물이 없거나 삭제되었습니다. postId: {}", postId);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("{\"message\": \"해당 게시물이 없거나 삭제되었습니다.\"}");
            }
        } catch (Exception e) {
            // 예외가 발생한 경우 상세 오류 로그 출력
            logger.error("게시글 조회 중 오류가 발생했습니다. postId: {}, 오류: {}", postId, e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"message\": \"서버에서 오류가 발생했습니다. 관리자에게 문의하세요.\"}");
        }
    }

    // 카테고리별 게시물 표시 Api
    @PostMapping("/category") // /api/post/category?categoryId=4   로 사용
    public ResponseEntity<?> getPostsByCategory(@RequestParam Long categoryId) {
        List<PostEntity> posts = postService.getPostsByCategoryId(categoryId);
        if (posts.isEmpty()) {
            logger.info("카테고리에 해당하는 게시물이 없습니다. categoryId: {}", categoryId);
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body("{\"message\": \"카테고리에 해당하는 게시물이 없습니다.\"}");
        }
        return ResponseEntity.ok(posts);
    }

    // 게시물 삭제관련 Api
    @PostMapping("/delete") // /api/post/delete?postId=4   로 사용
    public ResponseEntity<?> deletePost(@RequestParam Long postId) {
        try {
            boolean isDeleted = postService.deletePost(postId);
            if (isDeleted) {
                return ResponseEntity.ok("{\"message\": \"게시물이 성공적으로 삭제되었습니다.\"}");
            } else {
                logger.info("해당 게시물이 없거나 이미 삭제되었습니다. postId: {}", postId);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body("{\"message\": \"해당 게시물이 없거나 이미 삭제되었습니다.\"}");
            }
        } catch (Exception e) {
            logger.error("게시글 삭제 중 오류가 발생했습니다. postId: {}, 오류: {}", postId, e.getMessage(), e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"message\": \"서버에서 오류가 발생했습니다. 관리자에게 문의하세요.\"}");
        }
    }

    // firebase - chattingroom 관련
    // firebase에 채팅룸이 생성되면 해당 게시물의 chatCount 값을 1늘리는 로직
    @PostMapping("/incrementChatCount")
    public ResponseEntity<?> incrementChatCount(@RequestParam Long postId) {
        try {
            postService.incrementChatCount(postId);
            return ResponseEntity.ok("{\"message\": \"Chat count incremented successfully.\"}");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"message\": \"An error occurred while incrementing chat count.\"}");
        }
    }

    // firebase에 채팅룸이 생성되면 해당 게시물의 chatCount 값을 1줄이는 로직
    @PostMapping("/decrementChatCount")
    public ResponseEntity<?> decrementChatCount(@RequestParam Long postId) {
        try {
            postService.decrementChatCount(postId);
            return ResponseEntity.ok("{\"message\": \"Chat count decremented successfully.\"}");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("{\"message\": \"An error occurred while decrementing chat count.\"}");
        }
    }

}
