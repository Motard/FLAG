//
//  DetailUtilizadorViewController.h
//  iEscola
//
//  Created by Formando FLAG on 05/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilizadores.h"

@interface DetailUtilizadorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lNrUtilizador;
@property (weak, nonatomic) IBOutlet UILabel *lNomeUtilizador;

@property (weak, nonatomic) IBOutlet UILabel *lCursoUtilizador;
@property (weak, nonatomic) IBOutlet UILabel *lPasswordUtilizador;
@property (weak, nonatomic) IBOutlet UIImageView *ivTipoUtilizador;

@property Utilizadores * utilizadorObj;

@end
