//
//  AmbulareViewController.m
//  iFacebook
//
//  Created by Formando FLAG on 12/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareViewController.h"

@interface AmbulareViewController ()

@end

@implementation AmbulareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FBLoginView *loginView = [[FBLoginView alloc]initWithReadPermissions:@[@"basic_info",@"email",@"user_likes"]];

    
    loginView.frame= self.view.frame;
    loginView.delegate=self;
    [self.view addSubview:loginView];
    
    
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"%@",user);
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSLog(@"%@",error.description);
}
@end
