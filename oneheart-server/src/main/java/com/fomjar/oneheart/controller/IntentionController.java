package com.fomjar.oneheart.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fomjar.oneheart.service.IntentionService;

@RestController
@RequestMapping(path = "/intention", produces = "application/json; charset=utf-8")
public class IntentionController implements BasicController {
    
    @Autowired
    private IntentionService service;
    
    @RequestMapping("/read")
    String read(@RequestBody Map<String, Object> cond) {
        argsOptimize(cond);
        if (!argsMatched(cond, "user"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        return jsonObject().code(Code.SUCCESS).put("intentions", service.read((int) cond.get("user"))).toString();
    }
    
    @RequestMapping("/write")
    String write(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "user", "intention"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        service.write(data);
        return jsonObject().code(Code.SUCCESS).toString();
    }
    
    @RequestMapping("/read/my")
    String read_my(@RequestBody Map<String, Object> cond) {
        argsOptimize(cond);
        if (!argsMatched(cond, "user"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        return jsonObject().code(Code.SUCCESS).put("intentions", service.read_my((int) cond.get("user"))).toString();
    }
    
}
