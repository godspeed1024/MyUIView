//
//  AlViewLayout.h
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#ifndef __MyUIView__AlViewLayout__
#define __MyUIView__AlViewLayout__

#include <CoreGraphics/CoreGraphics.h>

#include "AlViewLayoutParameter.h"

typedef void (*OnSetFrameCallback) (void* ptrWrappedObject, CGRect frame);

class AlViewContainerLayout;


class AlViewLayout
{
    friend class AlViewContainerLayout;
    
public:
    
    AlViewLayout (void);
    
    virtual ~AlViewLayout (void);
    
    CGRect getRect ();
    
    void layout (AlViewLayoutParameter givenLayoutParam);
    
    void setMinimalMeasuredSize (float width, float height);
    
    void setDesiredMeasuredSize (float width, float height);
    
    virtual void onLayout (AlViewLayoutParameter givenLayoutParam);
    
    CGSize getMinimalMeasuredSize ();
    CGSize getDesiredMeasuredSize ();
    
    CGRect _layoutedRect;
    
    void setDelegate (void* delegate, OnSetFrameCallback onSetFrameCallback);
    
    void applyLayout ();
    
protected:
    
    AlViewContainerLayout* _parent;
    
    bool _isMinimalSizeSet;
    CGSize _minimalMeasuredSize;
    
    bool _isDesiredSizeSet;
    CGSize _desiredMeasuredSize;
    
    void* _delegate;
    OnSetFrameCallback _onSetFrameCallback;
};

#endif /* defined(__MyUIView__AlViewLayout__) */
