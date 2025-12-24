package com.example.e_library.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.e_library.model.Subscription;
import com.example.e_library.model.User;

public interface SubscriptionRepository extends JpaRepository<Subscription, Long> {

  Optional<Subscription> findByUserAndStatus(User user, String status);

}

