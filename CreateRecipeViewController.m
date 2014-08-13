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
    cell.textLabel.text = [[fetchedObjects objectAtIndex:indexPath.row] recipeName];
    
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
    if (RecipeName.text.length>0 ) {
    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName]];
    fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
        if (fetchedObjects.count>0) {
             [IngredientsTableView reloadData];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe"  message:@"Recipe not found! "
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)AddIngredient:(id)sender {
 
    if (RecipeName.text.length>0 && IngredientName.text.length>0 && IngredientGrams.text.length>0 ) {

    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(recipeName = %@) AND (recipeIngredient = %@)",RecipeName.text , IngredientName.text]];
    recipe = (Recipes*) [[context executeFetchRequest:request error:&error]lastObject] ;
        
    if (recipe==nil) {
                if (fetchedObjects.count>0) {
                            recipe = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"Recipes"
                                            inManagedObjectContext:context];
                            NSError *error = nil;
                            recipe.recipeName=RecipeName.text;
                            recipe.recipeIngredient=IngredientName.text;
                            recipe.recipeGrams = IngredientGrams.text;
                          if (![context save:&error]) {
                        
                           }
                          else{
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"  message:@"Recipe ingredient successfully saved."
                                                                       delegate:self
                                                                       cancelButtonTitle:@"OK"
                                                                       otherButtonTitles:nil];
                                 [alert show];
                        }
                    }
       }
        else{
                NSError *error = nil;
                recipe.recipeIngredient=IngredientName.text;
                recipe.recipeGrams = IngredientGrams.text;
                if (![context save:&error]) {
            
                }
                else{
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"  message:@"Recipe ingredient successfully updated."
                                                                        delegate:self
                                                                        cancelButtonTitle:@"OK"
                                                                        otherButtonTitles:nil];
                        [alert show];
            }
        }
         [IngredientsTableView reloadData];
    }
}


- (IBAction)DuplicateRecipe:(id)sender {
    if (RecipeName.text.length>0 ) {
        NSError *error;
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName]];
        fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
        if (fetchedObjects.count>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe"  message:@"This recipe already exist "
                                                            delegate:self
                                                            cancelButtonTitle:@"OK"
                                                            otherButtonTitles:nil];
            [alert show];
        }else{
            for (Recipes * item in fetchedObjects) {
                            recipe = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"Recipes"
                                            inManagedObjectContext:context];
                                            NSError *error = nil;
                                            recipe.recipeName=item.recipeName;
                                            recipe.recipeIngredient=item.recipeIngredient;
                                            recipe.recipeGrams =item.recipeGrams;
                if (![context save:&error]) {
                    
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"  message:@"Recipe successfully copied"
                                                                    delegate:self
                                                                    cancelButtonTitle:@"OK"
                                                                    otherButtonTitles:nil];
                    [alert show];
                }
            }
        }
    }
}









    @end
