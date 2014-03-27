//
//  AmbulareFacebookViewController.h
//  Ambulare
//
//  Created by Formando FLAG on 26/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface AmbulareFacebookViewController : UIViewController <FBLoginViewDelegate>

@property (nonatomic) NSString * nomeRota;
@property (nonatomic) double distanciaRota;

@property (weak, nonatomic) IBOutlet UILabel *lNomeRota;
@property (weak, nonatomic) IBOutlet UITextField *tvComentarioRota;
@property (weak, nonatomic) IBOutlet UILabel *lDistanciaRota;

@end
