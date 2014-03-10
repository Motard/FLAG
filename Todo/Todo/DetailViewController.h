//
//  DetailViewController.h
//  Todo
//
//  Created by Formando FLAG on 10/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *descricaoLabel;
@property (weak, nonatomic) IBOutlet UITextField *dataLabel;
@property (weak, nonatomic) IBOutlet UITextField *notasLabel;

@property (weak, nonatomic) IBOutlet UIButton *addButao;


@end
