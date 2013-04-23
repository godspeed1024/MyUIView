//
//  UILayoutManager.m
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "UILayoutManager.h"
#import "NSObject_KVContainer.h"

@implementation UILayoutManager

@synthesize measuredPreferSize = _measuredPreferSize;

- (id) init
{
    self = [super init];
    if (nil != self)
    {
        _subViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
    [_subViews removeAllObjects];
    [_subViews release];
}

- (void) addSubView : (UIView*) subView
    layoutParameter : (AlLayoutParameter*) parameter
{
    [subView retain];
    [_subViews addObject:subView];
    [subView setKVPair:parameter key:KEY_LAYOUTPARAMETER];
    [subView release];
}

- (void) removeSubView : (UIView*) subView
{
    [_subViews removeObject:subView];
}

@end
