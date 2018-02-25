//
//  vcGroup2.m
//  Project
//
//  Created by Malcolmn Roberts on 2017/02/28.
//  Copyright © 2017 Malcolmnmobile. All rights reserved.
//

#import "vcFavourites.h"

@interface vcFavourites ()
{
    UITableView *table_view;
    NSArray *favArray;
}

@end

@implementation vcFavourites

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavBar];
    [self setUpView];
    
    favArray = @[@"FAV 1", @"Fav", @"Favourite"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpView
{
    table_view = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [VariableManager sharedManager].screenWidth, [VariableManager sharedManager].screenHeight - 112)];
    
    table_view.delegate = self;
    table_view.dataSource = self;
    table_view.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [table_view setShowsVerticalScrollIndicator:NO];
    
    [self.view addSubview:table_view];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return favArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:favArray[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
