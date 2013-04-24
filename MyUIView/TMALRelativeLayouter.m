//
//  UIRelativeLayouter.m
//  MyUIView
//
//  Created by DomQiu on 13-4-17.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "TMALRelativeLayouter.h"
#import "TMALLayoutChainNode.h"
#import "UIView+AlViewLayout.h"
#import "NSObject_KVContainer.h"

///!!!static NSString* KEY_LAYOUT_FRAME = @"KEY_layoutFrame";
///!!!static NSString* KEY_LAYOUT_FLAG = @"KEY_layoutFlag";

@implementation TMALRelativeLayouter

- (id) init
{
    self = [super init];
    if (nil != self)
    {
        _horizontalLayoutChainRoots = [[NSMutableArray alloc] init];
        _verticalLayoutChainRoots = [[NSMutableArray alloc] init];
        _horizontalLayoutChains = [[NSMutableDictionary alloc] init];
        _verticalLayoutChains = [[NSMutableDictionary alloc] init];
        
        _layoutFlagsOfNode = [[NSMutableDictionary alloc] init];
        _frameOfSubLayouter = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void) dealloc
{
    [_horizontalLayoutChainRoots removeAllObjects];
    [_verticalLayoutChainRoots removeAllObjects];
    [_horizontalLayoutChains removeAllObjects];
    [_verticalLayoutChains removeAllObjects];
    
    [_layoutFlagsOfNode removeAllObjects];
    [_frameOfSubLayouter removeAllObjects];
}

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) rightSubLayouter
                            toRightOf : (TMALLayouter*) leftSubLayouter
{
    if (nil == rightSubLayouter) return;
    
    TMALLayoutChainNode* rightNode;
    TMALLayoutChainNode* leftNode;
    
    NSValue* nvRightPointer = [NSValue valueWithPointer:(void*)rightSubLayouter];
    rightNode = [_horizontalLayoutChains objectForKey:nvRightPointer];
    if (nil == rightNode)
    {
        rightNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:rightSubLayouter];
        [_horizontalLayoutChains setObject:rightNode forKey:nvRightPointer];
    }
    
    NSValue* nvLeftPointer = [NSValue valueWithPointer:(void*)leftSubLayouter];
    if (nil == leftSubLayouter)
    {
        leftNode = nil;
    }
    else
    {
        leftNode = [_horizontalLayoutChains objectForKey:nvLeftPointer];
        if (nil == leftNode)
        {
            leftNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:leftSubLayouter];
            [_horizontalLayoutChains setObject:leftNode forKey:nvLeftPointer];
        }
    }
    
    [[rightNode.nextNodes objectAtIndex:0] addObject:leftNode];
    [[leftNode.nextNodes objectAtIndex:1] addObject:rightNode];   
}

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) leftSubLayouter
                             toLeftOf : (TMALLayouter*) rightSubLayouter
{
    if (nil == leftSubLayouter) return;
    
    TMALLayoutChainNode* rightNode;
    TMALLayoutChainNode* leftNode;
    
    NSValue* nvLeftPointer = [NSValue valueWithPointer:(void*)leftSubLayouter];
    leftNode = [_horizontalLayoutChains objectForKey:nvLeftPointer];
    if (nil == leftNode)
    {
        leftNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:leftSubLayouter];
        [_horizontalLayoutChains setObject:leftNode forKey:nvLeftPointer];
    }
    
    NSValue* nvRightPointer = [NSValue valueWithPointer:(void*)rightSubLayouter];
    if (nil == rightSubLayouter)
    {
        rightNode = nil;
    }
    else
    {
        rightNode = [_horizontalLayoutChains objectForKey:nvRightPointer];
        if (nil == rightNode)
        {
            rightNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:rightSubLayouter];
            [_horizontalLayoutChains setObject:rightNode forKey:nvRightPointer];
        }
    }
    
    [[rightNode.nextNodes objectAtIndex:0] addObject:leftNode];
    [[leftNode.nextNodes objectAtIndex:1] addObject:rightNode];
}

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) aboveSubLayouter
                                above : (TMALLayouter*) belowSubLayouter
{
    if (nil == aboveSubLayouter) return;
    
    TMALLayoutChainNode* belowNode;
    TMALLayoutChainNode* aboveNode;
    
    NSValue* nvAbovePointer = [NSValue valueWithPointer:(void*)aboveSubLayouter];
    aboveNode = [_verticalLayoutChains objectForKey:nvAbovePointer];
    if (nil == aboveNode)
    {
        aboveNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:aboveSubLayouter];
        [_verticalLayoutChains setObject:aboveNode forKey:nvAbovePointer];
    }
    
    NSValue* nvBelowPointer = [NSValue valueWithPointer:(void*)belowSubLayouter];
    if (nil == belowSubLayouter)
    {
        belowNode = nil;
    }
    else
    {
        belowNode = [_verticalLayoutChains objectForKey:nvBelowPointer];
        if (nil == belowNode)
        {
            belowNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:belowSubLayouter];
            [_verticalLayoutChains setObject:belowNode forKey:nvBelowPointer];
        }
    }
    
    [[belowNode.nextNodes objectAtIndex:0] addObject:aboveNode];
    [[aboveNode.nextNodes objectAtIndex:1] addObject:belowNode];
}

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) belowSubLayouter
                                below : (TMALLayouter*) aboveSubLayouter
{
    if (nil == belowSubLayouter) return;
    
    TMALLayoutChainNode* belowNode;
    TMALLayoutChainNode* aboveNode;
    
    NSValue* nvBelowPointer = [NSValue valueWithPointer:(void*)belowSubLayouter];
    belowNode = [_verticalLayoutChains objectForKey:nvBelowPointer];
    if (nil == belowNode)
    {
        belowNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:belowSubLayouter];
        [_verticalLayoutChains setObject:belowNode forKey:nvBelowPointer];
    }
    
    NSValue* nvAbovePointer = [NSValue valueWithPointer:(void*)aboveSubLayouter];
    if (nil == aboveSubLayouter)
    {
        aboveNode = nil;
    }
    else
    {
        aboveNode = [_verticalLayoutChains objectForKey:nvAbovePointer];
        if (nil == aboveNode)
        {
            aboveNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:aboveSubLayouter];
            [_verticalLayoutChains setObject:aboveNode forKey:nvAbovePointer];
        }
    }
    
    [[belowNode.nextNodes objectAtIndex:0] addObject:aboveNode];
    [[aboveNode.nextNodes objectAtIndex:1] addObject:belowNode];
}

