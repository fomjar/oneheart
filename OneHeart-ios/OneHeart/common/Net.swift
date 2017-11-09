//
//  HTTP.swift
//  OneHeart
//
//  Created by fomjar on 2017/11/9.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

class Net {
    
    private static let server = "http://192.168.10.79:8081"
    
    private let path        : String!
    private var request     : URLRequest!
    private var formHead    : Dictionary<String, String>!
    private var formBody    : Dictionary<String, String>!
    private var jsonBody    : Dictionary<String, Any>!
    
    init(_ path: String) {
        self.path     = Net.server + path
        self.request  = URLRequest(url: URL(string: self.path)!)
        self.formHead = Dictionary<String, String>()
        self.formBody = Dictionary<String, String>()
        self.jsonBody = Dictionary<String, Any>()
    }
    
    func formHead(key: String, val: String) -> Net {
        self.formHead[key] = val
        return self;
    }
    
    func formBody(key: String, val: String) -> Net {
        self.formBody[key] = val
        return self;
    }
    
    func jsonBody(key: String, val: Any) -> Net {
        self.jsonBody[key] = val
        return self;
    }

    func get(_ done: @escaping ((Int, String, Dictionary<String, Any>)) -> Void) {
        self.request.httpMethod = "GET"
        self.send(done)
    }

    func post(_ done: @escaping ((Int, String, Dictionary<String, Any>)) -> Void) {
        self.request.httpMethod = "POST"
        self.send(done)
    }

    private func send(_ done: @escaping (Int, String, Dictionary<String, Any>) -> Void) {
        if !self.formHead.isEmpty {
            var path = ""
            for (key, val) in self.formHead {
                if path.isEmpty {path += "?"}
                else            {path += "&"}
                path += key + "=" + val.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
            self.request.url = URL(string: self.path + path)!
        }
        print("[REQUEST ] " + (self.request.url?.absoluteString)!)
        if !self.formBody.isEmpty {
            var data = ""
            for (key, val) in self.formBody {
                if !data.isEmpty {data += "&"}
                data += key + "=" + val.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            }
            self.request.httpBody = data.data(using: .utf8)
            print("[REQUEST ] " + data)
        }
        if !self.jsonBody.isEmpty {
            self.request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody, options: .sortedKeys)
            self.request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            print("[REQUEST ] " + String(data: self.request.httpBody!, encoding: .utf8)!)
        }
        URLSession.shared.dataTask(with: self.request) {(data, response, error) in
            print("[RESPONSE] " + String(data: data ?? Data(), encoding: .utf8)!)
            let json = try? JSONSerialization.jsonObject(with: data ?? Data(), options: .mutableContainers) as! Dictionary<String, Any>
            done(json!["code"] as! Int, json!["desc"] as! String, json!)
        }.resume()
    }
    
}
