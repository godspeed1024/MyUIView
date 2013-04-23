//
//  MainViewController.m
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "MainViewController.h"
#import "AlViewRelativeLayout.h"
#import "UIAlLayouter.h"
#import "UIView+AlViewLayout.h"
#import "UIRelativeLayoutManager.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView
{
    _btnParent = [[UIButton alloc] init];
    [_btnParent setBackgroundColor:[UIColor whiteColor]];
    _btnParent.clipsToBounds = YES;
    
    _btnWestNorth = [[UIButton alloc] init];
    [_btnWestNorth setBackgroundColor:[UIColor redColor]];
    _btnWestNorth.clipsToBounds = YES;
    
    _btnNorth = [[UIButton alloc] init];
    [_btnNorth setBackgroundColor:[UIColor orangeColor]];
    _btnNorth.clipsToBounds = YES;
    
    _btnEastNorth = [[UIButton alloc] init];
    [_btnEastNorth setBackgroundColor:[UIColor yellowColor]];
    _btnEastNorth.clipsToBounds = YES;
    
    _btnWest = [[UIButton alloc] init];
    [_btnWest setBackgroundColor:[UIColor greenColor]];
    _btnWest.clipsToBounds = YES;
    
    _btnCenter = [[UIButton alloc] init];
    [_btnCenter setBackgroundColor:[UIColor cyanColor]];
    _btnCenter.clipsToBounds = YES;
    
    _btnEast = [[UIButton alloc] init];
    [_btnEast setBackgroundColor:[UIColor blueColor]];
    _btnEast.clipsToBounds = YES;
    
    _btnWestSouth = [[UIButton alloc] init];
    [_btnWestSouth setBackgroundColor:[UIColor purpleColor]];
    _btnWestSouth.clipsToBounds = YES;
    
    _btnSouth = [[UIButton alloc] init];
    [_btnSouth setBackgroundColor:[UIColor redColor]];
    _btnSouth.clipsToBounds = YES;
    
    _btnEastSouth = [[UIButton alloc] init];
    [_btnEastSouth setBackgroundColor:[UIColor orangeColor]];
    _btnEastSouth.clipsToBounds = YES;
    
    
    [_btnParent addSubview:_btnWestNorth];
    [_btnParent addSubview:_btnNorth];
    [_btnParent addSubview:_btnEastNorth];
    [_btnParent addSubview:_btnWest];
    [_btnParent addSubview:_btnCenter];
    [_btnParent addSubview:_btnEast];
    [_btnParent addSubview:_btnWestSouth];
    [_btnParent addSubview:_btnSouth];
    [_btnParent addSubview:_btnEastSouth];
    
    UIView* rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [rootView setBackgroundColor:[UIColor blackColor]];
    [self setView:rootView];
    [rootView addSubview:_btnParent];
    [rootView release];
}

- (void) dealloc
{
    [super dealloc];
    [_btnParent release];
    [_btnWestNorth release];
    [_btnEastNorth release];
    [_btnWestSouth release];
    [_btnWest release];
    [_btnNorth release];
    [_btnEast release];
    [_btnEastSouth release];
    [_btnSouth release];
    [_btnCenter release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIRelativeLayoutManager* layoutManager = [[UIRelativeLayoutManager alloc] init];
    /*
    UIAlLayouter* layouterWestNorth = [_btnWestNorth alLayouter];///[[UIAlLayouter alloc] initWithUIView:_btnA layouter:NULL];
    UIAlLayouter* layouterWestSouth = [_btnWestSouth alLayouter];
    UIAlLayouter* layouterEastNorth = [_btnEastNorth alLayouter];
    UIAlLayouter* layouterEastSouth = [_btnEastSouth alLayouter];
    UIAlLayouter* layouterNorth = [_btnNorth alLayouter];
    UIAlLayouter* layouterSouth = [_btnSouth alLayouter];
    UIAlLayouter* layouterCenter = [_btnCenter alLayouter];
    UIAlLayouter* layouterEast = [_btnEast alLayouter];
    UIAlLayouter* layouterWest = [_btnWest alLayouter];
    //*/
    AlLayoutParameter* lp;
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnCenter setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnCenter layoutParameter:lp];
    [lp release];
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnWest setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnWest layoutParameter:lp];
    [lp release];
    /*
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnNorth layoutParameter:lp];
    [lp release];
    //*/
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnEast setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnEast layoutParameter:lp];
    [lp release];
