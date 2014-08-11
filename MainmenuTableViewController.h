//
//  MainmenuTableViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainmenuTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
    @property (strong, nonatomic) NSArray * AdminMenu;
@end
