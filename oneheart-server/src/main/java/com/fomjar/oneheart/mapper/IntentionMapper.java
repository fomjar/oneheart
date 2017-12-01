package com.fomjar.oneheart.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.DeleteProvider;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.annotations.UpdateProvider;

@Mapper
public interface IntentionMapper {
    
    class Provider implements BasicProvider {@Override public String table() {return "t_intention";}}
    
    @SelectProvider(type = Provider.class, method = "select")
    List<Map<String, Object>> select(Map<String, Object> cond);
    
    @UpdateProvider(type = Provider.class, method = "update")
    int update(Map<String, Object> cond, Map<String, Object> data);
    
    @InsertProvider(type = Provider.class, method = "insert")
    int insert(Map<String, Object> data);
    
    @DeleteProvider(type = Provider.class, method = "delete")
    int delete(Map<String, Object> cond);
    
    @Select({
        "select *",
        "  from t_intention",
        " where `invalid`   = 0",
        "   and `user`      != #{user}",    // 不是自己发的
        "   and `id`        not in (",      // 没收到过的
        "       select `id`",
        "         from t_post",
        "        where `invalid`    = 0",
        "          and `user`       = #{user}",
        "   )",
        " order by rand()",                 // 随机
        " limit 1"                          // 1条
    })
    List<Map<String, Object>> selectWillPost(Map<String, Object> cond);
    
    @Select({
        "select i.*",
        "  from t_intention i, t_like l",
        " where i.`invalid` = 0",
        "   and l.`invalid` = 0",
        "   and i.`id`      = l.`intention`",
        "   and l.`user`    = #{user}",
        " order by i.`update` desc",
        " limit ifnull(#{page_from}, 0), ifnull(#{page_size}, " + BasicProvider.PAGE_SIZE + ")"
    })
    List<Map<String, Object>> selectLike(Map<String, Object> cond);
    
    @Select({
        "select i.*",
        "  from t_intention i, t_post p",
        " where i.`invalid` = 0",
        "   and p.`invalid` = 0",
        "   and i.`id`      = p.`intention`",
        "   and p.`user`    = #{user}",
        " order by i.`update` desc",
        " limit ifnull(#{page_from}, 0), ifnull(#{page_size}, " + BasicProvider.PAGE_SIZE + ")"
    })
    List<Map<String, Object>> selectPost(Map<String, Object> cond);

}
