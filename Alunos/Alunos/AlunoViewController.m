//
//  AlunoViewController.m
//  Alunos
//
//  Created by Formando FLAG on 26/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AlunoViewController.h"

@interface AlunoViewController ()

@property (nonatomic) NSMutableArray * alunosArr;



@end

@implementation AlunoViewController

//Instanciar o alunosArr (lazy instantiaction)
-(NSMutableArray *) alunosArr
{
    if(_alunosArr == nil)
    {
        _alunosArr=[[NSMutableArray alloc]init];
    }
    return _alunosArr;
}


- (IBAction)submeter:(id)sender {
    
    NSString * nrAluno;
    NSString * nomeAluno;
    NSString * tipoUtilizador;
    NSString * cursoUtilizador;
    NSString * password;
    BOOL inputOK = YES;
    Alunos * alunoObj;
    
    //Instanciar um alunoObj
    alunoObj = [[Alunos alloc]init];
    
    do
    {
        //Obter os valores que estao nos TextField
        if([self.nrAluno.text length] == 0)
        {
                self.avisos.text=@"Introduza o nr do aluno";
                inputOK = NO;
            return;
        }
        else
            nrAluno = self.nrAluno.text;
        
        if([self.nomeAluno.text length] == 0)
        {
            self.avisos.text=@"Introduza o nome do aluno";
            inputOK = NO;
        }
        else
            nomeAluno = self.nomeAluno.text;
        
        if (self.tipoUtilizador.text == nil)
        {
            self.avisos.text=@"Introduza o tipo de utilizador - 0 para aluno";
            inputOK = NO;
        }
        else
            tipoUtilizador = self.tipoUtilizador.text;
        
        if (self.cursoUtilizador.text == nil)
        {
            self.avisos.text=@"Introduza o curso do aluno";
            inputOK = NO;
        }
        else
            cursoUtilizador = self.cursoUtilizador.text;
        
        if (self.password.text == nil)
        {
            self.avisos.text=@"Introduza a password do aluno";
            inputOK = NO;
        }
        else
            password = self.password.text;
        
        }
    while (inputOK == NO);
    
    //Indicar que os valores foram bem introduzido
    self.avisos.text = @"Introduçao bem sucedida";
    
    //Afetar as variaveis de classe do tipo aluno
    alunoObj.numero = [self.nrAluno.text integerValue];
    
    
    //Introduzir o alunoObj para dentro do array
    [self.alunosArr addObject:alunoObj];
    
}


@end
