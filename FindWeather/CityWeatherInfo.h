//
//  CityWeatherInfo.h
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityWeatherInfo : NSObject

@property (nonatomic, strong) NSNumber * dayTemp;
@property (nonatomic, strong) NSNumber * minTemp;
@property (nonatomic, strong) NSNumber * maxTemp;
@property (nonatomic, strong) NSNumber * nightTemp;
@property (nonatomic, strong) NSNumber * eveningTemp;
@property (nonatomic, strong) NSNumber * morningTemp;
@property (nonatomic, strong) NSNumber * pressure;
@property (nonatomic, strong) NSNumber * humidity;
@property (nonatomic, strong) NSString * weatherCondition;

- (id)initWithJSONData:(NSDictionary*)data;


@end
