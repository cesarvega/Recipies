//
//  LoginViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

- (IBAction)AdminLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Username;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property (weak, nonatomic) IBOutlet UILabel *LogoRecipesLabel;
@property (weak, nonatomic) IBOutlet UILabel *LogoLabel;
@end
