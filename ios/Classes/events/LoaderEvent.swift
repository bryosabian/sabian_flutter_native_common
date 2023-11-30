//
//  LoaderEvent.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation

class LoaderEvent : AbstractMappableEvent<Loader>{
    
    static let shared = LoaderEvent()
    
    private override init() {
        
    }
}
