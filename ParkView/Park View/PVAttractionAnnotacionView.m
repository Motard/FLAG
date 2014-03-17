//
//  PVAttractionAnnotacionView.m
//  Park View
//
//  Created by Paulo Martins on 17/03/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

#import "PVAttractionAnnotacionView.h"
#import "PVAttractionAnnotation.h"

@implementation PVAttractionAnnotacionView

-(id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if(self)
    {
        PVAttractionAnnotation *attractionAnnotation = self.annotation;
        switch (attractionAnnotation.type)
        {
            case PVAttractionFirstAid:
                self.image = [UIImage imageNamed:@"firstaid"];
                break;
            case PVAttractionFood:
                self.image = [UIImage imageNamed:@"food"];
                break;
            case PVAttractionRide:
                self.image = [UIImage imageNamed:@"ride"];
                break;
            default:
                self.image = [UIImage imageNamed:@"star"];
                break;
        }
    }
    return self;
}

@end
