package com.backend.Holo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class CategoryPostDto {
    private Long postId;
    private Long categoryId;
    private String title;

    // 여기 사진데이터 추가해야함 ************************

    // 프론트 데이터 가공을위한 CategoryDTO를 포함
    // categoryId, category, categoryType <--- 3가지 포함시켰음
    private CategoryDto category;
    private UserInfoDto user;

    // 나머지 필드들은 필요에 따라 추가

    public CategoryPostDto(Long postId, Long categoryId, String title, CategoryDto category, UserInfoDto user) {
        this.postId = postId;
        this.title = title;
        this.categoryId = categoryId;
        this.category = category;
        this.user = user;
    }
}
