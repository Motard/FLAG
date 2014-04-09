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
#import "AmbulareFacebookViewController.h"


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
    mapRegion.span.latitudeDelta = 0.0001;
    mapRegion.span.longitudeDelta = 0.0001;
    self.MapView.region = mapRegion;
    
    [self addPin];
    
    [self addRoute];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Isto permite desenhar a MKPolyline e também criar os custom pins
    [self.MapView setDelegate:self];
    
	// Do any additional setup after loading the view.
    
    AmbulareAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CoordenadasEntity" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error;
    
    self.rotasArr = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
}

-(void)addPin
{
    
    int count = [self.coordenadasArr count];
    //Colocar um marker nos pontos inicias e finais da rota
    
    for (int i=0 ; i<count ; i++)
    {
        CoordenadasEntity *coordenadaEntity = [self.coordenadasArr objectAtIndex:i];
        
        CLLocationCoordinate2D coordenada;
        coordenada.longitude = [coordenadaEntity.longitude doubleValue];
        coordenada.latitude = [coordenadaEntity.latitude doubleValue];
        
        if([coordenadaEntity.iD intValue] == 0)
        {
            MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
            point.coordinate = coordenada;
            point.title = @"Start";
            
            [self.MapView addAnnotation:point];
        }
        
        if([coordenadaEntity.iD intValue] == count-1)
        {
            MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
            point.coordinate = coordenada;
            point.title = @"End";
            [self.MapView addAnnotation:point];
        }
    }

}


-(void)addRoute
{
    CoordenadasEntity *coordenadaEntity;
    
    NSInteger pointsCount = [self.coordenadasArr count];
    
    CLLocationCoordinate2D pointsToUse[pointsCount];
    
    for (int i = 0; i< pointsCount ; i++)
    {
        for (int j = 0; j<pointsCount; j++)
        {
            coordenadaEntity = [self.coordenadasArr objectAtIndex:j];
            
            if([coordenadaEntity.iD intValue] == i)
                break;
        }
        
        pointsToUse[i] = CLLocationCoordinate2DMake([coordenadaEntity.latitude doubleValue], [coordenadaEntity.longitude doubleValue]);
    }
    
    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:pointsCount];
    
    [self.MapView addOverlay:myPolyline];
}


-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:MKPolyline.class])
    {
        MKPolylineView *lineView = [[MKPolylineView alloc] initWithOverlay:overlay];
        lineView.strokeColor = [UIColor blueColor];
        return lineView;
    }
    
    return nil;
}


- (IBAction)mapTypeChanged:(id)sender
{
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            self.MapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.MapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.MapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}

- (IBAction)goFacebookView:(id)sender
{
    //Instanciar a view
    AmbulareFacebookViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"FacebookView"];
    [self.navigationController pushViewController:view animated:YES];
    
    //Passar o nome da rota para a NString da DetailView
    view.nomeRota = self.nomeRota;
    view.distanciaRota = self.distanciaRota;
}




//Customizar o MKPointAnnotation
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    // If it's the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    
//    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//        // Try to dequeue an existing pin view first.
//        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
//        if (!pinView)
//        {
//            // If an existing pin view was not available, create one.
//            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
//            //pinView.animatesDrop = YES;
//            pinView.canShowCallout = YES;
//            //pinView.image = [UIImage imageNamed:@"customPin.png"];
//            pinView.calloutOffset = CGPointMake(0, 32);
//            
//        } else {
//            pinView.annotation = annotation;
//        }
//        return pinView;
//    }
//    return nil;
//}

@end
