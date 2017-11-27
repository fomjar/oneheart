package com.fomjar.oneheart.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fomjar.oneheart.mapper.IntentionMapper;

@Service
public class IntentionService extends BasicService {
    
    @Autowired
    private PostService post;
    
    @Autowired
    private IntentionMapper mapper;
    
    public synchronized List<Map<String, Object>> read(int user) {
        List<Map<String, Object>> list = post.postToday(user);
        
        if (!list.isEmpty()) {
            Map<String, Object> map = list.get(0);
            list = mapper.select(easyMap().put("id", map.get("intention")).get());
        } else {
            list = mapper.selectWillPost(easyMap().put("user", user).get());
            if (!list.isEmpty()) {
                Map<String, Object> map = list.get(0);
                post.post(user, (int) map.get("id"));
            }
        }
        
        return list;
    }
    
    public int write(Map<String, Object> data) {
        return mapper.insert(data);
    }
    
}
