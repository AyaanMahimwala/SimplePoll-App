//
//  PollResult.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/17/21.
//

import Foundation

struct PollResult : Decodable {
    var id: String
    var pollTitle: String
    var link: String
    var votes: Int
    var optionVotes: [Option]
    
}
