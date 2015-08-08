//
//  MulticastDelegateBaseObject.m
//
//  Created by yangyang on 15/8/9.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//
#import "MulticastDelegateBaseObject.h"

@implementation MulticastDelegateBaseObject

- (id)init
{
    return [self initWithDispatchQueue:NULL];
}

- (id)initWithDispatchQueue:(dispatch_queue_t)queue
{
    if ((self = [super init]))
    {
        if (queue)
        {
            moduleQueue = queue;
        }
        else
        {
            const char *moduleQueueName = [NSStringFromClass([self class]) UTF8String];
            moduleQueue = dispatch_queue_create(moduleQueueName, NULL);
        }
        
        moduleQueueTag = &moduleQueueTag;
        dispatch_queue_set_specific(moduleQueue, moduleQueueTag, moduleQueueTag, NULL);
        
        multicastDelegate = [[GCDMulticastDelegate alloc] init];
    }
    return self;
}

- (dispatch_queue_t)moduleQueue
{
    return moduleQueue;
}

- (void *)moduleQueueTag
{
    return moduleQueueTag;
}

- (void)addDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    dispatch_block_t block = ^{
        [multicastDelegate addDelegate:delegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(moduleQueueTag))
        block();
    else
        dispatch_async(moduleQueue, block);
}

- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue synchronously:(BOOL)synchronously
{
    dispatch_block_t block = ^{
        [multicastDelegate removeDelegate:delegate delegateQueue:delegateQueue];
    };
    
    if (dispatch_get_specific(moduleQueueTag))
        block();
    else if (synchronously)
        dispatch_sync(moduleQueue, block);
    else
        dispatch_async(moduleQueue, block);
    
}
- (void)removeDelegate:(id)delegate delegateQueue:(dispatch_queue_t)delegateQueue
{
    [self removeDelegate:delegate delegateQueue:delegateQueue synchronously:YES];
}

- (void)removeDelegate:(id)delegate
{
    [self removeDelegate:delegate delegateQueue:NULL synchronously:YES];
}


@end
