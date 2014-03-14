//
//  ViewController.m
//  LightSaber
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
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)rodar:(id)sender
{

    
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^
     {
     
         self.lightSaber.transform = CGAffineTransformMakeRotation(180);
     } completion: ^(BOOL finished){
         if (finished) {
             [self rodar:sender];
         }
     }];

    
}

@end
