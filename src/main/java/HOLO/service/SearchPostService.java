package HOLO.service;

import HOLO.entity.SearchPost;
import HOLO.repository.SearchPostRepository;
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

    public List<SearchPost> searchPostsByCategory(String keyword, int categoryId) {
        return searchPostRepository.findByTitleContainingAndCategoryId(keyword, categoryId);
    }
}