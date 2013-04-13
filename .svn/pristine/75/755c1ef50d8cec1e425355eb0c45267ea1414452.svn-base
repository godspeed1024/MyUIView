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
    
    [self setView:_btnParent];
    [_btnParent addSubview:_btnA];
    [_btnParent addSubview:_btnB];
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
    parent->addChild(a, lp);
    
    AlViewLayout* b = auvB.layouter;
    lp.givenSize = CGSizeMake(50, 50);
    parent->addChild(b, lp);
    
    ///parent->setLayoutRelation(1, 1, kLayoutRelationAlignParentBottom);
    
    parent->setLayoutRelation(1, 0, kLayoutRelationAlignParentRight);
    parent->setLayoutRelation(0, 1, kLayoutRelationAbove);
    parent->setLayoutRelation(1, 0, kLayoutRelationToRightOf);
    parent->setLayoutRelation(0, 1, kLayoutRelationAlignParentLeft);
    parent->setLayoutRelation(0, 0, kLayoutRelationAlignParentTop);
    
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
