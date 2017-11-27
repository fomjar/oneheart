package com.fomjar.oneheart.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.fomjar.oneheart.mapper.LikeMapper;

public class LikeService extends BasicService {
    
    @Autowired
    private LikeMapper mapper;
    
    public int like(int user, int intention) {
        return mapper.insert(easyMap()
                .put("user",        user)
                .put("intention",   intention)
                .get());
    }
    
    public int dislike(int user, int intention) {
        return mapper.delete(easyMap()
                .put("user",        user)
                .put("intention",   intention)
                .get());
    }
    
    public int count(int intention) {
        return mapper.count(easyMap().put("intention", intention).get());
    }

}
