//
//  MainContentStorage.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


final class MainContentStorage {
    
    // MARK: Property(s)
    
    private(set) var contentList: [MainContent] = []
    
    // MARK: Function(s)
    
    func fetchMainContentList() {
        contentList = (1...80).map { MainContent(number: $0) }
    }
    
    func filterContentList(minValue: Int, maxValue: Int) {
        let filterRange = minValue...maxValue
        print(minValue)
        resetContentList()
        contentList = contentList.filter { filterRange.contains($0.number) }
        print(contentList)
    }
    
    // MARK: Private Function(s)
    
    private func resetContentList() {
        fetchMainContentList()
    }
}
