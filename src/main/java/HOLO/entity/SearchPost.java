package HOLO.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
@Table(name = "post")
public class SearchPost {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "postId")
    private Long postId;

    private String title;

    @NotNull
    private Long categoryId;
}
