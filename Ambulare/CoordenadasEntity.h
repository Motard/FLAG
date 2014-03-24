//
//  CoordenadasEntity.h
//  Ambulare
//
//  Created by Formando FLAG on 24/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CoordenadasEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * nomeRota;
@property (nonatomic, retain) NSNumber * iD;

@end
