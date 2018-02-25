//
//  UIViewController+BackgroundNavBar.m
//  Adventure Club
//
//  Created by Malcolmn Roberts on 2015/11/19.
//  Copyright © 2015 Malcolmnmobile. All rights reserved.
//

#import "UIViewController+BackgroundNavBar.h"



@implementation UIViewController(BackgroundNavBar)

-(void)loadNavBarWithTitle:(NSString *)title
{
    [self statusBarBackground];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton=YES;
    [self.navigationController.navigationBar setBackgroundColor:[UIColor AppColorForNavBar]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.title = title;
}

- (void) statusBarBackground
{
    UIView *statusBarBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [VariableManager sharedManager].screenWidth, 20)];
    statusBarBackground.backgroundColor = [UIColor AppColorForNavBar];
    
    NSLog(@"view: %@", self.class);
    
    [self.view addSubview:statusBarBackground];
}

-(void)makeNavbarNotTranslucent:(UINavigationBar *)bar
{
    if (bar.isTranslucent)
    {
        bar.translucent = NO;
        NSLog(@"Navigation Bar is Translucent...");
    }
    else
    {
        NSLog(@"Navigation Bar is NOT Translucent...");
    }
}


- (void)showErrorBar:(UIViewController *)vc errorTitle:(NSString *)errorTitle subErrorTitle:(NSString *)subErrorTitle oneLiner:(BOOL)oneLiner
{
    UIView *errorView;
    UILabel *errorTitleLabel;
    UILabel *subErrorLabel;
    if (oneLiner)
    {
        errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[VariableManager sharedManager] screenWidth], 85)];
        errorTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 24, errorView.frame.size.width - 32, 20)];
        subErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, errorTitleLabel.frame.origin.y + 20, errorTitleLabel.frame.size.width, 34)];
        [subErrorLabel setNumberOfLines:1];
    }else
    {
        errorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[VariableManager sharedManager] screenWidth], 100)];
        errorTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 24, errorView.frame.size.width - 32, 20)];
        subErrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, errorTitleLabel.frame.origin.y + 20, errorTitleLabel.frame.size.width, 54)];
        [subErrorLabel setNumberOfLines:2];
    }

    [errorView setBackgroundColor:[UIColor redColor]];
    
    [errorTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [errorTitleLabel setTextColor:[UIColor blackColor]];
    [errorTitleLabel setText:errorTitle];
    
    [subErrorLabel setTextAlignment:NSTextAlignmentCenter];
    [subErrorLabel setTextColor:[UIColor blackColor]];
    
    [subErrorLabel setText:subErrorTitle];
    
    [errorView addSubview:errorTitleLabel];
    [errorView addSubview:subErrorLabel];
    
    KLCPopup *popUp = [KLCPopup popupWithContentView:errorView showType:KLCPopupShowTypeSlideInFromTop dismissType:KLCPopupDismissTypeSlideOutToTop maskType:KLCPopupMaskTypeNone dismissOnBackgroundTouch:YES dismissOnContentTouch:YES];
    
    [popUp showWithLayout:KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutTop) duration:2.0];

}

@end
