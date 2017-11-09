//
//  Model.swift
//  OneHeart
//
//  Created by fomjar on 2017/11/9.
//  Copyright © 2017年 fomjar. All rights reserved.
//

import Foundation

enum UserState: Int {
    case signup = 0
    case verify = 1
    case cancel = 2
}

struct User {
    var id      : Int!          = -1
    var state   : UserState!    = .signup
    var mail    : String!       = ""
    var phone   : String?
    var name    : String?
    var pass    : String!       = ""
    var avatar  : String?
}


