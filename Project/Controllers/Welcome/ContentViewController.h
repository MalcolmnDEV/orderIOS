//
//  ViewController.h
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedButton.h"
#import "WelcomeViewController.h"

@interface ContentViewController : UIViewController

@property (nonatomic) NSInteger pageIndex;

@property (nonatomic) NSString *backgroundImageName;

@property (nonatomic) NSString *titleText;
@property (nonatomic) NSString *subTitleText;
@property (nonatomic) NSString *imageName;

@property (nonatomic) NSString *buttonText;
@property (nonatomic) NSString *buttonBackgroundImageNameNormal;
@property (nonatomic) NSString *buttonBackgroundImageNamePressed;

@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIFont *subTitleFont;

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIColor *subTitleColor;

@property (nonatomic) UIColor *buttonTextColor;
@property (nonatomic) UIFont *buttonFont;

@property (nonatomic) CGFloat paddingAboveImage;
@property (nonatomic) CGFloat paddingBelowImage;

@end

