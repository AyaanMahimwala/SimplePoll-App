//
//  PollVoteViewModel.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/17/21.
//

import Foundation

final class PollVoteViewModel: ObservableObject {
    private var poll: PollResult?
    @Published var options: [Option]
    private var voteInt: Int
    @Published var votes: String
    @Published var query: String
    
    init(_ poll: PollResult?){
        self.poll = poll
        self.options = poll?.optionVotes ?? []
        self.voteInt = poll?.votes ?? 0
        votes = String(voteInt)
        query = ""
        self.options = self.options.sorted(by: { (o1: Option, o2: Option) -> Bool in
            return o1.votes > o2.votes
        })
    }
    
    func hasPoll() -> Bool {
        return poll != nil
    }
    
    func getTitle() -> String {
        return poll?.pollTitle ?? "No Title"
    }
    
    func getLink() -> String {
        return poll?.link ?? "No Link"
    }
    
    func castVote(for option: Option) {
        NetworkManager.shared.castVote(for: poll?.id ?? "", with: option.optionTitle) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let updatedPoll):
                self.updatePoll(updatedPoll)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func updatePoll(_ updatedPoll: PollResult){
        DispatchQueue.main.async {
            self.poll = updatedPoll
            self.options = self.poll?.optionVotes ?? []
            self.voteInt = self.poll?.votes ?? 0
            self.votes = String(self.voteInt)
            
            self.options = self.options.sorted(by: { (o1: Option, o2: Option) -> Bool in
                return o1.votes > o2.votes
            })
        }
    }
    
    func search() {
        NetworkManager.shared.search(for: query) { result in
            switch result {
            case .success(let poll):
                self.updatePoll(poll);
            case .failure(let error):
                print(error.rawValue)
            }
        }
        self.query = ""
    }
}
