//
//  Model.swift
//  OneHeart
//
//  Created by fomjar on 2017/11/9.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

enum Code: Int {
    case existing_mail      = 0x00001001
    case existing_name      = 0x00001002
    case existing_phone     = 0x00001003
    
    case signin_failed      = 0x00001101
    
    case success                = 0x00000000
    case sys_illegal_access     = 0xff000001
    case sys_illegal_resource   = 0xff000002
    case sys_illegal_argument   = 0xff000003
    case sys_illegal_message    = 0xff000004
    case sys_unknown_error      = 0xffffffff
}

enum UserState: Int {
    case signup = 0
    case verify = 1
    case cancel = 2
}

protocol Storable {
    func valid() -> Bool
    func save()
    mutating func save(_ data: [String:Any])
    mutating func load()
}

struct User: Storable {
    
    var id      : Int!          = -1
    var state   : UserState!    = .signup
    var mail    : String!       = ""
    var phone   : String?
    var name    : String?
    var pass    : String!       = ""
    var avatar  : String?
    
    init() {
        load()
    }
    
    func valid() -> Bool {
        return 0 < id
    }
    
    func save() {
        UserDefaults.standard.set(self.id,              forKey: "user.id")
        UserDefaults.standard.set(self.state.rawValue,  forKey: "user.state")
        UserDefaults.standard.set(self.mail,            forKey: "user.mail")
        UserDefaults.standard.set(self.phone,           forKey: "user.phone")
        UserDefaults.standard.set(self.name,            forKey: "user.name")
        UserDefaults.standard.set(self.pass,            forKey: "user.pass")
        UserDefaults.standard.set(self.avatar,          forKey: "user.avatar")
    }
    
    mutating func save(_ data: [String:Any]) {
        self.id     = data["id"]        as! Int
        self.state  = UserState(rawValue: data["state"] as! Int)
        self.mail   = data["mail"]      as! String
        self.phone  = data["phone"]     as? String
        self.name   = data["name"]      as? String
        self.pass   = data["pass"]      as! String
        self.avatar = data["avatar"]    as? String
        
        self.save()
    }
    
    mutating func load() {
        self.id     = UserDefaults.standard.integer(forKey: "user.id")
        self.state  = UserState(rawValue: UserDefaults.standard.integer(forKey: "user.state"))
        self.mail   = UserDefaults.standard.string(forKey: "user.mail")
        self.phone  = UserDefaults.standard.string(forKey: "user.phone")
        self.name   = UserDefaults.standard.string(forKey: "user.name")
        self.pass   = UserDefaults.standard.string(forKey: "user.pass")
        self.avatar = UserDefaults.standard.string(forKey: "user.avatar")
    }
}

class Model {
    static var user     = User()
}


