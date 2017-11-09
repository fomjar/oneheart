package com.fomjar.oneheart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.boot.autoconfigure.web.AbstractErrorController;
import org.springframework.boot.autoconfigure.web.DefaultErrorAttributes;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
@RequestMapping(produces = "application/json; charset=utf-8")
public class ErrorsController extends AbstractErrorController implements BasicController {
    
    private static final Log logger = LogFactory.getLog(ErrorsController.class);

    public ErrorsController() {super(new DefaultErrorAttributes());}

    @Override
    public String getErrorPath() {return "/error";}
    
    /********************** 状态码处理 **********************/
    @RequestMapping("/error")
    String error(HttpServletRequest request, HttpServletResponse response) {
        HttpStatus status = getStatus(request);
        response.setStatus(status.value());
        
        switch (status) {
        // 404
        case NOT_FOUND:     return jsonObject().code(Code.SYS_ILLEGAL_RESOURCE).toString();
        // others
        default:            return jsonObject().code(Code.SYS_UNKNOWN_ERROR).toString();
        }
    }
    /****************************************************/
    
    /********************** 异常处理 **********************/
    /** 期望但没有消息体 */
    @ExceptionHandler(HttpMessageNotReadableException.class)
    String handleHttpMessageNotReadableException(HttpMessageNotReadableException e)
    {logger.error(null, e); return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();}

    /** 消息类型错误 */
    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    String handleHttpMediaTypeNotSupportedException(HttpMediaTypeNotSupportedException e)
    {logger.error(null, e); return jsonObject().code(Code.SYS_ILLEGAL_MESSAGE).toString();}

    /** 数据库异常 */
    @ExceptionHandler(MyBatisSystemException.class)
    String handleMyBatisSystemException(MyBatisSystemException e)
    {logger.error(null, e); return jsonObject().code(Code.SYS_UNKNOWN_ERROR).toString();}
    
    /** 外键依赖不满足 */
    @ExceptionHandler(DataIntegrityViolationException.class)
    String handleDataIntegrityViolationException(DataIntegrityViolationException e)
    {logger.error(null, e); return jsonObject().code(Code.SYS_ILLEGAL_ARGUMENT).toString();}
    
    
    /** 其他异常 */
    @ExceptionHandler(Exception.class)
    String handleException(Exception e)
    {logger.error(null, e); return jsonObject().code(Code.SYS_UNKNOWN_ERROR).toString();}
    /****************************************************/

}
