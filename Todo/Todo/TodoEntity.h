//
//  TodoEntity.h
//  Todo
//
//  Created by Formando FLAG on 10/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TodoEntity : NSManagedObject

@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * nota;
@property (nonatomic, retain) NSDate * data;
@property (nonatomic, retain) NSNumber * completo;

@end
