//
//  AlViewRelativeLayout.cpp
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#include <stdlib.h>
#include "AlViewRelativeLayout.h"


void AlViewRelativeLayout::addLayoutRelation (int leftOperandID, int rightOperandID, int layoutRelation)
{
#ifdef V2
    map<int, ChildPair>::iterator itrLeftOpr = children.find(leftOperandID);
    map<int, ChildPair>::iterator itrRightOpr = children.find(rightOperandID);
    AlViewLayout* thisOperand = (children.end() == itrLeftOpr ? NULL : itrLeftOpr->second.child);
    AlViewLayout* dependencyOperand = (children.end() == itrRightOpr ? NULL : itrRightOpr->second.child);
    if (NULL == thisOperand) return;
    
    map<AlViewLayout*, LayoutChainNode*>* pLayoutChains;
    map<LayoutChainNode*, AlViewLayout*>* pLayoutChainRoots;
    switch (layoutRelation)
    {
        case kLayoutRelationToLeftOf:
        case kLayoutRelationToRightOf:
        case kLayoutRelationAlignLeftWith:
        case kLayoutRelationAlignRightWith:
        case kLayoutRelationCenterParentHorizontal:
        case kLayoutRelationAlignParentLeft:
        case kLayoutRelationAlignParentRight:
            pLayoutChains = &horizontalLayoutChains;
            pLayoutChainRoots = &horizontalLayoutChainRoots;
            
            break;
        case kLayoutRelationAbove:
        case kLayoutRelationBelow:
        case kLayoutRelationAlignTopWith:
        case kLayoutRelationAlignBottomWith:
        case kLayoutRelationCenterParentVertical:
        case kLayoutRelationAlignParentBottom:
        case kLayoutRelationAlignParentTop:
            pLayoutChains = &verticalLayoutChains;
            pLayoutChainRoots = &verticalLayoutChainRoots;
            
            break;
    }
    
    LayoutChainNode* thisNode;
    map<AlViewLayout*, LayoutChainNode*>::iterator itrThisNode = pLayoutChains->find(thisOperand);
    if (pLayoutChains->end() == itrThisNode)
    {
        thisNode = new LayoutChainNode;
        thisNode->layouter = thisOperand;
        pLayoutChains->insert(make_pair(thisOperand, thisNode));
    }
    else
    {
        thisNode = itrThisNode->second;
    }
    
    LayoutChainNode* dependencyNode;
    if (NULL == dependencyOperand)
    {
        dependencyNode = NULL;
    }
    else
    {
        map<AlViewLayout*, LayoutChainNode*>::iterator itrDependencyNode = pLayoutChains->find(dependencyOperand);
        if (pLayoutChains->end() == itrDependencyNode)
        {
            dependencyNode = new LayoutChainNode;
            dependencyNode->layouter = dependencyOperand;
            pLayoutChains->insert(make_pair(dependencyOperand, dependencyNode));
        }
        else
        {
            dependencyNode = itrDependencyNode->second;
        }
    }
    
    switch (layoutRelation)
    {
        case kLayoutRelationCenterParentHorizontal:
        case kLayoutRelationCenterParentVertical:
            pLayoutChainRoots->insert(make_pair(thisNode, thisNode->layouter));
            
            if (layoutFlagsOfNode.end() == layoutFlagsOfNode.find(thisNode))
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, layoutRelation));
            }
            else
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, (layoutRelation | layoutFlagsOfNode[thisNode])));
            }
            
            break;
        case kLayoutRelationAlignParentLeft:
        case kLayoutRelationAlignParentTop:
        case kLayoutRelationAlignParentRight:
        case kLayoutRelationAlignParentBottom:
            pLayoutChainRoots->insert(make_pair(thisNode, thisNode->layouter));

            if (layoutFlagsOfNode.end() == layoutFlagsOfNode.find(thisNode))
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, layoutRelation));
            }
            else
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, (layoutRelation | layoutFlagsOfNode[thisNode])));
            }
            
            break;
        case kLayoutRelationToLeftOf:
        case kLayoutRelationAbove:
            thisNode->nextNodes[1].insert(make_pair(dependencyNode, dependencyNode->layouter));
            dependencyNode->nextNodes[0].insert(make_pair(thisNode, thisNode->layouter));
            
            break;
        case kLayoutRelationToRightOf:
        case kLayoutRelationBelow:
            thisNode->nextNodes[0].insert(make_pair(dependencyNode, dependencyNode->layouter));
            dependencyNode->nextNodes[1].insert(make_pair(thisNode, thisNode->layouter));
            
            break;
        case kLayoutRelationAlignLeftWith:
        case kLayoutRelationAlignTopWith:
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = thisNode->nextNodes[0].begin();
                 iter != thisNode->nextNodes[0].end(); iter++)
            {
                iter->first->nextNodes[1].insert(make_pair(dependencyNode, dependencyNode->layouter));
            }
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = dependencyNode->nextNodes[0].begin();
                 iter != dependencyNode->nextNodes[0].end(); iter++)
            {
                iter->first->nextNodes[1].insert(make_pair(thisNode, thisNode->layouter));
            }
            
            break;
        case kLayoutRelationAlignRightWith:
        case kLayoutRelationAlignBottomWith:
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = thisNode->nextNodes[1].begin();
                 iter != thisNode->nextNodes[1].end(); iter++)
            {
                iter->first->nextNodes[0].insert(make_pair(dependencyNode, dependencyNode->layouter));
            }
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = dependencyNode->nextNodes[1].begin();
                 iter != dependencyNode->nextNodes[1].end(); iter++)
            {
                iter->first->nextNodes[0].insert(make_pair(thisNode, thisNode->layouter));
            }
            
            break;
    }
    
#else
    LayoutConstraint lc;
    lc.leftOperandID = leftOperandID;
    lc.rightOperandID = rightOperandID;
    lc.relation = layoutRelation;
    interpretLayoutConstraint(lc);
#endif
}

