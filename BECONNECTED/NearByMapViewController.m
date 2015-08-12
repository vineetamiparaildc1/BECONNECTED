//
//  NearByMapViewController.m
//  BECONNECTED
//
//  Created by indianic on 11/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "NearByMapViewController.h"

@interface NearByMapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    CLLocationManager *locationManager;
    CLGeocoder *geoCoder;
    NSMutableArray *locationArray;
    MKPolyline *routeLine;
    MKPolylineView *routeLineView;
    BOOL isUserLocationLoaded;

}

@end

@implementation NearByMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        [locationManager requestAlwaysAuthorization];
    }
    [locationManager startUpdatingLocation];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location manager
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"%d",status);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *location =  [locations firstObject];
    
    //    MKMapCamera *mapCamera = [MKMapCamera cameraLookingAtCenterCoordinate:location.coordinate fromEyeCoordinate:location.coordinate eyeAltitude:_mapView.camera.altitude];
    //    _mapView.camera = mapCamera;
    //
    //
    
    if(!isUserLocationLoaded){
        CLLocationCoordinate2D locationCoordinate = location.coordinate;
        
        [_mapview setCenterCoordinate:locationCoordinate animated:YES];
        
        
        isUserLocationLoaded = YES;
        
    }
    
    PFGeoPoint 	*currentlocation = [PFGeoPoint geoPointWithLocation:location];
    PFUser *user = [PFUser currentUser];
    
    [user setObject:currentlocation forKey:@"GeoPoint"];
    [user saveInBackground];
    
    //Reverse geocoding
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *myPlace = [placemarks firstObject];
        NSLog(@"%@",myPlace.name);
    }];
}


@end
