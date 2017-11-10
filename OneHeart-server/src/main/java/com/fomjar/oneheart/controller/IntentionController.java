package com.fomjar.oneheart.controller;

import java.util.Map;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(path = "/intention", produces = "application/json; charset=utf-8")
public class IntentionController implements BasicController {
    
    @RequestMapping("/read")
    String read(@RequestBody Map<String, Object> cond) {
        argsOptimize(cond);
        if (!argsMatched(cond, "uid"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        return null;
    }
    
    @RequestMapping("/write")
    String write(@RequestBody Map<String, Object> cond) {
        argsOptimize(cond);
        if (!argsMatched(cond, "uid"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        return null;
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
