package com.fomjar.oneheart.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fomjar.oneheart.mapper.LikeMapper;

@Service
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
    
    public boolean islike(int user, int intention) {
        List<Map<String, Object>> list = mapper.select(easyMap()
                .put("user",        user)
                .put("intention",   intention)
                .get());
        return !list.isEmpty();
    }
    
    public int count(int intention) {
        return mapper.count(easyMap().put("intention", intention).get());
    }

}
