//
//  MainmenuTableViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "MainmenuTableViewController.h"
#import "CreateUserViewController.h"
#import "CreateRecipeViewController.h"
#import "RecipiesListTableViewController.h"
@interface MainmenuTableViewController ()

@end

@implementation MainmenuTableViewController
@synthesize AdminMenu;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset= UIEdgeInsetsMake(20,0,0,0);
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];

    AdminMenu = [[NSArray alloc] initWithObjects:@"Recipes", @"Users ", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return AdminMenu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu" forIndexPath:indexPath];
    
    cell.textLabel.text = [AdminMenu objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CreateUserViewController *CreateUserView = (CreateUserViewController*)[storyboard instantiateViewControllerWithIdentifier:@"UserTableIdentifier"];
    CreateRecipeViewController *CreateRecipe = (CreateRecipeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"recipesIdentifier"];



    switch (indexPath.row) {
            	
        case 0:
            [self presentViewController:CreateRecipe animated:YES completion:nil];
            

            break;
        case 1:
            [self presentViewController:CreateUserView animated:YES completion:nil];
            

                  break;
    
        default:
            break;
    }


}



@end
