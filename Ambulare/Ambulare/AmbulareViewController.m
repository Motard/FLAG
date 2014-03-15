//
//  AmbulareViewController.m
//  Ambulare
//
//  Created by Formando FLAG on 12/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareViewController.h"
#import "AmbulareAppDelegate.h"

@interface AmbulareViewController ()

@property (nonatomic) bool showSwipeImage;
@property (nonatomic) AmbulareAppDelegate *delegate;

@end

@implementation AmbulareViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"viewDidLoad");
    
    //Esconder a imagem do swipe gesture
    self.ImageSwipeGesture.alpha = 0;

    //Instanciar a view do tipo AmbulareAppDelegate
    AmbulareAppDelegate *delegate = (AmbulareAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    self.showSwipeImage = delegate.showSwipeImage;
    
    if(self.showSwipeImage)
    {
        [self mostraImagem];
        NSLog(@"TRUE");
    }
    else
    {
        NSLog(@"FLASE");
    }
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    
    if(self.showSwipeImage)
    {
        //Voltar a duplicar a instancia do AppDelegate para alterar o valor do bool
        AmbulareAppDelegate *delegate = (AmbulareAppDelegate*)[[UIApplication sharedApplication]delegate];
        self.showSwipeImage = NO;
        delegate.showSwipeImage = NO;
    }
    
    if(self.showSwipeImage)
    {
        NSLog(@"TRUE");
    }
    else
    {
        NSLog(@"FLASE");
    }
}

//Bloco para tratar da imagem de swipe
//++++++++++++++++++++++++++++++++++++

-(void)mostraImagem
{
    NSLog(@"mostraImagem");
    
    if(self.showSwipeImage)
    {
        [UIView animateWithDuration:6 animations:^
        {
            self.ImageSwipeGesture.alpha = 1;
        } completion:^(BOOL finished)
        {
            [self escondeImagem];
        }];
    }
}

-(void)escondeImagem
{
    NSLog(@"escondeIMagem");
    [UIView animateWithDuration:4 animations:^
    {
        self.ImageSwipeGesture.alpha = 0;
    } completion:^(BOOL finished) {
        
        //Cria 1 Timer que reinicia o ciclo mas espera um X intervalo antes de o fazer  
        [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(mostraImagem) userInfo:Nil repeats:NO];
        
    }];
}
//++++++++++++++++++++++++++++++++++++


@end
