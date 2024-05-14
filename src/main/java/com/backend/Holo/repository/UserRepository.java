package com.backend.Holo.repository;

import com.backend.Holo.entity.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    UserEntity findByPhoneNumber(String PhoneNumber);
}
