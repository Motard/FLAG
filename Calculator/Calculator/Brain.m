//
//  Brain.m
//  Calculator
//
//  Created by Formando FLAG on 24/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "Brain.h"
@interface Brain()

@property (nonatomic) NSMutableArray * stack;


@end


@implementation Brain


//getter
-(NSMutableArray *) stack{
    if (_stack == Nil)
    _stack = [[NSMutableArray alloc]init];
    
    return _stack;
}

-(void) addNumber:(double) number
{
    //converter o number(tipo primitivo) para objecto do tipo NSNumber
    NSNumber * aux = [NSNumber numberWithDouble:number];
    [self.stack addObject:aux];
}

-(double) numberGet
{
    double aux = [[self.stack lastObject] doubleValue];
    if ([self.stack count] != 0)
        [self.stack removeLastObject];
    
    return aux;
}


-(double) performOperation:(NSString*)operation
{
    double result = 0;
    
    if([operation isEqualToString:@"+"])
        result = [self numberGet] + [self numberGet];
   
    if([operation isEqualToString:@"-"])
        result = [self numberGet] - [self numberGet];
    
    if([operation isEqualToString:@"x"])
        result = [self numberGet] * [self numberGet];
    
    if([operation isEqualToString:@"/"])
        result = [self numberGet] / [self numberGet];
    
    return result;
}
@end
