//
//  PVParkMapOverlay.m
//  Park View
//
//  Created by Paulo Martins on 17/03/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

#import "PVParkMapOverlay.h"
#import "PVPark.h"

@implementation PVParkMapOverlay

//Estas duas propriedades são obrigatórias. Condição de implementar o protocolo <MKOverlay> 
@synthesize coordinate;
@synthesize boundingMapRect;

-(instancetype)initWithPark:(PVPark *)park
{
    self = [super init];
    if(self)
    {
        boundingMapRect = park.overlayBoundingMapRect;
        coordinate = park.midCoordinate;
    }
    return self;
}

@end
