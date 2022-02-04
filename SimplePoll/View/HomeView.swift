//
//  HomeView.swift
//  SimplePoll
//
//  Created by Ayaan Mahimwala on 11/16/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                NavigationLink {
                    MakePollView()
                } label: {
                    Capsule()
                        .fill(.blue)
                        .overlay(
                            Text("Make A Simple Poll")
                                .foregroundColor(.white)
                                .bold())
                        .frame(width: 220, height: 40, alignment: .center)
                }
                NavigationLink {
                    PollVoteView(pollVoteViewModel: PollVoteViewModel(nil))
                } label: {
                    Text("Vote On Existing Polls")
                        .foregroundColor(.blue)
                        .bold()
                        .padding(.top)
                }
                Spacer()
                    .navigationTitle("📊 Simple Poll")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewDevice("iPhone 12")
    }
}
