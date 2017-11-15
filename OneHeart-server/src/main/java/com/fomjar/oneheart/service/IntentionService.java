package com.fomjar.oneheart.service;

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
    private UserService user;
    
    public synchronized List<Map<String, Object>> read(int uid) {
        List<Map<String, Object>> list = mapper.selectToday(easyMap().put("receiver", uid).get());
        
        if (list.isEmpty()) {
            list = mapper.select(easyMap().put("receiver", null).get());
            if (!list.isEmpty()) {
                Map<String, Object> map = list.get(0);
                mapper.update(easyMap().put("id", map.get("id")).get(), easyMap().put("receiver", uid).get());
            }
        }
        
        fillUser(list);
        
        return list;
    }
    
    public void write(Map<String, Object> data) {
        mapper.insert(data);
    }
    
    public List<Map<String, Object>> get(Map<String, Object> cond) {
        List<Map<String, Object>> list = mapper.select(cond);
        
        fillUser(list);
        
        return list;
    }
    
    private void fillUser(List<Map<String, Object>> list) {
        list.forEach(map -> {
            map.put("sender",   user.get((int) map.get("sender")));
            map.put("receiver", user.get((int) map.get("receiver")));
        });
    }
    
}
