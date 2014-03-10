//
//  MasterViewController.m
//  Todo
//
//  Created by Formando FLAG on 10/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "MasterViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "TodoEntity.h"

@interface MasterViewController ()

@property (nonatomic) NSArray * todos;
@property (nonatomic,strong) NSManagedObjectContext * managedObjectContext;


@end

@implementation MasterViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TodoEntity" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError * error;
    
    //passa os objectos da BD para a array todos
    self.todos = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
    TodoEntity * todo = [self.todos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = todo.descricao;
    
    return cell;
}



@end
