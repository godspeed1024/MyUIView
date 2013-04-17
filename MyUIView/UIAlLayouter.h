//
//  WrapAlLayouter.h
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlViewLayout.h"

@interface UIAlLayouter : NSObject
{
    UIView* _view;
    AlViewLayout* _alViewLayout;
    
    BOOL _isLayouterOwner;
}

@property (nonatomic, retain) UIView* view;
@property (nonatomic, readonly) AlViewLayout* layouter;

- (id) initWithUIView : (UIView*) wrappedView
             layouter : (AlViewLayout*) viewLayouter;

@end
