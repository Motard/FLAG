//
//  ExpViewController.m
//  Map
//
//  Created by Paulo Martins on 18/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ExpViewController.h"

@interface ExpViewController ()

@property (nonatomic) CLLocationManager *manager;

@end

@implementation ExpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.mapView.showsUserLocation = YES;
    
    self.manager = [[CLLocationManager alloc]init];
    self.manager.delegate = self;
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.manager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation != oldLocation)
    {
        CLLocationCoordinate2D coordenada;
        coordenada.latitude = newLocation.coordinate.latitude;
        coordenada.longitude = newLocation.coordinate.longitude;
        MKCoordinateRegion regiao = MKCoordinateRegionMakeWithDistance(coordenada, 500, 500);
        [self.mapView setRegion:regiao animated:YES];
    }
}

-(IBAction)mapTypeChanged:(id)sender
{
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            NSLog(@"0");
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}


@end
