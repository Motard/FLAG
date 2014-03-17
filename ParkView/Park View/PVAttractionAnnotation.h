//
//  PVAttractionAnnotation.h
//  Park View
//
//  Created by Paulo Martins on 17/03/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


typedef NS_ENUM(NSInteger, PVAttractionType)
{
    PVAttractionDefault = 0,
    PVAttractionRide,
    PVAttractionFood,
    PVAttractionFirstAid
};

@interface PVAttractionAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic) PVAttractionType type;

@end
