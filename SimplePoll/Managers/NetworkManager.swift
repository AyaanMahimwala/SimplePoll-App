//
//  NetworkManager.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/17/21.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL: String = "https://ttsd9ikku8.execute-api.us-west-1.amazonaws.com/dev"
    
    func createPoll(pollTitle: String, options: [String], completed: @escaping (Result<PollResult, SPError>) -> Void){
        
        let poll = Poll(pollTitle: pollTitle, options: options)
        guard let jsonPoll = try? JSONEncoder().encode(poll) else {
            completed(.failure(.encodingPollError))
            return
        }
        
        let url = URL(string: baseURL + "/createSP")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = jsonPoll
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.creatingError))
                return
            }
            
            // The API I made didn't set the statusCode?
           /* guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }*/
            guard let responseData = data else {
                completed(.failure(.responseDataError))
                return
            }
                do {
                    let decoder = JSONDecoder()
                    let pollRes = try decoder.decode(PollResult.self, from: responseData)
                    completed(.success(pollRes))
                } catch  {
                    completed(.failure(.decodingError))
                }
        }.resume()
    }
    
    func castVote(for pollID: String, with option: String, completed: @escaping (Result<PollResult, SPError>) -> Void){
        let vote = ["vote": option]
        guard let jsonPoll = try? JSONEncoder().encode(vote) else {
            completed(.failure(.encodingVoteError))
            return
        }
        
        let url = URL(string: baseURL + "/voteSP/\(pollID)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PATCH"
        request.httpBody = jsonPoll
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.castingVoteError))
                return
            }
            
           /* guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }*/
            guard let responseData = data else {
                completed(.failure(.responseDataError))
                return
            }
                do {
                    let decoder = JSONDecoder()
                    let pollRes = try decoder.decode(PollResult.self, from: responseData)
                    completed(.success(pollRes))
                } catch  {
                    completed(.failure(.decodingError))
                }
        }.resume()
    }
    
    func search(for pollID: String, completed: @escaping (Result<PollResult, SPError>) -> Void) {
        
        
        let url = URL(string: baseURL + "/sppoll/\(pollID)")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.searchPollError))
                return
            }
            
           /* guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.responseError))
                return
            }*/
            guard let responseData = data else {
                completed(.failure(.responseDataError))
                return
            }
                do {
                    let decoder = JSONDecoder()
                    let pollRes = try decoder.decode(PollResult.self, from: responseData)
                    completed(.success(pollRes))
                } catch  {
                    completed(.failure(.decodingError))
                }
        }.resume()
    }
    
}

