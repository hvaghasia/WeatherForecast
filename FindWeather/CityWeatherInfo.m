//
//  CityWeatherInfo.m
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import "CityWeatherInfo.h"

@implementation CityWeatherInfo


- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        
        NSDictionary * tempDict = data[@"temp"];
        self.dayTemp = tempDict[@"day"];
        self.minTemp = tempDict[@"min"];
        self.maxTemp = tempDict[@"max"];
        self.eveningTemp = tempDict[@"eve"];
        self.nightTemp = tempDict[@"night"];
        self.morningTemp = tempDict[@"morn"];
        
        self.pressure = data[@"pressure"];
        self.humidity = data[@"humidity"];
        
        NSArray * weatherArray = data[@"weather"];
        NSDictionary * weatherConditionDict = weatherArray[0];
        self.weatherCondition = weatherConditionDict[@"main"];
    }
    return self;
}


@end
