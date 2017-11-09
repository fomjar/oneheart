package com.fomjar.oneheart.service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Service层基类，提供了一些工具方法。
 * 
 * @author fomjar
 */
public class BasicService {
    
    /********************** 易用工具部分 **********************/
    
    /**
     * 包装一个对象，使其在某些要求final的场景下可以更改。
     * 
     * @param o
     * @return 一个包装过的对象
     */
    public static <T> Wrapper<T> wrap(T o) {
        Wrapper<T> w = new Wrapper<>();
        w.o = o;
        return w;
    }
    /**
     * 包装类型，包装一个对象，使其在某些要求final的场景下可以更改。
     * 
     * @author fomjar
     * @param <T> 对象类型
     */
    public static class Wrapper<T> {public T o;}
    
    
    
    /**
     * 创建一个可以链式调用的List对象。
     * 
     * @return 
     */
    public static     EasyList<Object> easyList()           {return easyList(Object.class);}
    public static <T> EasyList<T>      easyList(Class<T> c) {return new EasyList<T>();}
    
    /**
     * 创建一个可以链式调用的Map对象。
     * 
     * @return
     */
    public static        EasyMap<String, Object> easyMap()                         {return easyMap(String.class, Object.class);}
    public static <K, V> EasyMap<K, V>           easyMap(Class<K> ck, Class<V> cv) {return new EasyMap<K, V>();}
    
    /**
     * 方便类对象的基类。
     * 
     * @author fomjar
     *
     * @param <T> 内部操作的对象类型
     */
    public static interface EasyObject<T> {T get();}
    
    /**
     * 方便的链式调用的List对象。
     * 
     * @author fomjar
     *
     * @param <T> 保存对象的类型
     */
    public static class EasyList<T> implements EasyObject<List<T>> {
        private List<T> list = new LinkedList<>();
        
        @Override
        public List<T> get() {return list;}
        
        public EasyList<T> add(T e) {
            list.add(e);
            return this;
        }
    }
    
    /**
     * 方便调用的Map对象。
     * 
     * @author fomjar
     *
     * @param <K> Map的key类型
     * @param <V> Map的value类型
     */
    public static class EasyMap<K, V> implements EasyObject<Map<K, V>> {
        private Map<K, V> map = new LinkedHashMap<>();
        
        @Override
        public Map<K, V> get() {return map;}
        
        public EasyMap<K, V> put(K key, V val) {
            map.put(key, val);
            return this;
        }
    }
    
    /****************************************************/
    
    /********************** 缓存部分 **********************/
    
    private int max_cache_count = 100;
    private Map<String, Cache> caches = new HashMap<>();
    
    /**
     * 存储一个缓存。存储前会清理过期缓存。
     * 
     * @param key 缓存键
     * @param val 缓存值
     */
    public void cache(String key, Object... val) {
        cacheClearExpired();
        
        synchronized (caches) {caches.put(key, new Cache(val));}
    }
    
    /**
     * 存储一个缓存。存储前会清理过期缓存。
     * 
     * @param timeout 缓存超时时长，单位毫秒
     * @param key 缓存键
     * @param val 缓存值
     */
    public void cache(long timeout, String key, Object... val) {
        cacheClearExpired();
        
        synchronized (caches) {caches.put(key, new Cache(timeout, val));}
    }
    
    /**
     * 获取一个缓存。获取前会先清理已过期的缓存。
     * 
     * @param key 缓存键
     * @return 对应的缓存值
     */
    public Object[] cache(String key) {
        cacheClearExpired();
        
        synchronized (caches) {
            Cache cache = caches.get(key);
            if (null == cache) return null;
            
            cache.time = System.currentTimeMillis();
            return cache.data;
        }
    }
    
    /**
     * 清理已过期的缓存。
     */
    private void cacheClearExpired() {
        synchronized (caches) {
            if (caches.size() < max_cache_count) return;
            
            List<String> list = caches.entrySet().stream()
                    .filter(e -> e.getValue().expired())
                    .map(e -> e.getKey())
                    .collect(Collectors.toList());
            list.forEach(key -> caches.remove(key));
            
            if (caches.size() >= max_cache_count) max_cache_count *= 2;
        }
    }
    
