//
//  AmbulareRotaDetailViewController.h
//  Ambulare
//
//  Created by Paulo Martins on 23/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@interface AmbulareRotaDetailViewController : UIViewController 

@property (nonatomic) NSString *nomeRota;

@property (weak, nonatomic) IBOutlet MKMapView *MapView;

@end
