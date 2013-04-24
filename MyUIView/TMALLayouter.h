//
//  TMALLayouter.h
//  WeiBo_iPad
//
//  Created by DomQiu on 13-4-24.
//
//

#import <Foundation/Foundation.h>
#import "TMALLayoutParameter.h"


@interface TMALLayouter : NSObject
{
    //CGRect _layoutedFrame;
    
    CGSize _measuredPreferSize;
    
    BOOL    _isLayoutInvalid;
    
    __unsafe_unretained TMALLayouter* _parent;
    
    TMALLayoutParameter _layoutParameter;
}

@property (nonatomic, assign) CGRect layoutedFrame;

@property (nonatomic, assign) CGSize measuredPreferSize;

@property (nonatomic, unsafe_unretained) TMALLayouter* parent;

@property (nonatomic, assign) TMALLayoutParameter layoutParameter;


- (id) init;

- (id) initWithParent : (TMALLayouter*) parent;

- (void) setMeasuredPreferSize : (CGSize) size;

- (void) setLayoutInvalid;

- (void) layout;

- (void) onLayout;

@end
