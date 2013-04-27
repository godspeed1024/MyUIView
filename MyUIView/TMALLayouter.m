//
//  TMALLayouter.m
//  WeiBo_iPad
//
//  Created by DomQiu on 13-4-24.
//
//

#import "TMALLayouter.h"
#import "TMALContainerLayouter.h"

@implementation TMALLayouter

@synthesize layoutedFrame;

@synthesize measuredPreferSize = _measuredPreferSize;

@synthesize parent = _parent;

@synthesize layoutParameter = _layoutParameter;

- (id) init
{
    self = [super init];
    if (nil != self)
    {
        _parent = nil;
        _isLayoutInvalid = YES;
    }
    return self;
}
/*
- (id) initWithParent : (TMALLayouter*) parent
{
    self = [super init];
    if (nil != self)
    {
        TMALContainerLayouter* pp;
        _parent = parent;
        _isLayoutInvalid = YES;
    }
    return self;
}
//*/
- (void) setLayoutInvalid
{
    _isLayoutInvalid = YES;
    if (nil != _parent)
    {
        [_parent setLayoutInvalid];
    }
}

- (void) setMeasuredPreferSize : (CGSize) size
{
    /*
    if (!CGSizeEqualToSize(size, _measuredPreferSize))
    {
        [self setLayoutInvalid];
    }
     //*/
    _measuredPreferSize = size;
}

- (void) layout : (CGSize) givenSize
{
    ///!!!if (_isLayoutInvalid)
    {
        [self onLayout:givenSize];
    }
    _isLayoutInvalid = NO;
}

- (void) onLayout : (CGSize) givenSize
{
    
}

@end
