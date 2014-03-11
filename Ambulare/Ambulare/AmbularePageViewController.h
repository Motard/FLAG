//
//  AmbularePageViewController.h
//  Ambulare
//
//  Created by Paulo Martins on 11/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmbularePageViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@end
