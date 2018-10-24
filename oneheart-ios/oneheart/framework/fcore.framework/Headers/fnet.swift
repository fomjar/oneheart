//
//  fnet.swift
//  fios
//
//  Created by fomjar on 2017/11/9.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

public class fnet {

    public class code {
        public static let success                = 0x00000000
        public static let sys_illegal_access     = 0xff000001
        public static let sys_illegal_resource   = 0xff000002
        public static let sys_illegal_argument   = 0xff000003
        public static let sys_illegal_message    = 0xff000004
        public static let sys_network_fault      = 0xfffffffe
        public static let sys_unknown_error      = 0xffffffff
    }


    public typealias done = (Int, String, [String:Any]) -> Void

    private static var server = "http://127.0.0.1:80"
    
    public class func server(host   : String,
                             port   : Int   = 80,
                             ssl    : Bool  = false) {
        fnet.server = "http\(ssl ? "s" : "")://\(host):\(port)"
    }
    
    public class func get(path      : String,
                          headParam : [String:String] = [:],
                          done      : done? = nil) {
        fnet.send(method: "GET", url: fnet.server + path, headParam: headParam, done: done)
    }
    
    public class func post(path     : String,
                           headParam: [String:String] = [:],
                           bodyParam: [String:String] = [:],
                           done     : done? = nil) {
        fnet.send(method: "POST", url: fnet.server + path, headParam: headParam, bodyParam: bodyParam, done: done)
    }
    
    public class func post(path     : String,
                           headParam: [String:String] = [:],
                           jsonParam: [String:Any] = [:],
                           done     : done? = nil) {
        fnet.send(method: "POST", url: fnet.server + path, headParam: headParam, jsonParam: jsonParam, done: done)
    }

    private class func send(method      : String,
                            url         : String,
                            headParam   : [String:String]   = [:],
                            bodyParam   : [String:String]   = [:],
                            jsonParam   : [String:Any]      = [:],
                            done        : done? = nil) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method
        
        print("====")
        if !headParam.isEmpty {
            var param = ""
            for (key, val) in headParam {
                if param.isEmpty    {param += "?"}
                else                {param += "&"}
                param += key + "=" + val.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
            request.url = URL(string: url + param)!
        }
        print(">> " + (request.url?.absoluteString)!)
        
        if !bodyParam.isEmpty {
            var param = ""
            for (key, val) in bodyParam {
                if !param.isEmpty {param += "&"}
                param += key + "=" + val.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
            request.httpBody = param.data(using: .utf8)
            print(">> " + param)
        }
        if !jsonParam.isEmpty {
            request.httpBody = try? JSONSerialization.data(withJSONObject: jsonParam, options: .sortedKeys)
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print(">> " + String(data: request.httpBody!, encoding: .utf8)!)
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            if let data = data {
                print("<< " + String(data: data, encoding: .utf8)!)
                print("====")
                DispatchQueue.main.async {
                    if let json = try? JSONSerialization.jsonObject(with: data,
                                                                    options: .mutableContainers) as! Dictionary<String, Any> {
                        done?(json["code"] as! Int, json["desc"] as! String, json)
                    } else {
                        done?(code.sys_unknown_error, "unknown error", [:])
                    }
                }
            } else {
                print(error as Any)
                print("====")
                done?(code.sys_network_fault, "network fault", [:])
            }
        }.resume()
    }
    
}
