//
//  ViewController.m
//  PassVariable
//
//  Created by Paulo Martins on 04/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)google:(id)sender
{
    WebViewController *WVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    WVC.webSiteURL = @"http://www.google.com";
    [self presentViewController:WVC animated:YES completion:nil];
}

- (IBAction)yahoo:(id)sender
{
    WebViewController *WVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    WVC.webSiteURL = @"http://www.yahoo.com";
    [self presentViewController:WVC animated:YES completion:nil];
}

- (IBAction)bing:(id)sender
{
    WebViewController *WVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    WVC.webSiteURL = @"http://www.bing.com";
    [self presentViewController:WVC animated:YES completion:nil];
}
@end
