//
//  AmbulareStartRecViewController.m
//  Ambulare
//
//  Created by Paulo Martins on 15/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareGPSRecViewController.h"

@interface AmbulareGPSRecViewController ()

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation AmbulareGPSRecViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    //esconder a Navigation Controller
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"startRec_viewDidLoad");
    
    
    //  Bloco do GPS
    //***********************************************
    
    //mostra o ponto de localização actual
    self.mvMap.showsUserLocation = YES;
    
    //instanciar um objecto do tip CLLocationManager
    self.locationManager = [[CLLocationManager alloc]init];
    
    //Define-se como delegate ,para receber os updates
    self.locationManager.delegate = self;
    
    //Defenir a accuracy
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //liga o gps e pede actualização
    [self.locationManager startUpdatingLocation];
    
    NSLog(@"Estou a obter a localização");
    
    
    
    CLLocationCoordinate2D  newLocation, oldLocation;
    newLocation.latitude = 38.707508;
    newLocation.longitude = -9.136618;
    
    oldLocation.latitude = 38.707591;
    oldLocation.longitude = -9.133719;
    
    //Desenhar a polyLine
    [self drawRouteWithNewLocation:newLocation oldLocation:oldLocation];
}

//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    if(newLocation != oldLocation)
//    {
//        //Obter as coordenadas da nova posição
//        CLLocationCoordinate2D coordenada;
//        coordenada.latitude = newLocation.coordinate.latitude;
//        coordenada.longitude = newLocation.coordinate.longitude;
//        
//        //Define uma região baseada nas coordenadas actuais e aplica na mapView
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordenada, 500, 500);
//        [self.mvMap setRegion:region animated:YES];
//        
//        //Mostra as coordenadas na label
//        self.lcoordenadas.text = [NSString stringWithFormat:@"Lat:%lf  Long:%lf",coordenada.latitude,coordenada.longitude];
//        
//        //Desenhar a polyLine
//        //[self drawRouteWithNewLocation:newLocation oldLocation:oldLocation];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)GravarPercurso:(id)sender
{
    
    if ([self.tfNomePercurso.text length] == 0)
        self.lAviso.text = @"Necessário introduzir nome para a rota";
}

-(void)drawRouteWithNewLocation:(CLLocationCoordinate2D) newLocation oldLocation: (CLLocationCoordinate2D) oldLocation
{
    
        //http://www.raywenderlich.com/30001/overlay-images-and-overlay-views-with-mapkit-tutorial
        //http://www.devfright.com/mkdirections-tutorial/
    
    
        CLLocationCoordinate2D pointsToUse[2];
        pointsToUse[0] = CLLocationCoordinate2DMake(newLocation.latitude, newLocation.longitude);
        pointsToUse[1] = CLLocationCoordinate2DMake(oldLocation.latitude, oldLocation.longitude);
    
        MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:2];
        [self.mvMap addOverlay:myPolyline];
    
    
}


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id )overlay
{
    MKOverlayView* overlayView = nil;
    
    if(overlay == self.routeLine)
    {
        //if we have not yet created an overlay view for this overlay, create it now.
        if(nil == self.routeLineView)
        {
            self.routeLineView = [[[MKPolylineView alloc] initWithPolyline:self.routeLine] autorelease];
            self.routeLineView.fillColor = [UIColor redColor];
            self.routeLineView.strokeColor = [UIColor redColor];
            self.routeLineView.lineWidth = 3;
        }
        
        overlayView = self.routeLineView;
        
    }
    
    return overlayView;
    
}

//- (void)addRoute {
//    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"EntranceToGoliathRoute" ofType:@"plist"];
//    NSArray *pointsArray = [NSArray arrayWithContentsOfFile:thePath];
//    
//    NSInteger pointsCount = pointsArray.count;
//    
//    CLLocationCoordinate2D pointsToUse[pointsCount];
//    
//    for(int i = 0; i < pointsCount; i++) {
//        CGPoint p = CGPointFromString(pointsArray[i]);
//        pointsToUse[i] = CLLocationCoordinate2DMake(p.x,p.y);
//    }
//    
//    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:pointsCount];
//    
//    [self.mapView addOverlay:myPolyline];
//}


@end
