//
//  SabianException.swift
//  Runner
//
//  Created by Sweet Pea on 20/11/2023.
//

import Foundation


struct SabianException : CustomStringConvertible, LocalizedError {
   
    let title : String
    
    let message: String
    
    init(_ message: String,title : String = "Error") {
        self.message = message
        self.title = title
    }
    
    public var localizedDescription: String {
        return message
    }
    
    //ToString
    var description: String { return self.message }
    
    //You need to implement `errorDescription`, not `localizedDescription`.
    var errorDescription: String? {
        get {
            return self.message
        }
    }
}
