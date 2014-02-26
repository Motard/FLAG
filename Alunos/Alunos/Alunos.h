//
//  Alunos.h
//  Alunos
//
//  Created by Formando FLAG on 07/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alunos : NSObject

{
    int numero;
    NSString * nome;
    //NSArray * disciplinas;
    NSMutableArray * disciplinas;
}


-(int) numero;
-(void) setNumero:(int)novoNumero;
-(NSString *) getNome;
-(void)setNome:(NSString *)novoNome;
-(void) inicializarDisciplinas;
-(NSArray *) getDisciplina;

-(int) countDisciplinas;
-(float) mediaNotas;

@end
