//
//  AmbulareRotaDetailViewController.m
//  Ambulare
//
//  Created by Paulo Martins on 23/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareRotaDetailViewController.h"
#import "AmbulareAppDelegate.h"
#import "CoordenadasEntity.h"

@interface AmbulareRotaDetailViewController ()

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSArray *rotasArr;
@property (nonatomic) NSArray *coordenadasArr;

@end

@implementation AmbulareRotaDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoordenadasEntity" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    self.rotasArr = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AmbulareAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    int count = [self.rotasArr count];
    
    for (int i = 0; i < count; i++)
    {
        CoordenadasEntity *coordenadaEntity = [self.rotasArr objectAtIndex:i];
        
        if ([coordenadaEntity.nomeRota isEqualToString:self.nomeRota])
        {
            [self.coordenadasArr arrayByAddingObjectsFromArray:[self.rotasArr objectAtIndex:i]];
        }
    }
    
    count = [self.coordenadasArr count];
    
    NSLog(@"%d",count);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
