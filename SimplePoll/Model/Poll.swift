//
//  Poll.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/17/21.
//

import Foundation

struct Poll : Codable {
    var pollTitle: String
    var options: [String]
}
