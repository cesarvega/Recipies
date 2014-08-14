//
//  CalculaterecipeViewController.h
//  Recipes
//
//  Created by Xvegas on 8/14/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Recipes.h"

@interface CalculaterecipeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    Recipes * recipe;
    NSMutableArray *fetchedObjects;
    AppDelegate *appDelegate;
    NSManagedObjectContext * context;
    NSIndexPath *indexPathForDeletion;
    NSString *nameTodelete;
    NSString *RecipeFromSegue;
}
@property (weak, nonatomic) IBOutlet UITextField *pounds;
@property (weak, nonatomic) IBOutlet UITableView *IngredientsTableView;
@property (nonatomic) NSString *RecipeFromSegue;
@property (weak, nonatomic) IBOutlet UINavigationBar *NavigationBar;
@property (weak, nonatomic) IBOutlet UILabel *Recipetitle;
- (IBAction)CalculateRecipe:(id)sender;

@end
