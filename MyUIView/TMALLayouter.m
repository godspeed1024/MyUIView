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
    /*/
    //*
    if ((layoutedFrame.size.width > 0 && size.width > layoutedFrame.size.width)
        || (layoutedFrame.size.height > 0 && size.height > layoutedFrame.size.height))
    {
        [self setLayoutInvalid];
    }
    //*/
    _measuredPreferSize = CGSizeMake(MAX(size.width, layoutedFrame.size.width), MAX(size.height, layoutedFrame.size.height));
}

- (void) layout : (CGRect) givenBound
{
    [self onLayout:givenBound];
    self.layoutedFrame = givenBound;
    _isLayoutInvalid = NO;
}

- (void) onLayout : (CGRect) givenBound
{
    // TO BE IMPLEMENTED (Oftenly only by subclass of TMALContainerLayouter)
}

- (void) measure : (CGSize) givenSize
{
    [self setMeasuredPreferSize:[self onMeasure:givenSize]];
}

- (CGSize) onMeasure : (CGSize) givenSize
{
    // TO BE IMPLEMENTED (Oftenly only by subclass of TMALContainerLayouter)
    return _measuredPreferSize;
}

@end
