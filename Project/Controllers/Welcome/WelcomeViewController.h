//
//  WelcomeViewController.h
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface WelcomeViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageSubTitles;
@property (strong, nonatomic) NSArray *pageImages;
@property (strong, nonatomic) NSArray *pageBackgroundImages;
@property (strong, nonatomic) NSArray *pageButtonText;

@property (strong, nonatomic) UIPageControl *pageControl;

@property (assign, nonatomic) CGFloat pageControlLowerPadding;

@property (nonatomic) UIFont *titleFont;
@property (nonatomic) UIFont *subTitleFont;

@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIColor *subTitleColor;

@property (nonatomic) UIColor *buttonTextColor;
@property (nonatomic) UIFont *buttonFont;

@property (nonatomic) CGFloat paddingAboveImage;
@property (nonatomic) CGFloat paddingBelowImage;

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index;

@end
