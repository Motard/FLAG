//
//  Brain.h
//  Calculator
//
//  Created by Formando FLAG on 24/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Brain : NSObject

-(void) addNumber:(double) number;
-(double) performOperation:(NSString*)operation;

@end
