//
//  AmbulareFacebookViewController.m
//  Ambulare
//
//  Created by Formando FLAG on 26/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbulareFacebookViewController.h"

@interface AmbulareFacebookViewController ()

@end

@implementation AmbulareFacebookViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FBLoginView *loginView = [[FBLoginView alloc]initWithReadPermissions:@[@"basic_info",@"email",@"user_likes"]];
    loginView.defaultAudience=FBSessionDefaultAudienceFriends;
    loginView.publishPermissions=@[@"publish_actions"];
 //   [FBLoginView class];
   
  //  loginView.frame= self.view.frame;
    loginView.delegate=self;
  //  [self.view addSubview:loginView];
    
    
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    NSLog(@"%@",user);
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error
{
    NSLog(@"%@",error.description);
}

- (IBAction)postFB:(id)sender
{
    // instantiate a Facebook Open Graph object
    NSMutableDictionary<FBOpenGraphObject> *object = [FBGraphObject openGraphObjectForPost];
    
    // specify that this Open Graph object will be posted to Facebook
    object.provisionedForPost = YES;
    
    // for og:title
    object[@"title"] = @"Rota 1";
    
    // for og:type, this corresponds to the Namespace you've set for your app and the object type name
    object[@"type"] = @"ambulare:rota";
    
    // for og:description
    object[@"description"] = @"bla bla bla.";
    
    // for og:url, we cover how this is used in the "Deep Linking" section below
    object[@"url"] = @"http://example.com/roasted_pumpkin_seeds";
    
    // for og:image we assign the image that we just staged, using the uri we got as a response
    // the image has to be packed in a dictionary like this:
    //object[@"image"] = @[@{@"url": [result objectForKey:@"uri"], @"user_generated" : @"false" }];
    
    
    // Post custom object
    [FBRequestConnection startForPostOpenGraphObject:object completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if(!error) {
            // get the object ID for the Open Graph object that is now stored in the Object API
            NSString *objectId = [result objectForKey:@"id"];
            NSLog(@"object id: %@", objectId);
            
            // Further code to post the OG story goes here
            
            // create an Open Graph action
            id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
            [action setObject:objectId forKey:@"rota"];
            
            // create action referencing user owned object
            [FBRequestConnection startForPostWithGraphPath:@"me/ambulare:criar"
                                               graphObject:action
                                         completionHandler:^(FBRequestConnection *connection,
                                                             id result,
                                                             NSError *error) {
                if(!error) {
                    NSLog([NSString stringWithFormat:@"OG story posted, story id: %@", [result objectForKey:@"id"]]);
                    [[[UIAlertView alloc] initWithTitle:@"OG story posted"
                                                message:@"Check your Facebook profile or activity log to see the story."
                                               delegate:self
                                      cancelButtonTitle:@"OK!"
                                      otherButtonTitles:nil] show];
                } else {
                    // An error occurred
                    NSLog(@"Encountered a error posting to Open Graph: %@", error);
                }
            }];

            
            
            
        } else {
            // An error occurred
            NSLog(@"Error posting the Open Graph object to the Object API: %@", error);
        }
    }];
    
    
}


//https://developers.facebook.com/docs/android/scrumptious/publish-open-graph-story/

@end
