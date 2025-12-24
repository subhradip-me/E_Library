package com.example.e_library.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.e_library.model.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer> {}
