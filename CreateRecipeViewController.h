//
//  CreateRecipeViewController.h
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Recipes.h"

@interface CreateRecipeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    Recipes * recipe;
    NSMutableArray *fetchedObjects;
    AppDelegate *appDelegate;
    NSManagedObjectContext * context;
    NSIndexPath *indexPathForDeletion;
    NSString *nameTodelete;
    NSString *RecipeFromSegue;
    
}

- (IBAction)FindRecipe:(id)sender;
- (IBAction)AddIngredient:(id)sender;
- (IBAction)DuplicateRecipe:(id)sender;

@property (nonatomic) NSString *RecipeFromSegue;
@property (weak, nonatomic) IBOutlet UITextField *RecipeName;
@property (weak, nonatomic) IBOutlet UITextField *IngredientName;
@property (weak, nonatomic) IBOutlet UITextField *IngredientGrams;
@property (strong, nonatomic) IBOutlet UITableView *IngredientsTableView;
@end
