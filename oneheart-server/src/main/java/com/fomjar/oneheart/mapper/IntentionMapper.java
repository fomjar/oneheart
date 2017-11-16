package com.fomjar.oneheart.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.UpdateProvider;
import org.apache.ibatis.jdbc.SQL;

@Mapper
public interface IntentionMapper {
    
    class Provider implements BasicProvider {
        
        @Override
        public String table() {return "t_intention";}
        
        public String selectDidReceive(int receiver) {
            SQL sql = sqlSelect(new HashMap<>());
            sql.AND();
            sql.WHERE("`receiver` = #{receiver}");
            sql.AND();
            sql.WHERE("to_days(`update`) = to_days(now())");
            sql.ORDER_BY("`update` desc");
            
            return sql.toString();
        }
        
        public String selectWillReceive(int receiver) {
            SQL sql = sqlSelect(new HashMap<>());
            sql.AND();
            sql.WHERE("`receiver` is null");
            sql.AND();
            sql.WHERE("`sender` != #{receiver}");
            sql.ORDER_BY("`update` desc");
            
            return sql.toString() + " LIMIT 0, 1";
        }
    }
    
    @SelectProvider(type = Provider.class, method = "select")
    List<Map<String, Object>> select(Map<String, Object> cond);
    
    @SelectProvider(type = Provider.class, method = "selectDidReceive")
    List<Map<String, Object>> selectDidReceive(int receiver);
    
    @SelectProvider(type = Provider.class, method = "selectWillReceive")
    List<Map<String, Object>> selectWillReceive(int receiver);
    
    @UpdateProvider(type = Provider.class, method = "update")
    int update(Map<String, Object> cond, Map<String, Object> data);
    
    @InsertProvider(type = Provider.class, method = "insert")
    int insert(Map<String, Object> data);
    
    @DeleteProvider(type = Provider.class, method = "delete")
    int delete(Map<String, Object> cond);

}
