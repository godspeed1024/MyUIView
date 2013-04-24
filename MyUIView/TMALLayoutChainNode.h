//
//  TMALLayoutChainNode.h
//  MyUIView
//
//  Created by DomQiu on 13-4-23.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TMALLayouter;

@interface TMALLayoutChainNode : NSObject
{
    TMALLayouter*   _subLayouter;
    NSArray*        _nextNodes;
}

@property (nonatomic, strong, readonly) TMALLayouter* subLayouter;
@property (nonatomic, strong, readonly) NSArray* nextNodes;

- (id) initWithSubLayouter : (TMALLayouter*) subLayouter;

@end
