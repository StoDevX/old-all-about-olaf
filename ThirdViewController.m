//
//  ThirdViewController.m
//  St. Olaf
//
//  Created by Drew Volz on 7/26/13.
//  Copyright (c) 2013 Drew Volz. All rights reserved.
//

#import "ThirdViewController.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface ThirdViewController ()
@end

///////////////////////////////////////////////
//St. Olaf Building Locations
//////////////////////////////////////////////


//Aaker House
#define AAKERHOUSE_LATITUDE 44.45745;
#define AAKERHOUSE_LONGITUDE -93.181594;

//Administration
#define ADMIN_LATITUDE 44.462523;
#define ADMIN_LONGITUDE -93.185767;

//Boe Chapel
#define BOE_LATITUDE 44.461901;
#define BOE_LONGITUDE -93.183871;

//Boe House
#define BOEHOUSE_LATITUDE 44.46074;
#define BOEHOUSE_LONGITUDE -93.179684;

//Buntrock Commons
#define BUNTROCK_LATITUDE 44.461874;
#define BUNTROCK_LONGITUDE -93.183015;

//Carlson Tennis Courts
#define CARLSON_LATITUDE 44.464182;
#define CARLSON_LONGITUDE -93.187121;

//Christiansen Hall of Music
#define CHRISTIANSEN_LATITUDE 44.461744;
#define CHRISTIANSEN_LONGITUDE -93.186443;

//Dittmann Center
#define DITTMANN_LATITUDE 44.46271;
#define DITTMANN_LONGITUDE -93.184758;

//Ellingson Hall
#define ELLINGSON_LATITUDE 44.463876;
#define ELLINGSON_LONGITUDE -93.181387;

//Felland House
#define FELLANDHOUSE_LATITUDE 44.460725;
#define FELLANDHOUSE_LONGITUDE -93.178557;

//Finholt House
#define FINHOLTHOUSE_LATITUDE 44.458152;
#define FINHOLTHOUSE_LONGITUDE -93.178278;

//Flaten House
#define FLATENHOUSE_LATITUDE 44.4572858742497;
#define FLATENHOUSE_LONGITUDE -93.1862656756443;

//Flaten Art Barn
#define FlATEN_LATITUDE 44.462601;
#define FLATEN_LONGITUDE -93.191169;

//Haldorsen House
#define HALDORSENHOUSE_LATITUDE 44.462035;
#define HALDORSENHOUSE_LONGITUDE -93.176524;

//Hilleboe Hall
#define HILLEBOE_LATITUDE 44.458413;
#define HILLEBOE_LONGITUDE -93.186572;

//Holland Hall
#define HOLLAND_LATITUDE 44.459919;
#define HOLLAND_LONGITUDE -93.181918;

//Holland House
#define HOLLANDHOUSE_LATITUDE 44.460233;
#define HOLLANDHOUSE_LONGITUDE -93.177876;

//Holstad House
#define HOLSTADHOUSE_LATITUDE 44.460231;
#define HOLSTADHOUSE_LONGITUDE -93.177219;

//Hoyme Hall
#define HOYME_LATITUDE 44.460427;
#define HOYME_LONGITUDE -93.186883;

//Huggenvik House
#define HUGGENVIKHOUSE_LATITUDE 44.460735;
#define HUGGENVIKHOUSE_LONGITUDE -93.178874;

//Johnson House
#define JOHNSONHOUSE_LATITUDE 44.460744;
#define JOHNSONHOUSE_LONGITUDE -93.177028;

//Kildahl Hall
#define KILDAHL_LATITUDE 44.463551;
#define KILDAHL_LONGITUDE -93.183702;

//Kittelsby Hall
#define KITT_LATITUDE 44.458903;
#define KITT_LONGITUDE -93.187076;

//Larson Hall
#define LARSON_LATITUDE 44.459825;
#define LARSON_LONGITUDE -93.184887;

//Larson House
#define LARSONHOUSE_LATITUDE 44.45985;
#define LARSONHOUSE_LONGITUDE -93.177865;

//Lee House
#define LEEHOUSE_LATITUDE 44.460708;
#define LEEHOUSE_LONGITUDE -93.178021;

//Mabel Shirley Field
#define MABEL_LATITUDE 44.465718;
#define MABEL_LONGITUDE -93.18743;

//Madson Facilities Building
#define MADSON_LATITUDE 44.461979;
#define MADSON_LONGITUDE -93.181191;

//Manitou Field
#define MANITOU_LATITUDE 44.461935;
#define MANITOU_LONGITUDE -93.179067;

//Mark Almli Baseball Field
#define MARK_LATITUDE 44.466146;
#define MARK_LONGITUDE -93.184603;

