//
//  RecipesTableViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "RecipesTableViewController.h"
#import "AppDelegate.h"
#import "Recipes.h"
#import "CreateRecipeViewController.h"
@interface RecipesTableViewController ()

@end

@implementation RecipesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipesIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"recipesIdentifier"];
    }
    NSString* recipeName =[[fetchedObjects objectAtIndex:indexPath.row] objectForKey:@"recipeName"];
    cell.textLabel.text = recipeName;
    
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        nameTodelete = cell.textLabel.text;
        indexPathForDeletion = indexPath;
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to delete this recipe?"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"No"
                                                otherButtonTitles:@"Yes", nil];
        
        [message show];
    }
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSError *error;
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Yes"])
    {
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName	 = %@",nameTodelete]];
        
        NSMutableArray * recipesToDelete =  [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:request error:&error] ];
        for (Recipes* recipe in recipesToDelete) {
            [appDelegate.managedObjectContext deleteObject:recipe];
            if (![context save:&error]) {
            }
            else{
                NSError *error;
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                NSEntityDescription *entity = [NSEntityDescription
                                               entityForName:@"Recipes" inManagedObjectContext:context];
                [fetchRequest setEntity:entity];
                [fetchRequest setReturnsDistinctResults:YES];
                [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"recipeName"]];
                [fetchRequest setResultType:NSDictionaryResultType];
                
                fetchedObjects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:fetchRequest error:&error]];

                [self.tableView reloadData ];            }
             }
       }
}


@end
