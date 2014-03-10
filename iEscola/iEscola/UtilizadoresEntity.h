//
//  UtilizadoresEntity.h
//  iEscola
//
//  Created by Paulo Martins on 10/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UtilizadoresEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * nrUtilizador;
@property (nonatomic, retain) NSString * nomeUtilizador;
@property (nonatomic, retain) NSNumber * tipoUtilizador;
@property (nonatomic, retain) NSString * cursoUtilizador;
@property (nonatomic, retain) NSString * password;

@end
