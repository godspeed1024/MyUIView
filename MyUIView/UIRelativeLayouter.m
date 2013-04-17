//
//  UIRelativeLayouter.m
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "UIRelativeLayouter.h"
#import "AlViewRelativeLayout.h"

@implementation UIRelativeLayouter

- (id) initWithUIView:(UIView *)wrappedView
{
    AlViewRelativeLayout* relativeLayouter = new AlViewRelativeLayout;
    
    self = [super initWithUIView:wrappedView layouter:relativeLayouter];
    if (nil == self)
    {
        delete relativeLayouter;
    }
    return self;
}

@end
