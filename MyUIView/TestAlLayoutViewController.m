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
    _btnCell = [[UIButton alloc] init];
    [_btnCell setBackgroundColor:[UIColor whiteColor]];
    _btnCell.clipsToBounds = YES;
    
    _btnTopBar = [[UIButton alloc] init];
    [_btnTopBar setBackgroundColor:[UIColor whiteColor]];
    _btnTopBar.clipsToBounds = YES;
    
    _btnRichMedia = [[UIButton alloc] init];
    [_btnRichMedia setBackgroundColor:[UIColor whiteColor]];
    _btnRichMedia.clipsToBounds = YES;
    
    _btnAuthorsAvatar = [[UIButton alloc] init];
    [_btnAuthorsAvatar setBackgroundColor:[UIColor redColor]];
    [_btnAuthorsAvatar setBackgroundImage:[UIImage imageNamed:@"altest_authoravatar.png"] forState:UIControlStateNormal];
    _btnAuthorsAvatar.clipsToBounds = YES;
    
    _btnCommentButton = [[UIButton alloc] init];
    [_btnCommentButton setBackgroundColor:[UIColor orangeColor]];
    [_btnCommentButton setBackgroundImage:[UIImage imageNamed:@"altest_button_comment.png"] forState:UIControlStateNormal];
    _btnCommentButton.clipsToBounds = YES;
    
    _btnForwardButton = [[UIButton alloc] init];
    [_btnForwardButton setBackgroundColor:[UIColor yellowColor]];
    [_btnForwardButton setBackgroundImage:[UIImage imageNamed:@"altest_button_forward.png"] forState:UIControlStateNormal];
    _btnForwardButton.clipsToBounds = YES;
    
    _btnForwardTimes = [[UIButton alloc] init];
    [_btnForwardTimes setBackgroundColor:[UIColor greenColor]];
    [_btnForwardTimes setBackgroundImage:[UIImage imageNamed:@"altest_label_forwardtimes.png"] forState:UIControlStateNormal];
    _btnForwardTimes.clipsToBounds = YES;
    
    _btnForwardedFollowers = [[UIButton alloc] init];
    [_btnForwardedFollowers setBackgroundColor:[UIColor cyanColor]];
    [_btnForwardedFollowers setBackgroundImage:[UIImage imageNamed:@"altest_label_forwardfollowers.png"] forState:UIControlStateNormal];
    _btnForwardedFollowers.clipsToBounds = YES;
    
    _btnThisMsg = [[UIButton alloc] init];
    [_btnThisMsg setBackgroundColor:[UIColor blueColor]];
    [_btnThisMsg setBackgroundImage:[UIImage imageNamed:@"altest_thismsg.png"] forState:UIControlStateNormal];
    _btnThisMsg.clipsToBounds = YES;
    
    _btnNickname = [[UIButton alloc] init];
    [_btnNickname setBackgroundColor:[UIColor purpleColor]];
    [_btnNickname setBackgroundImage:[UIImage imageNamed:@"altest_nickname.png"] forState:UIControlStateNormal];
    _btnNickname.clipsToBounds = YES;
    
    _btnVideo = [[UIButton alloc] init];
    [_btnVideo setBackgroundColor:[UIColor redColor]];
    [_btnVideo setBackgroundImage:[UIImage imageNamed:@"altest_video.png"] forState:UIControlStateNormal];
    _btnVideo.clipsToBounds = YES;
    
    _btnLargeImage = [[UIButton alloc] init];
    [_btnLargeImage setBackgroundColor:[UIColor redColor]];
    [_btnLargeImage setBackgroundImage:[UIImage imageNamed:@"altest_largeimage.png"] forState:UIControlStateNormal];
    _btnLargeImage.clipsToBounds = YES;
    
    _btnReferMsg = [[UIButton alloc] init];
    [_btnReferMsg setBackgroundColor:[UIColor orangeColor]];
    [_btnReferMsg setBackgroundImage:[UIImage imageNamed:@"altest_refermsg.png"] forState:UIControlStateNormal];
    _btnReferMsg.clipsToBounds = YES;
    
    
    [_btnTopBar addSubview:_btnAuthorsAvatar];
    [_btnTopBar addSubview:_btnCommentButton];
    [_btnTopBar addSubview:_btnForwardButton];
    [_btnTopBar addSubview:_btnForwardTimes];
    [_btnTopBar addSubview:_btnNickname];
    
    [_btnRichMedia addSubview:_btnVideo];
    [_btnRichMedia addSubview:_btnReferMsg];
    [_btnRichMedia addSubview:_btnLargeImage];
    [_btnRichMedia addSubview:_btnForwardedFollowers];
    
    [_btnCell addSubview:_btnTopBar];
    [_btnCell addSubview:_btnRichMedia];
    [_btnCell addSubview:_btnThisMsg];
    
    UIView* rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [rootView setBackgroundColor:[UIColor blackColor]];
    [self setView:rootView];
    [rootView addSubview:_btnCell];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    TMALRelativeLayouter* alCell = [[TMALRelativeLayouter alloc] init];
    TMALRelativeLayouter* alTopBar = [[TMALRelativeLayouter alloc] init];
    TMALRelativeLayouter* alRichMedia = [[TMALRelativeLayouter alloc] init];
    
    TMALLayouter* alAuthorsAvatar = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alNickname = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alForwardTimes = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alForwardButton = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alCommentButton = [[TMALLayouter alloc] initWithParent:nil];
    
    TMALLayouter* alThisMsg = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alReferMsg = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alVideo = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alLargeImage = [[TMALLayouter alloc] initWithParent:nil];
    TMALLayouter* alForwardedFollowers = [[TMALLayouter alloc] initWithParent:nil];
    
    TMALLayoutParameter lp;
    
