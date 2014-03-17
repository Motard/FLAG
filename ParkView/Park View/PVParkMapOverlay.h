//
//  PVParkMapOverlay.h
//  Park View
//
//  Created by Paulo Martins on 17/03/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//Isto não sei o que faz
@class PVPark;

@interface PVParkMapOverlay : NSObject <MKOverlay>

-(instancetype)initWithPark:(PVPark *)park;

@end
