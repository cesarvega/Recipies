//
//  UsersTableViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Users.h"
@interface UsersTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray * Users;
    NSMutableArray *fetchedObjects;
    AppDelegate *appDelegate;
    NSManagedObjectContext * context;
    NSIndexPath *indexPathForDeletion;
    NSString *nameTodelete;
}
@end
