//
//  Loader.swift
//  Runner
//
//  Created by bryosabian on 22/11/2023.
//

import Foundation


struct Loader : IMappable {
    
    var title: String = ""
    var message: String = ""
    var isHidden: Bool = false
    
   var toMap: Dictionary<String, Any>{
        get {
            var dictionary = Dictionary<String,Any>()
            dictionary["title"] = title
            dictionary["message"] = message
            dictionary["isHidden"] = isHidden
            return dictionary
        }
    }
}
