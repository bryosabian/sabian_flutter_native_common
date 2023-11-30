//
//  SabianCodable.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation


protocol SabianCodable : Codable {
    func toJSON() throws -> String
    func fromJSON<T : SabianCodable>(_ text : String) throws -> T
}

extension SabianCodable {
    func toJSON() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(self)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }else{
                throw SabianException("Failed JSON")
            }
        } catch {
            throw error
        }
    }
    
    func fromJSON<T : SabianCodable>(_ text : String) throws -> T {
        do {
            let jsonData = text.data(using: .utf8)!
            let data = try JSONDecoder().decode(T.self, from: jsonData)
            return data
        }catch {
            throw error
        }
    }
    
    func fromJSONOrNull<T : SabianCodable>(_ text : String) -> T? {
        do {
            return try fromJSON(text)
        }catch {
            return nil
        }
    }
}

extension Array where Element : SabianCodable {
    func toJSON() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(self)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }else{
                throw SabianException("Failed JSON")
            }
        } catch {
            throw error
        }
    }
    
    func fromJSON<T : SabianCodable>(_ text : String) throws -> [T] {
        do {
            let jsonData = text.data(using: .utf8)!
            let data = try JSONDecoder().decode([T].self, from: jsonData)
            return data
        }catch {
            throw error
        }
}
}
