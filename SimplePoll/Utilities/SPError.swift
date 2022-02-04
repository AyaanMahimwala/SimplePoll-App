//
//  SPError.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/17/21.
//

import Foundation

enum SPError: String, Error {
    
    case encodingPollError = "There was an error encoding your SimplePoll"
    case creatingError = "There was an error creating your SimplePoll"
    case responseError = "There was an error with your SimplePoll Response"
    case responseDataError = "There was an error with your SimplePoll Response Data"
    case decodingError = "There was an error with decoding your SimplePoll"
    case encodingVoteError = "There was an error encoding your vote"
    case castingVoteError = "There was an error casting your vote"
    case searchPollError = "There was an error searching for your SimplePoll"
}
