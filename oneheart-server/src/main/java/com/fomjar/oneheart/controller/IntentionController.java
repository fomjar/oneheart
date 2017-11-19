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
        if (!argsMatched(cond, "uid"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        cond.put("receiver", cond.remove("uid"));
        return jsonObject().code(Code.SUCCESS).put("intentions", service.read(cond)).toString();
    }
    
    @RequestMapping("/write")
    String write(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "uid", "intention"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        data.put("sender", data.remove("uid"));
        service.write(data);
        return jsonObject().code(Code.SUCCESS).toString();
    }
    
    @RequestMapping("/get")
    String get(@RequestBody Map<String, Object> cond) {
        argsOptimize(cond);
        argsLimited(cond, "sender", "receiver");
        if (cond.isEmpty())
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        return null;
    }
    
    

}