    /**
     * 缓存通用类。
     * 
     * @author fomjar
     */
    public static class Cache {
        private long timeout;
        private long time = System.currentTimeMillis();
        private Object[] data;
        
        public Cache(Object... data) {
            this(1000L * 60 * 5, data);
        }
        
        public Cache(long timeout, Object... data) {
            this.timeout = timeout;
            this.data = data;
        }
        /**
         * 判断是否超期了
         * @return
         */
        public boolean expired() {return System.currentTimeMillis() - time >= timeout;}
    }
    
    /****************************************************/
    
    /********************** HTTP部分 **********************/
    
    /**
     * 创建一个方便的链式调用的HTTP请求封装体。
     * 
     * @return
     */
    public static Http http() {return new Http();}
    
    /**
     * 方便的链式调用的HTTP请求封装类。
     * 
     * @author fomjar
     */
    public static class Http {
        private HttpClient client = HttpClients.createDefault();
        private Map<String, Object> urlParam = new LinkedHashMap<>();
        private Map<String, Object> bodyJson = new LinkedHashMap<>();
        private Map<String, Object> bodyForm = new LinkedHashMap<>();
        
        /**
         * 增加URL中的参数。
         * 
         * @param key 参数键
         * @param val 参数值
         * @return
         */
        public Http urlParam(String key, Object val) {
            urlParam.put(key, val);
            return this;
        }
        /**
         * 增加消息体中的json参数。
         * 
         * @param key json键
         * @param val json值
         * @return
         */
        public Http bodyJson(String key, Object val) {
            bodyJson.put(key, val);
            return this;
        }
        /**
         * 增加消息体中的表单参数。
         * 
         * @param key 表单键
         * @param val 表单值
         * @return
         */
        public Http bodyForm(String key, Object val) {
            bodyForm.put(key, val);
            return this;
        }
        /**
         * 获取完整的请求URL。
         * 
         * @param host 主机地址，以http:开头
         * @return
         * @throws UnsupportedEncodingException
         */
        private String url(String host) throws UnsupportedEncodingException {
            StringBuilder sb = new StringBuilder(host);
            boolean first = true;
            for (Entry<String, Object> e : urlParam.entrySet()) {
                sb.append(String.format("%s%s=%s", first ? "?" : "&", e.getKey(), URLEncoder.encode(e.getValue().toString(), "utf-8")));
                first = false;
            }
            return sb.toString();
        }
        private String entity2string(HttpEntity entity) throws IOException {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            entity.writeTo(baos);
            return baos.toString("utf-8");
        }
        /**
         * 发起一个GET请求。
         * 
         * @param host 目标主机
         * @return 响应消息体字符串
         * @throws ClientProtocolException
         * @throws IOException
         */
        public String get(String host) throws ClientProtocolException, IOException {
            HttpGet request = new HttpGet(url(host));
            HttpResponse response = client.execute(request);
            return entity2string(response.getEntity());
        }
        /**
         * 发起一个POST请求。优先使用json消息体。
         * 
         * @param host 目标主机
         * @return 响应消息体字符串
         * @throws ClientProtocolException
         * @throws IOException
         */
        public String post(String host) throws ClientProtocolException, IOException {
            HttpPost request = new HttpPost(url(host));
            if (!bodyForm.isEmpty()) {
                request.setEntity(new UrlEncodedFormEntity(bodyForm.entrySet().stream()
                        .map(e -> new BasicNameValuePair(e.getKey(), e.getValue().toString()))
                        .collect(Collectors.toList())
                        , "utf-8"));
            }
            if (!bodyJson.isEmpty()) {
                request.setEntity(new StringEntity(new ObjectMapper().writeValueAsString(bodyJson)));
                request.setHeader("Content-Type", "application/json; charset=utf-8");
            }
            HttpResponse response = client.execute(request);
            return entity2string(response.getEntity());
        }
    }

    /****************************************************/
}
