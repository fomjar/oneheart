package com.fomjar.oneheart.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.UpdateProvider;

@Mapper
public interface LikeMapper {
    
    class Provider implements BasicProvider {@Override public String table() {return "t_like";}}
    
    @SelectProvider(type = Provider.class, method = "select")
    List<Map<String, Object>> select(Map<String, Object> cond);
    
    @UpdateProvider(type = Provider.class, method = "update")
    int update(Map<String, Object> cond, Map<String, Object> data);
    
    @InsertProvider(type = Provider.class, method = "insert")
    int insert(Map<String, Object> data);
    
    @Delete({
        "delete from t_like",
        " where `user`      = #{user}",
        "   and `intention` = #{intention}"
    })
    int delete(Map<String, Object> cond);
    
    @Select({
        "select count(1)",
        "  from t_like",
        " where `invalid`   = 0",
        "   and `intention` = #{intention}"
    })
    int count(Map<String, Object> cond);

}
