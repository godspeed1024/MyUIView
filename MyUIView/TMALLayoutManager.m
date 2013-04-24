//
//  TMALLayoutManager.m
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "TMALLayoutManager.h"
#import "NSObject_KVContainer.h"

@implementation TMALLayoutManager

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
    [_subViews removeAllObjects];
}

- (void) addSubView : (UIView*) subView
    layoutParameter : (TMALLayoutParameter*) parameter
{
    [_subViews addObject:subView];
    [subView setKVPair:parameter key:KEY_LAYOUTPARAMETER];
}

- (void) removeSubView : (UIView*) subView
{
    [_subViews removeObject:subView];
}

@end
