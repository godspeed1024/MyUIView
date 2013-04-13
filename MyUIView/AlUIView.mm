//
//  AlUIView.m
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "AlViewLayout.h"
#import "AlUIView.h"

@implementation AlUIView

@synthesize view = _view;
@synthesize layouter = _alViewLayout;

void onSetFrame (void* ptr, CGRect frame)
{
    AlUIView* auv = (AlUIView*)ptr;
    if (NULL != auv)
    {
        [auv.view setFrame:frame];
    }
}

- (id) initWithUIView : (UIView*) wrappedView
{
    self = [super init];
    if (nil != self)
    {
        self.view = wrappedView;
        _alViewLayout = new AlViewLayout;
        _alViewLayout->setDelegate(self, onSetFrame);
        _isLayouterOwner = YES;
    }
    return self;
}

- (id) initWithUIView : (UIView*) wrappedView
             layouter : (AlViewLayout*) viewLayouter
{
    self = [super init];
    if (nil != self)
    {
        self.view = wrappedView;
        if (NULL == viewLayouter)
        {
            _alViewLayout = new AlViewLayout;
            _isLayouterOwner = YES;
        }
        else
        {
            _alViewLayout = viewLayouter;
            _isLayouterOwner = NO;
        }
        _alViewLayout->setDelegate(self, onSetFrame);
    }
    return self;
}

- (void) dealloc
{
    [super dealloc];
    self.view = nil;
    if (NULL != _alViewLayout && YES == _isLayouterOwner)
    {
        delete _alViewLayout;
    }
}

@end
