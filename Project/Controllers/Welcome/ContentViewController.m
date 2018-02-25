//
//  ViewController.m
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "ContentViewController.h"
#import "HomeTabBar.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat topPaddingMultiplier = screenRect.size.height/667;
    
    self.titleFont = [self.titleFont fontWithSize:self.titleFont.pointSize*topPaddingMultiplier];
    self.subTitleFont = [self.subTitleFont fontWithSize:self.subTitleFont.pointSize*topPaddingMultiplier];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, screenRect.size.height)];
    [background setImage:[UIImage imageNamed:self.backgroundImageName]];
    [self.view addSubview:background];
    
    UIImage *badgeImage = [UIImage imageNamed:self.imageName];
    UIImageView *badgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, self.paddingAboveImage*topPaddingMultiplier, screenRect.size.width-32, badgeImage.size.height)];
    badgeImageView.contentMode = UIViewContentModeCenter;
    [badgeImageView setImage:badgeImage];
    [self.view addSubview:badgeImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:[self sizeForLabel:self.titleText font:self.titleFont x:16 y:badgeImageView.frame.origin.y+badgeImageView.frame.size.height+(self.paddingBelowImage*topPaddingMultiplier) screenWidth:screenRect.size.width-32]];
    [titleLabel setText:self.titleText];
    titleLabel.font = self.titleFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = self.titleColor;
    [self.view addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:[self sizeForLabel:self.subTitleText font:self.subTitleFont x:16 y:titleLabel.frame.origin.y+titleLabel.frame.size.height+(18*topPaddingMultiplier) screenWidth:screenRect.size.width-32]];
    [subTitleLabel setText:self.subTitleText];
    subTitleLabel.font = self.subTitleFont;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.textColor = self.subTitleColor;
    [self.view addSubview:subTitleLabel];
    
    if( [self.buttonText caseInsensitiveCompare:@"Next"] == NSOrderedSame ) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(16, (screenRect.size.height-40) - (35*topPaddingMultiplier) - 50, screenRect.size.width-32, 50)];
        [button setTitle:self.buttonText forState:UIControlStateNormal];
        [button.titleLabel setFont:self.buttonFont];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];

    } else {
        RedButton *button = [RedButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(16, (screenRect.size.height-40) - (35*topPaddingMultiplier) - 50, screenRect.size.width-32, 50);
        [button setTitle:self.buttonText forState:UIControlStateNormal];
        [button.titleLabel setFont:self.buttonFont];
        [self.view addSubview:button];
        [button addTarget:self action:@selector(segueToHome) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGRect)sizeForLabel:(NSString *)text
                  font:(UIFont *) font
                     x:(CGFloat) x
                     y:(CGFloat) y
           screenWidth:(CGFloat) screenWidth
{
    CGRect labelRect = [text boundingRectWithSize:CGSizeMake(screenWidth, 0)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName : font}
                                          context:nil];
    
    labelRect.origin.x = x;
    labelRect.origin.y = y;
    labelRect.size.width = screenWidth;
    return labelRect;
}

- (void) nextPage
{
    WelcomeViewController *welcomeViewController;
    for (UIViewController *i in [self.navigationController viewControllers]){
        if([i isKindOfClass:[WelcomeViewController class]]){
            welcomeViewController = ((WelcomeViewController *)i);
        }
    }
    NSArray *viewControllers = @[[welcomeViewController viewControllerAtIndex:(self.pageIndex+1)]];
    
    [welcomeViewController.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:true completion:nil];
}

- (void) segueToHome
{
    HomeTabBar *rootViewController = [[HomeTabBar alloc] init];
    UINavigationController *tabNav = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [[UIApplication sharedApplication].keyWindow setRootViewController:tabNav];
}

@end
