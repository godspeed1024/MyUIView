//
//  UIView+AlViewLayout.m
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "UIView+AlViewLayout.h"
#import "NSObject_KVContainer.h"

static NSString* kKeyMeasuredPreferSize = @"KEY_measuredPreferSize";

@implementation UIView (AlViewLayout)

- (void) setMeasuredPreferSize : (CGSize) size
{
    NSValue* pSize = [NSValue valueWithCGSize:size];
    [self setKVPair:pSize key:kKeyMeasuredPreferSize];
}

- (CGSize) measuredPreferSize
{
    NSValue* pSize = [self valueOfKVPair:kKeyMeasuredPreferSize];
    if (nil == pSize)
    {
        return self.bounds.size;
    }
    else
    {
        return pSize.CGSizeValue;
    }
}

@end
