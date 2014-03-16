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
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if(newLocation != oldLocation)
    {
        //Obter as coordenadas da nova posição
        CLLocationCoordinate2D coordenada;
        coordenada.latitude = newLocation.coordinate.latitude;
        coordenada.longitude = newLocation.coordinate.longitude;
        
        //Define uma região baseada nas coordenadas actuais e aplica na mapView
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordenada, 500, 500);
        [self.mvMap setRegion:region animated:YES];
        
        //Mostra as coordenadas na label
        self.lcoordenadas.text = [NSString stringWithFormat:@"Lat:%lf  Long:%lf",coordenada.latitude,coordenada.longitude];
        
    }
}

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


@end
