//
//  ViewController.h
//  additionalSql
//
//  Created by Anthony Dagati on 10/29/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HomeModelProtocol>

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

