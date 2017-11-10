package com.fomjar.oneheart.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 控制器基类接口。包含一些工具方法。
 * 
 * @author fomjar
 */
public interface BasicController {
    
    /********************** 参数部分 **********************/
    
    /**
     * 参数优化。裁剪首尾空格。移除空字段。移除token。
     * 
     * @param data 待优化的参数集
     */
    default void argsOptimize(Map<String, Object> data) {
        Set<String> keys = new HashSet<>(data.keySet());
        keys.forEach(key -> {
            if ("token".equals(key)) {
                data.remove(key);
                return;
            }
            Object val = data.get(key);
            if (null == val) {
                data.remove(key);
                return;
            }
            if (val instanceof String) {
                String string = (String) val;
                string = string.trim();
                if (0 == string.length()) {
                    data.remove(key);
                    return;
                }
                data.put(key, string);
                return;
            }
        });
    }
    
    /**
     * 正好匹配的参数。不多不少。不计token、page_from、page_size。
     * 
     * @param data 参数集
     * @param keys 待判断的参数
     * @return
     */
    default boolean argsMatched(Map<String, Object> data, String... keys) {
        Map<String, Object> clone = new HashMap<>(data);
        clone.remove("token");
        clone.remove("page_from");
        clone.remove("page_size");
        if (clone.size() != new HashSet<>(Arrays.asList(keys)).size())  return false;   // 尺寸不同，过滤重复键
        for (String key : keys) if (!clone.containsKey(key))            return false;   // 不重合的键
        
        return true;
    }
    
    /**
     * 必须有的参数。多余没关系。
     * 
     * @param data 参数集
     * @param keys 待判断的参数
     * @return
     */
    default boolean argsRequire(Map<String, Object> data, String... keys) {
        for (String key : keys) if (!data.containsKey(key)) return false;   // 没有的键
        
        return true;
    }
    
    /**
     * 限定参数。移除超出范围的参数。不计token、page_from、page_size。
     * 
     * @param data 参数集
     * @param keys 限制范围
     * @return
     */
    default void argsLimited(Map<String, Object> data, String... keys) {
        Map<String, Object> clone = new HashMap<>(data);
        clone.remove("token");
        clone.remove("page_from");
        clone.remove("page_size");
        
        for(String key : clone.keySet()) {
            boolean inLimit = false;
            for (String lk : keys) {
                if (key.equals(lk)) {
                    inLimit = true;
                    break;
                }
            }
            if (!inLimit) data.remove(key);
        }
    }
    
    /****************************************************/
    
    /********************** JSON部分 **********************/
    
    /**
     * 创建一个方便链式调用的json对象。
     * 
     * @return
     */
    default JsonObject jsonObject() {return new JsonObject();}
    /**
     * 创建一个方便链式调用的json数组。
     * 
     * @return
     */
    default JsonArray  jsonArray()  {return new JsonArray();}
    
    /**
     * 方便链式调用的json对象。
     * 
     * @author fomjar
     */
    static class JsonObject {
        private Map<String, Object> data;
        public JsonObject() {data = new LinkedHashMap<>();}
        
        public JsonObject code(Code code) {
            put("code", code.code());
            put("desc", code.desc());
            return this;
        }
        
        public JsonObject put(String key, Object val) {
            data.put(key, val);
            return this;
        }
        
        public JsonObject put(Map<String, Object> data) {
            this.data.putAll(data);
            return this;
        }
        
        @Override
        public String toString() {
            try {return new ObjectMapper().writeValueAsString(data);}
            catch (JsonProcessingException e) {
                e.printStackTrace();
                return "{}";
            }
        }
    }
    
    /**
     * 方便链式调用的json数组。
     * 
     * @author fomjar
     */
    static class JsonArray {
        private List<Object> data;
        public JsonArray() {data = new LinkedList<>();}
        
        public JsonArray add(Object val) {
            data.add(val);
            return this;
        }
        
        @Override
        public String toString() {
            try {return new ObjectMapper().writeValueAsString(data);}
            catch (JsonProcessingException e) {
                e.printStackTrace();
                return "[]";
            }
        }
    }
    
    
    /****************************************************/
    
    /**
     * 错误码定义，含描述。
     * 
     * @author fomjar
     *
     */
    static enum Code {
        
        /********************** 认证部分 **********************/
        EXISTING_MAIL           (0x00001001, "邮箱已存在"),
        EXISTING_NAME           (0x00001002, "姓名已存在"),
        EXISTING_PHONE          (0x00001003, "手机号已存在"),
        SIGNIN_FAILED           (0x00001101, "账号或密码错误"),
        /********************** 系统错误 **********************/
        SUCCESS                 (0x00000000, "成功"),
        SYS_ILLEGAL_ACCESS      (0xff000001, "非法访问"),
        SYS_ILLEGAL_RESOURCE    (0xff000002, "非法资源"),
        SYS_ILLEGAL_ARGUMENT    (0xff000003, "非法参数"),
        SYS_ILLEGAL_MESSAGE     (0xff000004, "非法消息"),
        SYS_UNKNOWN_ERROR       (0xffffffff, "未知错误");
        /****************************************************/
        
        
        private int status;
        private String msg;
        
        Code(int status, String msg) {
            this.status = status;
            this.msg = msg;
        }
        
        public int      code()    {return status;}
        public String   desc()       {return msg;}
        
    }

}