/*
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnSouth layoutParameter:lp];
    [lp release];

    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnWestNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnWestNorth layoutParameter:lp];
    [lp release];
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnEastNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnEastNorth layoutParameter:lp];
    [lp release];
    //*
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnEastSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnEastSouth layoutParameter:lp];
    [lp release];
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnWestSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnWestSouth layoutParameter:lp];
    [lp release];
    //*/
    
    [layoutManager setLayoutConstraintOfSubView:_btnWest toLeftOf:_btnCenter];
    [layoutManager setLayoutConstraintOfSubView:_btnCenter toLeftOf:_btnEast];
    
    ///[layoutManager setLayoutConstraintOfSubView:_btnNorth toRightOf:_btnWestNorth];
    ///[layoutManager setLayoutConstraintOfSubView:_btnEastNorth toRightOf:_btnNorth];
    /*
    alRelativeLayout->addLayoutRelation(westSouth, south, kLayoutRelationToLeftOf);
    alRelativeLayout->addLayoutRelation(eastSouth, south, kLayoutRelationToRightOf);
    
    alRelativeLayout->addLayoutRelation(center, north, kLayoutRelationBelow);
    alRelativeLayout->addLayoutRelation(westNorth, west, kLayoutRelationAbove);
    
    alRelativeLayout->addLayoutRelation(eastSouth, east, kLayoutRelationBelow);
    alRelativeLayout->addLayoutRelation(east, eastNorth, kLayoutRelationBelow);
    
    alRelativeLayout->addLayoutRelation(west, westSouth, kLayoutRelationAbove);
    
    alRelativeLayout->addLayoutRelation(center, center, kLayoutRelationCenterParentHorizontal);
    alRelativeLayout->addLayoutRelation(center, center, kLayoutRelationCenterParentVertical);
    
    alRelativeLayout->addLayoutRelation(west, NULL, kLayoutRelationAlignParentLeft);
    alRelativeLayout->addLayoutRelation(north, NULL, kLayoutRelationAlignParentTop);
    alRelativeLayout->addLayoutRelation(east, NULL, kLayoutRelationAlignParentRight);
    alRelativeLayout->addLayoutRelation(south, NULL, kLayoutRelationAlignParentBottom);
    
    alRelativeLayout->addLayoutRelation(westNorth, NULL, kLayoutRelationAlignParentLeft);
    alRelativeLayout->addLayoutRelation(westSouth, west, kLayoutRelationAlignParentLeft);
    
    alRelativeLayout->addLayoutRelation(eastNorth, eastSouth, kLayoutRelationAlignParentRight);
    alRelativeLayout->addLayoutRelation(eastSouth, east, kLayoutRelationAlignParentRight);
    
    alRelativeLayout->addLayoutRelation(westNorth, eastNorth, kLayoutRelationAlignParentTop);
    alRelativeLayout->addLayoutRelation(eastNorth, north, kLayoutRelationAlignParentTop);
    
    alRelativeLayout->addLayoutRelation(eastSouth, eastSouth, kLayoutRelationAlignParentBottom);
    alRelativeLayout->addLayoutRelation(westSouth, westSouth, kLayoutRelationAlignParentBottom);
    
     lp.givenSize = CGSizeMake(320, 360);
    alRelativeLayout->measure(lp);
    alRelativeLayout->applyLayout();
     //*/
    [layoutManager onLayout];
    [_btnParent setFrame:CGRectMake(0, 0, [layoutManager measuredPreferSize].width, [layoutManager measuredPreferSize].height)];
    ///!!![layoutManager autorelease];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
