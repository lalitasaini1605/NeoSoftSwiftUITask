//
//  DashboardViewModel.swift
//  NeoSoftSwiftUITask
//
//  Created by Ranju on 13/04/25.
//

import Foundation

// MARK: - ViewModel
class DashboardViewModel: ObservableObject {
    @Published var arrList: [DashModel] = []
    @Published var filteredList: [DashModel] = []
    @Published var searchText: String = ""
    @Published var currentPage: Int = 0

    var isSearching: Bool {
        !searchText.isEmpty
    }

    init() {
        loadData()
    }

    func loadData() {
        guard let url = Bundle.main.url(forResource: "dataitems", withExtension: "json") else {
            print("dataitems.json not found.")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedList = try JSONDecoder().decode([DashModel].self, from: data)
            self.arrList = decodedList
            self.filteredList = decodedList
        } catch {
            print("Failed to load or decode dataitems.json: \(error)")
        }
    }

    func filterData() {
        if searchText.isEmpty {
            filteredList = arrList
        } else {
            filteredList = arrList
            if currentPage < arrList.count {
                var model = arrList[currentPage]
                model.data = model.data?.filter {
                    ($0.title?.localizedCaseInsensitiveContains(searchText) ?? false) ||
                    ($0.desc?.localizedCaseInsensitiveContains(searchText) ?? false)
                }
                filteredList[currentPage] = model
            }
        }
    }

    func generateStats() -> [SectionStats] {
        var statsList: [SectionStats] = []

        for (index, section) in arrList.enumerated() {
            let allText = section.data?.compactMap { "\($0.title ?? "")\($0.desc ?? "")" }.joined().lowercased() ?? ""
            var freq: [Character: Int] = [:]
            for char in allText where char.isLetter {
                freq[char, default: 0] += 1
            }
            let top3 = freq.sorted { $0.value > $1.value }.prefix(3)
            let title = "List \(index + 1) (\(section.data?.count ?? 0) items)"
            statsList.append(SectionStats(sectionTitle: title, itemCount: section.data?.count ?? 0, topCharacters: Array(top3)))
        }

        return statsList
    }
}