void AlViewRelativeLayout::addLayoutRelation (AlViewLayout* leftOperandChild, AlViewLayout* rightOperandChild, int layoutRelation)
{
#ifdef V2
    AlViewLayout* thisOperand = leftOperandChild;
    AlViewLayout* dependencyOperand = rightOperandChild;
    if (NULL == thisOperand) return;
    
    map<AlViewLayout*, LayoutChainNode*>* pLayoutChains;
    map<LayoutChainNode*, AlViewLayout*>* pLayoutChainRoots;
    switch (layoutRelation)
    {
        case kLayoutRelationToLeftOf:
        case kLayoutRelationToRightOf:
        case kLayoutRelationAlignLeftWith:
        case kLayoutRelationAlignRightWith:
        case kLayoutRelationCenterParentHorizontal:
        case kLayoutRelationAlignParentLeft:
        case kLayoutRelationAlignParentRight:
            pLayoutChains = &horizontalLayoutChains;
            pLayoutChainRoots = &horizontalLayoutChainRoots;
            
            break;
        case kLayoutRelationAbove:
        case kLayoutRelationBelow:
        case kLayoutRelationAlignTopWith:
        case kLayoutRelationAlignBottomWith:
        case kLayoutRelationCenterParentVertical:
        case kLayoutRelationAlignParentBottom:
        case kLayoutRelationAlignParentTop:
            pLayoutChains = &verticalLayoutChains;
            pLayoutChainRoots = &verticalLayoutChainRoots;
            
            break;
    }
    
    LayoutChainNode* thisNode;
    map<AlViewLayout*, LayoutChainNode*>::iterator itrThisNode = pLayoutChains->find(thisOperand);
    if (pLayoutChains->end() == itrThisNode)
    {
        thisNode = new LayoutChainNode;
        thisNode->layouter = thisOperand;
        pLayoutChains->insert(make_pair(thisOperand, thisNode));
    }
    else
    {
        thisNode = itrThisNode->second;
    }
    
    LayoutChainNode* dependencyNode;
    if (NULL == dependencyOperand)
    {
        dependencyNode = NULL;
    }
    else
    {
        map<AlViewLayout*, LayoutChainNode*>::iterator itrDependencyNode = pLayoutChains->find(dependencyOperand);
        if (pLayoutChains->end() == itrDependencyNode)
        {
            dependencyNode = new LayoutChainNode;
            dependencyNode->layouter = dependencyOperand;
            pLayoutChains->insert(make_pair(dependencyOperand, dependencyNode));///!!!???
        }
        else
        {
            dependencyNode = itrDependencyNode->second;
        }
    }
    
    switch (layoutRelation)
    {
        case kLayoutRelationCenterParentHorizontal:
        case kLayoutRelationCenterParentVertical:
            pLayoutChainRoots->insert(make_pair(thisNode, thisNode->layouter));
            
            if (layoutFlagsOfNode.end() == layoutFlagsOfNode.find(thisNode))
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, layoutRelation));
            }
            else
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, (layoutRelation | layoutFlagsOfNode[thisNode])));
            }
            
            break;
        case kLayoutRelationAlignParentLeft:
        case kLayoutRelationAlignParentTop:
        case kLayoutRelationAlignParentRight:
        case kLayoutRelationAlignParentBottom:
            pLayoutChainRoots->insert(make_pair(thisNode, thisNode->layouter));
            
            if (layoutFlagsOfNode.end() == layoutFlagsOfNode.find(thisNode))
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, layoutRelation));
            }
            else
            {
                layoutFlagsOfNode.insert(make_pair(thisNode, (layoutRelation | layoutFlagsOfNode[thisNode])));
            }
            
            break;
        case kLayoutRelationToLeftOf:
        case kLayoutRelationAbove:
            thisNode->nextNodes[1].insert(make_pair(dependencyNode, dependencyNode->layouter));
            dependencyNode->nextNodes[0].insert(make_pair(thisNode, thisNode->layouter));
            
            break;
        case kLayoutRelationToRightOf:
        case kLayoutRelationBelow:
            thisNode->nextNodes[0].insert(make_pair(dependencyNode, dependencyNode->layouter));
            dependencyNode->nextNodes[1].insert(make_pair(thisNode, thisNode->layouter));
            break;
            
        case kLayoutRelationAlignLeftWith:
        case kLayoutRelationAlignTopWith:
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = thisNode->nextNodes[0].begin();
                 iter != thisNode->nextNodes[0].end(); iter++)
            {
                iter->first->nextNodes[1].insert(make_pair(dependencyNode, dependencyNode->layouter));
            }
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = dependencyNode->nextNodes[0].begin();
                 iter != dependencyNode->nextNodes[0].end(); iter++)
            {
                iter->first->nextNodes[1].insert(make_pair(thisNode, thisNode->layouter));
            }
            
            break;
        case kLayoutRelationAlignRightWith:
        case kLayoutRelationAlignBottomWith:
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = thisNode->nextNodes[1].begin();
                 iter != thisNode->nextNodes[1].end(); iter++)
            {
                iter->first->nextNodes[0].insert(make_pair(dependencyNode, dependencyNode->layouter));
            }
            for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = dependencyNode->nextNodes[1].begin();
                 iter != dependencyNode->nextNodes[1].end(); iter++)
            {
                iter->first->nextNodes[0].insert(make_pair(thisNode, thisNode->layouter));
            }
            
            break;
    }
    
#else
    map<AlViewLayout*, int>::iterator leftOpr = child2IdMap.find(leftOperandChild);
    if (child2IdMap.end() == leftOpr && NULL != leftOperandChild)
    {
        AlViewLayoutParameter lp;
        addChild(leftOperandChild, lp);
    }
    map<AlViewLayout*, int>::iterator rightOpr = child2IdMap.find(const_cast<AlViewLayout*>(rightOperandChild));
    if (child2IdMap.end() == rightOpr && NULL != rightOperandChild)
    {
        AlViewLayoutParameter lp;
        addChild(rightOperandChild, lp);
    }
    
    LayoutConstraint lc;
    lc.leftOperandID = leftOpr->second;
    lc.rightOperandID = rightOpr->second;
    lc.relation = layoutRelation;
    interpretLayoutConstraint(lc);
#endif
}

void AlViewRelativeLayout::interpretLayoutConstraint (LayoutConstraint originalLC)
{
    LayoutConstraint lc = originalLC;
    
    map<int, ChildPair>::iterator leftChildPair = children.find(lc.leftOperandID);
    map<int, ChildPair>::iterator rightChildPair = children.find(lc.rightOperandID);
    
    lc.leftOperandID <<= 3;
    lc.rightOperandID <<= 3;
    lc.coefficient = 1;
    lc.constant = 0;

    switch (originalLC.relation)
    {
        case kLayoutRelationCenterHorizontalWith:
        case kLayoutRelationCenterVerticalWith:
        case kLayoutRelationCenterParentHorizontal:
        case kLayoutRelationCenterParentVertical:
            suspendingConstraints.push_back(lc);
            
            break;
        case kLayoutRelationAbove:
            // L.Bottom >= R.Top - (L.MarginBottom + R.MarginTop)
            lc.leftOperandID |= VAR_BOTTOM;
            lc.rightOperandID |= VAR_TOP;
            lc.constant = - leftChildPair->second.parameter.marginBottom - rightChildPair->second.parameter.marginTop;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Bottom <= R.Top - (L.MarginBottom + R.MarginTop)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationBelow:
            // R.Bottom <= L.Top - (R.MarginBottom + L.MarginTop)
            lc.rightOperandID |= VAR_BOTTOM;
            lc.leftOperandID |= VAR_TOP;
            lc.constant = leftChildPair->second.parameter.marginTop + rightChildPair->second.parameter.marginBottom;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // R.Bottom >= L.Top - (R.MarginBottom + L.MarginTop)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;///
        case kLayoutRelationToLeftOf:
            // L.Right >= R.Left - (L.MarginRight + R.MarginLeft)
            lc.leftOperandID |= VAR_RIGHT;
            lc.rightOperandID |= VAR_LEFT;
            lc.constant = - leftChildPair->second.parameter.marginRight - rightChildPair->second.parameter.marginLeft;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Right <= R.Left - (L.MarginRight + R.MarginLeft)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationToRightOf:
            // R.Right <= L.Left - (R.MarginRight + L.MarginLeft)
            lc.rightOperandID |= VAR_RIGHT;
            lc.leftOperandID |= VAR_LEFT;
            lc.constant = leftChildPair->second.parameter.marginLeft + rightChildPair->second.parameter.marginRight;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // R.Right >= L.Left - (R.MarginRight + L.MarginLeft)
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationAlignTopWith:
            // L.Top >= R.Top
            lc.leftOperandID |= VAR_TOP;
            lc.rightOperandID |= VAR_TOP;
            lc.constant = 0;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Top <= R.Top
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
            
        case kLayoutRelationAlignBottomWith:
            // L.Bottom >= R.Bottom
            lc.leftOperandID |= VAR_BOTTOM;
            lc.rightOperandID |= VAR_BOTTOM;
            lc.constant = 0;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Bottom <= R.Bottom
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationAlignLeftWith:
            // L.Left >= R.Left
            lc.leftOperandID |= VAR_LEFT;
            lc.rightOperandID |= VAR_LEFT;
            lc.constant = 0;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Left <= R.Left
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
        case kLayoutRelationAlignRightWith:
            // L.Right >= R.Right
            lc.leftOperandID |= VAR_RIGHT;
            lc.rightOperandID |= VAR_RIGHT;
            lc.constant = 0;
            lc.relation = 1;
            interpretedConstraints.push_back(lc);
            
            // L.Right <= R.Right
            lc.relation = 0;
            interpretedConstraints.push_back(lc);
            break;
            
        case kLayoutRelationAlignParentLeft:
        case kLayoutRelationAlignParentRight:
        case kLayoutRelationAlignParentTop:
        case kLayoutRelationAlignParentBottom:
            lc.rightOperandID = NA_VAR;
            suspendingConstraints.push_back(lc);
            
            break;
            
    }
}

