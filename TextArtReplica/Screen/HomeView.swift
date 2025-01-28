//
//  HomeView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI

struct HomeView: View {

    @State var showInstagramFollowBar = true

    var body: some View {

        VStack {
            if showInstagramFollowBar {
                followInstagramBar()
            }

            Text("Hello")

            Spacer(minLength: 0)
        }
        .navigationTitle("Projects")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {

                Button {

                } label: {
                    Image(systemName: "gearshape.fill")
                }

                Button {

                } label: {
                    Image(systemName: "crown.fill")
                }
            }

            ToolbarItemGroup(placement: .topBarTrailing) {

                Button {

                } label: {
                    Image(systemName: "checkmark.square")
                }

                Button {

                } label: {
                    Text("+")
                }
            }
        }
    }


    @ViewBuilder
    func followInstagramBar() -> some View {

        Rectangle()
            .fill(Color.orange)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .overlay(alignment: .center) {
                Text("Follow on twitter")
                    .foregroundStyle(.white)

            }
            .overlay(alignment: .leading) {
                Button {
                    withAnimation {
                        showInstagramFollowBar = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding()
                        .offset(x: 20)
                }
            }
    }
}

#Preview {
    HomeView()
}
