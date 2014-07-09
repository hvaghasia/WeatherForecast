//
//  CityListViewController.m
//  FindWeather
//
//  Created by Hardik Vaghasia on 7/8/14.
//  Copyright (c) 2014 LeftShift. All rights reserved.
//

#import "CityListViewController.h"
#import "CityInfo.h"
#import "WeatherInfoTableViewController.h"
#import <CoreLocation/CoreLocation.h>

#define kAppId      @"4277acaa0207f790b85c7b1cd8964e5b"


@interface CityListViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSMutableArray * cityInfoArray;
@property (nonatomic) NSUInteger selectedCityIndex ;
@property (nonatomic, strong) CLLocationManager * locationManager;

@end


@implementation CityListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Weather App";
    
    UISearchBar * tempSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)];
    self.searchBar = tempSearchBar;
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchBar;
    
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cityInfoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier: @"CityCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.cityInfoArray[indexPath.row] cityName];
    
    return cell;
}

- (NSIndexPath *) tableView: (UITableView *) tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedCityIndex = indexPath.row;
    
    return indexPath;
}


#pragma mark - UISearchBar delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    NSArray * cityNamesArray = [searchBar.text componentsSeparatedByString: @", "];
    
    for (NSString * cityname in cityNamesArray)
    {
        NSString *string = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=%@&cnt=14&APPID=%@", cityname, kAppId];
        NSURL * url = [NSURL URLWithString:string];
        [self findWeatherDataWithURL: url];
    }
}

- (void) findWeatherDataWithURL: (NSURL *) url
{
    self.cityInfoArray = [NSMutableArray array];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionDataTask *dataTask =
    [self.session dataTaskWithURL: url
                completionHandler: ^(NSData *data,
                                     NSURLResponse *response,
                                     NSError *error) {
                    if (!error)
                    {
                        NSHTTPURLResponse * httpResp = (NSHTTPURLResponse*) response;
                        if (httpResp.statusCode == 200)
                        {
                            NSError * jsonError;
                            
                            NSDictionary * jsonData =
                            [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingAllowFragments
                                                              error:&jsonError];
                            NSLog(@"Result : %@", jsonData);
                            
                            if (!jsonError)
                            {
                                CityInfo * cityInfo = [[CityInfo alloc] initWithJSONData: jsonData];
                                [self.cityInfoArray addObject: cityInfo];
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    
                                    [self.tableView reloadData];
                                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                    
                                });
                            }
                        }
                        else
                        {
                            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                            
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather Information"
                                                                                message:[error localizedDescription]
                                                                               delegate:nil
                                                                      cancelButtonTitle:@"Ok"
                                                                      otherButtonTitles:nil];
                            [alertView show];
                        }
                    }
                }];
    
    [dataTask resume];

}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    WeatherInfoTableViewController * cityInfoVC = segue.destinationViewController;
    cityInfoVC.cityInfo = self.cityInfoArray[self.selectedCityIndex];
}


#pragma mark - CLLocationManager and its delegates

- (IBAction) findCurrentLoactionAndWeatherInfo: (id) sender
{
    if (!self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.distanceFilter = 50;
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * currentLocation = [locations lastObject];
    
    NSString *string = [NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/forecast/daily?lat=%f&lon=%f&cnt=14&mode=json&APPID=%@", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude,  kAppId];
    NSURL * url = [NSURL URLWithString: string];
    [self findWeatherDataWithURL: url];
    
    [self.locationManager stopUpdatingLocation];
}

- (void) locationManager: (CLLocationManager *) manager
        didFailWithError: (NSError *) error
{
    NSLog(@"Could not find user's location...");
    [self.locationManager stopUpdatingLocation];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not find user's location"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}


@end
