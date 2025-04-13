//
//  BannerView.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import SwiftUI

struct BannerView: View {
    @ObservedObject var viewModel: DashboardViewModel

    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        // Customize page indicator colors
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.systemBlue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray4
    }
    
    var body: some View {
        TabView(selection: $viewModel.currentPage) {
            ForEach(viewModel.arrList.indices, id: \.self) { index in
                let model = viewModel.arrList[index]
                if let img = model.image {
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .tag(index)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 220)
        .onChange(of: viewModel.currentPage) { _ in
            viewModel.filterData()
        }
    }
}
