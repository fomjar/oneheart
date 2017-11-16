package com.fomjar.oneheart.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fomjar.oneheart.service.ConfigService;

@RestController
@RequestMapping(path = "/config", produces = "application/json; charset=utf-8")
public class ConfigController implements BasicController {
    
    @Autowired
    private ConfigService service;
    
    @RequestMapping("/get")
    String get(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "keys"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        List<?> keys = (List<?>) data.get("keys");
        return jsonObject().code(Code.SUCCESS).put("vals",
                keys.stream()
                .map(key -> service.cache(key.toString())[0])
                .collect(Collectors.toList()))
                .toString();
    }

}
