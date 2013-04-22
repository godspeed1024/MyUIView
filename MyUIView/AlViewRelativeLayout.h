//
//  AlViewRelativeLayout.h
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#ifndef __MyUIView__AlViewRelativeLayout__
#define __MyUIView__AlViewRelativeLayout__

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

#include <list>
#include <map>
#include "BitMatrix.h"
#include "AlViewContainerLayout.h"

using namespace std;


typedef struct
{
    // leftOpr =?= coefficent * rightOpr + constant
    int leftOperandID;
    int rightOperandID;
    
    int coefficient;
    float constant;
    
    int relation;
} LayoutConstraint;


class RelationGraphNode;
typedef struct RelationGraphEdgeStruct
{
    RelationGraphNode* nextNode;
    int weight;
} RelationGraphEdge;


class RelationGraphNode
{
    friend class AlViewRelativeLayout;
    
public:
    
    inline RelationGraphNode (int nodeId)
    {
        id = nodeId;
        rangeBounds[0] = NA_RANGE;
        rangeBounds[1] = NA_RANGE;
    }
    
    // 0: this <= that + k;
    // 1: this >= that + k;
    // 2: this <= k - that;
    // 3: this >= k - that;
    list<RelationGraphEdge> edgesFromMe[4];
    float rangeBounds[2];
    int id;
};

typedef struct LayoutChainNodeStruct
{
    AlViewLayout*    layouter;
    map<LayoutChainNodeStruct*, AlViewLayout*> nextNodes[2];
} LayoutChainNode;

class AlViewRelativeLayout : public AlViewContainerLayout
{
public:
    
    // true : Skip
    typedef bool (AlViewRelativeLayout::*CallbackInTraversingRelationGraph) (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param);
    
    inline virtual ~AlViewRelativeLayout (void)
    {
#ifdef V2
        horizontalLayoutChainRoots.clear();
        verticalLayoutChainRoots.clear();
        clearLayoutChainGraph(horizontalLayoutChains);
        clearLayoutChainGraph(verticalLayoutChains);
        layoutFlagsOfNode.clear();
#else
        clearRelationGraph(relationGraphs);
#endif
    }
    
    void addLayoutRelation (int leftOperandID, int rightOperandID, int layoutRelation);
    
    void addLayoutRelation (AlViewLayout* leftOperandChild, AlViewLayout* rightOperandChild, int layoutRelation);
    
    void onMeasure (AlViewLayoutParameter givenLayoutParam);
    
protected:
    
    list<LayoutConstraint> interpretedConstraints;
    list<LayoutConstraint> suspendingConstraints;
    
private:
    
    bool needsUpdateRelationGraph;
    
    void interpretLayoutConstraint (LayoutConstraint originalLC);
    
    void interpretConstraintsWithChildsBound (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, CGSize bound);
    
    void interpretConstraintsWithParentsBound (list<LayoutConstraint>* reinterpretedConstraints, LayoutConstraint originalLC, AlViewLayoutParameter layoutParam);
    
    void updateRelationGraphs (map<int, RelationGraphNode*>& graphs, list<LayoutConstraint>* constraints);
    
    void solveRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount);
    
    void decideRelationGraphs (map<int, RelationGraphNode*>& graphs, int nodeCount, CGSize& parentBound);
    
    static void clearRelationGraph (map<int, RelationGraphNode*>& graph);
    
    map<int, RelationGraphNode*> relationGraphs;
    
    
    bool updateRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param);
    
    bool decideRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param);
    bool decideRangeBoundsArbitrarily (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param);
    
    bool offsetRangeBounds (RelationGraphNode* node, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge, void* param);
    
    void recursiveTraverseRelationGraph (RelationGraphNode* startNode, int nodeCount,
                                         void* param, CallbackInTraversingRelationGraph callback,
                                         bool allowReEnterInNode);
    
    void doRecursiveTraverse (RelationGraphNode* curNode, int direction, RelationGraphNode* fromNode, RelationGraphEdge* edge,
                              void* params, CallbackInTraversingRelationGraph callback,
                              bool allowReEnterInNode);
    
    ///static void recursiveUpdateGraphNodes (RelationGraphNode* node, int direction, BitMatrix* stamps);
    //////////////////////
    
    static void clearLayoutChainGraph (map<AlViewLayout*, LayoutChainNode*>& graph);
    
    bool canBeLayoutChainRootCandidate (LayoutChainNode* node);
    
    float recursiveFindMaxWidthOfHorizontalChain (LayoutChainNode* curNode, byte direction,
                                                  float curPosition, map<AlViewLayout*, CGRect>& framesOfChildren);
    void recursiveOffsetHorizontalChains (LayoutChainNode* curNode, int direction, float offset, map<AlViewLayout*, CGRect>& framesOfChildren);
    
    float recursiveFindMaxHeightOfVerticalChain (LayoutChainNode* curNode, byte direction,
                                                 float curPosition, map<AlViewLayout*, CGRect>& framesOfChildren);
    void recursiveOffsetVerticalChains (LayoutChainNode* curNode, int direction, float offset, map<AlViewLayout*, CGRect>& framesOfChildren);
    
    map<AlViewLayout*, LayoutChainNode*> horizontalLayoutChains;
    map<AlViewLayout*, LayoutChainNode*> verticalLayoutChains;
    
    map<LayoutChainNode*, AlViewLayout*> horizontalLayoutChainRoots;
    map<LayoutChainNode*, AlViewLayout*> verticalLayoutChainRoots;
    
    map<LayoutChainNode*, int> layoutFlagsOfNode;
};

#endif /* defined(__MyUIView__AlViewRelativeLayout__) */
