//
//  CreateUserViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "CreateUserViewController.h"
#import "AppDelegate.h"
#import "Users.h"
@interface CreateUserViewController ()

@end

@implementation CreateUserViewController
@synthesize UserName, Password;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Password setDelegate:self];
    [UserName setDelegate:self];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)SaveUser:(id)sender {
    
    if (Password.text.length>0 && UserName.text.length>0 ) {
     
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext * context = [appDelegate managedObjectContext];
        Users * user = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Users"
                        inManagedObjectContext:context];

       
        user.username = UserName.text;
        user.pasword = Password.text;
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"  message:@"Product successfully saved."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }

        
    }

}













@end
