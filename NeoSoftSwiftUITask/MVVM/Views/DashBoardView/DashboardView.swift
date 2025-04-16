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
        NavigationView {
            List {
                // 1. Banner that scrolls away
                BannerView(viewModel: viewModel)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)

                // 2. Sticky Search Bar as Section Header
                Section(header: StickyHeader {
                    SearchBarView(text: $viewModel.searchText)
                        .onChange(of: viewModel.searchText) { _ in
                            viewModel.filterData()
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                }) {
                    // 3. Your list items
                    ForEach(currentItems()) { item in
                        HStack(alignment: .top, spacing: 12) {
                            Image(item.image ?? "")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 48, height: 48)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .shadow(radius: 1)

                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.title ?? "")
                                    .font(.headline)
                                Text(item.desc ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Dashboard", displayMode: .inline)
            .sheet(isPresented: $showStats) {
                BottomSheetView(stats: viewModel.generateStats())
            }
            .overlay(
                // Floating Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showStats = true
                        }) {
                            Image("dots")
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
            )
        }
    }

    private func currentItems() -> [ArraySetModel] {
        let source = viewModel.isSearching ? viewModel.filteredList : viewModel.arrList
        return viewModel.currentPage < source.count ? source[viewModel.currentPage].data ?? [] : []
    }
}
struct StickyHeader<Content: View>: View {
    let content: () -> Content

    var body: some View {
        content()
            .background(Color(.systemBackground)) // Match background
    }
}



#Preview {
    DashboardView()
}
