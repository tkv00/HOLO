package com.backend.Holo.controller;

import com.backend.Holo.entity.CategoryEntity;
import com.backend.Holo.service.CategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api")
public class CategoryController {

    private final CategoryService categoryService;

    @PostMapping("/category")
    public ResponseEntity<List<CategoryEntity>> getCategoriesByCategory(@RequestParam String category) {
        List<CategoryEntity> categories = categoryService.getCategoriesByCategory(category);
        return ResponseEntity.ok(categories);
    }

//    @PostMapping("/category/type")
//    public ResponseEntity<List<CategoryEntity>> getCategoriesByCategoryAndType(@RequestParam String category, @RequestParam String type) {
//        List<CategoryEntity> categories = categoryService.getCategoriesByCategoryAndCategoryType(category, type);
//        return ResponseEntity.ok(categories);
//    }

}
