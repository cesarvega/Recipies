//
//  Users.h
//  Recipes
//
//  Created by Xvegas on 8/12/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Users : NSManagedObject

@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * createdBy;
@property (nonatomic, retain) NSString * pasword;
@property (nonatomic, retain) NSNumber * userId;
@property (nonatomic, retain) NSString * username;

@end
