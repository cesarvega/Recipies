//
//  LoginViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "LoginViewController.h"
#import "MainmenuTableViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize Username, Password, LogoLabel, LogoRecipesLabel;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    LogoLabel.textAlignment = NSTextAlignmentCenter;
    LogoLabel.text = @"R";
    LogoLabel.font = [UIFont fontWithName:@"ThirstyScriptExtraBoldDemo" size:80];
    LogoRecipesLabel.textAlignment = NSTextAlignmentCenter;
    LogoRecipesLabel.text = @"Recipes";
    LogoRecipesLabel.font = [UIFont fontWithName:@"ThirstyScriptExtraBoldDemo" size:40];
	Username.layer.borderColor=[[UIColor whiteColor]CGColor];
    Username.layer.borderWidth= 1.0f;
    Password.layer.borderColor=[[UIColor whiteColor]CGColor];
    Password.layer.borderWidth= 1.0f;
    [Password setDelegate:self];
    [Username setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)AdminLogin:(id)sender {
    
    if (Password.text.length>0 && Username.text.length>0 ) {
        
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        context = [appDelegate managedObjectContext];
    
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription
                                       entityForName:@"Users" inManagedObjectContext:context];
        NSError *error;
        [fetchRequest setEntity:entity];
        fetchedObjects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:fetchRequest error:&error]];
    NSString *password;
    NSString *userName ;
    BOOL   isUser;
    isUser = NO;
    for (NSArray *item in fetchedObjects) {
        
        password = [NSString stringWithFormat:@"%@",[item valueForKey:@"password"]];
        userName = [NSString stringWithFormat:@"%@",[item valueForKey:@"username"]];
        
        if([Username.text isEqual: userName ] && [Password.text isEqual:password]){
            appDelegate.LoginUserName = Username.text;
            appDelegate.LoginUserPassword = Password.text;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainmenuTableViewController *MainMenuViewControl = (MainmenuTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
            
            // present
            [self presentViewController:MainMenuViewControl animated:YES completion:nil];            //            isUser = NO;
            //
            //        }else { isUser = YES;   }
            //    }
            //
            //    if (isUser == YES) {
            //        NSString *successMsg = [NSString stringWithFormat:@"Wrong User Name or Password"];
            //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try Again"
            //                                                        message:successMsg
            //                                                       delegate:nil
            //                                              cancelButtonTitle:@"OK"
            //                                              otherButtonTitles: nil];
            // [alert show];
            
            
        }
        //  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        //
        //   MainMenuViewController *centerController = (MainMenuViewController *)[storyboard instantiateViewControllerWithIdentifier:@"mainMenu"];
        //    
        //    [self presentViewController:centerController animated:YES completion:nil];
        
    }
    
  }
    
    // dismiss
    //[self dismissViewControllerAnimated:YES completion:nil];
}



@end
