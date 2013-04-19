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
#import "UIRelativeLayouter.h"
#import "UIView+AlViewLayout.h"


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
    UIRelativeLayouter* layouterParent = [[UIRelativeLayouter alloc] initWithUIView:_btnParent];
    [_btnParent setAlLayouter:layouterParent];
    
    UIAlLayouter* layouterA = [_btnA alLayouter];///[[UIAlLayouter alloc] initWithUIView:_btnA layouter:NULL];
    
    UIAlLayouter* layouterB = [_btnB alLayouter];///[[UIAlLayouter alloc] initWithUIView:_btnB layouter:NULL];
    
    AlViewLayoutParameter lp;
    lp.horizontalLayoutFlag = kLayoutFlagPrecise;
    lp.verticalLayoutFlag = kLayoutFlagPrecise;
    
    AlViewLayout* a = layouterA.layouter;
    lp.givenSize = CGSizeMake(60, 60);
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 0;
    lp.marginBottom = 10;
    
    AlViewRelativeLayout* alRelativeLayout = (AlViewRelativeLayout*) layouterParent.layouter;
    alRelativeLayout->addChild(a, lp);
    
    AlViewLayout* b = layouterB.layouter;
    lp.givenSize = CGSizeMake(50, 50);
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 10;
    alRelativeLayout->addChild(b, lp);

    //alRelativeLayout->addLayoutRelation(b, b, kLayoutRelationAlignParentBottom);
    //alRelativeLayout->addLayoutRelation(a, b, kLayoutRelationAlignParentRight);
    //alRelativeLayout->addLayoutRelation(a, b, kLayoutRelationAlignBottomWith);
    alRelativeLayout->addLayoutRelation(a, b, kLayoutRelationToLeftOf);
    alRelativeLayout->addLayoutRelation(a, b, kLayoutRelationAbove);
    //alRelativeLayout->addLayoutRelation(a, b, kLayoutRelationAlignParentLeft);
    //alRelativeLayout->addLayoutRelation(a, a, kLayoutRelationAlignParentTop);
    
    //alRelativeLayout->addLayoutRelation(a, a, kLayoutRelationCenterParentHorizontal);
    ///alRelativeLayout->addLayoutRelation(a, b, kLayoutRelationCenterHorizontalWith);
    alRelativeLayout->addLayoutRelation(a, a, kLayoutRelationCenterParentVertical);
    
    lp.givenSize = CGSizeMake(130, 200);
    alRelativeLayout->measure(lp);
    alRelativeLayout->applyLayout();
    
    [layouterParent release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
