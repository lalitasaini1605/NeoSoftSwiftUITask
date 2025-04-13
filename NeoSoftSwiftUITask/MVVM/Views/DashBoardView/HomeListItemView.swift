//
//  HomeListItemView.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import SwiftUI

struct HomeListItemView: View {
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        let source = viewModel.isSearching ? viewModel.filteredList : viewModel.arrList
        let items = viewModel.currentPage < source.count ? source[viewModel.currentPage].data ?? [] : []

        List(items) { item in
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
