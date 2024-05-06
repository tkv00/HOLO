package com.backend.Holo.Entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter @Setter
public class DeviceInfo {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String deviceId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserEntity user;
}