//Mellby Hall
#define MELLBY_LATITUDE 44.460549;
#define MELLBY_LONGITUDE -93.185236;

//Mohn Hall
#define MOHN_LATITUDE 44.463664;
#define MOHN_LONGITUDE -93.181934;

//Mohn House
#define MOHNHOUSE_LATITUDE 44.460765;
#define MOHNHOUSE_LONGITUDE -93.178326;

//Music Box
#define BOX_LATITUDE 44.462507;
#define BOX_LONGITUDE -93.185456;

//Old Main
#define OLD_LATITUDE 44.45931;
#define OLD_LONGITUDE -93.180236;

//Ole Store Restaurant
#define OLESTORE_LATITUTDE 44.460327;
#define OLESTORE_LONGITUDE -93.175317;

//President's House
#define PRESIDENTSHOUSE_LATITUDE 44.460088693648;
#define PRESIDENTSHOUSE_LONGITUDE -93.1788214245041;

//Pump House
#define PUMPHOUSE_LATITUDE 44.4606532695658;
#define PUMPHOUSE_LONGITUDE -93.1804848077248;

//Rand Hall
#define RAND_LATITUDE 44.464181;
#define RAND_LONGITUDE -93.183806;

//Rose House
#define ROSEHOUSE_LATITUDE 44.459739;
#define ROSEHOUSE_LONGITUDE -93.176832;

//Regents Hall
#define REGENTS_LATITUDE 44.459219;
#define REGENTS_LONGITUDE -93.182015;

//Regents Hall of Math
#define REGENTS_MATH_LATITUDE 44.459670316077315;
#define REGENTS_MATH_LONGITUDE -93.18299621343613;

//Rolf Mellby Soccer Field
#define ROLF_LATITUDE 44.465113;
#define ROLF_LONGITUDE -93.185491;

//Rolvaag Memorial Library
#define ROLVAAG_LATITUDE 44.461353;
#define ROLVAAG_LONGITUDE -93.182159;

//Schmidt House
#define SCHMIDTHOUSE_LATITUDE 44.460739;
#define SCHMIDTHOUSE_LONGITUDE -93.17779;

//Skifter Hall
#define SKIFTER_LATITUDE 44.461585;
#define SKIFTER_LONGITUDE -93.185778;

//Skoglund Athletic Center
#define SKOGLUND_LATITUDE 44.463292;
#define SKOGLUND_LONGITUDE -93.187848;

//Sovik House
#define SOVIKHOUSE_LATITUDE 44.458198;
#define SOVIKHOUSE_LONGITUDE -93.177608;

//Speech-Theater Building
#define THEATER_LATITUDE 44.461512;
#define THEATER_LONGITUDE -93.184917;

//Steensland Hall
#define STEENSLAND_LATITUDE 44.459638;
#define STEENSLAND_LONGITUDE -93.180644;

//St. John's House
#define STJOHNHOUSE_LATITUDE 44.460749;
#define STJOHNHOUSE_LONGITUDE -93.179476;

//Swanson House
#define SWANSONHOUSE_LATITUDE 44.45972;
#define SWANSONHOUSE_LONGITUDE -93.177549;

//Thompson House
#define THOMPSONHOUSE_LATITUDE 44.460725;
#define THOMPSONHOUSE_LONGITUDE -93.180038;

//Thorson Hall
#define THORSON_LATITUDE 44.463352;
#define THORSON_LONGITUDE -93.180325;

//Tom Porter Hall
#define TOMPORT_LATITUDE 44.461914;
#define TOMPORT_LONGITUDE -93.180499;

//Tomson Hall
#define TOMSON_LATITUDE 44.460178;
#define TOMSON_LONGITUDE -93.18375;

//Tostrud Center
#define TOSTRUD_LATITUDE 44.463836;
#define TOSTRUD_LONGITUDE -93.189176;

//Ytterboe Hall
#define YTTERBOE_LATITUDE 44.461703;
#define YTTERBOE_LONGITUDE -93.188436;

//Ytterboe House
#define YTTERBOEHOUSE_LATITUDE 44.46074;
#define YTTERBOEHOUSE_LONGITUDE -93.179201;


//////////////////////////////////////////////
///////////////////////////////////////////////
//Span
#define THE_SPAN 0.010f;

