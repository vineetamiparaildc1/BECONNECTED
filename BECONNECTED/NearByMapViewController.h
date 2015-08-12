//
//  NearByMapViewController.h
//  BECONNECTED
//
//  Created by indianic on 11/08/15.
//  Copyright (c) 2015 indianic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Parse.h>

@interface NearByMapViewController : UIViewController

@property(nonatomic,weak)IBOutlet MKMapView *mapview;

@end
