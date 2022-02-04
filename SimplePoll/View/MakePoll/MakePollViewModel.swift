//
//  MakePollViewModel.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/16/21.
//

import Foundation
import SwiftUI
import UIKit

final class MakePollViewModel : ObservableObject {
    
    @Published var pollTitle: String = ""
    @Published var option1: String = ""
    @Published var option2: String = ""
    
    @Published var isCreatingPoll: Bool = false
    @Published var isReady: Bool = false
    @Published var createdPoll: PollResult?
    
    func createPoll(){
        isCreatingPoll = true
        NetworkManager.shared.createPoll(pollTitle: pollTitle, options: [option1, option2]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let pollResult):
                self.showPoll(pollResult)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func showPoll(_ pollResult : PollResult) {
        DispatchQueue.main.async {
            self.createdPoll = pollResult
            self.isCreatingPoll = false
            self.isReady = true
            
            self.pollTitle = ""
            self.option1 = ""
            self.option2 = ""
        }
    }
    
}
