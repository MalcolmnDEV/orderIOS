//
//  vcGroup1.m
//  Project
//
//  Created by Malcolmn Roberts on 2017/02/28.
//  Copyright © 2017 Malcolmnmobile. All rights reserved.
//

#import "vcHome.h"

@interface vcHome ()
{
    UITableView *table_view;
    MWFeedParser *feedParser;
    NSMutableArray *parsedItems;
    NSArray *itemsToDisplay;
    NSDateFormatter *formatter;
    
}

@end

@implementation vcHome

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    parsedItems = [[NSMutableArray alloc] init];
    itemsToDisplay = [NSArray array];
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
    self.navigationItem.title = @"Home";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpNavBar];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self getNews];
}

#pragma mark Network methods

-(void)getNews
{
    //Pull articles from RSS Feed
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSURL *feedURL = [NSURL URLWithString:@"https://magic.wizards.com/en/rss/rss.xml"];
    feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
    feedParser.delegate = self;
    feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
    feedParser.connectionType = ConnectionTypeAsynchronously;
    [feedParser parse];
}

- (void)updateTableWithParsedItems {
    
    itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
                           [NSArray arrayWithObject:[[NSSortDescriptor alloc] initWithKey:@"date"
                                                                                ascending:NO]]];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [table_view reloadData];
}

#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
    NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
    NSLog(@"Parsed Feed Info: “%@”", info.title);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    NSLog(@"Parsed Feed Item: “%@”", item.title);
    if (item) [parsedItems addObject:item];
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
    NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        
        [self showErrorBar:self errorTitle:@"Parsing Incomplete" subErrorTitle:@"There was an error during the parsing of this feed. Not all of the feed items could parsed." oneLiner:NO];
    }
    [self updateTableWithParsedItems];
}

#pragma mark Tableview methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return itemsToDisplay.count;
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item) {
        
        cell.textLabel.text = item.title;
        cell.detailTextLabel.text = item.author;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
    if (item)
    {
        NSString *body = [NSString convertHTML:item.summary];

        [self errorPopUp:item.title body:body];
    }
    
}
-(void)errorPopUp:(NSString *)title body:(NSString *)bodyText
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:bodyText preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    }];
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
