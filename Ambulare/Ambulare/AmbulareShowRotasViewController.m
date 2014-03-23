//
//  AmbulareShowRotasViewController.m
//  Ambulare
//
//  Created by Paulo Martins on 23/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareShowRotasViewController.h"
#import "AmbulareAppDelegate.h"
#import "RotaEntity.h"
#import "AmbulareRotaDetailViewController.h"

@interface AmbulareShowRotasViewController ()

@property (nonatomic) NSArray *rotasArr;
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;

@end

@implementation AmbulareShowRotasViewController

//Load dos valores da base de dados

-(void)viewWillAppear:(BOOL)animated
{
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RotaEntity" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError * error;
    
    //passa os objectos da BD para a array todos
    self.rotasArr = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AmbulareAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    //tive de colocar esta linha de código mas não percebo porquê
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rotasArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    RotaEntity * rota = [self.rotasArr objectAtIndex:indexPath.row];
    
    cell.textLabel.text = rota.nomeRota;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
    
    //Obter a rota da linha clickada
    RotaEntity *rota = [self.rotasArr objectAtIndex:indexPath.row];
    
    //Instanciar a view
    AmbulareRotaDetailViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    [self.navigationController pushViewController:view animated:YES];
    
    //Passar o nome da rota para a NString da DetailView
    view.nomeRota = rota.nomeRota;
    
}

@end
