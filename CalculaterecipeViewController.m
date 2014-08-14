//
//  CalculaterecipeViewController.m
//  Recipes
//
//  Created by Xvegas on 8/14/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "CalculaterecipeViewController.h"

@interface CalculaterecipeViewController ()

@end

@implementation CalculaterecipeViewController
@synthesize pounds,NavigationBar,RecipeFromSegue,IngredientsTableView,Recipetitle;
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
    [pounds setDelegate:self];
     if (RecipeFromSegue!=nil) {
        
         [self FindRecipeFromSegue];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"calculateRecipeIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"calculateRecipeIdentifier"];
    }
    cell.textLabel.text = [[fetchedObjects objectAtIndex:indexPath.row] recipeIngredient];
    if ( pounds.text.length>0) {

    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * grams = [f numberFromString:[[fetchedObjects objectAtIndex:indexPath.row] recipeGrams]];
    NSNumber * factor = [f numberFromString: pounds.text];
    NSNumber * result = [NSNumber numberWithFloat:([grams floatValue] * [factor floatValue])];
    cell.detailTextLabel.text =[ [result stringValue]stringByAppendingString:@" g"];
    }else{
    cell.detailTextLabel.text =[[[fetchedObjects objectAtIndex:indexPath.row] recipeGrams] stringByAppendingString:@" g"];
    }
    return cell;
}

-(void)FindRecipeFromSegue{
    Recipetitle.text = RecipeFromSegue;
    NSError *error;
    NSFetchRequest * request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Recipes" inManagedObjectContext:context]];
    [request setPredicate:[NSPredicate predicateWithFormat:@"recipeName = %@",RecipeFromSegue]];
    fetchedObjects = (NSMutableArray*) [context executeFetchRequest:request error:&error];
    fetchedObjects=[[[fetchedObjects reverseObjectEnumerator] allObjects] mutableCopy];
    
    }

- (IBAction)CalculateRecipe:(id)sender {
    if ( pounds.text.length>0) {
        [pounds resignFirstResponder];
        [self FindRecipeFromSegue];
        [IngredientsTableView reloadData];

     }
}






@end
