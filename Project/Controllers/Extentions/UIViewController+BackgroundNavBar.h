//
//  UIViewController+BackgroundNavBar.h
//  Adventure Club
//
//  Created by Malcolmn Roberts on 2015/11/19.
//  Copyright © 2015 Malcolmnmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCPopup.h"

@interface UIViewController(BackgroundNavBar)

- (void)loadNavBarWithTitle:(NSString *)title;
-(void)makeNavbarNotTranslucent:(UINavigationBar *)bar;

- (void)showErrorBar:(UIViewController *)vc errorTitle:(NSString *)errorTitle subErrorTitle:(NSString *)subErrorTitle oneLiner:(BOOL)oneLiner;


@end
