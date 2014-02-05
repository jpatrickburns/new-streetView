//
//  MyTableViewController.h
//  StreetView
//
//  Created by James Burns on 2/4/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) NSString *myKind;
@end
