//
//  MainmenuTableViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Users.h"
@interface MainmenuTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>{

    Users * user;
    AppDelegate *appDelegate;
    NSManagedObjectContext * context;

}
    @property (strong, nonatomic) NSArray * AdminMenu;
@end
