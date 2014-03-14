//
//  AmbulareViewController.m
//  Ambulare
//
//  Created by Formando FLAG on 12/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareViewController.h"

@interface AmbulareViewController ()

@end

@implementation AmbulareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Carrega a imagem HomeScreen para uma ImageVIew
    //self.ImageViewHome.image = [UIImage imageNamed:@"Default@2x"];
    
    NSLog(@"viewDidLoad");
    
    //Tirar a imagem do swipe gesture
    self.ImageSwipeGesture.alpha = 0;
    
    NSTimer *timer = [[NSTimer alloc]init];
    //[timer timeInterval
    
    [timer performSelector:[self mostraImagem] withObject:nil afterDelay:2.0];
    
    
    
    [self mostraImagem];
    
    [self escondeImagem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mostraImagem
{
    NSLog(@"mostraImagem");
    
    [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^
    {
        self.ImageSwipeGesture.alpha = 1;
    }
    completion:Nil];
    
    [NSThread sleepForTimeInterval:5];
    //[self escondeImagem];
}

-(void)escondeImagem
{
    NSLog(@"escondeIMagem");
    [UIView animateWithDuration:2 delay:3 options:UIViewAnimationOptionCurveEaseIn animations:^
    {
        self.ImageSwipeGesture.alpha = 0;
    }
    completion:Nil];
    
    //[self mostraImagem];
}



@end
