//
//  AlunoViewController.h
//  Alunos
//
//  Created by Formando FLAG on 26/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alunos.h"

@interface AlunoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nrAluno;

@property (weak, nonatomic) IBOutlet UITextField *nomeAluno;

@property (weak, nonatomic) IBOutlet UITextField *tipoUtilizador;

@property (weak, nonatomic) IBOutlet UITextField *cursoUtilizador;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UILabel *avisos;

@end