void AlViewRelativeLayout::interpretConstraintsWithParentsBound (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, AlViewLayoutParameter layoutParam)
{
    LayoutConstraint lc = originalLC;
    map<int, ChildPair>::iterator leftChildPair = children.find(lc.leftOperandID >> 3);
    map<int, ChildPair>::iterator rightChildPair;
    
    if (kLayoutFlagPrecise == layoutParam.horizontalLayoutFlag)
    {
        lc.coefficient = 1;
        switch (lc.relation)
        {
            case kLayoutRelationCenterHorizontalWith:
            case kLayoutRelationCenterVerticalWith:
                ///!!!
                
                break;
            case kLayoutRelationCenterParentHorizontal:
                
                // L.Left + L.Right = Width
                lc.leftOperandID |= VAR_LEFT;
                lc.rightOperandID |= VAR_RIGHT;
                lc.constant = layoutParam.givenSize.width;
                lc.relation = RELATION_LESS_EQUAL_N;
                reinterpretedConstraints->push_back(lc);
                lc.relation = RELATION_GREATER_EQUAL_N;
                reinterpretedConstraints->push_back(lc);
                
                // L.Left <= (Width - L.Width) / 2
                lc.rightOperandID = NA_VAR;
                lc.constant = (layoutParam.givenSize.width - leftChildPair->second.child->getMinimalMeasuredSize().width) / 2;
                lc.relation = 0;
                reinterpretedConstraints->push_back(lc);
                break;
            case kLayoutRelationCenterParentVertical:
                // L.Top + L.Bottom = Height
                lc.leftOperandID |= VAR_TOP;
                lc.rightOperandID |= VAR_BOTTOM;
                lc.constant = layoutParam.givenSize.height;
                lc.relation = RELATION_LESS_EQUAL_N;
                reinterpretedConstraints->push_back(lc);
                lc.relation = RELATION_GREATER_EQUAL_N;
                reinterpretedConstraints->push_back(lc);
                
                // L.Top <= (Height - L.Height) / 2
                lc.rightOperandID = NA_VAR;
                lc.constant = (layoutParam.givenSize.height - leftChildPair->second.child->getMinimalMeasuredSize().height) / 2;
                lc.relation = 0;
                reinterpretedConstraints->push_back(lc);
                
                break;
            case kLayoutRelationAlignParentLeft:
                lc.leftOperandID |= VAR_LEFT;
                lc.constant = leftChildPair->second.parameter.marginLeft;
                
                // L.Left <= L.MarginLeft
                lc.relation = 0;
                reinterpretedConstraints->push_back(lc);
                
                // L.Left >= L.MarginLeft
                lc.relation = 1;
                reinterpretedConstraints->push_back(lc);
                
                break;
            case kLayoutRelationAlignParentRight:
                lc.leftOperandID |= VAR_RIGHT;
                lc.constant = layoutParam.givenSize.width - leftChildPair->second.parameter.marginRight;
                
                // L.Right <= Width - L.MarginRight
                lc.relation = 0;
                reinterpretedConstraints->push_back(lc);
                
                // L.Right >= Width - L.MarginRight
                lc.relation = 1;
                reinterpretedConstraints->push_back(lc);
                
                break;
            case kLayoutRelationAlignParentTop:
                lc.leftOperandID |= VAR_TOP;
                lc.constant = leftChildPair->second.parameter.marginTop;
                
                // L.Top <= L.MarginTop
                lc.relation = 0;
                reinterpretedConstraints->push_back(lc);
                
                // L.Top >= L.MarginTop
                lc.relation = 1;
                reinterpretedConstraints->push_back(lc);
                
                break;
            case kLayoutRelationAlignParentBottom:
                lc.leftOperandID |= VAR_BOTTOM;
                lc.constant = layoutParam.givenSize.height - leftChildPair->second.parameter.marginBottom;
                
                // L.Bottom <= HEIGHT - L.MarginBottom
                lc.relation = 0;
                reinterpretedConstraints->push_back(lc);
                
                // L.Bottom >= HEIGHT - L.MarginBottom
                lc.relation = 1;
                reinterpretedConstraints->push_back(lc);
                
                break;
        }
    }
    else
    {
        
    }
}

void AlViewRelativeLayout::interpretConstraintsWithChildsBound (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, CGSize bound)
{
    LayoutConstraint lc = originalLC;
    lc.coefficient = 1;
    map<int, ChildPair>::iterator leftChildPair = children.find(lc.leftOperandID >> 3);
    map<int, ChildPair>::iterator rightChildPair;
    
    int shiftID = lc.leftOperandID << 3;
    
    // L.Left <= R.Right - Width
    lc.leftOperandID = shiftID | VAR_LEFT;
    lc.rightOperandID = shiftID | VAR_RIGHT;
    lc.constant = -bound.width;
    lc.relation = 0;
    reinterpretedConstraints->push_back(lc);
    
    // L.Top <= R.Bottom - Height
    lc.leftOperandID = shiftID | VAR_TOP;
    lc.rightOperandID = shiftID | VAR_BOTTOM;
    lc.constant = -bound.height;
    lc.relation = 0;
    reinterpretedConstraints->push_back(lc);
}

///!!! TODO: AlignXXXWith
float AlViewRelativeLayout::recursiveFindMaxWidthOfHorizontalChain (LayoutChainNode* curNode, byte direction,
                                                          float curPosition, map<AlViewLayout*, CGRect>& framesOfChildren)
{
    map<AlViewLayout*, int>::iterator iterChildID = child2IdMap.find(curNode->layouter);
    if (child2IdMap.end() == iterChildID)
    {
        return 0.0f;
    }
    
    map<int, ChildPair>::iterator iterChildPair = children.find(iterChildID->second);
    if (children.end() == iterChildPair)
    {
        return 0.0f;
    }
    
    float mySize = curNode->layouter->getDesiredMeasuredSize().width;
    mySize += iterChildPair->second.parameter.marginLeft;
    mySize += iterChildPair->second.parameter.marginRight;
    
    CGRect frame;
    map<AlViewLayout*, CGRect>::iterator iterFrameOfChild = framesOfChildren.find(curNode->layouter);
    if (framesOfChildren.end() != iterFrameOfChild)
    {
        frame = iterFrameOfChild->second;
    }
    else
    {
        frame = CGRectMake(0, NA_RANGE, 0, NA_RANGE);
    }
    
    if (0 == direction)
    {
        frame.origin.x = curPosition - iterChildPair->second.parameter.marginRight - curNode->layouter->getDesiredMeasuredSize().width;
        frame.size.width = curNode->layouter->getDesiredMeasuredSize().width;
        
        curPosition -= mySize;
    }
    else
    {
        frame.origin.x = curPosition + iterChildPair->second.parameter.marginLeft;
        frame.size.width = curNode->layouter->getDesiredMeasuredSize().width;
        
        curPosition += mySize;
    }
    framesOfChildren[curNode->layouter] = frame;
    
    float maxSubTotalSize = 0;
    for (map<LayoutChainNode*, AlViewLayout*>::iterator nextNode = curNode->nextNodes[direction].begin();
         nextNode != curNode->nextNodes[direction].end();
         nextNode++)
    {
        float subTotalSize = recursiveFindMaxWidthOfHorizontalChain(nextNode->first, direction, curPosition, framesOfChildren);
        
        if (subTotalSize > maxSubTotalSize)
        {
            maxSubTotalSize = subTotalSize;
        }
    }
    
    return mySize + maxSubTotalSize;
}

