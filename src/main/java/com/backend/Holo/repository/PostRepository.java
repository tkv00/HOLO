package com.backend.Holo.repository;

import com.backend.Holo.entity.PostEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostRepository extends JpaRepository<PostEntity, Long> {
    List<PostEntity> findByCategoryId(Long categoryId);
    List<PostEntity> findByCategory_CategoryAndCategory_CategoryType(String category, String categoryType);
}
