//
//  Recipes.h
//  Recipes
//
//  Created by Xvegas on 8/13/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Recipes : NSManagedObject

@property (nonatomic, retain) NSString * recipeName;
@property (nonatomic, retain) NSString * recipeIngredient;
@property (nonatomic, retain) NSString * recipeGrams;

@end