float AlViewRelativeLayout::recursiveFindMaxHeightOfVerticalChain (LayoutChainNode* curNode, byte direction,
                                                                    float curPosition, map<AlViewLayout*, CGRect>& framesOfChildren)
{
    map<AlViewLayout*, int>::iterator iterChildID = child2IdMap.find(curNode->layouter);
    if (child2IdMap.end() == iterChildID)
    {
        return 0.0f;
    }
    
    map<int, ChildPair>::iterator iterChildPair = children.find(iterChildID->second);
    if (children.end() == iterChildPair)
    {
        return 0.0f;
    }
    
    float mySize = curNode->layouter->getDesiredMeasuredSize().height;
    mySize += iterChildPair->second.parameter.marginTop;
    mySize += iterChildPair->second.parameter.marginBottom;
    
    CGRect frame;
    map<AlViewLayout*, CGRect>::iterator iterFrameOfChild = framesOfChildren.find(curNode->layouter);
    if (framesOfChildren.end() != iterFrameOfChild)
    {
        frame = iterFrameOfChild->second;
    }
    else
    {
        frame = CGRectMake(NA_RANGE, 0, NA_RANGE, 0);
    }
    
    if (0 == direction)
    {
        frame.origin.y = curPosition - iterChildPair->second.parameter.marginBottom - curNode->layouter->getDesiredMeasuredSize().height;
        frame.size.height = curNode->layouter->getDesiredMeasuredSize().height;
        
        curPosition -= mySize;
    }
    else
    {
        frame.origin.y = curPosition + iterChildPair->second.parameter.marginTop;
        frame.size.height = curNode->layouter->getDesiredMeasuredSize().height;
        
        curPosition += mySize;
    }
    framesOfChildren[curNode->layouter] = frame;
    
    float maxSubTotalSize = 0;
    for (map<LayoutChainNode*, AlViewLayout*>::iterator nextNode = curNode->nextNodes[direction].begin();
         nextNode != curNode->nextNodes[direction].end();
         nextNode++)
    {
        float subTotalSize = recursiveFindMaxHeightOfVerticalChain(nextNode->first, direction, curPosition, framesOfChildren);
        
        if (subTotalSize > maxSubTotalSize)
        {
            maxSubTotalSize = subTotalSize;
        }
    }
    
    return mySize + maxSubTotalSize;
}

void AlViewRelativeLayout::recursiveOffsetHorizontalChains (LayoutChainNode* curNode, int direction,
                                                            float offset, map<AlViewLayout*, CGRect>& framesOfChildren)
{
    if (NULL == curNode) return;
    
    CGRect frame = framesOfChildren[curNode->layouter];
    frame.origin.x += offset;
    framesOfChildren[curNode->layouter] = frame;
    
    for (map<LayoutChainNode*, AlViewLayout*>::iterator nextNode = curNode->nextNodes[direction].begin();
         nextNode != curNode->nextNodes[direction].end();
         nextNode++)
    {
        recursiveOffsetHorizontalChains(nextNode->first, direction, offset, framesOfChildren);
    }
}

void AlViewRelativeLayout::recursiveOffsetVerticalChains (LayoutChainNode* curNode, int direction,
                                                          float offset, map<AlViewLayout*, CGRect>& framesOfChildren)
{
    if (NULL == curNode) return;
    
    CGRect frame = framesOfChildren[curNode->layouter];
    frame.origin.y += offset;
    framesOfChildren[curNode->layouter] = frame;
    
    for (map<LayoutChainNode*, AlViewLayout*>::iterator nextNode = curNode->nextNodes[direction].begin();
         nextNode != curNode->nextNodes[direction].end();
         nextNode++)
    {
        recursiveOffsetVerticalChains(nextNode->first, direction, offset, framesOfChildren);
    }
}

bool AlViewRelativeLayout::canBeLayoutChainRootCandidate (LayoutChainNode* node)
{
    if (NULL == node)
    {
        return false;
    }
    
    if (node->nextNodes[0].size() == 0)
    {
        for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = node->nextNodes[1].begin();
             iter != node->nextNodes[1].end();
             iter++)
        {
            if (iter->first->nextNodes[0].size() > 1)
            {
                return false;
            }
        }
    }
    else if (node->nextNodes[1].size() == 0)
    {
        for (map<LayoutChainNode*, AlViewLayout*>::iterator iter = node->nextNodes[0].begin();
             iter != node->nextNodes[0].end();
             iter++)
        {
            if (iter->first->nextNodes[1].size() > 1)
            {
                return false;
            }
        }
    }
    else
    {
        return false;
    }
    
    return true;
}

void AlViewRelativeLayout::clearLayoutChainGraph (map<AlViewLayout*, LayoutChainNode*>& graph)
{
    for (map<AlViewLayout*, LayoutChainNode*>::iterator iter = graph.begin();
         iter != graph.end();
         iter++)
    {
        if (NULL != iter->second)
        {
            delete iter->second;
        }
    }
}

