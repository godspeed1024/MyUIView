//
//  AlLayoutChainNode.h
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
typedef struct LayoutChainNodeStruct
{
    AlViewLayout*    layouter;
    map<LayoutChainNodeStruct*, AlViewLayout*> nextNodes[2];
} LayoutChainNode;
//*/

@interface AlLayoutChainNode : NSObject
{
    UIView*         _subView;
    NSArray*        _nextNodes;
}

@property (nonatomic, retain, readonly) UIView* subView;
@property (nonatomic, retain, readonly) NSArray* nextNodes;

- (id) initWithSubView : (UIView*) subView;

@end
