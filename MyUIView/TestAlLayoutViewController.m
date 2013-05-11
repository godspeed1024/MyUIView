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

#define RootLayouter alRootArea
#define RootUIView   _rootArea


@implementation TwoPassMeasuringLayouter

- (id) initWithArea:(CGFloat)area
{
    self = [super init];
    if (nil != self)
    {
        _area = area;
    }
    return self;
}

- (CGSize) onMeasure:(CGSize)givenSize
{
    if (givenSize.width != 0.0f)
    {
        givenSize.height = _area / givenSize.width;
    }
    else if (givenSize.height != 0.0f)
    {
        givenSize.width = _area / givenSize.height;
    }
    else
    {
        givenSize.width = sqrtf(_area);
        givenSize.height = sqrtf(_area);
    }
    return givenSize;
}

@end


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
    _rootArea = [[UIButton alloc] init];
    [_rootArea setBackgroundColor:[UIColor whiteColor]];
    _rootArea.clipsToBounds = YES;
    
    _topBar = [[UIButton alloc] init];
    [_topBar setBackgroundColor:[UIColor whiteColor]];
    _topBar.clipsToBounds = YES;
    
    _rightArea = [[UIButton alloc] init];
    [_rightArea setBackgroundColor:[UIColor whiteColor]];
    _rightArea.clipsToBounds = YES;
    
    _authorsAvatar = [[UIButton alloc] init];
    [_authorsAvatar setBackgroundColor:[UIColor redColor]];
    [_authorsAvatar setBackgroundImage:[UIImage imageNamed:@"altest_authoravatar.png"] forState:UIControlStateNormal];
    _authorsAvatar.clipsToBounds = YES;
    
    _forwardTimes = [[UIButton alloc] init];
    [_forwardTimes setBackgroundColor:[UIColor greenColor]];
    [_forwardTimes setBackgroundImage:[UIImage imageNamed:@"altest_label_forwardtimes.png"] forState:UIControlStateNormal];
    _forwardTimes.clipsToBounds = YES;
    
    _commentButton = [[UIButton alloc] init];
    [_commentButton setBackgroundColor:[UIColor orangeColor]];
    [_commentButton setBackgroundImage:[UIImage imageNamed:@"altest_button_comment.png"] forState:UIControlStateNormal];
    _commentButton.clipsToBounds = YES;
    
    _forwardButton = [[UIButton alloc] init];
    [_forwardButton setBackgroundColor:[UIColor yellowColor]];
    [_forwardButton setBackgroundImage:[UIImage imageNamed:@"altest_button_forward.png"] forState:UIControlStateNormal];
    _forwardButton.clipsToBounds = YES;
    
    _forwardedFollowers = [[UIButton alloc] init];
    [_forwardedFollowers setBackgroundColor:[UIColor cyanColor]];
    [_forwardedFollowers setBackgroundImage:[UIImage imageNamed:@"altest_label_forwardfollowers.png"] forState:UIControlStateNormal];
    _forwardedFollowers.clipsToBounds = YES;
    
    _leftArea = [[UIButton alloc] init];
    [_leftArea setBackgroundColor:[UIColor blueColor]];
    [_leftArea setBackgroundImage:[UIImage imageNamed:@"altest_thismsg.png"] forState:UIControlStateNormal];
    _leftArea.clipsToBounds = YES;
    
    _nickname = [[UIButton alloc] init];
    [_nickname setBackgroundColor:[UIColor purpleColor]];
    [_nickname setBackgroundImage:[UIImage imageNamed:@"altest_nickname.png"] forState:UIControlStateNormal];
    _nickname.clipsToBounds = YES;
    
    _video = [[UIButton alloc] init];
    [_video setBackgroundColor:[UIColor redColor]];
    [_video setBackgroundImage:[UIImage imageNamed:@"altest_video.png"] forState:UIControlStateNormal];
    _video.clipsToBounds = YES;
    
    _largeImage = [[UIButton alloc] init];
    [_largeImage setBackgroundColor:[UIColor redColor]];
    [_largeImage setBackgroundImage:[UIImage imageNamed:@"altest_largeimage.png"] forState:UIControlStateNormal];
    _largeImage.clipsToBounds = YES;
    
    _referMsg = [[UIButton alloc] init];
    [_referMsg setBackgroundColor:[UIColor orangeColor]];
    [_referMsg setBackgroundImage:[UIImage imageNamed:@"altest_refermsg.png"] forState:UIControlStateNormal];
    _referMsg.clipsToBounds = YES;
    
    _LBSIcon = [[UIButton alloc] init];
    [_LBSIcon setBackgroundImage:[UIImage imageNamed:@"altest_lbs_icon" ] forState:UIControlStateNormal];
    _LBSIcon.clipsToBounds = YES;
    
    [_topBar addSubview:_authorsAvatar];
    [_topBar addSubview:_forwardTimes];
    [_topBar addSubview:_nickname];
    
    [_rightArea addSubview:_video];
    [_rightArea addSubview:_referMsg];
    [_rightArea addSubview:_largeImage];
    [_rightArea addSubview:_forwardedFollowers];
    
    [_rootArea addSubview:_topBar];
    [_rootArea addSubview:_leftArea];
    [_rootArea addSubview:_rightArea];
    [_rootArea addSubview:_commentButton];
    [_rootArea addSubview:_forwardButton];
    [_rootArea addSubview:_LBSIcon];
    
    UIView* rootView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [rootView setBackgroundColor:[UIColor blackColor]];
    [self setView:rootView];
    [RootUIView removeFromSuperview];
    [rootView addSubview:RootUIView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    TMALRelativeLayouter* alRootArea = [[TMALRelativeLayouter alloc] init];
    
    TMALRelativeLayouter* alTopBar = [[TMALRelativeLayouter alloc] init];
    TMALLayouter* alAuthorsAvatar = [[TMALLayouter alloc] init];
    TMALLayouter* alNickname = [[TMALLayouter alloc] init];
    TMALLayouter* alForwardTimes = [[TMALLayouter alloc] init];
    
    TMALRelativeLayouter* alRichMedia = nil;///!!![[TMALRelativeLayouter alloc] init];///!!!
    TMALLayouter* alReferMsg = [[TMALLayouter alloc] init];
    TMALLayouter* alVideo = [[TMALLayouter alloc] init];
    TMALLayouter* alLargeImage = [[TMALLayouter alloc] init];
    TMALLayouter* alForwardedFollowers = [[TMALLayouter alloc] init];
    /*
    TMALLayouter* alThisMsg = [[TMALRelativeLayouter alloc] init];
    /*/
    TMALLayouter* alThisMsg = nil;///!!![[TwoPassMeasuringLayouter alloc] initWithArea:311*396];///!!!
    //*/
    
    TMALLayouter* alForwardButton = [[TMALLayouter alloc] init];
    TMALLayouter* alCommentButton = [[TMALLayouter alloc] init];
    
    //TMALLayouter* alLBSIcon = [[TMALLayouter alloc] init];
    
    TMALLayoutParameter lp;
    lp.horizontalStretch = kLayoutWrapContent;
    lp.verticalStretch = kLayoutWrapContent;
    
    // Top Bar Area //
    lp.marginLeft = 0;
    lp.marginRight = 0;
    lp.marginTop = 0;
    lp.marginBottom = 0;
    lp.horizontalStretch = kLayoutFillParent;
    [alRootArea addSubLayouter:alTopBar withName:@"topbar" layoutParameter:lp];
    lp.horizontalStretch = kLayoutWrapContent;
    {
        // Author's Avatar //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_authorsAvatar sizeToFit];
        [alAuthorsAvatar setMeasuredPreferSize:[_authorsAvatar sizeThatFits:CGSizeZero]];
        [alTopBar addSubLayouter:alAuthorsAvatar withName:@"authorsavatar" layoutParameter:lp];
        
        // Author's Nickname //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_nickname sizeToFit];
        [alNickname setMeasuredPreferSize:[_nickname sizeThatFits:CGSizeZero]];
        [alTopBar addSubLayouter:alNickname withName:@"nickname" layoutParameter:lp];
        
        // Forward Times //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_forwardTimes sizeToFit];
        [alForwardTimes setMeasuredPreferSize:[_forwardTimes sizeThatFits:CGSizeZero]];
        [alTopBar addSubLayouter:alForwardTimes withName:@"forwardtimes" layoutParameter:lp];
        
        [alTopBar setLayoutConstraintOfSubLayouter:alAuthorsAvatar toLeftOf:alNickname];
        [alTopBar setLayoutConstraintOfSubLayouter:alForwardTimes toRightOf:alNickname];
        [alTopBar setLayoutConstraintOfSubLayouter:alAuthorsAvatar withAnchor:ParentLeft];
        [alTopBar setLayoutConstraintOfSubLayouter:alAuthorsAvatar withAnchor:ParentVerticalCenter];
        [alTopBar setLayoutConstraintOfSubLayouter:alNickname withAnchor:ParentVerticalCenter];
        [alTopBar setLayoutConstraintOfSubLayouter:alForwardTimes withAnchor:ParentRight];
        [alTopBar setLayoutConstraintOfSubLayouter:alForwardTimes withAnchor:ParentVerticalCenter];
    }
    
    // This Msg //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_leftArea sizeToFit];
    /*
    [alThisMsg setMeasuredPreferSize:[_leftArea sizeThatFits:CGSizeZero]];
    /*/
    [alThisMsg setMeasuredPreferSize:CGSizeMake(150, 0)];
    //*/
    [alRootArea addSubLayouter:alThisMsg withName:@"thismsg" layoutParameter:lp];
    
    // RichMedia //
    lp.marginLeft = 0;
    lp.marginRight = 0;
    lp.marginTop = 0;
    lp.marginBottom = 0;
    [alRootArea addSubLayouter:alRichMedia withName:@"richmedia" layoutParameter:lp];
    {
        // Video //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_video sizeToFit];
        [alVideo setMeasuredPreferSize:[_video sizeThatFits:CGSizeZero]];
        [alRichMedia addSubLayouter:alVideo withName:@"video" layoutParameter:lp];
        
        // Large Image //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_largeImage sizeToFit];
        [alLargeImage setMeasuredPreferSize:[_largeImage sizeThatFits:CGSizeZero]];
        [alRichMedia addSubLayouter:alLargeImage withName:@"largeimage" layoutParameter:lp];
        
        // Refer Msg //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_referMsg sizeToFit];
        [alReferMsg setMeasuredPreferSize:[_referMsg sizeThatFits:CGSizeZero]];
        [alRichMedia addSubLayouter:alReferMsg withName:@"refermsg" layoutParameter:lp];
        
        // Forwarded Followers //
        lp.marginLeft = 5;
        lp.marginRight = 5;
        lp.marginTop = 5;
        lp.marginBottom = 5;
        [_forwardedFollowers sizeToFit];
        [alForwardedFollowers setMeasuredPreferSize:[_forwardedFollowers sizeThatFits:CGSizeZero]];
        [alRichMedia addSubLayouter:alForwardedFollowers withName:@"forwardedfollwers" layoutParameter:lp];
        
        [alRichMedia setLayoutConstraintOfSubLayouter:alLargeImage below:alVideo];
        [alRichMedia setLayoutConstraintOfSubLayouter:alReferMsg below:alLargeImage];
        [alRichMedia setLayoutConstraintOfSubLayouter:alForwardedFollowers below:alReferMsg];
    }
    
    // Forward Button //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_forwardButton sizeToFit];
    [alForwardButton setMeasuredPreferSize:[_forwardButton sizeThatFits:CGSizeZero]];
    [alRootArea addSubLayouter:alForwardButton withName:@"forwardbutton" layoutParameter:lp];
    
    // Comment Button //
    lp.marginLeft = 5;
    lp.marginRight = 5;
    lp.marginTop = 5;
    lp.marginBottom = 5;
    [_commentButton sizeToFit];
    [alCommentButton setMeasuredPreferSize:[_commentButton sizeThatFits:CGSizeZero]];
    [alRootArea addSubLayouter:alCommentButton withName:@"commentbutton" layoutParameter:lp];
    //[alRootArea setLayoutConstraintOfSubLayouter:alWest toLeftOf:alNorth];
    
    [alRootArea setLayoutConstraintOfSubLayouter:alTopBar withAnchor:ParentLeft];
    [alRootArea setLayoutConstraintOfSubLayouter:alTopBar withAnchor:ParentRight];
    
    [alRootArea setLayoutConstraintOfSubLayouter:alThisMsg below:alTopBar];
    [alRootArea setLayoutConstraintOfSubLayouter:alThisMsg withAnchor:ParentLeft];
    
    [alRootArea setLayoutConstraintOfSubLayouter:alRichMedia below:alTopBar];
    [alRootArea setLayoutConstraintOfSubLayouter:alRichMedia toRightOf:alThisMsg];
    /*
    [alRootArea setLayoutConstraintOfSubLayouter:alRichMedia above:alForwardButton];
    [alRootArea setLayoutConstraintOfSubLayouter:alCommentButton below:alRichMedia];
    /*/
    [alRootArea setLayoutConstraintOfSubLayouter:alTopBar above:alForwardButton];
    [alRootArea setLayoutConstraintOfSubLayouter:alCommentButton below:alTopBar];
    //*/
    [alRootArea setLayoutConstraintOfSubLayouter:alForwardButton withAnchor:ParentBottom];
    //[alRootArea setLayoutConstraintOfSubLayouter:alCommentButton withAnchor:ParentBottom];
    [alRootArea setLayoutConstraintOfSubLayouter:alForwardButton toLeftOf:alCommentButton];
    [alRootArea setLayoutConstraintOfSubLayouter:alCommentButton withAnchor:ParentRight];
    ///[alRootArea setLayoutConstraintOfSubLayouter:alRichMedia withAnchor:ParentRight];
    
    // Layout :
    ///!!!
    TMALLayouter* rootLayouter = RootLayouter;
    [rootLayouter measure:CGSizeMake(0, 0)];
    [rootLayouter layout:CGRectMake(0, 0, rootLayouter.measuredPreferSize.width, rootLayouter.measuredPreferSize.height)];
    
    // Apply layout :
    _forwardTimes.frame = [alTopBar subLayouterOfName:@"forwardtimes"].layoutedFrame;
    _authorsAvatar.frame = [alTopBar subLayouterOfName:@"authorsavatar"].layoutedFrame;
    _nickname.frame = [alTopBar subLayouterOfName:@"nickname"].layoutedFrame;
    
    _topBar.frame = [alRootArea subLayouterOfName:@"topbar"].layoutedFrame;
    
    _leftArea.frame = [alRootArea subLayouterOfName:@"thismsg"].layoutedFrame;
    
    _video.frame = [alRichMedia subLayouterOfName:@"video"].layoutedFrame;
    _largeImage.frame = [alRichMedia subLayouterOfName:@"largeimage"].layoutedFrame;
    
    _rightArea.frame = [alRootArea subLayouterOfName:@"richmedia"].layoutedFrame;
    
    _forwardedFollowers.frame = [alRichMedia subLayouterOfName:@"forwardedfollowers"].layoutedFrame;
    _referMsg.frame = [alRichMedia subLayouterOfName:@"refermsg"].layoutedFrame;
    
    _commentButton.frame = [alRootArea subLayouterOfName:@"commentbutton"].layoutedFrame;
    _forwardButton.frame = [alRootArea subLayouterOfName:@"forwardbutton"].layoutedFrame;
    
    
    ///[alRootArea onLayout];
    [RootUIView setFrame:CGRectMake(0, 0, [RootLayouter measuredPreferSize].width, [RootLayouter measuredPreferSize].height)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
