//
//  UsersTableViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UsersTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{

    NSArray * Users;
    NSArray *fetchedObjects;
}
@end
