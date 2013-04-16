//
//  AlViewLayoutParameter.h
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#ifndef MyUIView_AlViewLayoutParameter_h
#define MyUIView_AlViewLayoutParameter_h

#include <CoreGraphics/CoreGraphics.h>

#define kLayoutFlagFillParent  1
#define kLayoutFlagWrapContent 2
#define kLayoutFlagPrecise     0

typedef struct
{
    int horizontalLayoutFlag;

    int verticalLayoutFlag;
    
    CGSize givenSize;

    float marginLeft;
    float marginTop;
    float marginRight;
    float marginBottom;
    
} AlViewLayoutParameter;

#endif
