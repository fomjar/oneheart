package com.fomjar.oneheart.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fomjar.oneheart.mapper.IntentionMapper;

@Service
public class IntentionService extends BasicService {
    
    @Autowired
    private IntentionMapper mapper;
    
    @Autowired
    private PostService post;
    
    @Autowired
    private LikeService like;
    
    public synchronized List<Map<String, Object>> read(int user) {
        List<Map<String, Object>> list = post.postToday(user);
        
        if (!list.isEmpty()) {
            List<Map<String, Object>> list1 = new LinkedList<Map<String,Object>>();
            list.forEach(map -> list1.addAll(mapper.select(easyMap().put("id", map.get("intention")).get())));
            list = list1;
        } else {
            list = mapper.selectWillPost(easyMap().put("user", user).get());
            if (!list.isEmpty()) {
                Map<String, Object> map = list.get(0);
                post.post(user, (int) map.get("id"));
            }
        }
        
        fill(list, user);
        
        return list;
    }
    
    public List<Map<String, Object>> read_my(int user) {
        List<Map<String, Object>> list = mapper.select(easyMap().put("user", user).get());
        
        fill(list, user);
        
        return list;
    }
    
    public int write(Map<String, Object> data) {
        return mapper.insert(data);
    }
    
    private void fill(List<Map<String, Object>> intentions, int user) {
        intentions.forEach(intention -> {
            intention.put("like_count", like.count((int) intention.get("id")));
            intention.put("islike",     like.islike(user, (int) intention.get("id")));
        });
    }
    
}
