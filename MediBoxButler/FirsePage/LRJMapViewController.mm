//
//  LRJMapViewController.m
//  MediBoxButler
//
//  Created by TonySheng on 16/4/9.
//  Copyright © 2016年 RenJiaLu. All rights reserved.
//

#import "LRJMapViewController.h"


#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import "JZLocationConverter.h"
#import "CCLocationManager.h"

@interface LRJMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,CLLocationManagerDelegate>
{
    
    BMKMapView         *_mapView;//地图对象
    BMKLocationService *_locationService;//定位
    BMKPoiSearch       *_poiSearch;//检索
    BMKGeoCodeSearch   *_citySearchOption;
    
    CLGeocoder *_geocoder;
    //
    bool isGeoSearch;
    BMKGeoCodeSearch* _geocodesearch;
    
    CLLocationManager *locationmanager;

    
}

@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKPointAnnotation *pointAnnotaiton;


@end

@implementation LRJMapViewController

@synthesize pointAnnotaiton = _pointAnnotaiton;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //_mapView.delegate = self;
    _geocodesearch.delegate = self;
    
    _citySearchOption.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [_mapView viewWillAppear];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
    
    [_mapView viewWillDisappear];
    _mapView.delegate=nil;
    _mapView=nil;
    _citySearchOption.delegate = nil; // 不用时，置nil
    
    _geocodesearch.delegate = nil;
    

    
}

- (void)dealloc {
    
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    [self.view addSubview:_mapView];
    
    //
    [self initLocationService];

    
    //
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    
    
    
    
    
    
    
//    [self initMapView];//初始化地图
//    [self initlocationService];
//    
//    [self SetBasicLocation];
    
    
    
    [self customNavigationLeftBarItems];

}

#pragma mark --private Method--根据关键字检索
-(void)SetBasicLocation{
    
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 40.20  ;
    coor.longitude = 116.23;
    annotation.coordinate = coor;
    annotation.title=@"昌平";
    
    
    //39.832670 116.460370°
    BMKPointAnnotation* annotationSecond = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D Secondcoor;
    Secondcoor.latitude = 39.832670 ;
    Secondcoor.longitude = 116.460370;
    annotationSecond.coordinate = Secondcoor;
    annotationSecond.title=@"朝阳";
    [_mapView addAnnotation:annotation];
    [_mapView addAnnotation:annotationSecond];
    [_mapView mapForceRefresh];
    
    
}




#pragma mark --private Method--初始化地图
- (void)initMapView
{
    
    BMKMapView  *mapView=[[ BMKMapView alloc] initWithFrame:self.view.frame];
    mapView.mapType=BMKMapTypeStandard;
    mapView.userTrackingMode=BMKUserTrackingModeFollow;
    mapView.zoomLevel=14;
    mapView.minZoomLevel=10;
    mapView.delegate=self;
    _mapView=mapView;
    [self.view addSubview:mapView];
}


#pragma mark --private Method--定位
- (void)initlocationService
{
    
    _locationService=[[BMKLocationService alloc] init];
    _locationService.desiredAccuracy=kCLLocationAccuracyBest;
    _locationService.delegate=self;
    _locationService.distanceFilter=1000;
    [_locationService startUserLocationService];
    
}





#pragma mark - 初始化地图，定位 -

- (void)initLocationService
{
    _mapView.zoomLevel=14;
    _mapView.minZoomLevel=10;
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    
    
    if (self.locationService == nil) {
        
        self.locationService = [[BMKLocationService alloc] init];
        
        [self.locationService setDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    //
    _mapView.mapType = BMKMapTypeStandard;
    
    //_mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层


    //
    
}


- (void)customNavigationLeftBarItems
{
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(18, 22, 35, 35)];
    
    UIImage *image = [[UIImage imageNamed:@"iconfont-jiantou"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    imgV.image = image;
    imgV.tintColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    //imgV.backgroundColor = [UIColor colorWithRed:138/255.0 green:207/255.0 blue:138/255.0 alpha:1.0];
    
    [self.view addSubview:imgV];
    
    imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick)];
    
    [imgV addGestureRecognizer:tap];
    
}


-(void)onClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark BMKLocationServiceDelegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    _mapView.showsUserLocation = YES;//显示定位图层
    //设置地图中心为用户经纬度
    [_mapView updateLocationData:userLocation];
    
    
    //    _mapView.centerCoordinate = userLocation.location.coordinate;
    BMKCoordinateRegion region ;//表示范围的结构体
    region.center = _mapView.centerCoordinate;//中心点
    region.span.latitudeDelta = 0.02;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
    region.span.longitudeDelta = 0.02;//纬度范围
    [_mapView setRegion:region animated:YES];
    
}


-(void)didFailToLocateUserWithError:(NSError *)error
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"出现错误" message:@"暂时无法为您定位" delegate:nil cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
    [alert show];
}

//
//
//#pragma mark BMKMapViewDelegate
//
//
////- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
////{
////    
////    
////    
////}
//
//
//- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
//{
////
//    self.pointAnnotaiton = view.annotation;
//    
//    _geocoder = [[CLGeocoder alloc]init];
//    
//    __block double latitud;
//    __block double longtitud;
//    
//    [[CCLocationManager shareLocation]getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
//        
//        latitud = locationCorrrdinate.latitude;
//        longtitud = locationCorrrdinate.longitude;
//        
//    } withAddress:^(NSString *addressString) {
//        
//        
//    }];
//    
//    
//    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitud longitude:longtitud];
//                              
//    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        
//        //CLPlacemark *placemark=[placemarks firstObject];
//        CLPlacemark *placemark=[placemarks firstObject];
//        
//        //NSLog(@"详细信息:name = %@",placemark.name);
//        
//        self.pointAnnotaiton.title = placemark.name;
//        self.pointAnnotaiton.subtitle = [NSString stringWithFormat:@"%@%@",placemark.locality,placemark.subLocality];
//        
//        //
//        //NSLog(@"%@",placemark.locality);
//    }];
//
//
//}



#pragma mark 设置大头针
//-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
//{
//    
//
//}


- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        
        titleStr = @"正向地理编码";
        showmeg = [NSString stringWithFormat:@"经度:%f,纬度:%f",item.coordinate.latitude,item.coordinate.longitude];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}










/**
 *  isGeoSearch = true;
 BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
 geocodeSearchOption.city= _cityText.text;
 geocodeSearchOption.address = _addrText.text;
 BOOL flag = [_geocodesearch geoCode:geocodeSearchOption];
 if(flag)
 {
 NSLog(@"geo检索发送成功");
 }
 else
 {
 NSLog(@"geo检索发送失败");//geo -> 城市 地址
 }

 */

/**
 *  isGeoSearch = false;
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
	if (_coordinateXText.text != nil && _coordinateYText.text != nil) {
 pt = (CLLocationCoordinate2D){[_coordinateYText.text floatValue], [_coordinateXText.text floatValue]};
	}
 BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
 reverseGeocodeSearchOption.reverseGeoPoint = pt;
 BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
 if(flag)
 {
 NSLog(@"反geo检索发送成功");
 }
 else
 {
 NSLog(@"反geo检索发送失败");  //反 geo -> 经度纬度
 }

 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
