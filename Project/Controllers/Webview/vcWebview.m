//
//  vcWebview.m
//  MalcolmnWizard
//
//  Created by Malcolmn Roberts on 2017/05/03.
//  Copyright © 2017 Malcolmn Roberts. All rights reserved.
//

#import "vcWebview.h"

@interface vcWebview ()

@end

@implementation vcWebview

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpView
{
    [self.web_view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"www.google.com"]]];
}

-(void)setUpNavBar
{
    [self makeNavbarNotTranslucent:self.navigationController.navigationBar];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    [self.navigationController.navigationBar setBarTintColor:[UIColor AppColorForNavBar]];
    [self.navigationController.navigationBar setHidden:NO];
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationItem.title = @"Profile";
}

@end
