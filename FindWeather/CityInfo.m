//
//  CityInfo.m
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import "CityInfo.h"
#import "CityWeatherInfo.h"

@implementation CityInfo

- (id)initWithJSONData:(NSDictionary*)data
{
    self = [super init];
    if (self) {
        
        NSDictionary * cityDict = data[@"city"];
        self.cityName = cityDict[@"name"];
        self.countryName = cityDict[@"country"];
        
        NSDictionary * locationDict = cityDict[@"coord"];
        self.latitude = [locationDict[@"lat"] doubleValue];
        self.longitude = [locationDict[@"lon"] doubleValue];
        
        NSArray * weatherInfoArray = data[@"list"];
        self.cityWeatherInfoArray = [NSMutableArray array];
        for (NSDictionary * weatherDict in weatherInfoArray)
        {
            CityWeatherInfo * cityWeatherInfo = [[CityWeatherInfo alloc] initWithJSONData: weatherDict];
            [self.cityWeatherInfoArray addObject: cityWeatherInfo];
        }
    }
    return self;
}


@end
