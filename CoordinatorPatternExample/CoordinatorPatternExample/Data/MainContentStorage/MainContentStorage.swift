//
//  MainContentStorage.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.


final class MainContentStorage {
    
    private(set) var contentList: [MainContent] = []
    
    func fetchMainContentList() {
        contentList = (1...80).map { MainContent(number: $0) }
    }
}
