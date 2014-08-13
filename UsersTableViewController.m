//
//  UsersTableViewController.m
//  Recipies
//
//  Created by Xvegas on 8/11/14.
//  Copyright (c) 2014 Xvegas. All rights reserved.
//

#import "UsersTableViewController.h"
#import "AppDelegate.h"
#import "Users.h"
@interface UsersTableViewController ()

@end

@implementation UsersTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        self.tableView.contentInset= UIEdgeInsetsMake(20,0,0,0);
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Users" inManagedObjectContext:context];
    NSError *error;
    [fetchRequest setEntity:entity];
    fetchedObjects = [[NSMutableArray alloc] initWithArray:[context executeFetchRequest:fetchRequest error:&error]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [fetchedObjects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userIdentifier" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"userIdentifier"];
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
        [self.tableView reloadData ];

    
    }
    
  }



@end
