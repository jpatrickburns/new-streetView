//
//  SpecialsViewController.h
//  streetView
//
//  Created by James Burns on 4/17/12.
//  Copyright (c) 2012 James Burns [design]. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpecialsViewController : UIViewController<UIWebViewDelegate,UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end