- (void) setLayoutConstraintOfSubLayouter : (TMALLayouter*) subLayouter
                           withAnchor : (EnumLayoutAnchor) anchor
{
    if (nil == subLayouter) return;
    
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
    
    TMALLayoutChainNode* thisNode;
    NSValue* nvPointer = [NSValue valueWithPointer:(void*)subLayouter];
    thisNode = [pLayoutChain objectForKey:nvPointer];
    if (nil == thisNode)
    {
        thisNode = [[TMALLayoutChainNode alloc] initWithSubLayouter:subLayouter];
        [pLayoutChain setObject:thisNode forKey:nvPointer];
    }
    
    [pLayoutChainRoots addObject:thisNode];
    
    NSValue* nsPtrNode = [NSValue valueWithPointer:(void*)thisNode];
    NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:nsPtrNode];
    if (nil == nnLayoutFlag)
    {
        nnLayoutFlag = [NSNumber numberWithInt:anchor];
    }
    else
    {
        nnLayoutFlag = [NSNumber numberWithInt: (anchor | [nnLayoutFlag intValue])];
    }
    [_layoutFlagsOfNode setObject:nnLayoutFlag forKey:nsPtrNode];
}

///+ (void) clearLayoutChainGraph : (NSDictionary*) graph;

- (BOOL) canBeLayoutChainRootCandidate : (TMALLayoutChainNode*) node
{
    if (nil == node)
    {
        return NO;
    }

    if ([[node.nextNodes objectAtIndex:0] count] == 0)
    {
        for (TMALLayoutChainNode* iNode in [node.nextNodes objectAtIndex:1])
        {
            if ([[iNode.nextNodes objectAtIndex:0] count] > 1)
            {
                return NO;
            }
        }
    }
    else if ([[node.nextNodes objectAtIndex:1] count] == 0)
    {
        for (TMALLayoutChainNode* iNode in [node.nextNodes objectAtIndex:0])
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

- (CGFloat) recursiveFindMaxWidthOfHorizontalChain : (TMALLayoutChainNode*) curNode
                                         direction : (int) direction
                                       curPosition : (CGFloat) curPosition
                                  ///!!!framesOfChildren : (NSDictionary*) framesOfChildren
{
    TMALLayoutParameter lp = curNode.subLayouter.layoutParameter;
    
    float mySize = [curNode.subLayouter measuredPreferSize].width;
    mySize += lp.marginLeft;
    mySize += lp.marginRight;
    
    NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)curNode.subLayouter];
    CGRect frame;
    NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
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
        frame.origin.x = curPosition - lp.marginRight - [curNode.subLayouter measuredPreferSize].width;
        frame.size.width = [curNode.subLayouter measuredPreferSize].width;
        
        curPosition -= mySize;
    }
    else
    {
        frame.origin.x = curPosition + lp.marginLeft;
        frame.size.width = [curNode.subLayouter measuredPreferSize].width;
        
        curPosition += mySize;
    }
    nvFrame = [NSValue valueWithCGRect:frame];
    [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
    
    float maxSubTotalSize = 0;
    for (TMALLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
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

- (void) recursiveOffsetHorizontalChains : (TMALLayoutChainNode*) curNode
                               direction : (int) direction
                                  offset : (CGFloat) offset
                        ///!!!framesOfChildren : (NSDictionary*) framesOfChildren;
{
    if (nil == curNode) return;
    
    NSValue* nsPtrLayouter = [NSValue valueWithPointer : (void*)curNode.subLayouter];
    NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrLayouter];
    CGRect frame = [nvFrame CGRectValue];
    frame.origin.x += offset;
    nvFrame = [NSValue valueWithCGRect:frame];
    [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrLayouter];
    
    for (TMALLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
    {
        [self recursiveOffsetHorizontalChains : nextNode
                                    direction : direction
                                       offset : offset];
    }
}

- (void) recursiveAdustForAlignParentHorizontalAnchors : (TMALLayoutChainNode*) curNode
                                             direction : (int) direction
                                                offset : (CGFloat) offset
{
    NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)curNode.subLayouter];
    NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
    CGRect frame = [nvFrame CGRectValue];
    
    NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)curNode]];
    int layoutFlag = (nil == nnLayoutFlag ? 0 : [nnLayoutFlag intValue]);
    if (0.0f > offset)
    {
        if (kLayoutWrapContent == curNode.subLayouter.layoutParameter.horizontalStretch)
        {
            if (layoutFlag & ParentRight)
            {
                return;
            }
            else
            {
                frame.origin.x += offset;
            }
        }
        else if (kLayoutFillParent == curNode.subLayouter.layoutParameter.horizontalStretch)
        {
            frame.origin.x += offset;
            frame.size.width -= offset;
            
            [curNode.subLayouter setLayoutInvalid];
            [curNode.subLayouter layout:frame.size];
        }
    }
    else
    {
        if (kLayoutWrapContent == curNode.subLayouter.layoutParameter.horizontalStretch)
        {
            if (layoutFlag & ParentLeft)
            {
                return;
            }
            else
            {
                frame.origin.x += offset;
            }
        }
        else if (kLayoutFillParent == curNode.subLayouter.layoutParameter.horizontalStretch)
        {
            frame.size.width += offset;
            
            [curNode.subLayouter setLayoutInvalid];
            [curNode.subLayouter layout:frame.size];
        }
    }
    
    nvFrame = [NSValue valueWithCGRect:frame];
    [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
    
    if (kLayoutFillParent != curNode.subLayouter.layoutParameter.horizontalStretch)
    {
        for (TMALLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
        {
            [self recursiveAdustForAlignParentHorizontalAnchors:nextNode direction:direction offset:offset];
        }
    }
}

- (CGFloat) recursiveFindMaxHeightOfVerticalChain : (TMALLayoutChainNode*) curNode
                                        direction : (int) direction
                                      curPosition : (CGFloat) curPosition
                                 ///!!!framesOfChildren : (NSDictionary*) framesOfChildren;
{
    TMALLayoutParameter lp = curNode.subLayouter.layoutParameter;
    
    float mySize = [curNode.subLayouter measuredPreferSize].height;
    mySize += lp.marginTop;
    mySize += lp.marginBottom;
    
    NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)curNode.subLayouter];
    CGRect frame;
    NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
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
        frame.origin.y = curPosition - lp.marginBottom - [curNode.subLayouter measuredPreferSize].height;
        frame.size.height = [curNode.subLayouter measuredPreferSize].height;
        
        curPosition -= mySize;
    }
    else
    {
        frame.origin.y = curPosition + lp.marginTop;
        frame.size.height = [curNode.subLayouter measuredPreferSize].height;
        
        curPosition += mySize;
    }
    nvFrame = [NSValue valueWithCGRect:frame];
    [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
    
    float maxSubTotalSize = 0;
    for (TMALLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
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

- (void) recursiveOffsetVerticalChains : (TMALLayoutChainNode*) curNode
                             direction : (int) direction
                                offset : (CGFloat) offset
                      ///!!!framesOfChildren : (NSDictionary*) framesOfChildren;
{
    if (nil == curNode) return;
    
    NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)curNode.subLayouter];
    NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
    CGRect frame = [nvFrame CGRectValue];
    frame.origin.y += offset;
    nvFrame = [NSValue valueWithCGRect:frame];
    [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
    
    for (TMALLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
    {
        [self recursiveOffsetVerticalChains : nextNode
                                    direction : direction
                                       offset : offset];
    }
}

- (void) recursiveAdustForAlignParentVerticalAnchors : (TMALLayoutChainNode*) curNode
                                             direction : (int) direction
                                                offset : (CGFloat) offset
{
    //bool continueRecursing = true;
    
    NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)curNode.subLayouter];
    NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
    CGRect frame = [nvFrame CGRectValue];
    
    NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)curNode]];
    int layoutFlag = (nil == nnLayoutFlag ? 0 : [nnLayoutFlag intValue]);
    if (0.0f > offset)
    {
        if (kLayoutWrapContent == curNode.subLayouter.layoutParameter.verticalStretch)
        {
            if (layoutFlag & ParentBottom)
            {
                return;
            }
            else
            {
                frame.origin.y += offset;
            }
        }
        else if (kLayoutFillParent == curNode.subLayouter.layoutParameter.verticalStretch)
        {
            frame.origin.y += offset;
            frame.size.height -= offset;
        }
    }
    else
    {
        if (kLayoutWrapContent == curNode.subLayouter.layoutParameter.verticalStretch)
        {
            if (layoutFlag & ParentTop)
            {
                return;
            }
            else
            {
                frame.origin.y += offset;
            }
        }
        else if (kLayoutFillParent == curNode.subLayouter.layoutParameter.verticalStretch)
        {
            frame.size.height += offset;
        }
    }
    
    nvFrame = [NSValue valueWithCGRect:frame];
    [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
    
    if (kLayoutFillParent != curNode.subLayouter.layoutParameter.verticalStretch)
    {
        for (TMALLayoutChainNode* nextNode in [curNode.nextNodes objectAtIndex:direction])
        {
            [self recursiveAdustForAlignParentVerticalAnchors:nextNode direction:direction offset:offset];
        }
    }
}

