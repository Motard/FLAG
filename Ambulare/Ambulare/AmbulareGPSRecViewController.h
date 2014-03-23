//
//  AmbulareGPSRecViewController.h
//  Ambulare
//
//  Created by Paulo Martins on 15/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface AmbulareGPSRecViewController : UIViewController <CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UITextField *tfNomePercurso;
@property (weak, nonatomic) IBOutlet UILabel *lAviso;
@property (weak, nonatomic) IBOutlet UILabel *lcoordenadas;
@property (weak, nonatomic) IBOutlet UIView *vBottomViewGetNomePercurso;

@property (weak, nonatomic) IBOutlet UIView *vViewGPSStatus;
@property (weak, nonatomic) IBOutlet UILabel *lTotalTimeTracked;
@property (weak, nonatomic) IBOutlet UILabel *lAVGPace;
@property (weak, nonatomic) IBOutlet UILabel *lSpeed;
@property (weak, nonatomic) IBOutlet UILabel *lDistance;
@property (weak, nonatomic) IBOutlet UILabel *lUnidadeDistancia;

@property (weak, nonatomic) IBOutlet MKMapView *mvMap;

@property (nonatomic) NSMutableArray *locationsArr;

@end
