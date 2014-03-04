//
//  AddUtilizadorViewController.h
//  iEscola
//
//  Created by Paulo Martins on 03/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilizadores.h"
#import "ListaUtilizadoresViewController.h"



@interface AddUtilizadorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tfNrUtilizador;
@property (weak, nonatomic) IBOutlet UITextField *tfNomeUtilizador;
@property (weak, nonatomic) IBOutlet UITextField *tfTipoUtilizador;
@property (weak, nonatomic) IBOutlet UITextField *tfCursoUtilizador;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@property (weak, nonatomic) IBOutlet UILabel *lAviso;

@property (strong,nonatomic) NSMutableArray* utilizadoresArr;

@end
