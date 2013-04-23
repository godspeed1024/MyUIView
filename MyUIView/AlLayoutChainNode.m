//
//  AlLayoutChainNode.m
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "AlLayoutChainNode.h"

@implementation AlLayoutChainNode

@synthesize subView = _subView;
@synthesize nextNodes = _nextNodes;

- (id) initWithSubView : (UIView*) subView
{
    self = [super init];
    if (nil != self)
    {
        _subView = subView;
        
        NSMutableArray* array0 = [[NSMutableArray alloc] init];
        NSMutableArray* array1 = [[NSMutableArray alloc] init];
        _nextNodes = [[NSArray alloc] initWithObjects:array0, array1, nil];
    }
    return self;
}

- (void) dealloc
{
    [_nextNodes[0] removeAllObjects];
    [_nextNodes[1] removeAllObjects];
}

@end
