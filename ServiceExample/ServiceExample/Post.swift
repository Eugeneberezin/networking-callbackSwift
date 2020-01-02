//
//  Post.swift
//  ServiceExample
//
//  Created by Eugene Berezin on 12/28/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import Foundation

struct Post: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
}
