//
//  CreateUserViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateUserViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *UserName;
@property (weak, nonatomic) IBOutlet UITextField *Password;

- (IBAction)SaveUser:(id)sender;

@end
