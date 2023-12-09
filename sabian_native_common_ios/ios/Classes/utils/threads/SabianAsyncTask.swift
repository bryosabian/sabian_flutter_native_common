//
//  SabianAsyncTask.swift
//  Nygma Period Tracker
//
//  Created by Jared Leto on 20/07/2021.
//  Copyright © 2021 Jared Leto. All rights reserved.
//

import Foundation

class SabianAsyncTask<T> {
    
    private var ioDispatcher : DispatchQueue {
        get {
            return DispatchQueue.global(qos: .background)
        }
    }
    
   private var defaultDispatcher : DispatchQueue{
        get {
            return DispatchQueue.main
        }
    }
    
    
    private var group : DispatchGroup? = nil
    private var isComplete : Bool = false
    
    /**
     Executes a background task
     */
    func execute(_ action :  @escaping () throws ->  T, onBefore : (() -> Void)? = nil,  onComplete :  ((T) -> Void)? = nil, onError : ((Error) -> Void)? = nil, onCancel : (() -> Void)? = nil){
        
        onBefore?()
        
        var throwable: Error? = nil
        var retuns : T!
        
        if group != nil {
            group = nil
        }
        
        group = DispatchGroup()
        isComplete = false
        
        let group = self.group!
        
        group.enter()
        
        
        ioDispatcher.async { [weak self] in
            do{
                retuns = try action()
            }catch {
                throwable = error
            }
            self?.isComplete = true
            group.leave()
        }
        
        group.notify(queue: defaultDispatcher){
            
            if !self.isComplete {
                onCancel?()
                return
            }
            
            if throwable != nil {
                onError?(throwable!)
            }else{
                onComplete?(retuns)
            }
        }
        
    }
    
    /**
     Buggy. Not in use
     */
    func cancel(){
        if let g = self.group {
            g.leave()
            self.group = nil
        }
    }
    
    deinit {
        print("Async task terminated")
    }
}