// Top Bar Area //

// Author's Avatar //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnAuthorsAvatar sizeToFit];
    [alAuthorsAvatar setMeasuredPreferSize:[_btnAuthorsAvatar sizeThatFits:CGSizeZero]];
    [alTopBar addSubLayouter:alAuthorsAvatar withName:@"authorsavatar" layoutParameter:lp];
// Author's Nickname //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnNickname sizeToFit];
    [alNickname setMeasuredPreferSize:[_btnNickname sizeThatFits:CGSizeZero]];
    [alTopBar addSubLayouter:alNickname withName:@"nickname" layoutParameter:lp];
// Forward Times //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnForwardTimes sizeToFit];
    [alForwardTimes setMeasuredPreferSize:[_btnForwardTimes sizeThatFits:CGSizeZero]];
    [alTopBar addSubLayouter:alForwardTimes withName:@"forwardtimes" layoutParameter:lp];
// Forward Button //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnForwardButton sizeToFit];
    [alForwardButton setMeasuredPreferSize:[_btnForwardButton sizeThatFits:CGSizeZero]];
    [alTopBar addSubLayouter:alForwardButton withName:@"forwardbutton" layoutParameter:lp];
// Comment Button //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnCommentButton sizeToFit];
    [alCommentButton setMeasuredPreferSize:[_btnCommentButton sizeThatFits:CGSizeZero]];
    [alTopBar addSubLayouter:alCommentButton withName:@"commentbutton" layoutParameter:lp];
    
    [alTopBar setLayoutConstraintOfSubLayouter:alAuthorsAvatar toLeftOf:alNickname];
    [alTopBar setLayoutConstraintOfSubLayouter:alAuthorsAvatar withAnchor:ParentLeft];
    
    [alTopBar setLayoutConstraintOfSubLayouter:alCommentButton toRightOf:alForwardButton];
    [alTopBar setLayoutConstraintOfSubLayouter:alForwardButton toRightOf:alForwardTimes];
    
    [alTopBar setLayoutConstraintOfSubLayouter:alCommentButton withAnchor:ParentRight];
    
    [alTopBar setLayoutConstraintOfSubLayouter:alAuthorsAvatar withAnchor:ParentVerticalCenter];
    [alTopBar setLayoutConstraintOfSubLayouter:alNickname withAnchor:ParentVerticalCenter];
    [alTopBar setLayoutConstraintOfSubLayouter:alCommentButton withAnchor:ParentVerticalCenter];
    [alTopBar setLayoutConstraintOfSubLayouter:alForwardButton withAnchor:ParentVerticalCenter];
    [alTopBar setLayoutConstraintOfSubLayouter:alForwardTimes withAnchor:ParentVerticalCenter];
    
    lp.marginLeft = 0;
    lp.marginRight = 0;
    lp.marginTop = 0;
    lp.marginBottom = 0;
    lp.horizontalStretch = kLayoutFillParent;
    [alCell addSubLayouter:alTopBar withName:@"topbar" layoutParameter:lp];
    lp.horizontalStretch = kLayoutWrapContent;
    
// This Msg //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnThisMsg sizeToFit];
    [alThisMsg setMeasuredPreferSize:[_btnThisMsg sizeThatFits:CGSizeZero]];
    [alCell addSubLayouter:alThisMsg withName:@"thismsg" layoutParameter:lp];
    
