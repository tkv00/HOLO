package HOLO.repository;

import HOLO.entity.SearchPost;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SearchPostRepository extends JpaRepository<SearchPost, Long> {

    @Query("SELECT p FROM SearchPost p WHERE p.title LIKE %:keyword%")
    List<SearchPost> findByTitleContaining(@Param("keyword") String keyword);

    @Query("SELECT p FROM SearchPost p WHERE p.title LIKE %:keyword% AND p.categoryId = :categoryId")
    List<SearchPost> findByTitleContainingAndCategoryId(@Param("keyword") String keyword, @Param("categoryId") int categoryId);
}
