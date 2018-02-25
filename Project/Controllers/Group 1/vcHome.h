//
//  vcGroup1.h
//  Project
//
//  Created by Malcolmn Roberts on 2017/02/28.
//  Copyright © 2017 Malcolmnmobile. All rights reserved.
//

#import "BaseViewController.h"
#import "MWFeedItem.h"
#import "MWFeedParser.h"

@interface vcHome : BaseViewController<MWFeedParserDelegate,UITableViewDelegate, UITableViewDataSource>

@end
