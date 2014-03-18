//
//  ExpViewController.h
//  Map
//
//  Created by Paulo Martins on 18/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ExpViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;

@end
