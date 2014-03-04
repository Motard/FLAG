//
//  WebViewController.h
//  PassVariable
//
//  Created by Paulo Martins on 04/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (strong, nonatomic) NSString *webSiteURL;

@end
