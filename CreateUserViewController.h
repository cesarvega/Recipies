//
//  CreateUserViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Users.h"
@interface CreateUserViewController : UIViewController<UITextFieldDelegate>{

    AppDelegate *appDelegate;
    NSManagedObjectContext * context;
    Users * user;
  
}

@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *Password;

- (IBAction)SaveUser:(id)sender;

@end