void AlViewRelativeLayout::onMeasure (AlViewLayoutParameter givenLayoutParam)
{
#ifdef V2
    
    // Measure all children & Create nodes for children that not exist in any constraints :
    for (map<int, ChildPair>::iterator iter = children.begin(); iter != children.end(); iter++)
    {
        ChildPair cp = iter->second;
        cp.child->onMeasure(cp.parameter);
        
        map<AlViewLayout*, LayoutChainNode*>::iterator itrNode = horizontalLayoutChains.find(cp.child);
        if (horizontalLayoutChains.end() == itrNode)
        {
            LayoutChainNode* node = new LayoutChainNode;
            node->layouter = cp.child;
            horizontalLayoutChains.insert(make_pair(cp.child, node));
        }
        
        itrNode = verticalLayoutChains.find(cp.child);
        if (verticalLayoutChains.end() == itrNode)
        {
            LayoutChainNode* node = new LayoutChainNode;
            node->layouter = cp.child;
            verticalLayoutChains.insert(make_pair(cp.child, node));
        }
    }
    
    // 
    
    
    // Use this map for both recording children's frame, and to mark if a child is reached in traversing a chain :
    map<AlViewLayout*, CGRect> framesOfChildren;
    
    // Horizontal :
    
        // Measure max width of all chains:
    float widthNeeded = 0.0f;
    
    for (map<LayoutChainNode*, AlViewLayout*>::iterator itrRoot = horizontalLayoutChainRoots.begin();
         itrRoot != horizontalLayoutChainRoots.end();
         itrRoot++)
    {
        float widthOfThisChain;
        map<LayoutChainNode*, int>::iterator itrLayoutFlag = layoutFlagsOfNode.find(itrRoot->first);
        if (layoutFlagsOfNode.end() != itrLayoutFlag)
        {
            if (itrLayoutFlag->second & kLayoutRelationAlignParentRight)
            {
                widthOfThisChain = recursiveFindMaxWidthOfHorizontalChain(itrRoot->first, 0, 0.0f, framesOfChildren);
            }
            else if (itrLayoutFlag->second & kLayoutRelationCenterParentHorizontal)
            {
                map<AlViewLayout*, int>::iterator iterChildID = child2IdMap.find(itrRoot->first->layouter);
                if (child2IdMap.end() == iterChildID)
                {
                    throw "Not gonna happen! #0";
                }
                map<int, ChildPair>::iterator iterChildPair = children.find(iterChildID->second);
                if (children.end() == iterChildPair)
                {
                    throw "Not gonna happen! #1";
                }
                float boundWidthOfRoot = itrRoot->first->layouter->getDesiredMeasuredSize().width;
                boundWidthOfRoot += iterChildPair->second.parameter.marginLeft;
                boundWidthOfRoot += iterChildPair->second.parameter.marginRight;
                
                float halfWidth0 = recursiveFindMaxWidthOfHorizontalChain(itrRoot->first, 0, boundWidthOfRoot, framesOfChildren)
                                    - itrRoot->first->layouter->getDesiredMeasuredSize().width / 2
                                    - iterChildPair->second.parameter.marginRight;
                float halfWidth1 = recursiveFindMaxWidthOfHorizontalChain(itrRoot->first, 1, 0.0f, framesOfChildren)
                                    - itrRoot->first->layouter->getDesiredMeasuredSize().width / 2
                                    - iterChildPair->second.parameter.marginLeft;
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
                widthOfThisChain = recursiveFindMaxWidthOfHorizontalChain(itrRoot->first, 1, 0.0f, framesOfChildren);
            }
        }
        else
        {
            widthOfThisChain = recursiveFindMaxWidthOfHorizontalChain(itrRoot->first, 1, 0.0f, framesOfChildren);
        }
        
        if (widthOfThisChain > widthNeeded)
        {
            widthNeeded = widthOfThisChain;
        }
    }
    
        // Find in other chains, root of which not exists in horizontalLayoutChainRoots :
    for (map<AlViewLayout*, LayoutChainNode*>::iterator itrRoot = horizontalLayoutChains.begin();
         itrRoot != horizontalLayoutChains.end();
         itrRoot++)
    {
        if (!canBeLayoutChainRootCandidate(itrRoot->second))
        {
            continue;
        }
        
        if (horizontalLayoutChainRoots.find(itrRoot->second) != horizontalLayoutChainRoots.end())
        {
            continue;
        }
        
        map<AlViewLayout*, CGRect>::iterator iterFrameOfChild = framesOfChildren.find(itrRoot->second->layouter);
        if (framesOfChildren.end() != iterFrameOfChild && iterFrameOfChild->second.origin.x != NA_RANGE)
        {
            continue;
        }
        
        horizontalLayoutChainRoots.insert(make_pair(itrRoot->second, itrRoot->first));
        
        float widthOfThisChain;
        if (0 == itrRoot->second->nextNodes[0].size())
        {
            widthOfThisChain = recursiveFindMaxWidthOfHorizontalChain(itrRoot->second, 1, 0.0f, framesOfChildren);
        }
        else
        {
            widthOfThisChain = recursiveFindMaxWidthOfHorizontalChain(itrRoot->second, 0, 0.0f, framesOfChildren);
        }
        if (widthOfThisChain > widthNeeded)
        {
            widthNeeded = widthOfThisChain;
        }
    }
    
        // Layout in horizontal :    
    for (map<LayoutChainNode*, AlViewLayout*>::iterator itrRoot = horizontalLayoutChainRoots.begin();
         itrRoot != horizontalLayoutChainRoots.end();
         itrRoot++)
    {
        if (NULL == itrRoot->first) continue;
        
        float offset;
        int direction = 1;
        
        map<AlViewLayout*, int>::iterator iterChildID = child2IdMap.find(itrRoot->first->layouter);
        if (child2IdMap.end() == iterChildID)
        {
            throw "Not gonna happen! #2";
        }
        map<int, ChildPair>::iterator iterChildPair = children.find(iterChildID->second);
        if (children.end() == iterChildPair)
        {
            throw "Not gonna happen! #3";
        }
        map<AlViewLayout*, CGRect>::iterator iterFrameOfChild = framesOfChildren.find(itrRoot->first->layouter);
        if (framesOfChildren.end() == iterFrameOfChild)
        {
            throw "Not gonna happen! #4";
        }
        
        map<LayoutChainNode*, int>::iterator itrLayoutFlag = layoutFlagsOfNode.find(itrRoot->first);
        if (layoutFlagsOfNode.end() != itrLayoutFlag)
        {
            if (itrLayoutFlag->second & kLayoutRelationAlignParentRight)
            {
                offset = widthNeeded - iterChildPair->second.parameter.marginRight - iterFrameOfChild->second.size.width
                        - iterFrameOfChild->second.origin.x;
                direction = 0;
            }
            else if (itrLayoutFlag->second & kLayoutRelationCenterParentHorizontal)
            {
                offset = (widthNeeded - iterFrameOfChild->second.size.width) / 2
                        - iterFrameOfChild->second.origin.x;
                
                CGRect offsettedRect = iterFrameOfChild->second;
                offsettedRect.origin.x -= offset;
                framesOfChildren[itrRoot->first->layouter] = offsettedRect;
                recursiveOffsetHorizontalChains(itrRoot->first, 0, offset, framesOfChildren);
            }
            else if (itrLayoutFlag->second & kLayoutRelationAlignParentLeft)
            {
                offset = iterChildPair->second.parameter.marginLeft - iterFrameOfChild->second.origin.x;
            }
            else
            {
                if (0 == itrRoot->first->nextNodes[0].size())
                {
                    offset = iterChildPair->second.parameter.marginLeft - iterFrameOfChild->second.origin.x;
                }
                else
                {
                    offset = widthNeeded - iterChildPair->second.parameter.marginRight - iterFrameOfChild->second.size.width
                            - iterFrameOfChild->second.origin.x;
                    direction = 0;
                }
            }
        }
        else
        {
            if (0 == itrRoot->first->nextNodes[0].size())
            {
                offset = iterChildPair->second.parameter.marginLeft - iterFrameOfChild->second.origin.x;
            }
            else
            {
                offset = widthNeeded - iterChildPair->second.parameter.marginRight - iterFrameOfChild->second.size.width
                - iterFrameOfChild->second.origin.x;
                direction = 0;
            }
        }
        
        recursiveOffsetHorizontalChains(itrRoot->first, direction, offset, framesOfChildren);
    }
    
    /////////////
    // Vertical :
    
        // Measure max height of all chains:
    float heightNeeded = 0.0f;
    
    for (map<LayoutChainNode*, AlViewLayout*>::iterator itrRoot = verticalLayoutChainRoots.begin();
         itrRoot != verticalLayoutChainRoots.end();
         itrRoot++)
    {
        if (NULL == itrRoot->first) continue;
        
        float heightOfThisChain;
        map<LayoutChainNode*, int>::iterator itrLayoutFlag = layoutFlagsOfNode.find(itrRoot->first);
        if (layoutFlagsOfNode.end() != itrLayoutFlag)
        {
            if (itrLayoutFlag->second & kLayoutRelationAlignParentBottom)
            {
                heightOfThisChain = recursiveFindMaxHeightOfVerticalChain(itrRoot->first, 0, 0.0f, framesOfChildren);
            }
            else if (itrLayoutFlag->second & kLayoutRelationCenterParentVertical)
            {
                map<AlViewLayout*, int>::iterator iterChildID = child2IdMap.find(itrRoot->first->layouter);
                if (child2IdMap.end() == iterChildID)
                {
                    throw "Not gonna happen! #0";
                }
                map<int, ChildPair>::iterator iterChildPair = children.find(iterChildID->second);
                if (children.end() == iterChildPair)
                {
                    throw "Not gonna happen! #1";
                }
                float boundHeightOfRoot = itrRoot->first->layouter->getDesiredMeasuredSize().height;
                boundHeightOfRoot += iterChildPair->second.parameter.marginTop;
                boundHeightOfRoot += iterChildPair->second.parameter.marginBottom;
                
                float halfHeight0 = recursiveFindMaxHeightOfVerticalChain(itrRoot->first, 0, boundHeightOfRoot, framesOfChildren)
                                    - itrRoot->first->layouter->getDesiredMeasuredSize().height / 2
                                    - iterChildPair->second.parameter.marginBottom;
                float halfHeight1 = recursiveFindMaxHeightOfVerticalChain(itrRoot->first, 1, 0.0f, framesOfChildren)
                                    - itrRoot->first->layouter->getDesiredMeasuredSize().height / 2
                                    - iterChildPair->second.parameter.marginTop;
                
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
                heightOfThisChain = recursiveFindMaxHeightOfVerticalChain(itrRoot->first, 1, 0.0f, framesOfChildren);
            }
        }
        else
        {
            heightOfThisChain = recursiveFindMaxHeightOfVerticalChain(itrRoot->first, 1, 0.0f, framesOfChildren);
        }
        
        if (heightOfThisChain > heightNeeded)
        {
            heightNeeded = heightOfThisChain;
        }
    }
    
        // Find in other chains, root of which not exists in verticalLayoutChainRoots :
    for (map<AlViewLayout*, LayoutChainNode*>::iterator itrRoot = verticalLayoutChains.begin();
         itrRoot != verticalLayoutChains.end();
         itrRoot++)
    {
        if (!canBeLayoutChainRootCandidate(itrRoot->second))
        {
            continue;
        }
        
        if (verticalLayoutChainRoots.find(itrRoot->second) != verticalLayoutChainRoots.end())
        {
            continue;
        }
        
        map<AlViewLayout*, CGRect>::iterator iterFrameOfChild = framesOfChildren.find(itrRoot->second->layouter);
        if (framesOfChildren.end() != iterFrameOfChild && iterFrameOfChild->second.origin.y != NA_RANGE)
        {
            continue;
        }
        
        verticalLayoutChainRoots.insert(make_pair(itrRoot->second, itrRoot->first));
        float heightOfThisChain;
        if (0 == itrRoot->second->nextNodes[0].size())
        {
            heightOfThisChain = recursiveFindMaxHeightOfVerticalChain(itrRoot->second, 1, 0.0f, framesOfChildren);
        }
        else
        {
            heightOfThisChain = recursiveFindMaxHeightOfVerticalChain(itrRoot->second, 0, 0.0f, framesOfChildren);
        }
        if (heightOfThisChain > heightNeeded)
        {
            heightNeeded = heightOfThisChain;
        }
    }
    
        // Layout in vertical :
    for (map<LayoutChainNode*, AlViewLayout*>::iterator itrRoot = verticalLayoutChainRoots.begin();
         itrRoot != verticalLayoutChainRoots.end();
         itrRoot++)
    {
        if (NULL == itrRoot->first) continue;
        
        float offset;
        int direction = 1;
        
        map<AlViewLayout*, int>::iterator iterChildID = child2IdMap.find(itrRoot->first->layouter);
        if (child2IdMap.end() == iterChildID)
        {
            throw "Not gonna happen! #2";
        }
        map<int, ChildPair>::iterator iterChildPair = children.find(iterChildID->second);
        if (children.end() == iterChildPair)
        {
            throw "Not gonna happen! #3";
        }
        map<AlViewLayout*, CGRect>::iterator iterFrameOfChild = framesOfChildren.find(itrRoot->first->layouter);
        if (framesOfChildren.end() == iterFrameOfChild)
        {
            throw "Not gonna happen! #4";
        }
        
        map<LayoutChainNode*, int>::iterator itrLayoutFlag = layoutFlagsOfNode.find(itrRoot->first);
        if (layoutFlagsOfNode.end() != itrLayoutFlag)
        {
            if (itrLayoutFlag->second & kLayoutRelationAlignParentBottom)
            {
                offset = heightNeeded - iterChildPair->second.parameter.marginBottom - iterFrameOfChild->second.size.width
                        - iterFrameOfChild->second.origin.y;
                direction = 0;
            }
            else if (itrLayoutFlag->second & kLayoutRelationCenterParentVertical)
            {
                offset = (heightNeeded - iterFrameOfChild->second.size.height) / 2
                        - iterFrameOfChild->second.origin.y;
                
                CGRect offsettedRect = iterFrameOfChild->second;
                offsettedRect.origin.y -= offset;
                framesOfChildren[itrRoot->first->layouter] = offsettedRect;
                recursiveOffsetVerticalChains(itrRoot->first, 0, offset, framesOfChildren);
            }
            else if (itrLayoutFlag->second & kLayoutRelationAlignParentTop)
            {
                offset = iterChildPair->second.parameter.marginTop - iterFrameOfChild->second.origin.y;
            }
            else
            {
                if (0 == itrRoot->first->nextNodes[0].size())
                {
                    offset = iterChildPair->second.parameter.marginTop - iterFrameOfChild->second.origin.y;
                }
                else
                {
                    offset = heightNeeded - iterChildPair->second.parameter.marginBottom - iterFrameOfChild->second.size.height
                            - iterFrameOfChild->second.origin.y;
                    direction = 0;
                }
            }
        }
        else
        {
            if (0 == itrRoot->first->nextNodes[0].size())
            {
                offset = iterChildPair->second.parameter.marginTop - iterFrameOfChild->second.origin.y;
            }
            else
            {
                offset = heightNeeded - iterChildPair->second.parameter.marginBottom - iterFrameOfChild->second.size.height
                        - iterFrameOfChild->second.origin.y;
                direction = 0;
            }
        }
        
        recursiveOffsetVerticalChains(itrRoot->first, direction, offset, framesOfChildren);
    }
    
    ////////
    for (map<int, ChildPair>::iterator iter = children.begin(); iter != children.end(); iter++)
    {
        ChildPair cp = iter->second;
        
        cp.child->_layoutedRect = framesOfChildren[cp.child];
        cp.child->applyLayout();///!!!
    }
    
    setMinimalMeasuredSize(widthNeeded, heightNeeded);
    setDesiredMeasuredSize(widthNeeded, heightNeeded);
    _layoutedRect = CGRectMake(0, 0, widthNeeded, heightNeeded);
    
#else
    
    CGSize myBound = givenLayoutParam.givenSize;
    
    // 已决的条件：
    list<LayoutConstraint> constraints;
    constraints.splice(constraints.end(), interpretedConstraints);
    
    // 未决的条件——子布局的最小尺寸：
    LayoutConstraint lc;
    lc.relation = kLayoutRelationSetSelfBound;
    for (map<int, ChildPair>::iterator iter = children.begin(); iter != children.end(); iter++)
    {
        ChildPair cp = iter->second;
        cp.child->onMeasure(cp.parameter);
        lc.leftOperandID = iter->first;
        interpretConstraintsWithChildsBound(&constraints, lc, cp.child->getMinimalMeasuredSize());
    }
    
    for (list<LayoutConstraint>::iterator iter = suspendingConstraints.begin(); iter != suspendingConstraints.end(); iter++)
    {
        interpretConstraintsWithParentsBound(&constraints, *iter, givenLayoutParam);
    }
    
    updateRelationGraphs(relationGraphs, &constraints);
    
    solveRelationGraphs(relationGraphs, currentUsableID + 1);
#ifdef DEBUG_OUTPUT
    printf("\n");
    for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
    {
        RelationGraphNode* curNode = iter->second;
        printf("Node#%d : [%f, %f]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
    }
#endif
    decideRelationGraphs(relationGraphs, currentUsableID + 1, myBound);
#ifdef DEBUG_OUTPUT
    printf("\n");
    for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
    {
        RelationGraphNode* curNode = iter->second;
        printf("Node#%d : [%f, %f]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
    }
#endif
    for (map<int, ChildPair>::iterator iter = children.begin(); iter != children.end(); iter++)
    {
        ChildPair cp = iter->second;
        int id = iter->first << 3;
        int left = relationGraphs[id | VAR_LEFT]->rangeBounds[0];
        int top = relationGraphs[id | VAR_TOP]->rangeBounds[0];
        int right = relationGraphs[id | VAR_RIGHT]->rangeBounds[0];
        int bottom = relationGraphs[id | VAR_BOTTOM]->rangeBounds[0];
        cp.child->_layoutedRect = CGRectMake(left, top, right - left, bottom - top);
        cp.child->applyLayout();///!!!
    }
    
    setMinimalMeasuredSize(givenLayoutParam.givenSize.width, givenLayoutParam.givenSize.height);
    setDesiredMeasuredSize(givenLayoutParam.givenSize.width, givenLayoutParam.givenSize.height);
    _layoutedRect = CGRectMake(0, 0, givenLayoutParam.givenSize.width, _minimalMeasuredSize.height);
    
#endif // V2
}

void AlViewRelativeLayout::doRecursiveTraverse (RelationGraphNode* curNode, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge,
                                                void* params, CallbackInTraversingRelationGraph callback,
                                                bool allowReEnterInNode)
{
    BitMatrix* pBitmap = (BitMatrix*) ((void**) params)[0];
    void* callbackParam = ((void**) params)[1];
    BitMatrixSetBit(pBitmap, 0, curNode->id, 1);
    
    if (NULL != callback)
    {
        bool skip = (this->*callback)(curNode, direction, fromNode, edge, callbackParam);
        if (skip)
        {
            BitMatrixSetBit(pBitmap, 0, curNode->id, 0);///!!!
            return;
        }
        
        int nextDirections[2];
        switch (direction)
        {
            case RELATION_LESS_EQUAL:
                nextDirections[0] = RELATION_LESS_EQUAL;
                nextDirections[1] = RELATION_LESS_EQUAL_N;
                break;
            case RELATION_GREATER_EQUAL:
                nextDirections[0] = RELATION_GREATER_EQUAL;
                nextDirections[1] = RELATION_GREATER_EQUAL_N;
                break;
            case RELATION_LESS_EQUAL_N:
                nextDirections[0] = RELATION_GREATER_EQUAL;
                nextDirections[1] = RELATION_GREATER_EQUAL_N;
                break;
            case RELATION_GREATER_EQUAL_N:
                nextDirections[0] = RELATION_LESS_EQUAL;
                nextDirections[1] = RELATION_LESS_EQUAL_N;
                break;
        }
        for (int iD=0; iD<2; iD++)
        {///!!!
            for (list<RelationGraphEdge>::iterator iter = curNode->edgesFromMe[nextDirections[iD]].begin();
                 iter != curNode->edgesFromMe[nextDirections[iD]].end(); iter++)
            {
                RelationGraphNode* nextNode = iter->nextNode;
                if (NULL == nextNode) continue;
                if (1 == BitMatrixGet(pBitmap, 0, nextNode->id)) continue;
                
                doRecursiveTraverse(nextNode, nextDirections[iD], curNode, (RelationGraphEdge*) &*iter, params, callback, allowReEnterInNode);
            }
        }
    }
    
    if (allowReEnterInNode)
    {
        BitMatrixSetBit(pBitmap, 0, curNode->id, 0);
    }
}

void AlViewRelativeLayout::recursiveTraverseRelationGraph (RelationGraphNode* startNode, int nodeCount,
                                     void* param, CallbackInTraversingRelationGraph callback,
                                     bool allowReEnterInNode)
{
    BitMatrix bm = CreateBitMatrix(1, nodeCount);
    void* params[2];
    params[0] = &bm;
    params[1] = param;
    
    for (int direction = 0; direction < 4; direction++)
    {
        BitMatrixSetAllBits(&bm, 0);
        
        doRecursiveTraverse(startNode, direction, NULL, NULL, params, callback, allowReEnterInNode);
    }
    
    ReleaseBitMatrix(&bm);
}

bool AlViewRelativeLayout::updateRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    if (NULL == fromNode)
    {
        if (NA_RANGE == node->rangeBounds[direction & 0x01])
            return true;
        else
            return false;
    }
    
    float newBoundValue0 = NA_RANGE;
    float newBoundValue1 = NA_RANGE;
    switch (direction)
    {
        case RELATION_LESS_EQUAL:
        case RELATION_GREATER_EQUAL:
            if (NA_RANGE != fromNode->rangeBounds[0])
            {
                newBoundValue0 = fromNode->rangeBounds[0] - edge->weight;
            }
            if (NA_RANGE != fromNode->rangeBounds[1])
            {
                newBoundValue1 = fromNode->rangeBounds[1] - edge->weight;
            }
            break;
            
        case RELATION_LESS_EQUAL_N:
        case RELATION_GREATER_EQUAL_N:
            if (NA_RANGE != fromNode->rangeBounds[1])
            {
                newBoundValue0 = edge->weight - fromNode->rangeBounds[1];
            }
            if (NA_RANGE != fromNode->rangeBounds[0])
            {
                newBoundValue1 = edge->weight - fromNode->rangeBounds[0];
            }
            break;
    }
    
    if (NA_RANGE != newBoundValue0 &&
        (NA_RANGE == node->rangeBounds[0] || newBoundValue0 > node->rangeBounds[0]))
    {
        node->rangeBounds[0] = newBoundValue0;
        return false;
    }
    if (NA_RANGE != newBoundValue1 &&
        (NA_RANGE == node->rangeBounds[1] || newBoundValue1 < node->rangeBounds[1]))
    {
        node->rangeBounds[1] = newBoundValue1;
        return false;
    }
    
    return true;
}

bool AlViewRelativeLayout::decideRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    if (NULL == fromNode)
    {
        if (node->rangeBounds[1] == node->rangeBounds[0])
        {
            return false;///!!! true ???
        }
        else if (node->rangeBounds[0] != NA_RANGE)
        {
            node->rangeBounds[1] = node->rangeBounds[0];
            return false;
        }
        else ///!!! if (node->rangeBounds[1] != NA_RANGE)
        {
            node->rangeBounds[0] = node->rangeBounds[1];
            return false;
        }
    }
    
    float newBoundValue0 = NA_RANGE;
    float newBoundValue1 = NA_RANGE;
    switch (direction)
    {
        case RELATION_LESS_EQUAL:
        case RELATION_GREATER_EQUAL:
            if (NA_RANGE != fromNode->rangeBounds[0])
            {
                newBoundValue0 = fromNode->rangeBounds[0] - edge->weight;
            }
            if (NA_RANGE != fromNode->rangeBounds[1])
            {
                newBoundValue1 = fromNode->rangeBounds[1] - edge->weight;
            }
            break;
            
        case RELATION_LESS_EQUAL_N:
        case RELATION_GREATER_EQUAL_N:
            if (NA_RANGE != fromNode->rangeBounds[1])
            {
                newBoundValue0 = edge->weight - fromNode->rangeBounds[1];
            }
            if (NA_RANGE != fromNode->rangeBounds[0])
            {
                newBoundValue1 = edge->weight - fromNode->rangeBounds[0];
            }
            break;
    }
    
    if (NA_RANGE != newBoundValue0 &&
        (NA_RANGE == node->rangeBounds[0] || newBoundValue0 > node->rangeBounds[0]))
    {
        node->rangeBounds[0] = newBoundValue0;
        return false;
    }
    if (NA_RANGE != newBoundValue1 &&
        (NA_RANGE == node->rangeBounds[1] || newBoundValue1 < node->rangeBounds[1]))
    {
        node->rangeBounds[1] = newBoundValue1;
        return false;
    }
    
    return true;
}

