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


#import "UILayoutManager.h"


typedef enum
{
    ParentLeft,
    ParentTop,
    ParentRight,
    ParentBottom,
    ParentHorizontalCenter,
    ParentVerticalCenter,
    
} EnumLayoutAnchor;

@class AlLayoutChainNode;


@interface UIRelativeLayoutManager : UILayoutManager

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
    ///!!!NSMutableDictionary* _layoutFlagsOfNode;
}

- (id) init;

///+ (void) clearLayoutChainGraph : (NSDictionary*) graph;

- (void) setLayoutConstraintOfSubView : (UIView*) rightSubView
                            toRightOf : (UIView*) leftSubView;

- (void) setLayoutConstraintOfSubView : (UIView*) leftSubView
                             toLeftOf : (UIView*) rightSubView;

- (void) setLayoutConstraintOfSubView : (UIView*) aboveSubView
                                above : (UIView*) belowSubView;

- (void) setLayoutConstraintOfSubView : (UIView*) belowSubView
                                below : (UIView*) aboveSubView;

- (void) setLayoutConstraintOfSubView : (UIView*) subView
                           withAnchor : (EnumLayoutAnchor) anchor;

//////////////
- (BOOL) canBeLayoutChainRootCandidate : (AlLayoutChainNode*) node;

- (CGFloat) recursiveFindMaxWidthOfHorizontalChain : (AlLayoutChainNode*) curNode
                                         direction : (int) direction
                                       curPosition : (CGFloat) curPosition;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) recursiveOffsetHorizontalChains : (AlLayoutChainNode*) curNode
                               direction : (int) direction
                                  offset : (CGFloat) offset;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (CGFloat) recursiveFindMaxHeightOfVerticalChain : (AlLayoutChainNode*) curNode
                                        direction : (int) direction
                                      curPosition : (CGFloat) curPosition;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) recursiveOffsetVerticalChains : (AlLayoutChainNode*) curNode
                             direction : (int) direction
                                offset : (CGFloat) offset;
///!!!framesOfChildren : (NSDictionary*) framesOfChildren;

- (void) onLayout;

@end
