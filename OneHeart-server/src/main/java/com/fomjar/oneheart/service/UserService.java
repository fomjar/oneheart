package com.fomjar.oneheart.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fomjar.oneheart.mapper.UserMapper;

@Service
public class UserService extends BasicService {
    
    @Autowired
    private UserMapper mapper;
    
    public boolean checkMail(Object mail) {
        List<Map<String, Object>> list = mapper.select(easyMap().put("mail", mail).get());
        return list.isEmpty();
    }
    
    public Map<String, Object> signup(Map<String, Object> data) {
        mapper.insert(data);
        Object mail = data.get("mail");
        List<Map<String, Object>> list = mapper.select(easyMap().put("mail", mail).get());
        return list.get(0);
    }
    
    public Map<String, Object> signin(Map<String, Object> data) {
        List<Map<String, Object>> list = mapper.select(easyMap()
                .put("mail", data.get("mail"))
                .put("pass", data.get("pass"))
                .get());
        return list.isEmpty() ? null : list.get(0);
    }
    
    public List<Map<String, Object>> get(Map<String, Object> cond) {
        return mapper.select(cond);
    }
    
    public Map<String, Object> get(int id) {
        List<Map<String, Object>> list = get(easyMap().put("id", id).get());
        return list.isEmpty() ? null : list.get(0);
    }
    
}
