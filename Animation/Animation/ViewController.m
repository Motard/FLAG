//
//  ViewController.m
//  Animation
//
//  Created by Formando FLAG on 14/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)MudarCor:(id)sender
{
    UIButton *botao = sender;
    self.nomeLabel.alpha = 0;
    CGRect frameDaLabel = self.nomeLabel.frame;
    
    if([botao.titleLabel.text isEqualToString:@"Rosa"])
    {
        [UIView animateWithDuration:2 delay:1 options:UIViewAnimationOptionCurveEaseIn animations:^
        {
            self.nomeLabel.textColor = [UIColor purpleColor];
            self.nomeLabel.alpha = 1;
            
            self.nomeLabel.frame = CGRectMake(frameDaLabel.origin.x, 120, frameDaLabel.size.width , frameDaLabel.size.height);
        } completion:nil];
        
    }
    
    if([botao.titleLabel.text isEqualToString:@"Amarelo"])
    {
        
        
        [UIView animateWithDuration:10 animations:^{
            
            self.nomeLabel.textColor = [UIColor yellowColor];
            self.nomeLabel.alpha = 1;
        }];
        
    }
    
    if([botao.titleLabel.text isEqualToString:@"Verde"])
    {
        
        [UIView animateWithDuration:10 animations:^{
            self.nomeLabel.textColor = [UIColor greenColor];
        }];
        
    }

   
    
}



@end
