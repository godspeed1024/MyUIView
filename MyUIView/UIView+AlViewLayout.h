//
//  UIView+AlViewLayout.h
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIAlLayouter.h"

@interface UIView (AlViewLayout)

- (void) setAlLayouter : (UIAlLayouter*) alLayouter;

- (UIAlLayouter*) alLayouter;

@end
