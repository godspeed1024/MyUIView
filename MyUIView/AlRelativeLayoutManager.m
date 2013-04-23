//
//  UIRelativeLayouter.m
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "AlRelativeLayoutManager.h"
#import "AlLayoutChainNode.h"
#import "UIView+AlViewLayout.h"
#import "NSObject_KVContainer.h"

static NSString* KEY_LAYOUT_FRAME = @"KEY_layoutFrame";
static NSString* KEY_LAYOUT_FLAG = @"KEY_layoutFlag";

@implementation AlRelativeLayoutManager

- (id) init
{
    self = [super init];
    if (nil != self)
    {
        _horizontalLayoutChainRoots = [[NSMutableArray alloc] init];
        _verticalLayoutChainRoots = [[NSMutableArray alloc] init];
        _horizontalLayoutChains = [[NSMutableDictionary alloc] init];
        _verticalLayoutChains = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) dealloc
{
    [_horizontalLayoutChainRoots removeAllObjects];
    [_verticalLayoutChainRoots removeAllObjects];
    [_horizontalLayoutChains removeAllObjects];
    [_verticalLayoutChains removeAllObjects];
}

- (void) setLayoutConstraintOfSubView : (UIView*) rightSubView
                            toRightOf : (UIView*) leftSubView
{
    if (nil == rightSubView) return;
    
    AlLayoutChainNode* rightNode;
    AlLayoutChainNode* leftNode;
    
    NSValue* nvRightPointer = [NSValue valueWithPointer:(void*)rightSubView];
    rightNode = [_horizontalLayoutChains objectForKey:nvRightPointer];
    if (nil == rightNode)
    {
        rightNode = [[AlLayoutChainNode alloc] initWithSubView:rightSubView];
        [_horizontalLayoutChains setObject:rightNode forKey:nvRightPointer];
    }
    
    NSValue* nvLeftPointer = [NSValue valueWithPointer:(void*)leftSubView];
    if (nil == leftSubView)
    {
        leftNode = nil;
    }
    else
    {
        leftNode = [_horizontalLayoutChains objectForKey:nvLeftPointer];
        if (nil == leftNode)
        {
            leftNode = [[AlLayoutChainNode alloc] initWithSubView:leftSubView];
            [_horizontalLayoutChains setObject:leftNode forKey:nvLeftPointer];
        }
    }
    
    [[rightNode.nextNodes objectAtIndex:0] addObject:leftNode];
    [[leftNode.nextNodes objectAtIndex:1] addObject:rightNode];   
}

- (void) setLayoutConstraintOfSubView : (UIView*) leftSubView
                             toLeftOf : (UIView*) rightSubView
{
    if (nil == leftSubView) return;
    
    AlLayoutChainNode* rightNode;
    AlLayoutChainNode* leftNode;
    
    NSValue* nvLeftPointer = [NSValue valueWithPointer:(void*)leftSubView];
    leftNode = [_horizontalLayoutChains objectForKey:nvLeftPointer];
    if (nil == leftNode)
    {
        leftNode = [[AlLayoutChainNode alloc] initWithSubView:leftSubView];
        [_horizontalLayoutChains setObject:leftNode forKey:nvLeftPointer];
    }
    
    NSValue* nvRightPointer = [NSValue valueWithPointer:(void*)rightSubView];
    if (nil == rightSubView)
    {
        rightNode = nil;
    }
    else
    {
        rightNode = [_horizontalLayoutChains objectForKey:nvRightPointer];
        if (nil == rightNode)
        {
            rightNode = [[AlLayoutChainNode alloc] initWithSubView:rightSubView];
            [_horizontalLayoutChains setObject:rightNode forKey:nvRightPointer];
        }
    }
    
    [[rightNode.nextNodes objectAtIndex:0] addObject:leftNode];
    [[leftNode.nextNodes objectAtIndex:1] addObject:rightNode];
}

- (void) setLayoutConstraintOfSubView : (UIView*) aboveSubView
                                above : (UIView*) belowSubView
{
    if (nil == aboveSubView) return;
    
    AlLayoutChainNode* belowNode;
    AlLayoutChainNode* aboveNode;
    
    NSValue* nvAbovePointer = [NSValue valueWithPointer:(void*)aboveSubView];
    aboveNode = [_verticalLayoutChains objectForKey:nvAbovePointer];
    if (nil == aboveNode)
    {
        aboveNode = [[AlLayoutChainNode alloc] initWithSubView:aboveSubView];
        [_verticalLayoutChains setObject:aboveNode forKey:nvAbovePointer];
    }
    
    NSValue* nvBelowPointer = [NSValue valueWithPointer:(void*)belowSubView];
    if (nil == belowSubView)
    {
        belowNode = nil;
    }
    else
    {
        belowNode = [_verticalLayoutChains objectForKey:nvBelowPointer];
        if (nil == belowNode)
        {
            belowNode = [[AlLayoutChainNode alloc] initWithSubView:belowSubView];
            [_verticalLayoutChains setObject:belowNode forKey:nvBelowPointer];
        }
    }
    
    [[belowNode.nextNodes objectAtIndex:0] addObject:aboveNode];
    [[aboveNode.nextNodes objectAtIndex:1] addObject:belowNode];
}

- (void) setLayoutConstraintOfSubView : (UIView*) belowSubView
                                below : (UIView*) aboveSubView
{
    if (nil == belowSubView) return;
    
    AlLayoutChainNode* belowNode;
    AlLayoutChainNode* aboveNode;
    
    NSValue* nvBelowPointer = [NSValue valueWithPointer:(void*)belowSubView];
    belowNode = [_verticalLayoutChains objectForKey:nvBelowPointer];
    if (nil == belowNode)
    {
        belowNode = [[AlLayoutChainNode alloc] initWithSubView:belowSubView];
        [_verticalLayoutChains setObject:belowNode forKey:nvBelowPointer];
    }
    
    NSValue* nvAbovePointer = [NSValue valueWithPointer:(void*)aboveSubView];
    if (nil == aboveSubView)
    {
        aboveNode = nil;
    }
    else
    {
        aboveNode = [_verticalLayoutChains objectForKey:nvAbovePointer];
        if (nil == aboveNode)
        {
            aboveNode = [[AlLayoutChainNode alloc] initWithSubView:aboveSubView];
            [_verticalLayoutChains setObject:aboveNode forKey:nvAbovePointer];
        }
    }
    
    [[belowNode.nextNodes objectAtIndex:0] addObject:aboveNode];
    [[aboveNode.nextNodes objectAtIndex:1] addObject:belowNode];
}

- (void) setLayoutConstraintOfSubView : (UIView*) subView
                           withAnchor : (EnumLayoutAnchor) anchor
{
    if (nil == subView) return;
    
    NSMutableArray* pLayoutChainRoots;
    NSMutableDictionary* pLayoutChain;
    
    switch (anchor)
    {
        case ParentBottom:
        case ParentTop:
        case ParentVerticalCenter:
            pLayoutChain = _verticalLayoutChains;
            pLayoutChainRoots = _verticalLayoutChainRoots;
            break;
        case ParentRight:
        case ParentLeft:
        case ParentHorizontalCenter:
            pLayoutChain = _horizontalLayoutChains;
            pLayoutChainRoots = _horizontalLayoutChainRoots;
            break;

    }
    
    AlLayoutChainNode* thisNode;
    NSValue* nvPointer = [NSValue valueWithPointer:(void*)subView];
    thisNode = [pLayoutChain objectForKey:nvPointer];
    if (nil == thisNode)
    {
        thisNode = [[AlLayoutChainNode alloc] initWithSubView:subView];
        [pLayoutChain setObject:thisNode forKey:nvPointer];
    }
    
    [pLayoutChainRoots addObject:thisNode];
    
    NSNumber* nnLayoutFlag = [thisNode valueOfKVPair:KEY_LAYOUT_FLAG];
    if (nil == nnLayoutFlag)
    {
        nnLayoutFlag = [NSNumber numberWithInt:anchor];
        [thisNode setKVPair:nnLayoutFlag key:KEY_LAYOUT_FLAG];
    }
    else
    {
        nnLayoutFlag = [NSNumber numberWithInt: (anchor | [nnLayoutFlag intValue])];
        [thisNode setKVPair:nnLayoutFlag key:KEY_LAYOUT_FLAG];
    }
    
}

///+ (void) clearLayoutChainGraph : (NSDictionary*) graph;

- (BOOL) canBeLayoutChainRootCandidate : (AlLayoutChainNode*) node
{
    if (nil == node)
    {
        return NO;
    }

    if ([[node.nextNodes objectAtIndex:0] count] == 0)
    {
        for (AlLayoutChainNode* iNode in [node.nextNodes objectAtIndex:1])
        {
            if ([[iNode.nextNodes objectAtIndex:0] count] > 1)
            {
                return NO;
            }
        }
    }
    else if ([[node.nextNodes objectAtIndex:1] count] == 0)
    {
        for (AlLayoutChainNode* iNode in [node.nextNodes objectAtIndex:0])
        {
            if ([[iNode.nextNodes objectAtIndex:1] count] > 1)
            {
                return NO;
            }
        }
    }
    else
    {
        return NO;
    }
    
    return YES;
}

- (CGFloat) recursiveFindMaxWidthOfHorizontalChain : (AlLayoutChainNode*) curNode
                                         direction : (int) direction
                                       curPosition : (CGFloat) curPosition
                                  ///!!!framesOfChildren : (NSDictionary*) framesOfChildren
{
    AlLayoutParameter* lp = [curNode.subView valueOfKVPair:KEY_LAYOUTPARAMETER];
    
    float mySize = [curNode.subView measuredPreferSize].width;
    mySize += lp.marginLeft;
    mySize += lp.marginRight;
    
    CGRect frame;
    NSValue* nvFrame = [curNode.subView valueOfKVPair:KEY_LAYOUT_FRAME];
    if (nil == nvFrame)
    {
        frame = CGRectMake(0, NA_RANGE, 0, NA_RANGE);
    }
    else
    {
        frame = [nvFrame CGRectValue];
    }
    
    if (0 == direction)
    {
        frame.origin.x = curPosition - lp.marginRight - [curNode.subView measuredPreferSize].width;
        frame.size.width = [curNode.subView measuredPreferSize].width;
        
        curPosition -= mySize;
    }
    else
    {
        frame.origin.x = curPosition + lp.marginLeft;
        frame.size.width = [curNode.subView measuredPreferSize].width;
        
        curPosition += mySize;
    }
    nvFrame = [NSValue valueWithCGRect:frame];
    [curNode.subView setKVPair:nvFrame key:KEY_LAYOUT_FRAME];
    
    float maxSubTotalSize = 0;
    for (AlLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
    {
        float subTotalSize = [self recursiveFindMaxWidthOfHorizontalChain : nextNode
                                                                direction : direction
                                                              curPosition : curPosition];
        
        if (subTotalSize > maxSubTotalSize)
        {
            maxSubTotalSize = subTotalSize;
        }
    }
    
    return mySize + maxSubTotalSize;
}

- (void) recursiveOffsetHorizontalChains : (AlLayoutChainNode*) curNode
                               direction : (int) direction
                                  offset : (CGFloat) offset
                        ///!!!framesOfChildren : (NSDictionary*) framesOfChildren;
{
    if (nil == curNode) return;
    
    NSValue* nvFrame = [curNode.subView valueOfKVPair:KEY_LAYOUT_FRAME];
    CGRect frame = [nvFrame CGRectValue];
    frame.origin.x += offset;
    nvFrame = [NSValue valueWithCGRect:frame];
    [curNode.subView setKVPair:nvFrame key:KEY_LAYOUT_FRAME];
    
    for (AlLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
    {
        [self recursiveOffsetHorizontalChains : nextNode
                                    direction : direction
                                       offset : offset];
    }
}

- (CGFloat) recursiveFindMaxHeightOfVerticalChain : (AlLayoutChainNode*) curNode
                                        direction : (int) direction
                                      curPosition : (CGFloat) curPosition
                                 ///!!!framesOfChildren : (NSDictionary*) framesOfChildren;
{
    AlLayoutParameter* lp = [curNode.subView valueOfKVPair:KEY_LAYOUTPARAMETER];
    
    float mySize = [curNode.subView measuredPreferSize].height;
    mySize += lp.marginTop;
    mySize += lp.marginBottom;
    
    CGRect frame;
    NSValue* nvFrame = [curNode.subView valueOfKVPair:KEY_LAYOUT_FRAME];
    if (nil == nvFrame)
    {
        frame = CGRectMake(NA_RANGE, 0, NA_RANGE, 0);
    }
    else
    {
        frame = [nvFrame CGRectValue];
    }
    
    if (0 == direction)
    {
        frame.origin.y = curPosition - lp.marginBottom - [curNode.subView measuredPreferSize].height;
        frame.size.height = [curNode.subView measuredPreferSize].height;
        
        curPosition -= mySize;
    }
    else
    {
        frame.origin.y = curPosition + lp.marginTop;
        frame.size.height = [curNode.subView measuredPreferSize].height;
        
        curPosition += mySize;
    }
    nvFrame = [NSValue valueWithCGRect:frame];
    [curNode.subView setKVPair:nvFrame key:KEY_LAYOUT_FRAME];
    
    float maxSubTotalSize = 0;
    for (AlLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
    {
        float subTotalSize = [self recursiveFindMaxHeightOfVerticalChain : nextNode
                                                                direction : direction
                                                              curPosition : curPosition];
        
        if (subTotalSize > maxSubTotalSize)
        {
            maxSubTotalSize = subTotalSize;
        }
    }
    
    return mySize + maxSubTotalSize;
}

- (void) recursiveOffsetVerticalChains : (AlLayoutChainNode*) curNode
                             direction : (int) direction
                                offset : (CGFloat) offset
                      ///!!!framesOfChildren : (NSDictionary*) framesOfChildren;
{
    if (nil == curNode) return;
    
    NSValue* nvFrame = [curNode.subView valueOfKVPair:KEY_LAYOUT_FRAME];
    CGRect frame = [nvFrame CGRectValue];
    frame.origin.y += offset;
    nvFrame = [NSValue valueWithCGRect:frame];
    [curNode.subView setKVPair:nvFrame key:KEY_LAYOUT_FRAME];
    
    for (AlLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
    {
        [self recursiveOffsetVerticalChains : nextNode
                                    direction : direction
                                       offset : offset];
    }
}

- (void) onLayout
{
    // Measure all children & Create nodes for children that not exist in any constraints :
    for (UIView* subView in _subViews)
    {
        [subView setKVPair:nil key:KEY_LAYOUT_FRAME];
        
        NSValue* nvPointer = [NSValue valueWithPointer:(void*)subView];
        AlLayoutChainNode* node = [_horizontalLayoutChains objectForKey:nvPointer];
        if (nil == node)
        {
            node = [[AlLayoutChainNode alloc] initWithSubView:subView];
            [_horizontalLayoutChains setObject:node forKey:nvPointer];
        }
        
        node = [_verticalLayoutChains objectForKey:nvPointer];
        if (nil == node)
        {
            node = [[AlLayoutChainNode alloc] initWithSubView:subView];
            [_verticalLayoutChains setObject:node forKey:nvPointer];
        }
    }
    
    // Horizontal :
    
    // Measure max width of all chains:
    float widthNeeded = 0.0f;
    
    for (AlLayoutChainNode* node in _horizontalLayoutChainRoots)
    {
        float widthOfThisChain;
        
        NSNumber* nnLayoutFlag = [node valueOfKVPair:KEY_LAYOUT_FLAG];
        if (nil != nnLayoutFlag)
        {
            int layoutFlag = [nnLayoutFlag intValue];
            if (layoutFlag & ParentRight)
            {
                widthOfThisChain = [self recursiveFindMaxWidthOfHorizontalChain:node direction:0 curPosition:0.0f];
            }
            else if (layoutFlag & ParentHorizontalCenter)
            {
                AlLayoutParameter* lp = [node.subView valueOfKVPair:KEY_LAYOUTPARAMETER];
                float boundWidthOfRoot = [node.subView measuredPreferSize].width;
                boundWidthOfRoot += lp.marginLeft;
                boundWidthOfRoot += lp.marginRight;
                
                float halfWidth0 = [self recursiveFindMaxWidthOfHorizontalChain:node direction:0 curPosition:boundWidthOfRoot]
                                - [node.subView measuredPreferSize].width / 2
                                - lp.marginRight;
                float halfWidth1 = [self recursiveFindMaxWidthOfHorizontalChain:node direction:1 curPosition:0.0f]
                                - [node.subView measuredPreferSize].width / 2
                                - lp.marginLeft;
                if (halfWidth0 > halfWidth1)
                {
                    widthOfThisChain = halfWidth0 * 2;
                }
                else
                {
                    widthOfThisChain = halfWidth1 * 2;
                }
            }
            else
            {
                widthOfThisChain = [self recursiveFindMaxWidthOfHorizontalChain:node direction:1 curPosition:0.0f];
            }
        }
        else
        {
            widthOfThisChain = [self recursiveFindMaxWidthOfHorizontalChain:node direction:1 curPosition:0.0f];
        }
        
        if (widthOfThisChain > widthNeeded)
        {
            widthNeeded = widthOfThisChain;
        }
    }
    
    // Find in other chains, root of which not exists in horizontalLayoutChainRoots :
    NSEnumerator* enumerator = [_horizontalLayoutChains keyEnumerator];
    id key;
    while ((key = [enumerator nextObject]))
    {
        AlLayoutChainNode* node = [_horizontalLayoutChains objectForKey:key];
        
        if (NO == [self canBeLayoutChainRootCandidate:node])
        {
            continue;
        }
        
        if (YES == [_horizontalLayoutChainRoots containsObject:node])
        {
            continue;
        }
        
        NSValue* nvFrame = [node.subView valueOfKVPair:KEY_LAYOUT_FRAME];
        if (nil != nvFrame && [nvFrame CGRectValue].origin.x != NA_RANGE)
        {
            continue;
        }
        
        [_horizontalLayoutChainRoots addObject:node];
        
        float widthOfThisChain;
        if (0 == [[node.nextNodes objectAtIndex:0] count])
        {
            widthOfThisChain = [self recursiveFindMaxWidthOfHorizontalChain:node direction:1 curPosition:0.0f];
        }
        else
        {
            widthOfThisChain = [self recursiveFindMaxWidthOfHorizontalChain:node direction:0 curPosition:0.0f];
        }
        if (widthOfThisChain > widthNeeded)
        {
            widthNeeded = widthOfThisChain;
        }
    }
    
    // Layout in horizontal :
    for (AlLayoutChainNode* node in _horizontalLayoutChainRoots)
    {
        if (nil == node) continue;
        
        float offset;
        int direction = 1;
        
        NSValue* nvFrame = [node.subView valueOfKVPair:KEY_LAYOUT_FRAME];
        NSNumber* nnLayoutFlag = [node valueOfKVPair:KEY_LAYOUT_FLAG];
        AlLayoutParameter* lp = [node.subView valueOfKVPair:KEY_LAYOUTPARAMETER];
        
        if (nil != nnLayoutFlag)
        {
            int layoutFlag = [nnLayoutFlag intValue];
            if (layoutFlag & ParentRight)
            {
                offset = widthNeeded - lp.marginRight - [nvFrame CGRectValue].size.width
                        - [nvFrame CGRectValue].origin.x;
                direction = 0;
            }
            else if (layoutFlag & ParentHorizontalCenter)
            {
                offset = (widthNeeded - [nvFrame CGRectValue].size.width) / 2
                        - [nvFrame CGRectValue].origin.x;
                
                CGRect offsettedRect = [nvFrame CGRectValue];
                offsettedRect.origin.x -= offset;
                nvFrame = [NSValue valueWithCGRect:offsettedRect];
                [node.subView setKVPair:nvFrame key:KEY_LAYOUT_FRAME];
                
                [self recursiveOffsetHorizontalChains:node direction:0 offset:offset];
            }
            else if (layoutFlag & ParentLeft)
            {
                offset = lp.marginLeft - [nvFrame CGRectValue].origin.x;
            }
            else
            {
                if (0 == [[node.nextNodes objectAtIndex:0] count])
                {
                    offset = lp.marginLeft - [nvFrame CGRectValue].origin.x;
                }
                else
                {
                    offset = widthNeeded - lp.marginRight - [nvFrame CGRectValue].size.width
                            - [nvFrame CGRectValue].origin.x;
                    direction = 0;
                }
            }
        }
        else
        {
            if (0 == [[node.nextNodes objectAtIndex:0] count])
            {
                offset = lp.marginLeft - [nvFrame CGRectValue].origin.x;
            }
            else
            {
                offset = widthNeeded - lp.marginRight - [nvFrame CGRectValue].size.width
                        - [nvFrame CGRectValue].origin.x;
                direction = 0;
            }
        }
        
        [self recursiveOffsetHorizontalChains:node direction:direction offset:offset];
    }
    
    // Vertical:
    
    // Measure max height of all chains:
    float heightNeeded = 0.0f;
    
    for (AlLayoutChainNode* node in _verticalLayoutChainRoots)
    {
        float heightOfThisChain;
        
        NSNumber* nnLayoutFlag = [node valueOfKVPair:KEY_LAYOUT_FLAG];
        if (nil != nnLayoutFlag)
        {
            int layoutFlag = [nnLayoutFlag intValue];
            if (layoutFlag & ParentBottom)
            {
                heightOfThisChain = [self recursiveFindMaxHeightOfVerticalChain:node direction:0 curPosition:0.0f];
            }
            else if (layoutFlag & ParentVerticalCenter)
            {
                AlLayoutParameter* lp = [node.subView valueOfKVPair:KEY_LAYOUTPARAMETER];
                float boundHeightOfRoot = [node.subView measuredPreferSize].height;
                boundHeightOfRoot += lp.marginTop;
                boundHeightOfRoot += lp.marginBottom;
                
                float halfHeight0 = [self recursiveFindMaxHeightOfVerticalChain:node direction:0 curPosition:boundHeightOfRoot]
                                    - [node.subView measuredPreferSize].height / 2
                                    - lp.marginBottom;
                float halfHeight1 = [self recursiveFindMaxHeightOfVerticalChain:node direction:1 curPosition:0.0f]
                                    - [node.subView measuredPreferSize].height / 2
                                    - lp.marginTop;
                if (halfHeight0 > halfHeight1)
                {
                    heightOfThisChain = halfHeight0 * 2;
                }
                else
                {
                    heightOfThisChain = halfHeight1 * 2;
                }
            }
            else
            {
                heightOfThisChain = [self recursiveFindMaxHeightOfVerticalChain:node direction:1 curPosition:0.0f];
            }
        }
        else
        {
            heightOfThisChain = [self recursiveFindMaxHeightOfVerticalChain:node direction:1 curPosition:0.0f];
        }
        
        if (heightOfThisChain > heightNeeded)
        {
            heightNeeded = heightOfThisChain;
        }
    }
    
    // Find in other chains, root of which not exists in verticalLayoutChainRoots :
    enumerator = [_verticalLayoutChains keyEnumerator];
    while ((key = [enumerator nextObject]))
    {
        AlLayoutChainNode* node = [_verticalLayoutChains objectForKey:key];
        
        if (NO == [self canBeLayoutChainRootCandidate:node])
        {
            continue;
        }
        
        if (YES == [_verticalLayoutChainRoots containsObject:node])
        {
            continue;
        }
        
        NSValue* nvFrame = [node.subView valueOfKVPair:KEY_LAYOUT_FRAME];
        if (nil != nvFrame && [nvFrame CGRectValue].origin.y != NA_RANGE)
        {
            continue;
        }
        
        [_verticalLayoutChainRoots addObject:node];
        
        float heightOfThisChain;
        if (0 == [[node.nextNodes objectAtIndex:0] count])
        {
            heightOfThisChain = [self recursiveFindMaxHeightOfVerticalChain:node direction:1 curPosition:0.0f];
        }
        else
        {
            heightOfThisChain = [self recursiveFindMaxHeightOfVerticalChain:node direction:0 curPosition:0.0f];
        }
        if (heightOfThisChain > heightNeeded)
        {
            heightNeeded = heightOfThisChain;
        }
    }
    
    // Layout in vertical :
    for (AlLayoutChainNode* node in _verticalLayoutChainRoots)
    {
        if (nil == node) continue;
        
        float offset;
        int direction = 1;
        
        NSValue* nvFrame = [node.subView valueOfKVPair:KEY_LAYOUT_FRAME];
        NSNumber* nnLayoutFlag = [node valueOfKVPair:KEY_LAYOUT_FLAG];
        AlLayoutParameter* lp = [node.subView valueOfKVPair:KEY_LAYOUTPARAMETER];
        
        if (nil != nnLayoutFlag)
        {
            int layoutFlag = [nnLayoutFlag intValue];
            if (layoutFlag & ParentBottom)
            {
                offset = heightNeeded - lp.marginBottom - [nvFrame CGRectValue].size.height
                        - [nvFrame CGRectValue].origin.y;
                direction = 0;
            }
            else if (layoutFlag & ParentVerticalCenter)
            {
                offset = (heightNeeded - [nvFrame CGRectValue].size.height) / 2
                        - [nvFrame CGRectValue].origin.y;
                
                CGRect offsettedRect = [nvFrame CGRectValue];
                offsettedRect.origin.y -= offset;
                nvFrame = [NSValue valueWithCGRect:offsettedRect];
                [node.subView setKVPair:nvFrame key:KEY_LAYOUT_FRAME];
                
                [self recursiveOffsetVerticalChains:node direction:0 offset:offset];
            }
            else if (layoutFlag & ParentTop)
            {
                offset = lp.marginTop - [nvFrame CGRectValue].origin.y;
            }
            else
            {
                if (0 == [[node.nextNodes objectAtIndex:0] count])
                {
                    offset = lp.marginTop - [nvFrame CGRectValue].origin.y;
                }
                else
                {
                    offset = heightNeeded - lp.marginBottom - [nvFrame CGRectValue].size.height
                            - [nvFrame CGRectValue].origin.y;
                    direction = 0;
                }
            }
        }
        else
        {
            if (0 == [[node.nextNodes objectAtIndex:0] count])
            {
                offset = lp.marginTop - [nvFrame CGRectValue].origin.y;
            }
            else
            {
                offset = heightNeeded - lp.marginBottom - [nvFrame CGRectValue].size.height
                        - [nvFrame CGRectValue].origin.y;
                direction = 0;
            }
        }
        
        [self recursiveOffsetVerticalChains:node direction:direction offset:offset];
    }
    
    ////////
    for (UIView* subView in _subViews)
    {
        NSValue* nvFrame = [subView valueOfKVPair:KEY_LAYOUT_FRAME];
        subView.frame = [nvFrame CGRectValue];
    }
    
    _measuredPreferSize = CGSizeMake(widthNeeded, heightNeeded);
    
}

@end
