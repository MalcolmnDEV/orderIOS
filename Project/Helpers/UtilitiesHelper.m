//
//  UtilitiesHelper.m
//  Adv Clubs
//
//  Created by Malcolmn Roberts on 2016/04/05.
//  Copyright © 2016 Malcolmnmobile. All rights reserved.
//

#import "UtilitiesHelper.h"

@implementation UtilitiesHelper

static UtilitiesHelper *sharedManager = nil;

+ (UtilitiesHelper*)sharedManager
{
    if (sharedManager == nil)
    {
        sharedManager = [[super allocWithZone:NULL] init];
    }
    return sharedManager;
}

- (id)init
{
    if (self = [super init])
    {
    }
    return self;
}

-(void)userDeletedPopUp
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Account Removed" message:NSLocalizedString(@"Popup.DeletedPopup", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [self authFailReturnToLanding];
                                 }];
    [alert addAction:okayAction];
    
    [[self topMostController] presentViewController:alert animated:YES completion:nil];
}

-(void)userBlockedPopUp
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Account Blocked" message:NSLocalizedString(@"Popup.BlockedPopup", nil) preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     [self authFailReturnToLanding];
                                 }];
    [alert addAction:okayAction];
    
    [[self topMostController] presentViewController:alert animated:YES completion:nil];
}

-(void)authFailReturnToLanding
{
//    LandingViewController *rootViewController = [[LandingViewController alloc] init];
//    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
//    [[[AppDelegate shareAppDelegate] window] setRootViewController:navController];
}

- (UIViewController*) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
