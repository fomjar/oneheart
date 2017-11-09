package com.fomjar.oneheart.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.UpdateProvider;

@Mapper
public interface UserMapper {
    
    class Provider implements BasicProvider {@Override public String table() {return "t_user";}}
    
    @SelectProvider(type = Provider.class, method = "select")
    List<Map<String, Object>> select(Map<String, Object> cond);
    
    @UpdateProvider(type = Provider.class, method = "update")
    int update(Map<String, Object> cond, Map<String, Object> data);
    
    @InsertProvider(type = Provider.class, method = "insert")
    int insert(Map<String, Object> data);
    
    @DeleteProvider(type = Provider.class, method = "delete")
    int delete(Map<String, Object> cond);

}
