//
//  AmbularePageViewController.m
//  Ambulare
//
//  Created by Paulo Martins on 11/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AmbularePageViewController.h"

@interface AmbularePageViewController ()

@end

@implementation AmbularePageViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    return NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIViewController *viewControler = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
    if (viewControler.view.superview != Nil)
    {
        [viewControler viewWillAppear:animated];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    UIViewController *viewControler = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
    if (viewControler.view.superview != Nil)
    {
        [viewControler viewWillDisappear:animated];
    }
    [super viewWillDisappear:animated];
}

-(void)viewDidDisappear:(BOOL)animated
{
    UIViewController *viewControler = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
    if (viewControler.view.superview != Nil)
    {
        [viewControler viewDidDisappear:animated];
    }
    [super viewDidDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (NSUInteger i = 0; i < [self.childViewControllers count]; i++)
    {
        [self loadScrollViewWithPage:i];
    }
    
    self.pageControl.currentPage = 0;
    _pageControl=0;
    
    [self.pageControl setNumberOfPages:[self.childViewControllers count]];
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
    if(viewController.view.superview != Nil)
    {
        [viewController viewWillAppear:animated];
    }
    
    self.scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * [self.childViewControllers count], _scrollView.frame.size.height);
}

-(void) loadScrollViewWithPage:(int)page
{
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
            //replace the placeholder if necessary
    UIViewController *controler = [self.childViewControllers objectAtIndex:page];
    if (controler == Nil)
    {
        return;
    }
    
            //add the controller's view to the scroll view
    if (controler.view.superview == Nil)
    {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controler.view.frame = frame;
        [self.scrollView addSubview:controler.view];
    }
}


// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControl = NO;
}

@end
