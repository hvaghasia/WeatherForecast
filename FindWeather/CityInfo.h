//
//  CityInfo.h
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityInfo : NSObject

@property (strong, nonatomic) NSString * cityName;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (strong, nonatomic) NSString * countryName;
@property (strong, nonatomic) NSMutableArray * cityWeatherInfoArray;


- (id)initWithJSONData:(NSDictionary*)data;


@end
