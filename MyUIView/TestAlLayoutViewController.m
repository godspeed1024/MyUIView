//
//  MainViewController.m
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "TestAlLayoutViewController.h"
#import "UIView+AlViewLayout.h"
#import "TMALRelativeLayouter.h"
#import "TMALLayoutParameter.h"

@interface TestAlLayoutViewController ()

@end

@implementation TestAlLayoutViewController

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
    
    TMALRelativeLayouter* layoutManager = [[TMALRelativeLayouter alloc] init];
    
    TMALLayouter* alCenter = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alWest = [[TMALLayouter alloc] initWithParent:layoutManager];
    TMALLayouter* alEast = [[TMALLayouter alloc] initWithParent:layoutManager];
    TMALLayouter* alNorth = [[TMALLayouter alloc] initWithParent:layoutManager];
    TMALLayouter* alSouth = [[TMALLayouter alloc] initWithParent:layoutManager];
    TMALLayouter* alWestNorth = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alEastNorth = [[TMALLayouter alloc] initWithParent:layoutManager];
    TMALLayouter* alWestSouth = [[TMALLayouter alloc] initWithParent:layoutManager];
    TMALLayouter* alEastSouth = [[TMALLayouter alloc] initWithParent:layoutManager];
    
    TMALLayoutParameter lp;
// Center //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alCenter setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alCenter withName:@"center" layoutParameter:lp];
// West //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alWest setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alWest withName:@"west" layoutParameter:lp];
// North //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alNorth withName:@"north" layoutParameter:lp];
// East //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alEast setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alEast withName:@"east" layoutParameter:lp];
// South //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alSouth withName:@"south" layoutParameter:lp];
// WestNorth */
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alWestNorth setMeasuredPreferSize:CGSizeMake(10, 10)];
    [layoutManager addSubLayouter:alWestNorth withName:@"westnorth" layoutParameter:lp];
// EastNorth //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alEastNorth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alEastNorth withName:@"eastnorth" layoutParameter:lp];
// EastSouth //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alEastSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alEastSouth withName:@"eastsouth" layoutParameter:lp];
// WestSouth //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alWestSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [layoutManager addSubLayouter:alWestSouth withName:@"westsouth" layoutParameter:lp];
//*/
    
    //[layoutManager setLayoutConstraintOfSubLayouter:alWest toLeftOf:alNorth];
    
    [layoutManager setLayoutConstraintOfSubLayouter:alWest toLeftOf:alCenter];
    [layoutManager setLayoutConstraintOfSubLayouter:alCenter toLeftOf:alEast];

    [layoutManager setLayoutConstraintOfSubLayouter:alWestNorth toLeftOf:alNorth];
    [layoutManager setLayoutConstraintOfSubLayouter:alEastNorth toRightOf:alNorth];

    [layoutManager setLayoutConstraintOfSubLayouter:alWestSouth toLeftOf:alSouth];
    [layoutManager setLayoutConstraintOfSubLayouter:alEastSouth toRightOf:alSouth];

    [layoutManager setLayoutConstraintOfSubLayouter:alCenter below:alNorth];
    [layoutManager setLayoutConstraintOfSubLayouter:alWestNorth above:alWest];
    [layoutManager setLayoutConstraintOfSubLayouter:alEastNorth above:alEast];

    [layoutManager setLayoutConstraintOfSubLayouter:alEastSouth below:alEast];
    
    [layoutManager setLayoutConstraintOfSubLayouter:alWest above:alWestSouth];

    [layoutManager setLayoutConstraintOfSubLayouter:alNorth withAnchor:ParentHorizontalCenter];
    [layoutManager setLayoutConstraintOfSubLayouter:alCenter withAnchor:ParentVerticalCenter];

    [layoutManager setLayoutConstraintOfSubLayouter:alWest withAnchor:ParentLeft];
    [layoutManager setLayoutConstraintOfSubLayouter:alNorth withAnchor:ParentTop];///!!!
    [layoutManager setLayoutConstraintOfSubLayouter:alEast withAnchor:ParentRight];
    [layoutManager setLayoutConstraintOfSubLayouter:alSouth withAnchor:ParentBottom];
    
    //[layoutManager setLayoutConstraintOfSubLayouter:alWestNorth withAnchor:ParentLeft];
    [layoutManager setLayoutConstraintOfSubLayouter:alWestSouth withAnchor:ParentLeft];
    
    [layoutManager setLayoutConstraintOfSubLayouter:alEastNorth withAnchor:ParentRight];
    [layoutManager setLayoutConstraintOfSubLayouter:alEastSouth withAnchor:ParentRight];
    
    //[layoutManager setLayoutConstraintOfSubLayouter:alWestNorth withAnchor:ParentTop];
    [layoutManager setLayoutConstraintOfSubLayouter:alEastNorth withAnchor:ParentTop];
    
    [layoutManager setLayoutConstraintOfSubLayouter:alEastSouth withAnchor:ParentBottom];
    [layoutManager setLayoutConstraintOfSubLayouter:alWestSouth withAnchor:ParentBottom];
    
    
    [layoutManager onLayout];
    [layoutManager onLayout];
    
    _btnCenter.frame = [layoutManager subLayouterOfName:@"center"].layoutedFrame;
    _btnWest.frame = [layoutManager subLayouterOfName:@"west"].layoutedFrame;
    _btnEast.frame = [layoutManager subLayouterOfName:@"east"].layoutedFrame;
    _btnNorth.frame = [layoutManager subLayouterOfName:@"north"].layoutedFrame;
    _btnSouth.frame = [layoutManager subLayouterOfName:@"south"].layoutedFrame;
    _btnWestNorth.frame = [layoutManager subLayouterOfName:@"westnorth"].layoutedFrame;
    _btnEastNorth.frame = [layoutManager subLayouterOfName:@"eastnorth"].layoutedFrame;
    _btnWestSouth.frame = [layoutManager subLayouterOfName:@"westsouth"].layoutedFrame;
    _btnEastSouth.frame = [layoutManager subLayouterOfName:@"eastsouth"].layoutedFrame;
    
    [_btnParent setFrame:CGRectMake(0, 0, [layoutManager measuredPreferSize].width, [layoutManager measuredPreferSize].height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
