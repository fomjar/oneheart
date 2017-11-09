package com.fomjar.oneheart.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.fomjar.oneheart.mapper.ConfigMapper;

@Service
@EnableScheduling
public class ConfigService extends BasicService {
    
    @Autowired
    private ConfigMapper mapper;
    
    @Scheduled(fixedDelay = 1000L * 60 * 3)
    void reload() {
        mapper.select(easyMap().put("page_size", Integer.MAX_VALUE).get())
        .forEach(c -> cache(Long.MAX_VALUE, (String) c.get("key"), c.get("val")));
    }

}
