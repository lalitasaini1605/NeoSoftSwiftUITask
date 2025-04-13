//
//  BottomSheetView.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import SwiftUI

struct BottomSheetView: View {
    let stats: [SectionStats]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(stats) { section in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(section.sectionTitle)
                            .font(.headline)
                        ForEach(section.topCharacters, id: \ .0) { char, count in
                            Text("• \(char) = \(count)")
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

