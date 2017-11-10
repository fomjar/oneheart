package com.fomjar.oneheart.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fomjar.oneheart.mapper.IntentionMapper;

@Service
public class IntentionService extends BasicService {
    
    @Autowired
    private IntentionMapper mapper;

    public Map<String, Object> read(int uid) {
        return null;
    }
    
}
