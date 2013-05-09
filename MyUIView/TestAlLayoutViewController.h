//
//  MainViewController.h
//  MyUIButton
//
//  Created by Li Kai on 13-3-28.
//  Copyright (c) 2013年 DomQiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestAlLayoutViewController : UIViewController
{
    UIButton* _rootArea;
    //{
    UIButton* _topBar;
    //  {
    UIButton* _authorsAvatar;
    UIButton* _nickname;
    UIButton* _forwardTimes;
    //  }
    
    UIButton* _leftArea;
    
    UIButton* _rightArea;
    //  {
    UIButton* _video;
    UIButton* _largeImage;

    UIButton* _referMsg;
    
    UIButton* _forwardedFollowers;
    //  }
    
    UIButton* _commentButton;
    UIButton* _forwardButton;
    
    UIButton* _LBSIcon;
    //}
}

@end
