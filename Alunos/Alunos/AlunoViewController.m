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


- (IBAction)editingDidBegin {
    self.avisos.text = @"";
    
}


- (IBAction)submeter {
   
    NSString * nrAluno;
    NSString * nomeAluno;
    NSString * tipoUtilizador;
    NSString * cursoUtilizador;
    NSString * password;
    Alunos * alunoObj;
    
    //Instanciar um alunoObj
    alunoObj = [[Alunos alloc]init];
    
    //Desligar o teclado depois de introduzir
    [self.nrAluno resignFirstResponder];
    [self.nomeAluno resignFirstResponder];
    [self.tipoUtilizador resignFirstResponder];
    [self.cursoUtilizador resignFirstResponder];
    [self.password resignFirstResponder];
    
    
    //Ver se ja existe  um aluno com o numero introduzido
    for (Alunos * obj in self.alunosArr)
    {
        NSString * aux = [NSString stringWithFormat:@"%d",obj.nrAluno];
        if([aux isEqualToString:self.nrAluno.text])
        {
            self.avisos.textColor = [UIColor redColor];
            self.avisos.text = @"Numero já existe";
            self.nrAluno.text = @"";
            return;
        }
    }
    
    //Obter os valores que estao nos TextField
    if([self.nrAluno.text length] == 0)
    {
        self.avisos.text=@"Introduza o nr do aluno";
        return;
    }
    else
        nrAluno = self.nrAluno.text;
    
    if([self.nomeAluno.text length] == 0)
    {
        self.avisos.text=@"Introduza o nome do aluno";
        return;
    }
    else
        nomeAluno = self.nomeAluno.text;
    
    if ([self.tipoUtilizador.text length] == 0)
    {
        self.avisos.text=@"Introduza o tipo de utilizador - 0 para aluno";
        return;
    }
    else
        tipoUtilizador = self.tipoUtilizador.text;
    
    if ([self.cursoUtilizador.text length] == 0)
    {
        self.avisos.text=@"Introduza o curso do aluno";
        return;
    }
    else
        cursoUtilizador = self.cursoUtilizador.text;
    
    if ([self.password.text length] == 0)
    {
        self.avisos.text=@"Introduza a password do aluno";
        return;
    }
    else
        password = self.password.text;
    
    
    //Indicar que os valores foram bem introduzido
    self.avisos.textColor = [UIColor greenColor];
    self.avisos.text = @"Introduçao bem sucedida";
    
    //Afetar as variaveis de classe do tipo aluno
    alunoObj.nrAluno = [self.nrAluno.text integerValue];
    alunoObj.nomeAluno = self.nomeAluno.text;
    alunoObj.tipoUtilizador = [self.tipoUtilizador.text integerValue];
    alunoObj.curso = self.cursoUtilizador.text;
    alunoObj.password = self.password.text;
    
    //Introduzir o alunoObj para dentro do array
    [self.alunosArr addObject:alunoObj];
    
    //Apagar os valores dos TextField
    self.nrAluno.text = @"";
    self.nomeAluno.text = @"";
    self.tipoUtilizador.text =@"";
    self.cursoUtilizador.text = @"";
    self.password.text = @"";
    
    [self.navigationController popViewControllerAnimated:YES];
    
}






@end
