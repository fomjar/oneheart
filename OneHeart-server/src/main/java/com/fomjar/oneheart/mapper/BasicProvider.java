package com.fomjar.oneheart.mapper;

import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.ibatis.jdbc.SQL;

/**
 * Mapper层Provider基类，提供了针对单表的4类操作SQL生成。
 * <ul>
 * <li>{@link #select} - 根据条件查询</li>
 * <li>{@link #update} - 根据条件更新</li>
 * <li>{@link #delete} - 根据条件删除</li>
 * <li>{@link #insert} - 根据条件添加</li>
 * </ul>
 * 
 * @author fomjar
 */
public interface BasicProvider {
    
    String table();

    /********************** mapper直接用的接口 **********************/
    
    default String select(Map<String, Object> cond) {
        Map<String, Object> clone = new LinkedHashMap<>(cond);
        clone.remove("page_from");
        clone.remove("page_size");
        return sqlSelect(clone).toString() + String.format(" LIMIT %d, %d",
                        cond.containsKey("page_from") ? cond.get("page_from") : 0,
                        cond.containsKey("page_size") ? cond.get("page_size") : 20);
    }
    
    default String update(Map<String, Object> cond, Map<String, Object> data) {
        return sqlUpdate(cond, data).toString();
    }
    
    default String delete(Map<String, Object> cond) {
        return sqlDelete(cond).toString();
    }
    
    default String insert(Map<String, Object> data) {
        return sqlInsert(data).toString();
    }
    
    /****************************************************/
    
    
    
    
    /********************** 子类继承和定制SQL的接口 **********************/
    
    default SQL sqlSelect(Map<String, Object> cond) {
        return new SQL(){{
            SELECT("*");
            FROM(table());
            WHERE("`invalid` = 0");
            cond.forEach((key, val) -> {
                AND();
                WHERE(String.format("`%s` = #{%s}", key, key));
            });
        }};
    }
    
    default SQL sqlUpdate(Map<String, Object> cond, Map<String, Object> data) {
        return new SQL(){{
            UPDATE(table());
            data.forEach((key, val) -> SET(String.format("`%s` = #{arg1.%s}", key, key)));
            SET("`update` = now()");
            WHERE("1 = 1");
            cond.forEach((key, val) -> {
                AND();
                WHERE(String.format("`%s` = #{arg0.%s}", key, key));
            });
        }};
    }
    
    default SQL sqlDelete(Map<String, Object> cond) {
        return new SQL(){{
            UPDATE(table());
            SET("`invalid` = 1");
            WHERE("1 = 1");
            cond.forEach((key, val) -> {
                AND();
                WHERE(String.format("`%s` = #{%s}", key, key));
            });
        }};
    }
    
    default SQL sqlInsert(Map<String, Object> data) {
        return new SQL(){{
            INSERT_INTO(table());
            data.forEach((key, val) -> VALUES(String.format("`%s`", key), String.format("#{%s}", key)));
            if (!data.containsKey("create"))  VALUES("`create`",  "now()");
            if (!data.containsKey("update"))  VALUES("`update`",  "now()");
            if (!data.containsKey("invalid")) VALUES("`invalid`", "0");
        }};
    }
    
    /****************************************************/

}