bool AlViewRelativeLayout::decideRangeBoundsArbitrarily (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    void** pastParams = (void**)param;
    map<RelationGraphNode*, int>* pRelevantNodes = (map<RelationGraphNode*, int>*) pastParams[2];
    int* pMin = ((int*) pastParams[0]);
    int* pMax = ((int*) pastParams[1]);
    
    (*pRelevantNodes)[node] = 1;
    
    float margin0 = 0, margin1 = 0;
    map<int, ChildPair>::iterator foundChild = children.find(node->id >> 3);
    if (children.end() != foundChild)
    {
        switch (node->id & 0x07)
        {
            case VAR_LEFT:
                margin0 = -foundChild->second.parameter.marginLeft;
                break;
            case VAR_TOP:
                margin0 = -foundChild->second.parameter.marginTop;
                break;
            case VAR_RIGHT:
                margin1 = foundChild->second.parameter.marginRight;
                break;
            case VAR_BOTTOM:
                margin1 = foundChild->second.parameter.marginBottom;
                break;
        }
    }
    
    if (NULL == fromNode)
    {
        if (node->rangeBounds[0] != NA_RANGE)
        {
            node->rangeBounds[1] = node->rangeBounds[0];
        }
        else if (node->rangeBounds[1] != NA_RANGE)
        {
            node->rangeBounds[0] = node->rangeBounds[1];
        }
        else
        {
            return true;
        }
        
        if (node->rangeBounds[0] + margin0 < *pMin)
        {
            *pMin = node->rangeBounds[0] + margin0;
        }
        if (node->rangeBounds[0] + margin1 > *pMax)
        {
            *pMax = node->rangeBounds[0] + margin1;
        }
        
        return false;
    }
    
    float newBoundValue0 = NA_RANGE;
    float newBoundValue1 = NA_RANGE;
    switch (direction)
    {
        case RELATION_LESS_EQUAL:
        case RELATION_GREATER_EQUAL:
            if (NA_RANGE != fromNode->rangeBounds[0])
            {
                newBoundValue0 = fromNode->rangeBounds[0] - edge->weight;
                
                if (newBoundValue0 + margin0 < *pMin)
                {
                    *pMin = newBoundValue0 + margin0;
                }
            }
            if (NA_RANGE != fromNode->rangeBounds[1])
            {
                newBoundValue1 = fromNode->rangeBounds[1] - edge->weight;
                
                if (newBoundValue1 + margin1 > *pMax)
                {
                    *pMax = newBoundValue1 + margin1;
                }
            }
            break;
            
        case RELATION_LESS_EQUAL_N:
        case RELATION_GREATER_EQUAL_N:
            if (NA_RANGE != fromNode->rangeBounds[1])
            {
                newBoundValue0 = edge->weight - fromNode->rangeBounds[1];
                
                if (newBoundValue0 + margin0 < *pMin)
                {
                    *pMin = newBoundValue0 + margin0;
                }
            }
            if (NA_RANGE != fromNode->rangeBounds[0])
            {
                newBoundValue1 = edge->weight - fromNode->rangeBounds[0];
                
                if (newBoundValue1 + margin1 > *pMax)
                {
                    *pMax = newBoundValue1 + margin1;
                }
            }
            break;
    }
    
    if (NA_RANGE != newBoundValue0 &&
        (NA_RANGE == node->rangeBounds[0] || newBoundValue0 > node->rangeBounds[0]))
    {
        node->rangeBounds[0] = newBoundValue0;
        return false;
    }
    if (NA_RANGE != newBoundValue1 &&
        (NA_RANGE == node->rangeBounds[1] || newBoundValue1 < node->rangeBounds[1]))
    {
        node->rangeBounds[1] = newBoundValue1;
        return false;
    }
    
    return true;
}

