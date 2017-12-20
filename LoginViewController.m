//
//  LoginViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "LoginViewController.h"
#import "MainmenuTableViewController.h"
#import "RecipiesListTableViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize Username, Password, LogoLabel, LogoRecipesLabel;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    // Override point for customization after application launch.
    return YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
   
//    LogoLabel.textAlignment = NSTextAlignmentCenter;
//    LogoLabel.text = @"La Parisienne";
//    LogoLabel.font = [UIFont fontWithName:@"ThirstyScriptExtraBoldDemo" size:30];
//    LogoRecipesLabel.textAlignment = NSTextAlignmentCenter;
    LogoRecipesLabel.text = @"La Parisienne Recipes";
    LogoRecipesLabel.font = [UIFont fontWithName:@"ThirstyScriptExtraBoldDemo" size:20];
	Username.layer.borderColor=[[UIColor whiteColor]CGColor];
    Username.layer.borderWidth= 1.0f;
    Password.layer.borderColor=[[UIColor whiteColor]CGColor];
    Password.layer.borderWidth= 1.0f;
    [Password setDelegate:self];
    [Username setDelegate:self];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    [self AdminLogin:@"d"];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
    
- (IBAction)AdminLogin:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainmenuTableViewController *MainMenuViewControl = (MainmenuTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    [self presentViewController:MainMenuViewControl animated:YES completion:nil];

    if (Password.text.length>0 && Username.text.length>0 ) {
        NSError *error;
        
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"username = %@",Username.text]];
        
        user = [[context executeFetchRequest:request error:&error] lastObject];
        
        if(user){
            appDelegate.LoginUserName = Username.text;
            appDelegate.LoginUserPassword = Password.text;
            
            if ([appDelegate.LoginUserName isEqual: @"Admin"] && [appDelegate.LoginUserPassword isEqual: @"embarek"] ) {
//                
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                MainmenuTableViewController *MainMenuViewControl = (MainmenuTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
//                [self presentViewController:MainMenuViewControl animated:YES completion:nil];
//                
            }else{
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                RecipiesListTableViewController *RecipeListView = (RecipiesListTableViewController*)[storyboard instantiateViewControllerWithIdentifier:@"recipesIdentifie"];
                [self presentViewController:RecipeListView animated:YES completion:nil];
            }            
            
        }
        else{
            
            NSString *successMsg = [NSString stringWithFormat:@"Wrong User Name or Password"];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Try Again"
                                                            message:successMsg
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
           
        }
    
    }
 }
@end
