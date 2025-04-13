//
//  SearchBarView.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String

    var body: some View {
        TextField("Search...", text: $text)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}
