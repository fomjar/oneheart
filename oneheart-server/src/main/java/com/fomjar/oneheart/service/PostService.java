package com.fomjar.oneheart.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.fomjar.oneheart.mapper.PostMapper;

public class PostService extends BasicService {
    
    @Autowired
    private PostMapper mapper;
    
    public List<Map<String, Object>> postToday(int user) {
        return mapper.selectToday(easyMap().put("user", user).get());
    }
    
    public int post(int user, int intention) {
        return mapper.insert(easyMap()
                .put("user",        user)
                .put("intention",   intention)
                .get());
    }
    
}
