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
@property (nonatomic) NSMutableArray *coordenadasArr;

@end

@implementation AmbulareRotaDetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.coordenadasArr =  [[NSMutableArray alloc]init];
    
    
    int count = [self.rotasArr count];
    
    
    //Passar as coordenadas para o NSMutableArray coordenadasArr cujo nome seja igual á rota escolhida
    for (int i = 0; i < count; i++)
    {
        CoordenadasEntity *coordenadaEntity = [self.rotasArr objectAtIndex:i];
        
        if ([coordenadaEntity.nomeRota isEqualToString:self.nomeRota])
        {
            [self.coordenadasArr addObject:[self.rotasArr objectAtIndex:i]];
        }
    }
    
    count = [self.coordenadasArr count];
    
    NSLog(@"%d",count);
    
    
    //Centrar o mapa no primeiro ponto da Rota
    CoordenadasEntity *coordenadaEntity = [self.coordenadasArr objectAtIndex:0];
    
    
    MKCoordinateRegion mapRegion;
    mapRegion.center.latitude = [coordenadaEntity.latitude doubleValue];
    mapRegion.center.longitude = [coordenadaEntity.longitude doubleValue];
    mapRegion.span.latitudeDelta = 0.010;
    mapRegion.span.longitudeDelta = 0.010;
    self.MapView.region = mapRegion;
    
    
    //Colocar um marker nos pontos da rota
  
    for (int i=0 ; i<count ; i++)
    {
        CoordenadasEntity *coordenadaEntity = [self.coordenadasArr objectAtIndex:i];
        
        CLLocationCoordinate2D coordenada;
        coordenada.longitude = [coordenadaEntity.longitude doubleValue];
        coordenada.latitude = [coordenadaEntity.latitude doubleValue];
    
        MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
        point.coordinate = coordenada;
        //point.title = [NSString stringWithFormat:@"%d",[coordenadaEntity.iD intValue]];
        
        if([coordenadaEntity.iD intValue] == 0)
            point.title = @"Start";
        if([coordenadaEntity.iD intValue] == count-1)
            point.title = @"End";
        
        [self.MapView addAnnotation:point];
    }
 
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    AmbulareAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoordenadasEntity" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    self.rotasArr = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