// RichMedia //
    // Video //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnVideo sizeToFit];
    [alVideo setMeasuredPreferSize:[_btnVideo sizeThatFits:CGSizeZero]];
    [alRichMedia addSubLayouter:alVideo withName:@"video" layoutParameter:lp];
    // Large Image //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnLargeImage sizeToFit];
    [alLargeImage setMeasuredPreferSize:[_btnLargeImage sizeThatFits:CGSizeZero]];
    [alRichMedia addSubLayouter:alLargeImage withName:@"largeimage" layoutParameter:lp];
    // Refer Msg //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnReferMsg sizeToFit];
    [alReferMsg setMeasuredPreferSize:[_btnReferMsg sizeThatFits:CGSizeZero]];
    [alRichMedia addSubLayouter:alReferMsg withName:@"refermsg" layoutParameter:lp];
    // Forwarded Followers //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_btnForwardedFollowers sizeToFit];
    [alForwardedFollowers setMeasuredPreferSize:[_btnForwardedFollowers sizeThatFits:CGSizeZero]];
    [alRichMedia addSubLayouter:alForwardedFollowers withName:@"forwardedfollwers" layoutParameter:lp];
    
    [alRichMedia setLayoutConstraintOfSubLayouter:alLargeImage below:alVideo];
    [alRichMedia setLayoutConstraintOfSubLayouter:alReferMsg below:alLargeImage];
    [alRichMedia setLayoutConstraintOfSubLayouter:alForwardedFollowers below:alReferMsg];
    
    lp.marginLeft = 0;
    lp.marginRight = 0;
    lp.marginTop = 0;
    lp.marginBottom = 0;
    [alCell addSubLayouter:alRichMedia withName:@"richmedia" layoutParameter:lp];
    
/* EastSouth //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alEastSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [alCell addSubLayouter:alEastSouth withName:@"eastsouth" layoutParameter:lp];
// WestSouth //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [alWestSouth setMeasuredPreferSize:CGSizeMake(60, 60)];
    [alCell addSubLayouter:alWestSouth withName:@"westsouth" layoutParameter:lp];
//*/
    
    //[alCell setLayoutConstraintOfSubLayouter:alWest toLeftOf:alNorth];
    
    [alCell setLayoutConstraintOfSubLayouter:alTopBar withAnchor:ParentLeft];
    [alCell setLayoutConstraintOfSubLayouter:alTopBar withAnchor:ParentRight];
    
    [alCell setLayoutConstraintOfSubLayouter:alThisMsg below:alTopBar];
    [alCell setLayoutConstraintOfSubLayouter:alThisMsg withAnchor:ParentLeft];
    
    [alCell setLayoutConstraintOfSubLayouter:alRichMedia below:alTopBar];
    [alCell setLayoutConstraintOfSubLayouter:alRichMedia toRightOf:alThisMsg];
    ///[alCell setLayoutConstraintOfSubLayouter:alRichMedia withAnchor:ParentRight];
    
    [alCell layout:CGSizeZero];
    ///[alCell onLayout];
    
    _btnForwardTimes.frame = [alTopBar subLayouterOfName:@"forwardtimes"].layoutedFrame;
    _btnCommentButton.frame = [alTopBar subLayouterOfName:@"commentbutton"].layoutedFrame;
    _btnAuthorsAvatar.frame = [alTopBar subLayouterOfName:@"authorsavatar"].layoutedFrame;
    _btnForwardButton.frame = [alTopBar subLayouterOfName:@"forwardbutton"].layoutedFrame;
    _btnNickname.frame = [alTopBar subLayouterOfName:@"nickname"].layoutedFrame;
    
    _btnTopBar.frame = [alCell subLayouterOfName:@"topbar"].layoutedFrame;
    
    _btnThisMsg.frame = [alCell subLayouterOfName:@"thismsg"].layoutedFrame;
    
    _btnVideo.frame = [alRichMedia subLayouterOfName:@"video"].layoutedFrame;
    _btnLargeImage.frame = [alRichMedia subLayouterOfName:@"largeimage"].layoutedFrame;
    
    _btnRichMedia.frame = [alCell subLayouterOfName:@"richmedia"].layoutedFrame;
    
    _btnForwardedFollowers.frame = [alRichMedia subLayouterOfName:@"forwardedfollowers"].layoutedFrame;
    _btnReferMsg.frame = [alRichMedia subLayouterOfName:@"refermsg"].layoutedFrame;
    
    [_btnCell setFrame:CGRectMake(0, 0, [alCell measuredPreferSize].width, [alCell measuredPreferSize].height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
