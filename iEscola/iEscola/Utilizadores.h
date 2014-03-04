//
//  Utilizadores.h
//  iEscola
//
//  Created by Paulo Martins on 03/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilizadores : NSObject

@property (nonatomic) int nrUtilizador;
@property (nonatomic) NSString* nomeUtilizador;
@property (nonatomic) int tipoUtilizador;
@property (nonatomic) NSString* curso;
@property (nonatomic) NSString* password;

@end
