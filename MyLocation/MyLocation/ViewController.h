//
//  ViewController.h
//  MyLocation
//
//  Created by Formando FLAG on 07/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
//esta framework vai gerir a locations
#import <CoreLocation/CoreLocation.h>
//esta framework trata dos mapas
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;


@end
