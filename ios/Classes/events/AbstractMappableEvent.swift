//
//  AbstractMappableEvent.swift
//  Runner
//
//  Created by Sweet Pea on 22/11/2023.
//

import Foundation


class AbstractMappableEvent<T : IMappable> : AbstractEvent {
    
    func raise(_ payload: T) {
        super.raise(payload.toMap)
    }
}
