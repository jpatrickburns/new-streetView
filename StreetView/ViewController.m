//
//  ViewController.m
//  StreetView
//
//  Created by James Burns on 12/14/13.
//  Copyright (c) 2013 James Burns. All rights reserved.
//

#import "ViewController.h"

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

- (IBAction)changeScene:(id)sender {
    if ([sender isMemberOfClass:[UIButton class]]) {
        
        UIButton *btn = (UIButton *)sender;
        if ([btn.currentTitle isEqualToString:@"Historical"]) {
            NSLog(@"Pushed historical");
        }else if ([btn.currentTitle isEqualToString:@"Attractions"]){
            NSLog(@"Pushed Attractions");
        }else if ([btn.currentTitle isEqualToString:@"Neighborhoods"]){
            NSLog(@"Pushed neighborhoods");
        }else if ([btn.currentTitle isEqualToString:@"Only in the ATL"]){
            NSLog(@"Pushed Only in the ATL");
        }else if ([btn.currentTitle isEqualToString:@"What’s Near Me?"]){
            NSLog(@"Pushed What’s Near Me?");
        }else if ([btn.currentTitle isEqualToString:@"Special Offers"]){
            NSLog(@"Pushed Special Offers");
        }else{
            NSLog(@"Something went wrong.");
        }
    }
         }
@end
