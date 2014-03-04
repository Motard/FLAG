//
//  WebViewController.m
//  PassVariable
//
//  Created by Paulo Martins on 04/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize myWebView;
@synthesize webSiteURL;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webSiteURL]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
