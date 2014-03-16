//
//  ExpViewController.m
//  FadeIn&FadeOut
//
//  Created by Paulo Martins on 14/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ExpViewController.h"

@interface ExpViewController ()

@end

@implementation ExpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Tirar a label
    self.label.alpha = 0;
    
    [self mostraLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) mostraLabel
{
    [UIView animateWithDuration:4 animations:^
    {
        self.label.alpha = 1;
    } completion:^(BOOL finished)
    {
        [self escondeLabel];
    }];
}

-(void)escondeLabel
{
    NSLog(@"escondeLabel");
    
    [UIView animateWithDuration:4 animations:^
    {
        self.label.alpha = 0;
    } completion:^(BOOL finished)
    {
        [self mostraLabel];
    }];
}

@end