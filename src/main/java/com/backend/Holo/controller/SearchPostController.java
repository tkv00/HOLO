package com.backend.Holo.controller;

import com.backend.Holo.entity.SearchPost;
import com.backend.Holo.service.SearchPostService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class SearchPostController {

    private final SearchPostService searchPostService;

    @GetMapping("/search")
    public List<SearchPost> searchPosts(@RequestParam String keyword) {
        return searchPostService.searchPosts(keyword);
    }
}
