//
//  TMALLayouter.m
//  WeiBo_iPad
//
//  Created by DomQiu on 13-4-24.
//
//

#import "TMALLayouter.h"

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

- (id) initWithParent : (TMALLayouter*) parent
{
    self = [super init];
    if (nil != self)
    {
        _parent = parent;
        _isLayoutInvalid = YES;
    }
    return self;
}

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
    _measuredPreferSize = size;
}

- (void) layout
{
    if (_isLayoutInvalid)
    {
        [self onLayout];
    }
    _isLayoutInvalid = NO;
}

- (void) onLayout
{
    
}

@end