bool AlViewRelativeLayout::offsetRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param)
{
    int offset = *((int*) param);
    
    if (NA_RANGE != node->rangeBounds[0])
    {
        node->rangeBounds[0] += offset;
        node->rangeBounds[1] = node->rangeBounds[0];
        return false;
    }
    else if (NA_RANGE != node->rangeBounds[1])
    {
        node->rangeBounds[1] += offset;
        node->rangeBounds[0] = node->rangeBounds[1];
        return false;
    }
    else
    {
        return true;
    }
}

void AlViewRelativeLayout::solveRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount)
{
    for (map<int, RelationGraphNode*>::iterator iter = graphs.begin(); iter != graphs.end(); iter++)
    {
        // Find one node, at least one of which ranges can be confirmed :
        RelationGraphNode* node = iter->second;
        recursiveTraverseRelationGraph(node, nodeCount, &graphs, (CallbackInTraversingRelationGraph) (&AlViewRelativeLayout::updateRangeBounds), true);
    }
}

void AlViewRelativeLayout::decideRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount, CGSize& parentBound)
{
    for (map<int, RelationGraphNode*>::iterator iter = graphs.begin(); iter != graphs.end(); iter++)
    {
        // Find one node, at least one of which ranges can be confirmed :
        RelationGraphNode* node = iter->second;
        
        
        if (NA_RANGE == node->rangeBounds[0] && NA_RANGE == node->rangeBounds[1])
        {
            node->rangeBounds[0] = 0;
            node->rangeBounds[1] = 0;
            
            void* pastParams[3];
            map<RelationGraphNode*, int> relevantNodes;
            int min = 0;
            int max = 0;
            pastParams[2] = &relevantNodes;
            pastParams[0] = &min;
            pastParams[1] = &max;
            
            recursiveTraverseRelationGraph(node, nodeCount, pastParams, (CallbackInTraversingRelationGraph) (&AlViewRelativeLayout::decideRangeBoundsArbitrarily), true);
#ifdef DEBUG_OUTPUT
            printf("\n\nAfter [decideRangeBoundsArbitrarily \n");///!!!For Debug
            for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
            {
                RelationGraphNode* curNode = iter->second;
                printf("Node#%d : [%f, %f]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
            }
#endif
            int offset = 0;
            if (min < 0)
            {
                offset = -min;
            }
            else
            {
                switch (node->id & 0x7)
                {
                    case VAR_LEFT:
                    case VAR_RIGHT:
                        if (max >= parentBound.width)
                        {
                            offset = parentBound.width - max;
                        }
                        
                        break;
                    case VAR_TOP:
                    case VAR_BOTTOM:
                        if (max >= parentBound.height)
                        {
                            offset = parentBound.height - max;
                        }
                        break;
                }
            }
            
            if (0 != offset)
            {
                for (map<RelationGraphNode*, int>::iterator iter = relevantNodes.begin(); iter != relevantNodes.end(); iter++)
                {
                    RelationGraphNode* nodeToAdust = iter->first;
                    if (NA_RANGE != nodeToAdust->rangeBounds[0])
                    {
                        nodeToAdust->rangeBounds[0] += offset;
                        nodeToAdust->rangeBounds[1] = nodeToAdust->rangeBounds[0];
                    }
                    else if (NA_RANGE != nodeToAdust->rangeBounds[1])
                    {
                        nodeToAdust->rangeBounds[1] += offset;
                        nodeToAdust->rangeBounds[0] = nodeToAdust->rangeBounds[1];
                    }
                }
            }
#ifdef DEBUG_OUTPUT
            printf("\n\nAfter [offsetRangeBounds \n");///!!!For Debug
            for (map<int, RelationGraphNode*>::iterator iter = relationGraphs.begin(); iter != relationGraphs.end(); iter++)
            {
                RelationGraphNode* curNode = iter->second;
                printf("Node#%d : [%f, %f]\n", iter->first, curNode->rangeBounds[0], curNode->rangeBounds[1]);
            }
#endif
            relevantNodes.clear();
        }
        else
        {
            recursiveTraverseRelationGraph(node, nodeCount, NULL, (CallbackInTraversingRelationGraph) (&AlViewRelativeLayout::decideRangeBounds), true);
        }
    }
}

void AlViewRelativeLayout::clearRelationGraph (map<int, RelationGraphNode*>& graph)
{
    for (map<int, RelationGraphNode*>::iterator iter = graph.begin(); iter != graph.end(); iter++)
    {
        if (NULL != iter->second)
        {
            delete iter->second;
        }
    }
    graph.clear();
}

void AlViewRelativeLayout::updateRelationGraphs (map<int, RelationGraphNode*>& graphs, list<LayoutConstraint>* constraints)
{
    clearRelationGraph(graphs);
    
    int maxVars = 4 * (currentUsableID + 1); /// 2 * constraints->size(); ///
    RelationGraphNode** nodes = new RelationGraphNode*[maxVars];
    for (int i=maxVars-1; i>=0; i--)
    {
        nodes[i] = NULL;
    }
    
    for (list<LayoutConstraint>::iterator iter = constraints->begin(); iter != constraints->end(); iter++)
    {
        RelationGraphNode* pLeftNode;
        if (NULL == nodes[iter->leftOperandID])
        {
            pLeftNode = new RelationGraphNode(iter->leftOperandID);
            nodes[iter->leftOperandID] = pLeftNode;
            
            graphs.insert(make_pair(iter->leftOperandID, pLeftNode));
        }
        else
        {
            pLeftNode = nodes[iter->leftOperandID];
        }
        
        RelationGraphNode* pRightNode = NULL;
        if (NA_VAR != iter->rightOperandID)
        {
            if (NULL == nodes[iter->rightOperandID])
            {
                pRightNode = new RelationGraphNode(iter->rightOperandID);
                nodes[iter->rightOperandID] = pRightNode;
                
                graphs.insert(make_pair(iter->rightOperandID, pRightNode));
            }
            else
            {
                pRightNode = nodes[iter->rightOperandID];
            }
            
            RelationGraphEdge edge;
            edge.nextNode = pRightNode;
            edge.weight = iter->constant;
            pLeftNode->edgesFromMe[iter->relation].push_back(edge);
            
            edge.nextNode = pLeftNode;
            if (2 > iter->relation)
            {
                edge.weight = -iter->constant;
                pRightNode->edgesFromMe[1 - iter->relation].push_back(edge);
            }
            else
            {
                edge.weight = iter->constant;
                pRightNode->edgesFromMe[iter->relation].push_back(edge);
            }
        }
        else
        {
            if (NA_RANGE == pLeftNode->rangeBounds[1 - iter->relation] ||
                (0 == iter->relation && pLeftNode->rangeBounds[1] > iter->constant) ||
                (1 == iter->relation && pLeftNode->rangeBounds[0] < iter->constant))
            {
                pLeftNode->rangeBounds[1 - iter->relation] = iter->constant;
            }
        }
    }
    
    delete[] nodes;
}
