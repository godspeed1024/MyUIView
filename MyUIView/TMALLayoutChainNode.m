//
//  TMALLayoutChainNode.m
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "TMALLayoutChainNode.h"

@implementation TMALLayoutChainNode

@synthesize subLayouter = _subLayouter;
@synthesize nextNodes = _nextNodes;

- (id) initWithSubLayouter : (TMALLayouter*) subLayouter
{
    self = [super init];
    if (nil != self)
    {
        _subLayouter = subLayouter;
        
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
