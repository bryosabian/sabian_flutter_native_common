////  Nygma Period Tracker
//
//  Created by Jared Leto on 26/08/2021.
//  Copyright © 2021 Jared Leto. All rights reserved.

import Foundation
class SabianDebounceTask<T>  {
    
    private var debounceRate :Int = 500
    private var taskJob : DispatchWorkItem? = nil
    
    private var hasFinished = false
    private var ioDispatcher : DispatchQueue = DispatchQueue.global(qos: .background)
    private var defaultDispatcher : DispatchQueue = DispatchQueue.main
    
    init(debounceRate : Int = 500) {
        self.debounceRate = debounceRate
    }
    
    /**
     Executes a background task
     */
    func execute(_ action :  @escaping () throws ->  T?, onExecuting : (() -> Void)? = nil,  onComplete :  ((T?) -> Void)? = nil, onError : ((Error) -> Void)? = nil, onCancel : (() -> Void)? = nil){
        
        self.hasFinished = false
        
        onExecuting?()
        
        taskJob?.cancel()
        taskJob = nil
        
        
        var throwable: Error? = nil
        var returns : T?
        
        taskJob = DispatchWorkItem {[unowned self] in
            
            ioDispatcher.async(execute: {
                
                do{
                    returns = try action()
                }catch {
                    throwable = error
                }
                
                self.hasFinished = true
                
                self.defaultDispatcher.async {
                    if self.hasFinished {
                        if throwable != nil {
                            onError?(throwable!)
                        }else{
                            onComplete?(returns)
                        }
                    }else{
                        onCancel?()
                    }
                }
            })
            
        }
        
        defaultDispatcher.asyncAfter(deadline: .now() + .milliseconds(self.debounceRate),execute: taskJob!)
        
    }
}
