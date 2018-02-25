//
//  WelcomeViewController.m
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    self.pageControlLowerPadding = 20.0f;

    self.titleFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:38];
    self.subTitleFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:21];
    self.buttonFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.titleColor = [UIColor whiteColor];
    self.subTitleColor = [UIColor whiteColor];
    
    self.pageTitles = @[@"Test1", @"Test2", @"Test3"];
    self.pageSubTitles = @[@"This is a test string for now1.",
                           @"This is a test string for now2.",
                           @"This is a test string for now3."];
    
    self.pageImages = @[@"welcome_badge_1", @"welcome_badge_2", @"welcome_badge_3"];
    self.pageBackgroundImages = @[@"welcome_background_1.jpg", @"welcome_background_2.jpg", @"welcome_background_3.jpg"];
    
    self.pageButtonText = @[@"Next", @"Next", @"Let's Get Started!"];
    
    self.paddingAboveImage = 140.0f;
    self.paddingBelowImage = 45.0f;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.345f green:0.349f blue:0.357f alpha:1.00f];
    
    // Create page view controller
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    //Update status bar to white
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height + 40);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(16, screenHeight - 20 - self.pageControlLowerPadding, screenWidth - 32, 20)];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:(1/255.0) green:(69/255.0) blue:(135/255.0) alpha:1.0];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = self.pageTitles.count;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = 0;
    index = ((ContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = 0;
    index = ((ContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    ContentViewController *pageContentViewController = [[ContentViewController alloc] init];
    pageContentViewController.titleText = self.pageTitles[index];
    pageContentViewController.subTitleText = self.pageSubTitles[index];
    pageContentViewController.imageName = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    pageContentViewController.backgroundImageName = self.pageBackgroundImages[index];
    pageContentViewController.titleFont = self.titleFont;
    pageContentViewController.subTitleFont = self.subTitleFont;
    pageContentViewController.titleColor = self.titleColor;
    pageContentViewController.subTitleColor = self.subTitleColor;
    pageContentViewController.buttonText = self.pageButtonText[index];
    pageContentViewController.buttonFont = self.buttonFont;
    
    pageContentViewController.paddingAboveImage = self.paddingAboveImage;
    pageContentViewController.paddingBelowImage = self.paddingBelowImage;
    
    return pageContentViewController;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *currentView = [pageViewController.viewControllers objectAtIndex:0];
    NSInteger index = 0;
    index = ((ContentViewController*) currentView).pageIndex;
    self.pageControl.hidden = false;
    self.pageControl.currentPage = index;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    UIViewController *currentView = [pageViewController.viewControllers objectAtIndex:0];
    NSInteger index = 0;
    index = ((ContentViewController*) currentView).pageIndex;
    self.pageControl.currentPage = index;
    return index;
}

@end
