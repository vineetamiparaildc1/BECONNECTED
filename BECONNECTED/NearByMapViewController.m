//
//  NearByMapViewController.m
//  BECONNECTED
//
//  Created by indianic on 11/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import "NearByMapViewController.h"
#import "ChatDetailsViewController.h"

@interface NearByMapViewController ()
{
    CLLocationManager *locationManager;
    CLLocation *location;
    GMSPolyline *polyLine;
    GMSCameraPosition *camera;
    // CLGeocoder *geoCoder;
    //  NSMutableArray *locationArray;
    //  MKPolyline *routeLine;
    //  MKPolylineView *routeLineView;
    BOOL isMapLoaded;
    PFObject *obj;
    
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
    _mapView.myLocationEnabled = YES;
    
    _mapView.delegate =self;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"%d",status);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    location = [locations firstObject];
    if(!isMapLoaded){
        camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:5];
        _mapView.camera =  camera;
        isMapLoaded = YES;
    }
    
    if (![location isEqual: location])
    {
        PFGeoPoint 	*currentlocation = [PFGeoPoint geoPointWithLocation:location];
        PFUser *user = [PFUser currentUser];
        
        [user setObject:currentlocation forKey:@"GeoPoint"];
        [user saveInBackground];
    }
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKeyExists:@"GeoPoint"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (int i=0; i<objects.count; i++) {
                PFGeoPoint *point = [[objects objectAtIndex:i]objectForKey:@"GeoPoint"];
                
                GMSMarker *marker = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(point.latitude, point.longitude)];
                marker.title = [[objects objectAtIndex:i]objectForKey:@"fullname"];
                marker.map =  _mapView;
                
            }
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}
-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
    
    [polyLine setMap:nil];
    [self drawPathBetween:location.coordinate toLocation:marker.position];
    return NO;
    
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    [[NSUserDefaults standardUserDefaults]setObject:marker.title forKey:@"MapName"];
    PFUser *user = [PFUser currentUser];
    if (![marker.title isEqualToString:[user objectForKey:@"fullname"]])
    {
        ChatDetailsViewController *objclass = [self.storyboard instantiateViewControllerWithIdentifier:@"ChatDetailsViewController"];
        [self presentViewController:objclass animated:YES completion:nil];
    }
    
}

-(void)drawPathBetween:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation{
    
    // Google direction URL
    NSString *baseUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=true", fromLocation.latitude,  fromLocation.longitude, toLocation.latitude,  toLocation.longitude];
    
    NSURL *url = [NSURL URLWithString:[baseUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"Url: %@", url);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *aDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        NSString *aStrPoints = [[[[aDict objectForKey:@"routes"] firstObject] objectForKey:@"overview_polyline"] objectForKey:@"points"];
        
        GMSPath *path =  [GMSPath pathFromEncodedPath:aStrPoints];
        polyLine = [GMSPolyline polylineWithPath:path];
        polyLine.strokeWidth = 3.0;
        polyLine.strokeColor =  [UIColor redColor];
        polyLine.map= _mapView;
        
        
        NSLog(@"%@",aDict);
        
    }];
    
}


@end