@implementation ThirdViewController
@synthesize myMapView;
@synthesize centerMap;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create the region
    MKCoordinateRegion myRegion;
    
    //Center
    CLLocationCoordinate2D center;
    center.latitude = DITTMANN_LATITUDE;
    center.longitude = -93.184158;
    
    //Span
    MKCoordinateSpan span;
    span.latitudeDelta = THE_SPAN;
    span.longitudeDelta = THE_SPAN;
    
    myRegion.center = center;
    myRegion.span = span;
    myMapView.mapType = MKMapTypeHybrid;
    
    //Set our mapView
    [myMapView setRegion:myRegion animated:YES];
	
    //Annotation
    NSMutableArray * locations = [[NSMutableArray alloc] init];
    CLLocationCoordinate2D location;
    Annotation * myAnn;
    
    
    //////////////////////////////////////////////////////////

    //Aaker House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = AAKERHOUSE_LATITUDE;
    location.longitude = AAKERHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Aaker House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Administration Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = ADMIN_LATITUDE;
    location.longitude = ADMIN_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Administration";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Boe Chapel Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = BOE_LATITUDE;
    location.longitude = BOE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Boe Chapel";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Boe House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = BOEHOUSE_LATITUDE;
    location.longitude = BOEHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Boe House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Buntrock Commons Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = BUNTROCK_LATITUDE;
    location.longitude = BUNTROCK_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Buntrock Commons";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Carlson Tennis Courts Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = CARLSON_LATITUDE;
    location.longitude = CARLSON_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Carlson Tennis Courts";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Christiansen Hall of Music Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = CHRISTIANSEN_LATITUDE;
    location.longitude = CHRISTIANSEN_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Christiansen Hall of Music";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Dittmann Center Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = DITTMANN_LATITUDE;
    location.longitude = DITTMANN_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Dittmann Center";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Ellingson Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = ELLINGSON_LATITUDE;
    location.longitude = ELLINGSON_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Ellingson Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Felland House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = FELLANDHOUSE_LATITUDE;
    location.longitude = FELLANDHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Felland House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Finholt House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = FINHOLTHOUSE_LATITUDE;
    location.longitude = FINHOLTHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Finholt House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Flaten Art Barn Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = FlATEN_LATITUDE;
    location.longitude = FLATEN_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Flaten Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Flaten House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = FLATENHOUSE_LATITUDE;
    location.longitude = FLATENHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Flaten House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Haldorsen House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HALDORSENHOUSE_LATITUDE;
    location.longitude = HALDORSENHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Haldorsen House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Hilleboe Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HILLEBOE_LATITUDE;
    location.longitude = HILLEBOE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Hilleboe Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Holland Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HOLLAND_LATITUDE;
    location.longitude = HOLLAND_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Holland Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Holland House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HOLLANDHOUSE_LATITUDE;
    location.longitude = HOLLANDHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Holland House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Holstad House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HOLSTADHOUSE_LATITUDE;
    location.longitude = HOLSTADHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Holstad House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Hoyme Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HOYME_LATITUDE;
    location.longitude = HOYME_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Hoyme Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Huggenvik House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = HUGGENVIKHOUSE_LATITUDE;
    location.longitude = HUGGENVIKHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Huggenvik House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Johnson House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = JOHNSONHOUSE_LATITUDE;
    location.longitude = JOHNSONHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Johnson House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Kildahl Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = KILDAHL_LATITUDE;
    location.longitude = KILDAHL_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Kildahl Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Kittelsby Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = KITT_LATITUDE;
    location.longitude = KITT_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Kittelsby Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Larson Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = LARSON_LATITUDE;
    location.longitude = LARSON_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Larson Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Larson House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = LARSONHOUSE_LATITUDE;
    location.longitude = LARSONHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Larson House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Lee House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = LEEHOUSE_LATITUDE;
    location.longitude = LEEHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Lee House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
 
    //Mabel Shirley Field
    myAnn = [[Annotation alloc] init];
    location.latitude = MABEL_LATITUDE;
    location.longitude = MABEL_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Mabel Shirley Field";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Madson Facilities Building Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = MADSON_LATITUDE;
    location.longitude = MADSON_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Madson Facilities Building";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Manitou Field Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = MANITOU_LATITUDE;
    location.longitude = MANITOU_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Manitou Field";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Mark Almli Baseball Field
    myAnn = [[Annotation alloc] init];
    location.latitude = MARK_LATITUDE;
    location.longitude = MARK_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Mark Almli Baseball Field";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Mellby Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = MELLBY_LATITUDE;
    location.longitude = MELLBY_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Mellby Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Mohn Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = MOHN_LATITUDE;
    location.longitude = MOHN_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Mohn Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Mohn House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = MOHNHOUSE_LATITUDE;
    location.longitude = MOHNHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Mohn House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];

    //Music Box Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = BOX_LATITUDE;
    location.longitude = BOX_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Music Box";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Ole Store Restaurant Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = OLESTORE_LATITUTDE;
    location.longitude = OLESTORE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Ole Store Restaurant";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Old Main Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = OLD_LATITUDE;
    location.longitude = OLD_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Old Main";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];

    //President's House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = PRESIDENTSHOUSE_LATITUDE;
    location.longitude = PRESIDENTSHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"President's House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Pump House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = PUMPHOUSE_LATITUDE;
    location.longitude = PUMPHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"The Pump House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Rand Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = RAND_LATITUDE;
    location.longitude = RAND_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Rand Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Rose House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = ROSEHOUSE_LATITUDE;
    location.longitude = ROSEHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Rose House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];

    //Regents Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = REGENTS_LATITUDE;
    location.longitude = REGENTS_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Regents Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Regents Math Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = REGENTS_MATH_LATITUDE;
    location.longitude = REGENTS_MATH_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Regents Math";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Rolf Mellby Soccer Field Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = ROLF_LATITUDE;
    location.longitude = ROLF_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Rolf Mellby Soccer Field";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Rolvaag Memorial Library Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = ROLVAAG_LATITUDE;
    location.longitude = ROLVAAG_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Rolvaag Memorial Library";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Schmidt House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = SCHMIDTHOUSE_LATITUDE;
    location.longitude = SCHMIDTHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Schmidt House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Sovik House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = SOVIKHOUSE_LATITUDE;
    location.longitude = SOVIKHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Sovik House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Speech-Theater Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = THEATER_LATITUDE;
    location.longitude = THEATER_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Speech-Theater Building";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];

    //Skifter Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = SKIFTER_LATITUDE;
    location.longitude = SKIFTER_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Skifter Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Skoglund Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = SKOGLUND_LATITUDE;
    location.longitude = SKOGLUND_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Skoglund Athletic Center";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Steensland Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = STEENSLAND_LATITUDE;
    location.longitude = STEENSLAND_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Steensland Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //St. John's House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = STJOHNHOUSE_LATITUDE;
    location.longitude = STJOHNHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"St. John's House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Swanson House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = SWANSONHOUSE_LATITUDE;
    location.longitude = SWANSONHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Swanson House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
 
    //Thompson House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = THOMPSONHOUSE_LATITUDE;
    location.longitude = THOMPSONHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Thompson House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Thorson Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = THORSON_LATITUDE;
    location.longitude = THORSON_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Thorson Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Tom Porter Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = TOMPORT_LATITUDE;
    location.longitude = TOMPORT_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Tom Porter Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Tomson Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = TOMSON_LATITUDE;
    location.longitude = TOMSON_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Tomson Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Tostrud Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = TOSTRUD_LATITUDE;
    location.longitude = TOSTRUD_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Tostrud Center";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Ytterboe Hall Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = YTTERBOE_LATITUDE;
    location.longitude = YTTERBOE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Ytterboe Hall";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];
    
    //Ytterboe House Annotation
    myAnn = [[Annotation alloc] init];
    location.latitude = YTTERBOEHOUSE_LATITUDE;
    location.longitude = YTTERBOEHOUSE_LONGITUDE;
    myAnn.coordinate = location;
    myAnn.title = @"Ytterboe House";
    myAnn.subtitle = @"";
    [locations addObject:myAnn];

    [self.myMapView addAnnotations:locations];
    
    
    // Set-up for the center map button
    [centerMap addTarget:self action:@selector(centerMap:) forControlEvents:UIControlEventTouchUpInside];

}