- (void) onLayout : (CGSize) givenSize
{
    // Measure all children & Create nodes for children that not exist in any constraints :
    [_frameOfSubLayouter removeAllObjects];
    for (TMALLayouter* subLayouter in [_name2SubLayouterMap allValues])
    {
        NSValue* nvPointer = [NSValue valueWithPointer:(void*)subLayouter];
        TMALLayoutChainNode* node = [_horizontalLayoutChains objectForKey:nvPointer];
        if (nil == node)
        {
            node = [[TMALLayoutChainNode alloc] initWithSubLayouter:subLayouter];
            [_horizontalLayoutChains setObject:node forKey:nvPointer];
        }
        
        node = [_verticalLayoutChains objectForKey:nvPointer];
        if (nil == node)
        {
            node = [[TMALLayoutChainNode alloc] initWithSubLayouter:subLayouter];
            [_verticalLayoutChains setObject:node forKey:nvPointer];
        }
    }
    
    // Horizontal :
    
    // Measure max width of all chains:
    float widthNeeded = givenSize.width;
    
    for (TMALLayoutChainNode* node in _horizontalLayoutChainRoots)
    {
        float widthOfThisChain;
        
        NSValue* nsPtrNode = [NSValue valueWithPointer:(void*)node];
        NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:nsPtrNode];
        if (nil != nnLayoutFlag)
        {
            int layoutFlag = [nnLayoutFlag intValue];
            if (layoutFlag & ParentRight)
            {
                widthOfThisChain = [self recursiveFindMaxWidthOfHorizontalChain:node direction:0 curPosition:0.0f];
            }
            else if (layoutFlag & ParentHorizontalCenter)
            {
                TMALLayoutParameter lp = node.subLayouter.layoutParameter;
                float boundWidthOfRoot = [node.subLayouter measuredPreferSize].width;
                boundWidthOfRoot += lp.marginLeft;
                boundWidthOfRoot += lp.marginRight;
                
                float halfWidth0 = [self recursiveFindMaxWidthOfHorizontalChain:node direction:0 curPosition:boundWidthOfRoot]
                                - [node.subLayouter measuredPreferSize].width / 2
                                - lp.marginRight;
                float halfWidth1 = [self recursiveFindMaxWidthOfHorizontalChain:node direction:1 curPosition:0.0f]
                                - [node.subLayouter measuredPreferSize].width / 2
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
        TMALLayoutChainNode* node = [_horizontalLayoutChains objectForKey:key];
        
        if (NO == [self canBeLayoutChainRootCandidate:node])
        {
            continue;
        }
        
        if (YES == [_horizontalLayoutChainRoots containsObject:node])
        {
            continue;
        }
        
        NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)node.subLayouter];
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
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
    for (TMALLayoutChainNode* node in _horizontalLayoutChainRoots)
    {
        if (nil == node) continue;
        
        float offset;
        int direction = 1;
        
        NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)node.subLayouter];
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
        NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)node]];
        TMALLayoutParameter lp = node.subLayouter.layoutParameter;
        
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
                [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
                
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
    
    for (TMALLayoutChainNode* node in _horizontalLayoutChainRoots)
    {
        if (nil == node) continue;
        
        float offset;
        
        CGRect frame;
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:[NSValue valueWithPointer:(void*)node.subLayouter]];
        frame = [nvFrame CGRectValue];
        
        NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)node]];
        int layoutFlag = (nil == nnLayoutFlag ? 0 : [nnLayoutFlag intValue]);
        if (layoutFlag & ParentLeft)
        {
            offset = node.subLayouter.layoutParameter.marginLeft - frame.origin.x;
            [self recursiveAdustForAlignParentHorizontalAnchors:node direction:1 offset:offset];
        }
        else if (layoutFlag & ParentRight)
        {
            offset = widthNeeded - node.subLayouter.layoutParameter.marginRight - frame.origin.x - frame.size.width;
            [self recursiveAdustForAlignParentHorizontalAnchors:node direction:0 offset:offset];
        }
    }
    
    // Vertical:
    
    // Measure max height of all chains:
    float heightNeeded = givenSize.height;
    
    for (TMALLayoutChainNode* node in _verticalLayoutChainRoots)
    {
        float heightOfThisChain;
        
        NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)node]];
        if (nil != nnLayoutFlag)
        {
            int layoutFlag = [nnLayoutFlag intValue];
            if (layoutFlag & ParentBottom)
            {
                heightOfThisChain = [self recursiveFindMaxHeightOfVerticalChain:node direction:0 curPosition:0.0f];
            }
            else if (layoutFlag & ParentVerticalCenter)
            {
                TMALLayoutParameter lp = node.subLayouter.layoutParameter;
                float boundHeightOfRoot = [node.subLayouter measuredPreferSize].height;
                boundHeightOfRoot += lp.marginTop;
                boundHeightOfRoot += lp.marginBottom;
                
                float halfHeight0 = [self recursiveFindMaxHeightOfVerticalChain:node direction:0 curPosition:boundHeightOfRoot]
                                    - [node.subLayouter measuredPreferSize].height / 2
                                    - lp.marginBottom;
                float halfHeight1 = [self recursiveFindMaxHeightOfVerticalChain:node direction:1 curPosition:0.0f]
                                    - [node.subLayouter measuredPreferSize].height / 2
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
        TMALLayoutChainNode* node = [_verticalLayoutChains objectForKey:key];
        
        if (NO == [self canBeLayoutChainRootCandidate:node])
        {
            continue;
        }
        
        if (YES == [_verticalLayoutChainRoots containsObject:node])
        {
            continue;
        }
        
        NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)node.subLayouter];
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
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
    for (TMALLayoutChainNode* node in _verticalLayoutChainRoots)
    {
        if (nil == node) continue;
        
        float offset;
        int direction = 1;
        
        NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)node.subLayouter];
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
        NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)node]];
        TMALLayoutParameter lp = node.subLayouter.layoutParameter;
        
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
                [_frameOfSubLayouter setObject:nvFrame forKey:nsPtrNode];
                
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
    
    for (TMALLayoutChainNode* node in _verticalLayoutChainRoots)
    {
        if (nil == node) continue;
        
        float offset;
        
        CGRect frame;
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:[NSValue valueWithPointer:(void*)node.subLayouter]];
        frame = [nvFrame CGRectValue];
        
        NSNumber* nnLayoutFlag = [_layoutFlagsOfNode objectForKey:[NSValue valueWithPointer:(void*)node]];
        int layoutFlag = (nil == nnLayoutFlag ? 0 : [nnLayoutFlag intValue]);
        if (layoutFlag & ParentTop)
        {
            offset = node.subLayouter.layoutParameter.marginTop - frame.origin.y;
            [self recursiveAdustForAlignParentVerticalAnchors:node direction:1 offset:offset];
        }
        else if (layoutFlag & ParentBottom)
        {
            offset = heightNeeded - node.subLayouter.layoutParameter.marginBottom - frame.origin.y - frame.size.height;
            [self recursiveAdustForAlignParentVerticalAnchors:node direction:0 offset:offset];
        }
    }
    
    ////////
    for (TMALLayouter* subLayouter in [_name2SubLayouterMap allValues])
    {
        NSValue* nsPtrNode = [NSValue valueWithPointer : (void*)subLayouter];
        NSValue* nvFrame = [_frameOfSubLayouter objectForKey:nsPtrNode];
        subLayouter.layoutedFrame = [nvFrame CGRectValue];
    }
    
    [self setMeasuredPreferSize:CGSizeMake(widthNeeded, heightNeeded)];
}

@end
