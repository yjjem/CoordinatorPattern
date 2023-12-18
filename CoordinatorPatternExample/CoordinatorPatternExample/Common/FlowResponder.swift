//
//  FlowResponder.swift
//  CoordinatorPatternExample
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

class FlowResponder: NSObject {
    
    var nextFlowResponder: FlowResponder?
    
    func sendFlowEvent(_ selector: Selector) {
        if responds(to: selector) {
            perform(selector)
        } else {
            nextFlowResponder?.sendFlowEvent(selector)
        }
    }
    
    func setNext(flowResponder: FlowResponder) {
        self.nextFlowResponder = flowResponder
    }
}
