//
//  FavoritesTableView.h
//  StreetView
//
//  Created by James Burns on 2/11/14.
//  Copyright (c) 2014 James Burns. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapAnnotations.h"

@interface FavoritesTableView : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property MapAnnotations *currLoc;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end
