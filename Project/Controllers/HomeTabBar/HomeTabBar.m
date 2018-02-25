//
//  HomeTabBar.m
//  Project
//
//  Created by Malcolmn Roberts on 2017/02/28.
//  Copyright © 2017 Malcolmnmobile. All rights reserved.
//

#import "HomeTabBar.h"

#import "vcHome.h"
#import "vcProfile.h"
#import "vcFavourites.h"

@interface HomeTabBar ()
{
    UITabBarItem *tabBarItemHome;
    UITabBarItem *tabBarItemFav;
    UITabBarItem *tabBarItemProfile;
}

@end

@implementation HomeTabBar

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.delegate = self;
    
    vcHome *Group1ViewController = [[vcHome alloc] init];
    vcFavourites *Group2ViewController = [[vcFavourites alloc] init];
    vcProfile *Group3ViewController = [[vcProfile alloc] init];

    
    UINavigationController *Group1NavigationController = [[UINavigationController alloc] initWithRootViewController:Group1ViewController];
    UINavigationController *Group2NavigationController = [[UINavigationController alloc] initWithRootViewController:Group2ViewController];
    UINavigationController *Group3NavigationController = [[UINavigationController alloc] initWithRootViewController:Group3ViewController];
    
    [Group1NavigationController.navigationBar setTranslucent:NO];
    [Group2NavigationController.navigationBar setTranslucent:NO];
    [Group3NavigationController.navigationBar setTranslucent:NO];
    
    Group1NavigationController.navigationBar.barStyle = UIBarStyleBlack;
    Group2NavigationController.navigationBar.barStyle = UIBarStyleBlack;
    Group3NavigationController.navigationBar.barStyle = UIBarStyleBlack;

    
    NSArray *controllers = @[Group1ViewController, Group2ViewController, Group3ViewController];
    
    [self setViewControllers:controllers animated:YES];
    
    [[self tabBar] setBarStyle:UIBarStyleDefault];
    [[self tabBar] setTranslucent:NO];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"SFUIText-Regular" size:12.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [self.tabBar setTintColor:[UIColor redColor]];
    
    tabBarItemHome = [self.tabBar.items objectAtIndex:0];
    tabBarItemFav = [self.tabBar.items objectAtIndex:1];
    tabBarItemProfile = [self.tabBar.items objectAtIndex:2];

    
    [self setSelectedIndex:0];
    
    (void)[tabBarItemHome initWithTitle:@"Home" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    (void)[tabBarItemFav initWithTitle:@"Favourites" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    (void)[tabBarItemProfile initWithTitle:@"Profile" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
