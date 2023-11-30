//
//  String+Sabian.swift
//  Runner
//
//  Created by Sweet Pea on 20/11/2023.
//

import Foundation


extension String {
    func localize(comment : String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
    func localizeWithFormat(args : CVarArg...,comment : String = "") -> String {
        let string =  NSLocalizedString(self, comment: comment)
        return String(format: string, arguments: args)
    }
    func format(args : CVarArg...) -> String{
        let string = String(format: self,arguments: args)
        return string
    }
}
