//
//  PollVoteView.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/17/21.
//

import SwiftUI

struct PollVoteView: View {
    @StateObject var pollVoteViewModel: PollVoteViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Search For SimplePoll", text: $pollVoteViewModel.query)
                    .disableAutocorrection(true)
                Button {
                    pollVoteViewModel.search()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .overlay(
                            Text("Go")
                                .foregroundColor(.white)
                                .bold())
                        .frame(width: 40, height: 40, alignment: .center)
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            Spacer()
            if pollVoteViewModel.hasPoll() {
                Text("🤔 \(pollVoteViewModel.getTitle())")
                Button {
                    UIPasteboard.general.setValue(pollVoteViewModel.getLink(), forPasteboardType: "public.plain-text")
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.blue)
                        .overlay(Text("Copy Link!")
                                    .bold()
                                    .foregroundColor(.white))
                        .frame(width: 100, height: 40, alignment: .center)
                }

                
                Text("Total Votes: \(pollVoteViewModel.votes)")
                Text("Leader: \(pollVoteViewModel.options[0].optionTitle)")
                Button {
                    pollVoteViewModel.castVote(for: pollVoteViewModel.options[0])
                } label: {
                    Capsule()
                        .fill(.blue)
                        .overlay(
                            Text("\(pollVoteViewModel.options[0].optionTitle)")
                                .foregroundColor(.white)
                                .bold())
                        .frame(width: 220, height: 40, alignment: .center)
                }

                
                Button {
                    pollVoteViewModel.castVote(for: pollVoteViewModel.options[1])
                } label: {
                    Capsule()
                        .fill(.blue)
                        .overlay(
                            Text("\(pollVoteViewModel.options[1].optionTitle)")
                                .foregroundColor(.white)
                                .bold())
                        .frame(width: 220, height: 40, alignment: .center)
                }
                Divider()
                    .padding()
                 
                Text("\(pollVoteViewModel.options[0].optionTitle) has \(pollVoteViewModel.options[0].votes) votes")
                Text("\(pollVoteViewModel.options[1].optionTitle) has \(pollVoteViewModel.options[1].votes) votes")
            } else {
                Text("🙈 Search for a SimplePoll!")
            }
            Spacer()
        }
    }
}

struct PollVoteView_Previews: PreviewProvider {
    static var previews: some View {
        PollVoteView(pollVoteViewModel: PollVoteViewModel(PollResult(id: "1234", pollTitle: "Is Ayaan Hired?", link: "1234", votes: 4 , optionVotes: [Option(
        optionTitle: "yes", votes: 3), Option(optionTitle: "of course", votes: 2)])))
    }
}
