//
//  WeatherInfoTableViewController.h
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityInfo.h"

@interface WeatherInfoTableViewController : UITableViewController

@property (nonatomic, strong) CityInfo * cityInfo;

@end
