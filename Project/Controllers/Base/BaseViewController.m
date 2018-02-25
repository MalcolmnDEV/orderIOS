//
//  ViewController.m
///  Parking Solutions
//
//  Created by Malcolmn Roberts on 2016/10/05.
//  Copyright (c) 2016 Malcolmn Roberts. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpBaseViewController
{
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 120, self.view.frame.size.width - 32, 30)];
    
    [lblTitle setText:@"Welcome"];
    
    [self.view addSubview:lblTitle];
}

@end
