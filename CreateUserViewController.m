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
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];

   
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
    
    NSError *error;

    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"username = %@",UserName.text]];
    
    user = [[context executeFetchRequest:request error:&error] lastObject];
    
    if (user == nil) {
        
    
    
    if (Password.text.length>0 && UserName.text.length>0 ) {
     
        user = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Users"
                        inManagedObjectContext:context];

       
        user.username = UserName.text;
        user.pasword = Password.text;
        
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
    }else{
      [self updateExistingClient: user];
    }
  
    [self clearTextFields];
}


-(void)updateExistingClient:(Users*)exsitingUser{
    NSError *error = nil;
   
    exsitingUser.username = UserName.text;
    exsitingUser.pasword = Password.text;
    
    error = nil;
    if (![context save:&error]) {
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"  message:@"User successfully updated."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    
}


-(void)clearTextFields{
    
    UserName.text=@"";
    Password.text=@"";
    [Password resignFirstResponder];
    
}






@end
