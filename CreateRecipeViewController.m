//
//  CreateRecipeViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "CreateRecipeViewController.h"
#import "AppDelegate.h"
#import "Users.h"
@interface CreateRecipeViewController ()
@end
@implementation CreateRecipeViewController
@synthesize IngredientsTableView,RecipeName,IngredientGrams,IngredientName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
   }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"createRecipeIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"createRecipeIdentifier"];
    }
    cell.textLabel.text = [[fetchedObjects objectAtIndex:indexPath.row] username];
    cell.detailTextLabel.text =[[fetchedObjects objectAtIndex:indexPath.row] pasword];
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
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Are you sure you want to delete this user?"
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
        [request setEntity:[NSEntityDescription entityForName:@"Users" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"username = %@",nameTodelete]];
        
        Users * user = [[context executeFetchRequest:request error:&error] lastObject];
        [appDelegate.managedObjectContext deleteObject:user];
        
        [fetchedObjects removeObjectAtIndex:indexPathForDeletion.row];
        [IngredientsTableView reloadData];
    }
    
}

- (IBAction)FindRecipe:(id)sender {
    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName]];
    fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
    [IngredientsTableView reloadData];
}

- (IBAction)AddIngredient:(id)sender {
    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(recipeName = %@) AND (recipeIngredient = %@)",RecipeName , IngredientName]];
    fetchedObjects = (NSMutableArray*) [[context executeFetchRequest:request error:&error]lastObject];
    
    if (fetchedObjects.count>0) {
        
    }else{
        
        
    }
    
    
    
    [IngredientsTableView reloadData];
}

- (IBAction)DuplicateRecipe:(id)sender {


}







@end
