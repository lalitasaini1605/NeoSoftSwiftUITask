//
//  DashboardView.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var viewModel = DashboardViewModel()
    @State private var showStats = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack(spacing: 0) {
                    BannerView(viewModel: viewModel)

                    SearchBarView(text: $viewModel.searchText)
                        .padding(.horizontal)
                        .onChange(of: viewModel.searchText) { _ in
                            viewModel.filterData()
                        }

                    HomeListItemView(viewModel: viewModel)
                }
                .navigationBarTitle("Dashboard", displayMode: .inline)
                .sheet(isPresented: $showStats) {
                    BottomSheetView(stats: viewModel.generateStats())
                }
                
            }

            // Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showStats = true
                    }) {
                        Image("dots") // Replace with your asset name
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 30)
                }
            }
        }
    }
}



#Preview {
    DashboardView()
}
