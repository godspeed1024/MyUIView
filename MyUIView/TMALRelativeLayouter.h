//
//  UIRelativeLayouter.h
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#define DEBUG_OUTPUT
#define V2

#define kLayoutRelationAlignTopWith          0x01
#define kLayoutRelationAlignBottomWith       0x02
#define kLayoutRelationAlignLeftWith         0x04
#define kLayoutRelationAlignRightWith        0x08
#define kLayoutRelationAbove                 0x10
#define kLayoutRelationBelow                 0x20
#define kLayoutRelationToLeftOf              0x40
#define kLayoutRelationToRightOf             0x80

#define kLayoutRelationCenterParentHorizontal  0x100
#define kLayoutRelationCenterParentVertical    0x200

#define kLayoutRelationAlignParentTop        0x400
#define kLayoutRelationAlignParentBottom     0x800
#define kLayoutRelationAlignParentLeft       0x1000
#define kLayoutRelationAlignParentRight      0x2000

#define kLayoutRelationSetSelfBound          0x4000

#define kLayoutRelationCenterHorizontalWith  0x8000
#define kLayoutRelationCenterVerticalWith    0x10000

#define VAR_LEFT    0
#define VAR_TOP     1
#define VAR_RIGHT   2
#define VAR_BOTTOM  3

#define VAR_PARENT_WIDTH  4
#define VAR_PARENT_HEIGHT 5

#define RELATION_LESS_EQUAL      0
#define RELATION_GREATER_EQUAL   1
#define RELATION_LESS_EQUAL_N    2
#define RELATION_GREATER_EQUAL_N 3

#define RANGE_LOW_BOUND  0
#define RANGE_HIGH_BOUND 1

#define NA_VAR     -1

#define NA_RANGE   (-32768.0f)


#import "TMALContainerLayouter.h"


typedef enum
{
    ParentLeft = 0x01,
    ParentTop = 0x02,
    ParentRight = 0x04,
    ParentBottom = 0x08,
    ParentHorizontalCenter = 0x10,
    ParentVerticalCenter = 0x20,
    
} EnumLayoutAnchor;

@class TMALLayoutChainNode;


@interface TMALRelativeLayouter : TMALContainerLayouter

{
    //map<AlViewLayout*, LayoutChainNode*> horizontalLayoutChains;
    NSMutableDictionary* _horizontalLayoutChains;
    
    //map<AlViewLayout*, LayoutChainNode*> verticalLayoutChains;
    NSMutableDictionary* _verticalLayoutChains;
    
    //map<LayoutChainNode*, AlViewLayout*> horizontalLayoutChainRoots;
    NSMutableArray* _horizontalLayoutChainRoots;
    
    //map<LayoutChainNode*, AlViewLayout*> verticalLayoutChainRoots;
    NSMutableArray* _verticalLayoutChainRoots;
    
    //map<LayoutChainNode*, int> layoutFlagsOfNode;
    NSMutableDictionary* _layoutFlagsOfNode;
    
    NSMutableDictionary* _frameOfSubLayouter;
}

- (id) init;

///+ (void) clearLayoutChainGraph : (NSDictionary*) graph;

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) rightSubLayouter
                                toRightOf : (TMALLayouter*) leftSubLayouter;

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) leftSubLayouter
                                 toLeftOf : (TMALLayouter*) rightSubLayouter;

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) aboveSubLayouter
                                    above : (TMALLayouter*) belowSubLayouter;

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) belowSubLayouter
                                    below : (TMALLayouter*) aboveSubLayouter;

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) subView
                               withAnchor : (EnumLayoutAnchor) anchor;

//////////////
- (BOOL) canBeLayoutChainRootCandidate : (TMALLayoutChainNode*) node;

- (CGFloat) recursiveFindMaxWidthOfHorizontalChain : (TMALLayoutChainNode*) curNode
                                         direction : (int) direction
                                       curPosition : (CGFloat) curPosition
                                      stampedNodes : (NSMutableSet*) stampedNodes;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) recursiveOffsetHorizontalChains : (TMALLayoutChainNode*) curNode
                                  offset : (CGFloat) offset
                            stampedNodes : (NSMutableSet*) stampedNodes;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) recursiveAdustForAlignParentHorizontalAnchors : (TMALLayoutChainNode*) curNode
                                           direction : (int) direction
                                              offset : (CGFloat) offset;

- (CGFloat) recursiveFindMaxHeightOfVerticalChain : (TMALLayoutChainNode*) curNode
                                        direction : (int) direction
                                      curPosition : (CGFloat) curPosition
                                     stampedNodes : (NSMutableSet*) stampedNodes;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) recursiveOffsetVerticalChains : (TMALLayoutChainNode*) curNode
                                offset : (CGFloat) offset
                          stampedNodes : (NSMutableSet*) stampedNodes;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) recursiveAdustForAlignParentVerticalAnchors : (TMALLayoutChainNode*) curNode
                                           direction : (int) direction
                                              offset : (CGFloat) offset;

///!!!- (void) onLayout : (CGSize) givenSize;

@end
