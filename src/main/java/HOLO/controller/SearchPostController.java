package HOLO.controller;

import HOLO.entity.SearchPost;
import HOLO.service.SearchPostService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequiredArgsConstructor
public class SearchPostController {

    private final SearchPostService searchPostService;
    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/search")
    public ResponseEntity<String> searchPosts(@RequestParam String keyword, @RequestParam(defaultValue = "1") int type) {
        List<SearchPost> searchResults = searchPostService.searchPostsByCategory(keyword, type);
        if (searchResults.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당 키워드와 카테고리로 검색된 결과가 없습니다.");
        }

        StringBuilder responseBuilder = new StringBuilder();
        for (SearchPost post : searchResults) {
            String url = "http://~:8080/api/post/" + post.getPostId(); // 다른 서버의 IP Address 통신
            try {
                ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
                responseBuilder.append(response.getBody()).append("\n");
            } catch (Exception e) {
                responseBuilder.append("Failed to retrieve post with ID: ").append(post.getPostId()).append("\n");
            }
        }

        return new ResponseEntity<>(responseBuilder.toString(), HttpStatus.OK);
    }
}


// return /postlist 오류가 안나는 테스트용 SearchPostController

//@RestController
//@RequiredArgsConstructor
//public class SearchPostController {
//
//    private final SearchPostService searchPostService;
//
//    @PostMapping("/search")
//    public ResponseEntity<String> searchPosts(@RequestParam String keyword) {
//        List<SearchPost> searchResults = searchPostService.searchPosts(keyword);
//        if (searchResults.isEmpty()) {
//            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("해당 키워드로 검색된 결과가 없습니다.");
//        }
//
//        StringBuilder urlBuilder = new StringBuilder("http://localhost:8080/api/post/?");
//        for (SearchPost post : searchResults) {
//            urlBuilder.append("postId=").append(post.getPostId()).append("&");
//            urlBuilder.append("title=").append(post.getTitle()).append("&");
//        }
//        urlBuilder.setLength(urlBuilder.length() - 1);
//
//        String url = urlBuilder.toString();
//        return ResponseEntity.status(HttpStatus.OK).body("Generated URL: " + url);
//    }
//}