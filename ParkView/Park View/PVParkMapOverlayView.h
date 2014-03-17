//
//  PVParkMapOverlayView.h
//  Park View
//
//  Created by Paulo Martins on 17/03/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface PVParkMapOverlayView : MKOverlayView

-(instancetype)initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage;

@end
