//
//  PVParkMapOverlayView.m
//  Park View
//
//  Created by Paulo Martins on 17/03/14.
//  Copyright (c) 2014 Chris Wagner. All rights reserved.
//

#import "PVParkMapOverlayView.h"

@interface PVParkMapOverlayView ()

@property (nonatomic,strong) UIImage *overlayImage;

@end



@implementation PVParkMapOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(instancetype) initWithOverlay:(id<MKOverlay>)overlay overlayImage:(UIImage *)overlayImage
{
    self = [super initWithOverlay:overlay];
    if(self)
    {
        _overlayImage = overlayImage;
    }
    return self;
}

-(void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context
{
    CGImageRef imageReference = self.overlayImage.CGImage;
    
    MKMapRect theMapRect = self.overlay.boundingMapRect;
    CGRect theRect = [self rectForMapRect:theMapRect];
    
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -theRect.size.height);
    CGContextDrawImage(context, theRect, imageReference);
    
}

@end
