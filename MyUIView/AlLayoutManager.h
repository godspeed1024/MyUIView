//
//  AlLayoutManager.h
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlLayoutParameter.h"

static NSString* KEY_LAYOUTPARAMETER = @"lp";

@interface AlLayoutManager : NSObject
{
    NSMutableArray* _subViews;
    
    CGSize          _measuredPreferSize;
}

@property (nonatomic, assign, readonly) CGSize measuredPreferSize;


- (id) init;

- (void) addSubView : (UIView*) subView
    layoutParameter : (AlLayoutParameter*) parameter;

- (void) removeSubView : (UIView*) subView;

@end
