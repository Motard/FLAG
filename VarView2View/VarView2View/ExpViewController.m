//
//  ExpViewController.m
//  VarView2View
//
//  Created by Paulo Martins on 15/03/14.
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
    NSLog(@"viewDidLoad");
    
    //Cria uma variável e instancia
    ExpAppDelegate *delegate = (ExpAppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.verdade=NO;
    
    
    if (delegate.verdade)
    {
        NSLog(@"TRUE");

    }
    else
    {
        NSLog(@"FALSE");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
