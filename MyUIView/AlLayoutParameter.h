//
//  AlLayoutParameter.h
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlLayoutParameter : NSObject
{
    CGFloat _marginLeft;
    CGFloat _marginRight;
    CGFloat _marginTop;
    CGFloat _marginBottom;
}

@property (nonatomic, assign) CGFloat marginLeft;
@property (nonatomic, assign) CGFloat marginRight;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat marginBottom;

@end

