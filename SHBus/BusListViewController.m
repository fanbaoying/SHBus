//
//  BusListViewController.m
//  SHBus
//
//  Created by 范保莹 on 2017/6/8.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "BusListViewController.h"
#import "agreeFirstNav.h"

#import "AGREEHomeService.h"
#import "AFNetworking.h"

#import "MapViewController.h"

@interface BusListViewController ()

@property(strong,nonatomic)agreeFirstNav *nav;
@property(strong,nonatomic)NSString *status;


@end

@implementation BusListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  =[UIColor whiteColor];
    
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:@"back" andWithTitleLab:_nameStr andWithRightBtn:nil andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)leftBtn:(UIButton *)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

//- (void)rightBtn:(UIButton *)sender{
//
//    MapViewController *mvc = [[MapViewController alloc]init];
//    
//    [self.navigationController pushViewController:mvc animated:YES];
//    
//}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.view  = nil;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://bus.ark930.wang:8600/bus/%@/stop/%@",_nameStr,_nameidStr];
    
    NSLog(@"%@",urlStr);
    
    // 1、 创建URL
    NSString *encodePath = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSURL *url = [NSURL URLWithString:encodePath];
    NSLog(@"url:%@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    // 3、 创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    // 4、 创建任务
    NSURLSessionDataTask *tast = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        NSInteger responseStatusCode = [httpResponse statusCode];
        NSLog(@"%d", responseStatusCode);
        
        if (responseStatusCode == 200) {
        
        NSString *router_name = [NSString stringWithFormat:@"线路名称：%@",[dict objectForKey:@"router_name"]];
        NSString *plate_number = [NSString stringWithFormat:@"车牌号：%@",[dict objectForKey:@"plate_number"]];
        NSString *distance = [NSString stringWithFormat:@"剩余距离：%@米",[dict objectForKey:@"distance"]];
        NSString *stop_interval = [NSString stringWithFormat:@"剩余站数：%@站",[dict objectForKey:@"stop_interval"]];
        
        NSString *statusStr = [dict objectForKey:@"status"];
        
        if ([statusStr isEqualToString:[NSString stringWithFormat:@"running"]]) {
            self.status = [NSString stringWithFormat:@"车辆状态：运行中"];
        }else if ([statusStr isEqualToString:[NSString stringWithFormat:@"waiting"]]) {
            self.status = [NSString stringWithFormat:@"车辆状态：等待发车"];
        }
        
        NSString *time = [dict objectForKey:@"time"];
        int timeInt = [time intValue];
        int seconds = timeInt % 60;
        int minutes = (timeInt / 60) % 60;
        int hours = timeInt / 3600;
        
        NSString *timeStr =  [NSString stringWithFormat:@"剩余时间：%02d:%02d:%02d",hours, minutes, seconds];
        
        NSArray *dataArr = @[router_name,plate_number,distance,stop_interval,_status,timeStr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dataView:dataArr];
        });
            
        }else{}
        
    }];
    
    // 5、开始任务
    
    [tast resume];
}

- (void)dataView:(NSArray *)dataArr{

    for(int i = 0; i < dataArr.count; i++){
    
        int count = 45 * i;
        
        UILabel *contentLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 74 + count, SCREEN_WIDTH-20, 45)];
        contentLab.text = dataArr[i];
        [self.view addSubview:contentLab];
        
    }
    
}


@end
