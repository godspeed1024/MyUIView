//
//  MainViewController.m
//  MyUIView
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import "MainViewController.h"
#import "AlUIView.h"
#import "AlViewRelativeLayout.h"

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
    [_btnParent setBackgroundColor:[UIColor greenColor]];
    _btnParent.clipsToBounds = YES;
    
    _btnA = [[UIButton alloc] init];
    [_btnA setBackgroundColor:[UIColor redColor]];
    _btnA.clipsToBounds = YES;
    
    _btnB = [[UIButton alloc] init];
    [_btnB setBackgroundColor:[UIColor blueColor]];
    _btnB.clipsToBounds = YES;
    
    [_btnParent addSubview:_btnA];
    [_btnParent addSubview:_btnB];
    
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
    [_btnA release];
    [_btnB release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    AlViewRelativeLayout* parent = new AlViewRelativeLayout;
    AlUIView* auvParent = [[AlUIView alloc] initWithUIView:_btnParent layouter:parent];
    
    AlUIView* auvA = [[AlUIView alloc] initWithUIView:_btnA];
    
    AlUIView* auvB = [[AlUIView alloc] initWithUIView:_btnB];
    
    AlViewLayoutParameter lp;
    lp.horizontalLayoutFlag = kLayoutFlagPrecise;
    lp.verticalLayoutFlag = kLayoutFlagPrecise;
    
    AlViewLayout* a = auvA.layouter;
    lp.givenSize = CGSizeMake(60, 60);
    lp.marginLeft = 5;
    lp.marginRight = 0;
    lp.marginTop = 10;
    lp.marginBottom = 0;
    parent->addChild(a, lp);
    
    AlViewLayout* b = auvB.layouter;
    lp.givenSize = CGSizeMake(50, 50);
    lp.marginLeft = 0;
    lp.marginRight = 5;
    lp.marginTop = 0;
    lp.marginBottom = 5;
    //parent->addChild(b, lp);

    //parent->addLayoutRelation(b, b, kLayoutRelationAlignParentBottom);
    //parent->addLayoutRelation(b, a, kLayoutRelationAlignParentRight);
    //parent->addLayoutRelation(a, b, kLayoutRelationAbove);
    //parent->addLayoutRelation(b, a, kLayoutRelationToRightOf);
    //parent->addLayoutRelation(a, b, kLayoutRelationAlignParentLeft);
    parent->addLayoutRelation(a, a, kLayoutRelationAlignParentTop);
    
    parent->addLayoutRelation(a, a, kLayoutRelationCenterParentHorizontal);
    ///parent->addLayoutRelation(a, b, kLayoutRelationCenterHorizontalWith);
    parent->addLayoutRelation(a, a, kLayoutRelationCenterParentVertical);
    
    lp.givenSize = CGSizeMake(120, 200);
    parent->measure(lp);
    parent->applyLayout();
    
    delete parent;
    
    [auvParent release];
    [auvA release];
    [auvB release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
