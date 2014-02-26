//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Formando FLAG on 24/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@property (nonatomic) Brain * brain;
@property (nonatomic) BOOL userIsEnteringText;

@end

@implementation CalculatorViewController

-(Brain * )brain
{
    if(_brain == Nil)
    {
        _brain=[[Brain alloc]init];
    }
    return _brain;
}

- (IBAction)numberPressed:(UIButton *)sender {
    NSString * texto;
    
    if(!self.userIsEnteringText)
    {
        texto = sender.currentTitle;
        self.userIsEnteringText =YES;
    }
    else
    {
            texto = [self.display.text stringByAppendingString:sender.currentTitle];
    }
    
  //  NSLog(@"%@",texto);
    self.display.text = texto;
    
}


- (IBAction)operationPressed:(UIButton *)sender {
    double result = [self.brain performOperation:sender.currentTitle];
    
    
    self.display.text = [NSString  stringWithFormat:@"%.0f",result];
}


- (IBAction)enterPressed:(id)sender {
    
    [self.brain addNumber:[self.display.text doubleValue]];
    self.userIsEnteringText = NO;
    self.display.text = @"0";
    
}


@end
