//
//  MainViewController.m
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+AlViewLayout.h"
#import "AlRelativeLayoutManager.h"

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
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AlRelativeLayoutManager* layoutManager = [[AlRelativeLayoutManager alloc] init];
    
    AlLayoutParameter* lp;
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnCenter setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnCenter layoutParameter:lp];
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnWest setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnWest layoutParameter:lp];
//*
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnNorth layoutParameter:lp];
//*/
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnEast setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnEast layoutParameter:lp];

    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnSouth layoutParameter:lp];
//*/
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnWestNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnWestNorth layoutParameter:lp];
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnEastNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnEastNorth layoutParameter:lp];

    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnEastSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnEastSouth layoutParameter:lp];
    
    lp = [[AlLayoutParameter alloc] init];
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnWestSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubView:_btnWestSouth layoutParameter:lp];
//*/
    
    //[layoutManager setLayoutConstraintOfSubView:_btnWest toLeftOf:_btnNorth];
    
    [layoutManager setLayoutConstraintOfSubView:_btnWest toLeftOf:_btnCenter];
    [layoutManager setLayoutConstraintOfSubView:_btnCenter toLeftOf:_btnEast];
    
    [layoutManager setLayoutConstraintOfSubView:_btnNorth toRightOf:_btnWestNorth];
    [layoutManager setLayoutConstraintOfSubView:_btnEastNorth toRightOf:_btnNorth];

    [layoutManager setLayoutConstraintOfSubView:_btnWestSouth toLeftOf:_btnSouth];
    [layoutManager setLayoutConstraintOfSubView:_btnEastSouth toRightOf:_btnSouth];

    [layoutManager setLayoutConstraintOfSubView:_btnCenter below:_btnNorth];
    [layoutManager setLayoutConstraintOfSubView:_btnWestNorth above:_btnWest];
    [layoutManager setLayoutConstraintOfSubView:_btnEastNorth above:_btnEast];

    [layoutManager setLayoutConstraintOfSubView:_btnEastSouth below:_btnEast];
    
    [layoutManager setLayoutConstraintOfSubView:_btnWest above:_btnWestSouth];

    [layoutManager setLayoutConstraintOfSubView:_btnNorth withAnchor:ParentHorizontalCenter];
    //[layoutManager setLayoutConstraintOfSubView:_btnCenter withAnchor:ParentVerticalCenter];

//    [layoutManager setLayoutConstraintOfSubView:_btnWest withAnchor:ParentLeft];
    [layoutManager setLayoutConstraintOfSubView:_btnNorth withAnchor:ParentTop];///!!!
//    [layoutManager setLayoutConstraintOfSubView:_btnEast withAnchor:ParentRight];
    [layoutManager setLayoutConstraintOfSubView:_btnSouth withAnchor:ParentBottom];
    
    //[layoutManager setLayoutConstraintOfSubView:_btnWestNorth withAnchor:ParentLeft];
    [layoutManager setLayoutConstraintOfSubView:_btnWestSouth withAnchor:ParentLeft];
    
    //[layoutManager setLayoutConstraintOfSubView:_btnEastNorth withAnchor:ParentRight];
    [layoutManager setLayoutConstraintOfSubView:_btnEastSouth withAnchor:ParentRight];
    
    //[layoutManager setLayoutConstraintOfSubView:_btnWestNorth withAnchor:ParentTop];
    //[layoutManager setLayoutConstraintOfSubView:_btnEastNorth withAnchor:ParentTop];
    
    [layoutManager setLayoutConstraintOfSubView:_btnEastSouth withAnchor:ParentBottom];
    [layoutManager setLayoutConstraintOfSubView:_btnWestSouth withAnchor:ParentBottom];
    
    
    [layoutManager onLayout];
    [layoutManager onLayout];
    [_btnParent setFrame:CGRectMake(0, 0, [layoutManager measuredPreferSize].width, [layoutManager measuredPreferSize].height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
