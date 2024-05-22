package com.backend.Holo.service;

import com.backend.Holo.entity.SearchPost;
import com.backend.Holo.repository.SearchPostRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SearchPostService {

    private final SearchPostRepository searchPostRepository;

    public List<SearchPost> searchPosts(String keyword) {
        return searchPostRepository.findByTitleContaining(keyword);
    }
}