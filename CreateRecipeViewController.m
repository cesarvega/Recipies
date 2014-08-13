//
//  CreateRecipeViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "CreateRecipeViewController.h"
#import "AppDelegate.h"
#import "Recipes.h"
@interface CreateRecipeViewController ()
@end
@implementation CreateRecipeViewController

@synthesize IngredientsTableView,RecipeName,IngredientGrams,IngredientName,RecipeFromSegue;

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
    [RecipeName setDelegate:self];
    [IngredientName setDelegate:self];
    [IngredientGrams setDelegate:self];
    if (RecipeFromSegue!=nil) {
        
        [RecipeName setText: RecipeFromSegue];
        [self FindRecipeFromSegue];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
   }

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    IngredientName.text = cell.textLabel.text;
    IngredientGrams.text = [cell.detailTextLabel.text stringByReplacingOccurrencesOfString:@"g" withString:@""];
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
    cell.textLabel.text = [[fetchedObjects objectAtIndex:indexPath.row] recipeIngredient];
    cell.detailTextLabel.text =[[[fetchedObjects objectAtIndex:indexPath.row] recipeGrams] stringByAppendingString:@" g"];;
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
        [request setPredicate:[NSPredicate predicateWithFormat:@"(recipeName = %@) AND (recipeIngredient = %@)",RecipeName.text , nameTodelete]];
        Recipes * recipeToDelete = [[context executeFetchRequest:request error:&error] lastObject];
        [appDelegate.managedObjectContext deleteObject:recipeToDelete];
        [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName.text]];
        fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
        [IngredientsTableView reloadData];
    }
    
}

- (IBAction)FindRecipe:(id)sender {
    if (RecipeName.text.length>0 ) {
    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName.text]];
    fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
    fetchedObjects=[[[fetchedObjects reverseObjectEnumerator] allObjects] mutableCopy];
        if (fetchedObjects.count>0) {
            [RecipeName resignFirstResponder];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe"  message:@"Recipe not found! "
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
    }
     [IngredientsTableView reloadData];
}

- (IBAction)AddIngredient:(id)sender {
 
    if (RecipeName.text.length>0 && IngredientName.text.length>0 && IngredientGrams.text.length>0 ) {

    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"(recipeName = %@) AND (recipeIngredient = %@)",RecipeName.text , IngredientName.text]];
    recipe = (Recipes*) [[context executeFetchRequest:request error:&error]lastObject] ;
        
    if (recipe==nil) {
        
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
                              NSError *error;
                              NSFetchRequest * request = [[NSFetchRequest alloc] init];
                              [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
                              [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName.text]];
                              fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
                              fetchedObjects=[[[fetchedObjects reverseObjectEnumerator] allObjects] mutableCopy];
                              [IngredientName setText:@""];
                              [IngredientGrams setText:@""];
                              [IngredientName becomeFirstResponder];
                            }
        
       }
        else{
                NSError *error = nil;
                recipe.recipeIngredient=IngredientName.text;
                recipe.recipeGrams = IngredientGrams.text;
                if (![context save:&error]) {
            
                }
                else{
                    NSError *error;
                    NSFetchRequest * request = [[NSFetchRequest alloc] init];
                    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
                    [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName.text]];
                    fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
                    [IngredientName setText:@""];
                    [IngredientGrams setText:@""];
                    [IngredientName becomeFirstResponder];
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
        [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName.text	]];
        NSMutableArray* duplicateObjects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
        if (duplicateObjects.count>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"  message:@"This recipe already exist "
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
                                            recipe.recipeName=RecipeName.text;
                                            recipe.recipeIngredient=item.recipeIngredient;
                                            recipe.recipeGrams =item.recipeGrams;
                if (![context save:&error]) {
                    
                }
                
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"  message:@"Recipe successfully copied"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];

        }
    }
}

-(void)FindRecipeFromSegue{
    if (RecipeName.text.length>0 ) {
        NSError *error;
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
        [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeName.text]];
        fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
        fetchedObjects=[[[fetchedObjects reverseObjectEnumerator] allObjects] mutableCopy];
        if (fetchedObjects.count>0) {
            [RecipeName resignFirstResponder];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Recipe"  message:@"Recipe not found! "
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
    }
    [IngredientsTableView reloadData];



}

@end
