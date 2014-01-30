//
//  SpecialsViewController.m
//  streetView
//
//  Originally created by James Burns on 4/17/12.
//  Copyright (c) 2014 James Burns [design]. All rights reserved.
//

#import "SpecialsViewController.h"

@implementation SpecialsViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)loadUpPage
{

    [_spinner startAnimating];
    UIColor *purple = [UIColor colorWithRed:108.0f/255.0f green:81.0f/255.0f blue:152.0f/255.0f alpha:1];
    [[[self navigationController] navigationBar] setTintColor:purple];
        
    NSString *specialURL = @"http://jamesburnsdesign.com/tests/streetLevel/specials.html";
    NSURL *url = [NSURL URLWithString:specialURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60]; 
    
    [_myWebView loadRequest:request];

}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	// starting the load, show the activity indicator in the status bar
	[_spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	// finished loading, hide the activity indicator in the status bar
	[_spinner stopAnimating];
    [_spinner setAlpha:0];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Failed to load with error: %@",[error localizedDescription]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Can’t retrieve specials."  
                                                    message:[error localizedDescription] 
                                                   delegate:self cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    _myWebView.delegate = self;

    [super viewDidLoad];
    [self loadUpPage];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)viewDidUnload
{
    [self setMyWebView:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
