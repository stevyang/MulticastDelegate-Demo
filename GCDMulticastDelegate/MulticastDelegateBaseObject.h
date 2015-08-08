//
//  MulticastDelegateBaseObject.h
//
//  Created by yangyang on 15/8/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDMulticastDelegate.h"

//多播委托的基类
@interface MulticastDelegateBaseObject : NSObject{
    id multicastDelegate;
    dispatch_queue_t moduleQueue;
    void *moduleQueueTag;
}

- (id)init;
- (id)initWithDispatchQueue:(dispatch_queue_t)queue;

@property (readonly) dispatch_queue_t moduleQueue;
@property (readonly) void *moduleQueueTag;

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue;
- (void)removeDelegate:(id)delegate;
@end
