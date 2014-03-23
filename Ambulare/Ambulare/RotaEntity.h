//
//  RotaEntity.h
//  Ambulare
//
//  Created by Paulo Martins on 22/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RotaEntity : NSManagedObject

@property (nonatomic, retain) NSString * nomeRota;
@property (nonatomic, retain) NSNumber * distancia;
@property (nonatomic, retain) NSNumber * media;
@property (nonatomic, retain) NSNumber * tempo;

@end
