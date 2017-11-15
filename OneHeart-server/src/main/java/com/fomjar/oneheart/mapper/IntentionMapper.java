package com.fomjar.oneheart.mapper;

import java.util.LinkedHashMap;
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
        
        public String selectToday(Map<String, Object> cond) {
            Map<String, Object> clone = new LinkedHashMap<>(cond);
            clone.remove("page_from");
            clone.remove("page_size");
            
            SQL sql = sqlSelect(clone);
            if (!clone.isEmpty()) sql.AND();
            sql.WHERE("to_days(`update`) = to_days(now())");
            
            return sql.toString() + String.format(" LIMIT %d, %d",
                            cond.containsKey("page_from") ? cond.get("page_from") : 0,
                            cond.containsKey("page_size") ? cond.get("page_size") : 20);
        }
    }
    
    @SelectProvider(type = Provider.class, method = "select")
    List<Map<String, Object>> select(Map<String, Object> cond);
    
    @SelectProvider(type = Provider.class, method = "selectToday")
    List<Map<String, Object>> selectToday(Map<String, Object> cond);
    
    @UpdateProvider(type = Provider.class, method = "update")
    int update(Map<String, Object> cond, Map<String, Object> data);
    
    @InsertProvider(type = Provider.class, method = "insert")
    int insert(Map<String, Object> data);
    
    @DeleteProvider(type = Provider.class, method = "delete")
    int delete(Map<String, Object> cond);

}
