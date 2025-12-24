package com.example.e_library.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.e_library.model.User;
import com.example.e_library.repository.UserRepository;

@Service
public class UserService {
    
    @Autowired
    private UserRepository userRepository;
    
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }
    
    public Optional<User> getUserById(int id) {
        return userRepository.findById(id);
    }
    
    public User saveUser(User user) {
        if (user.getCreatedAt() == null) {
            user.setCreatedAt(LocalDateTime.now());
        }
        return userRepository.save(user);
    }
    
    public void deleteUser(int id) {
        userRepository.deleteById(id);
    }
    
    public long getTotalUserCount() {
        return userRepository.count();
    }
    
    public long getUsersCountByRole(String role) {
        return userRepository.findAll().stream()
                .filter(u -> role.equalsIgnoreCase(u.getRole()))
                .count();
    }
    
    public long getActiveUsersCount() {
        return userRepository.findAll().stream()
                .filter(User::isEnabled)
                .count();
    }
    
    public long getInactiveUsersCount() {
        return userRepository.findAll().stream()
                .filter(u -> !u.isEnabled())
                .count();
    }
    
    public User toggleUserStatus(int id) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setEnabled(!user.isEnabled());
            return userRepository.save(user);
        }
        return null;
    }
    
    public User updateUserRole(int id, String role) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setRole(role);
            return userRepository.save(user);
        }
        return null;
    }
    
    public List<User> searchUsers(String query) {
        if (query == null || query.isEmpty()) {
            return userRepository.findAll();
        }
        
        String lowerQuery = query.toLowerCase();
        return userRepository.findAll().stream()
                .filter(u -> 
                    u.getFullname().toLowerCase().contains(lowerQuery) ||
                    u.getEmail().toLowerCase().contains(lowerQuery) ||
                    u.getRole().toLowerCase().contains(lowerQuery)
                )
                .toList();
    }
    
    public List<User> filterUsersByRole(String role) {
        if (role == null || role.isEmpty() || "all".equalsIgnoreCase(role)) {
            return userRepository.findAll();
        }
        
        return userRepository.findAll().stream()
                .filter(u -> role.equalsIgnoreCase(u.getRole()))
                .toList();
    }
    
    public List<User> filterUsersByStatus(String status) {
        if (status == null || status.isEmpty() || "all".equalsIgnoreCase(status)) {
            return userRepository.findAll();
        }
        
        boolean enabled = "active".equalsIgnoreCase(status);
        return userRepository.findAll().stream()
                .filter(u -> u.isEnabled() == enabled)
                .toList();
    }
}
