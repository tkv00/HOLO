package com.backend.Holo.service;

import com.backend.Holo.entity.CategoryEntity;
import com.backend.Holo.repository.CategoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CategoryService {

    private final CategoryRepository categoryRepository;

    public List<CategoryEntity> getCategoriesByCategory(String category) {
        return categoryRepository.findByCategoryType(category);
    }


}