- (IBAction)centerMap:(UIButton *)sender
{
    //User Location Button
    
    //Center
    CLLocationCoordinate2D center;
    center.latitude = DITTMANN_LATITUDE;
    center.longitude = -93.184158;
    [myMapView setCenterCoordinate:center animated:YES];
    
    //Zoom
    //Create the region
    MKCoordinateRegion myRegion;
    MKCoordinateSpan span;
    span.latitudeDelta = THE_SPAN;
    span.longitudeDelta = THE_SPAN;
    
    myRegion.center = center;
    myRegion.span = span;
    [myMapView setRegion:myRegion animated:YES];

}


-(void) viewDidFinishLoading{

}

-(void) viewDidAppear:(BOOL)animated {
    __myLocationManager = [[CLLocationManager alloc] init];
    __myLocationManager.delegate = self;
    
    float ver = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (ver >= 8.0) {
        [__myLocationManager requestWhenInUseAuthorization]; // iOS 8 MUST
    }
    self.myMapView.showsUserLocation = YES;
    [__myLocationManager startUpdatingLocation];  //requesting location updates
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Stop using the user's location
    if (__myLocationManager)
    {
        self.myMapView.showsUserLocation = NO;
        [__myLocationManager stopUpdatingLocation];
    }
    
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)shouldAutorotate
{
    return NO;
}


-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
