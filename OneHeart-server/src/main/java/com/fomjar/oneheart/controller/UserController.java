package com.fomjar.oneheart.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fomjar.oneheart.service.UserService;

@RestController
@RequestMapping(path = "/user", produces = "application/json; charset=utf-8")
public class UserController implements BasicController {
    
    @Autowired
    private UserService service;
    
    @RequestMapping("/signup")
    String signup(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "mail", "pass"))     return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        if (service.checkMail(data.get("mail")))    return jsonObject().code(Code.EXISTING_MAIL).toString();
        
        return jsonObject().code(Code.SUCCESS).put(service.signup(data)).toString();
    }
    
    @RequestMapping("/signin")
    String signin(@RequestBody Map<String, Object> data) {
        argsOptimize(data);
        if (!argsMatched(data, "mail", "pass")) return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();
        
        Map<String, Object> user = service.signin(data);
        if (null == user)   return jsonObject().code(Code.SIGNIN_FAILED).toString();
        else                return jsonObject().code(Code.SUCCESS).put(user).toString();
    }

}
