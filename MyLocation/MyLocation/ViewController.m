//
//  ViewController.m
//  MyLocation
//
//  Created by Formando FLAG on 07/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) CLLocationManager * manager;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated
{
    //mostra o ponto da localização actual
    self.mapView.showsUserLocation=YES;
    
    
    
    //Criar um objecto de tipo CLLocationManager
    self.manager = [[CLLocationManager alloc]init];
    
    self.manager.delegate = self;
    
    //Defenir a accuracy
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;

    //liga o GPS e pede a localizaçao
    [self.manager startUpdatingLocation];
    
    NSLog(@"Estou a obter a localização");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@",newLocation);
    
    
    if(newLocation != oldLocation)
    {
        CLLocationCoordinate2D coordenada;
        coordenada.latitude = newLocation.coordinate.latitude;
        coordenada.longitude = newLocation.coordinate.longitude;
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordenada, 500, 500);
        
        //serve para desenhar o caminho
        MKPointAnnotation * point = [[MKPointAnnotation alloc]init];
        point.coordinate = coordenada;
        point.title = @"Hello";
        [self.mapView addAnnotation:point];
        
        [self.mapView setRegion:region animated:YES];
        
        self.locationLabel.text = [NSString stringWithFormat:@"%lf %lf", coordenada.longitude,coordenada.latitude];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"ERRO!! Nao foi possivel localizar: %@",error);
}

@end
