package com.fomjar.oneheart.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fomjar.oneheart.service.LikeService;

@RestController
@RequestMapping(path = "/like", produces = "application/json; charset=utf-8")
public class LikeController implements BasicController {
    
    @Autowired
    private LikeService service;
    
    @RequestMapping("/like")
    String like(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "user", "intention"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        service.like((int) data.get("user"), (int) data.get("intention"));
        return jsonObject().code(Code.SUCCESS).toString();
    }
    
    @RequestMapping("/dislike")
    String dislike(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "user", "intention"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        service.dislike((int) data.get("user"), (int) data.get("intention"));
        return jsonObject().code(Code.SUCCESS).toString();
    }
    
    @RequestMapping("/count")
    String count(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "intention"))
            return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        return jsonObject().code(Code.SUCCESS).put("count", service.count((int) data.get("intention"))).toString();
    }

}
