package com.backend.Holo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class CategoryDto {
    private Long categoryId;
    private String category;
    private String categoryType;
    // 필요한 필드들만 포함

    public CategoryDto(Long categoryId, String category, String categoryType) {
        this.categoryId = categoryId;
        this.category = category;
        this.categoryType = categoryType;

    }
}
