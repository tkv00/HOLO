package com.backend.Holo.service;

import com.backend.Holo.entity.PostEntity;
import com.backend.Holo.repository.PostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PostService {

    private final PostRepository postRepository;

    public PostEntity write(PostEntity postEntity) {
        return postRepository.save(postEntity);
    }

    public List<PostEntity> postList() {
        return postRepository.findAll();
    }

    public PostEntity getPostById(Long postId) {
        Optional<PostEntity> post = postRepository.findById(postId);
        return post.orElse(null);
    }

    //
    public void incrementViewCount(Long postId) {
        PostEntity post = postRepository.findById(postId).orElse(null);
        if (post != null) {
            post.setViewCount(post.getViewCount() + 1);
            postRepository.save(post);
        }
    }

    // 카테고리별 게시물 목록 반환 (categoryId 인데스컬럼으로 접근)
    public List<PostEntity> getPostsByCategoryId(Long categoryId) {
        return postRepository.findByCategoryId(categoryId);
    }

    // 카테고리별 게시물 목록 반환 (category 및 categoryType 컬럼으로 접근)
    public List<PostEntity> getPostsByCategoryAndCategoryType(String category, String categoryType) {
        return postRepository.findByCategory_CategoryAndCategory_CategoryType(category, categoryType);
    }

    // 게시글 삭제
    public boolean deletePost(Long postId) {
        Optional<PostEntity> post = postRepository.findById(postId);
        if (post.isPresent()) {
            postRepository.delete(post.get());
            return true;
        } else {
            return false;
        }
    }

    // 파이어베이스에서 채팅룸이 생성되면 chatCount가 1 증가
    public void incrementChatCount(Long postId) {
        PostEntity post = postRepository.findById(postId).orElseThrow(() -> new IllegalArgumentException("Invalid post ID"));
        post.setChatCount(post.getChatCount() + 1);
        postRepository.save(post);
    }

    // 파이어베이스에서 채팅룸이 생성되면 chatCount가 1 감소
    public void decrementChatCount(Long postId) {
        PostEntity post = postRepository.findById(postId).orElseThrow(() -> new IllegalArgumentException("Invalid post ID"));
        post.setChatCount(post.getChatCount() - 1);
        postRepository.save(post);
    }
}
