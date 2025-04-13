//
//  DashModel.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import Foundation

import SwiftUI

// MARK: - Models
struct ArraySetModel: Codable, Identifiable {
    var id = UUID()
    var title: String?
    var desc: String?
    var image: String?
    private enum CodingKeys: String, CodingKey {
        case title, desc, image
    }
}

struct DashModel: Codable, Identifiable {
    var id = UUID()
    let image: String?
    var data: [ArraySetModel]?
    private enum CodingKeys: String, CodingKey {
        case image, data
    }
}

struct SectionStats: Identifiable {
    var id = UUID()
    let sectionTitle: String
    let itemCount: Int
    let topCharacters: [(Character, Int)]
}
