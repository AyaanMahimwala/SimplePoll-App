//
//  MakePollView.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/16/21.
//

import SwiftUI

struct MakePollView: View {
    @StateObject private var makePollViewModel = MakePollViewModel()
    
    var body: some View {
        VStack{
            Text("Create Your SimplePoll!")
                .bold()
                .font(.title)
            VStack(){
                HStack(){
                    Text("Give Your SimplePoll A Title")
                        .font(.subheadline)
                    Spacer()
                }
                TextField("Poll Title", text: $makePollViewModel.pollTitle)
                    .disableAutocorrection(true)
                HStack(){
                    Text("Specify Your Options")
                        .font(.subheadline)
                    Spacer()
                }
                TextField("Option #1", text: $makePollViewModel.option1)
                    .disableAutocorrection(true)
                TextField("Option #2", text: $makePollViewModel.option2)
                    .disableAutocorrection(true)
                
                NavigationLink(isActive: $makePollViewModel.isReady) {
                    PollVoteView(pollVoteViewModel: PollVoteViewModel(makePollViewModel.createdPoll))
                } label: {
                    Button {
                        makePollViewModel.createPoll()
                    } label: {
                        Capsule()
                            .fill(.blue)
                            .overlay(
                                Text("Create")
                                    .foregroundColor(.white)
                            ) .frame(width: 220, height: 40, alignment: .center)
                    }
                }
            }
            .textFieldStyle(.roundedBorder)
            .padding()   
        }
    }
}

struct MakePollView_Previews: PreviewProvider {
    static var previews: some View {
        MakePollView()
    }
}
