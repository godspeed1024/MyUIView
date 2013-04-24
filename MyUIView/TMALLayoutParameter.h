//
//  TMALLayoutParameter.h
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kLayoutWrapContent = 0x00,
    kLayoutFillParent = 0x01,
} EnumLayoutStretch;

typedef struct
{
    CGFloat marginLeft;
    CGFloat marginRight;
    CGFloat marginTop;
    CGFloat marginBottom;
    
    EnumLayoutStretch horizontalStretch;
    EnumLayoutStretch verticalStretch;
    
} TMALLayoutParameter;


