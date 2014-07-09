//
//  WeatherInfoTableViewController.m
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import "WeatherInfoTableViewController.h"
#import "CityWeatherInfo.h"


#define kDefaultRow_Height          290.0
#define kFirstRow_Height            100.0


@interface WeatherInfoTableViewController ()

@end


@implementation WeatherInfoTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.cityInfo.cityName;
}


#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section
{
    return self.cityInfo.cityWeatherInfoArray.count +1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = kDefaultRow_Height;
    if (indexPath.row == 0)
    {
        rowHeight = kFirstRow_Height;
    }
    
    return rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"WeatherInfoCell"
                                                            forIndexPath: indexPath];
    
    for (UIView * subview in cell.contentView.subviews)
    {
        [subview removeFromSuperview];
    }
    
    if (indexPath.row == 0)
    {
        UILabel * countryTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 0.0, 150.0, 30.0)];
        countryTitleLabel.text = @"Country";
        [cell.contentView addSubview: countryTitleLabel];
        
        UILabel * countryValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 0.0, 100.0, 30.0)];
        countryValueLabel.text = self.cityInfo.countryName;
        countryValueLabel.textAlignment = NSTextAlignmentRight;
        countryValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.5];
        [cell.contentView addSubview: countryValueLabel];
        
        UILabel * latitudeTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 30.0, 150.0, 30.0)];
        latitudeTitleLabel.text = @"Latitude";
        [cell.contentView addSubview: latitudeTitleLabel];
        
        UILabel * latitudeValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 30.0, 100.0, 30.0)];
        latitudeValueLabel.text = [NSString stringWithFormat: @"%f", self.cityInfo.latitude];
        latitudeValueLabel.textAlignment = NSTextAlignmentRight;
        latitudeValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: latitudeValueLabel];
        
        UILabel * longitudeTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 60.0, 150.0, 30.0)];
        longitudeTitleLabel.text = @"Longitude";
        [cell.contentView addSubview: longitudeTitleLabel];
        
        UILabel * longitudeValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 60.0, 100.0, 30.0)];
        longitudeValueLabel.text = [NSString stringWithFormat: @"%f", self.cityInfo.longitude];
        longitudeValueLabel.textAlignment = NSTextAlignmentRight;
        longitudeValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: longitudeValueLabel];
    }
    else
    {
        CityWeatherInfo * weatherInfo = self.cityInfo.cityWeatherInfoArray[indexPath.row -1];
        
        UILabel * dayTempTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 0.0, 150.0, 30.0)];
        dayTempTitleLabel.text = @"Day Temp";
        [cell.contentView addSubview: dayTempTitleLabel];
        
        UILabel * dayTempValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 0.0, 100.0, 30.0)];
        dayTempValueLabel.text = [weatherInfo.dayTemp stringValue];
        dayTempValueLabel.textAlignment = NSTextAlignmentRight;
        dayTempValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: dayTempValueLabel];
        
        UILabel * minTempTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 30.0, 150.0, 30.0)];
        minTempTitleLabel.text = @"Minimum Temp";
        [cell.contentView addSubview: minTempTitleLabel];
        
        UILabel * minTempValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 30.0, 100.0, 30.0)];
        minTempValueLabel.text = [weatherInfo.minTemp stringValue];
        minTempValueLabel.textAlignment = NSTextAlignmentRight;
        minTempValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: minTempValueLabel];
        
        UILabel * maxTempTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 60.0, 150.0, 30.0)];
        maxTempTitleLabel.text = @"Maximum Temp";
        [cell.contentView addSubview: maxTempTitleLabel];
        
        UILabel * maxTempValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 60.0, 100.0, 30.0)];
        maxTempValueLabel.text = [weatherInfo.maxTemp stringValue];
        maxTempValueLabel.textAlignment = NSTextAlignmentRight;
        maxTempValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: maxTempValueLabel];
        
        UILabel * nightTempTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 90.0, 150.0, 30.0)];
        nightTempTitleLabel.text = @"Night Temp";
        [cell.contentView addSubview: nightTempTitleLabel];
        
        UILabel * nightTempValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 90.0, 100.0, 30.0)];
        nightTempValueLabel.text = [weatherInfo.nightTemp stringValue];
        nightTempValueLabel.textAlignment = NSTextAlignmentRight;
        nightTempValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: nightTempValueLabel];
        
        UILabel * eveningTempTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 120.0, 150.0, 30.0)];
        eveningTempTitleLabel.text = @"Evening Temp";
        [cell.contentView addSubview: eveningTempTitleLabel];
        
        UILabel * eveningTempValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 120.0, 100.0, 30.0)];
        eveningTempValueLabel.text = [weatherInfo.eveningTemp stringValue];
        eveningTempValueLabel.textAlignment = NSTextAlignmentRight;
        eveningTempValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: eveningTempValueLabel];
        
        UILabel * monringTempTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 150.0, 150.0, 30.0)];
        monringTempTitleLabel.text = @"Morning Temp";
        [cell.contentView addSubview: monringTempTitleLabel];
        
        UILabel * morningTempValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 150.0, 100.0, 30.0)];
        morningTempValueLabel.text = [weatherInfo.morningTemp stringValue];
        morningTempValueLabel.textAlignment = NSTextAlignmentRight;
        morningTempValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: morningTempValueLabel];
        
        UILabel * pressureTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 180.0, 150.0, 30.0)];
        pressureTitleLabel.text = @"Pressure";
        [cell.contentView addSubview: pressureTitleLabel];
        
        UILabel * pressureValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 180.0, 100.0, 30.0)];
        pressureValueLabel.text = [weatherInfo.pressure stringValue];
        pressureValueLabel.textAlignment = NSTextAlignmentRight;
        pressureValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: pressureValueLabel];
        
        UILabel * humidityTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 210.0, 150.0, 30.0)];
        humidityTitleLabel.text = @"Humidity";
        [cell.contentView addSubview: humidityTitleLabel];
        
        UILabel * humidityValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 210.0, 100.0, 30.0)];
        humidityValueLabel.text = [weatherInfo.humidity stringValue];
        humidityValueLabel.textAlignment = NSTextAlignmentRight;
        humidityValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: humidityValueLabel];
        
        UILabel * weatherCondTitleLabel = [[UILabel alloc] initWithFrame: CGRectMake(20.0, 240.0, 150.0
                                                                                     , 30.0)];
        weatherCondTitleLabel.text = @"Weather condition";
        [cell.contentView addSubview: weatherCondTitleLabel];
        
        UILabel * weatherCondValueLabel = [[UILabel alloc] initWithFrame: CGRectMake(200.0, 240.0, 100.0, 30.0)];
        weatherCondValueLabel.text = weatherInfo.weatherCondition;
        weatherCondValueLabel.textAlignment = NSTextAlignmentRight;
        weatherCondValueLabel.textColor = [[UIColor blueColor] colorWithAlphaComponent: 0.7];
        [cell.contentView addSubview: weatherCondValueLabel];
    }
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
