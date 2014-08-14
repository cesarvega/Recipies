//
//  RecipiesListTableViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "RecipiesListTableViewController.h"
#import "CreateUserViewController.h"
#import "AppDelegate.h"
#import "Recipes.h"
#import "CreateRecipeViewController.h"
@interface RecipiesListTableViewController ()

@end

@implementation RecipiesListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.contentInset= UIEdgeInsetsMake(20,0,0,0);
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Recipes" inManagedObjectContext:context];
    NSError *error;
    [fetchRequest setEntity:entity];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"recipeName"]];
    [fetchRequest setResultType:NSDictionaryResultType];
    
    fetchedObjects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:fetchRequest error:&error]];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    indexPathForSeguey = indexPath;
    RecipeFromSegue = [[fetchedObjects objectAtIndex:indexPathForSeguey.row]objectForKey:@"recipeName"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CreateRecipeViewController *CreateRecipe = (CreateRecipeViewController*)[storyboard instantiateViewControllerWithIdentifier:@"createrecipeIdentifier"];
    [CreateRecipe setRecipeFromSegue:RecipeFromSegue];
    [self presentViewController:CreateRecipe animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipes" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"recipes"];
    }
    NSString* recipeName =[[fetchedObjects objectAtIndex:indexPath.row] objectForKey:@"recipeName"];
    cell.textLabel.text = recipeName;
    
    return cell;
}

@end
