//
//  DetailUtilizadorViewController.m
//  iEscola
//
//  Created by Formando FLAG on 05/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "DetailUtilizadorViewController.h"

@interface DetailUtilizadorViewController ()


@end

@implementation DetailUtilizadorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//metodo que corre antes da view aparecer
-(void)viewWillAppear:(BOOL)animated
{
    self.lNrUtilizador.text = [NSString  stringWithFormat:@"%d",self.utilizadorObj.nrUtilizador];
    self.lNomeUtilizador.text = self.utilizadorObj.nomeUtilizador;
    
    if (self.utilizadorObj.tipoUtilizador == 0)
        self.ivTipoUtilizador.image = [UIImage imageNamed:@"student"];
    else
        self.ivTipoUtilizador.image = [UIImage imageNamed:@"professor.jpeg"];
    
    self.lCursoUtilizador.text = self.utilizadorObj.curso;
    self.lPasswordUtilizador.text = self.utilizadorObj.password;
}

@end
