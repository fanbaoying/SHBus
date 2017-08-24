//
//  ViewController.m
//  SHBus
//
//  Created by 范保莹 on 2017/6/8.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "ViewController.h"

#import "agreeFirstNav.h"

#import "AFNetworking.h"

#import "BusListViewController.h"
#import "MapViewController.h"

#import "FirstTableViewCell.h"
#import "UILabel+LabelHeightAndWidth.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(strong,nonatomic)agreeFirstNav *nav;

@property(strong,nonatomic)UITableView *myTableView;

@property (strong,nonatomic) NSMutableArray *sourceArr;
@property (strong,nonatomic) NSMutableArray *stopidArr;
@property (strong,nonatomic) NSMutableArray *platenumberArr;
@property (strong,nonatomic) NSMutableArray *stopintervalArr;
@property (strong,nonatomic) NSMutableArray *distanceArr;
@property (strong,nonatomic) NSMutableArray *timeArr;

@property(strong,nonatomic)UILabel *startLab;
@property(strong,nonatomic)UILabel *stopLab;

@property(strong,nonatomic)NSString *startStr;
@property(strong,nonatomic)NSString *stopStr;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UITextField *textView;

@property(assign,nonatomic)BOOL transformBool;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    _textView = [[UITextField alloc]initWithFrame:CGRectMake(10, 74, SCREEN_WIDTH-100, 50)];
    _textView.backgroundColor = ALLBGColor;
    _textView.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textView];
    
    UIButton *myBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 74, 70, 50)];
    myBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:80/255.0 blue:10/255.0 alpha:1];
    [myBtn setTitle:@"搜索" forState:0];
    [myBtn addTarget:self action:@selector(myBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myBtn];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 124, SCREEN_WIDTH, SCREEN_HEIGHT-124)];
    
    self.myTableView.backgroundColor = [UIColor whiteColor];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    //    self.myTableView.showsVerticalScrollIndicator = NO;
    //    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.myTableView.scrollEnabled = NO;
    [self.view addSubview:_myTableView];
    
    self.nav = [[agreeFirstNav alloc]initWithLeftBtn:nil andWithTitleLab:@"上海公交" andWithRightBtn:@"地图" andWithBgImg:nil andWithLab1Btn:nil andWithLab2Btn:nil];
    
    [self.nav.rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_nav];
    
}

- (void)rightBtn:(UIButton *)sender{
    
    MapViewController *mvc = [[MapViewController alloc]init];
    
    mvc.nameStr = [NSString stringWithFormat:@"%@路",_textView.text];
    
    [self.navigationController pushViewController:mvc animated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
    
}

- (void)myBtn:(UIButton *)sender{
    [self netWorking:@"0"];
}

- (void)netWorking:(NSString *)direction{

    _sourceArr = [[NSMutableArray alloc]initWithCapacity:0];
    _stopidArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    _platenumberArr = [[NSMutableArray alloc]initWithCapacity:0];
    _stopintervalArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    _distanceArr = [[NSMutableArray alloc]initWithCapacity:0];
    _timeArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    int directionInt = [direction intValue];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://bus.ark930.wang:8600/bus/%@路/details?direction=%d",_textView.text ,directionInt];
    
    NSLog(@"%@",urlStr);
    
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
        NSLog(@"%ld", (long)responseStatusCode);
        
        if (responseStatusCode == 200) {
        
        NSArray *stopsArr = [dict objectForKey:@"stops"];
        
        for (int i = 0; i < stopsArr.count; i++) {
            NSString *stop_name = [stopsArr[i] objectForKey:@"stop_name"];
            NSString *stop_id = [stopsArr[i] objectForKey:@"stop_id"];
            NSString *plate_number = [stopsArr[i] objectForKey:@"plate_number"];
            NSString *distance = [NSString stringWithFormat:@"距离%@米",[stopsArr[i] objectForKey:@"distance"]];
            NSString *stop_interval = [NSString stringWithFormat:@"还有%@站",[stopsArr[i] objectForKey:@"stop_interval"]];
            NSString *time = [stopsArr[i] objectForKey:@"time"];
            int timeInt = [time intValue];
            int seconds = timeInt % 60;
            int minutes = (timeInt / 60) % 60;
            NSString *timeStr =  [NSString stringWithFormat:@"约%02d分%02d秒",minutes, seconds];
            
            [self.sourceArr addObject:stop_name];
            [self.stopidArr addObject:stop_id];
            
            [self.platenumberArr addObject:plate_number];
            [self.distanceArr addObject:distance];
            
            [self.stopintervalArr addObject:stop_interval];
            [self.timeArr addObject:timeStr];
        }
        
        self.startStr = [dict objectForKey:@"from"];
        self.stopStr = [dict objectForKey:@"to"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.myTableView reloadData];
        });
            
        }else{
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dict objectForKey:@"error_msg"] preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action1];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        
    }];
    
    // 5、开始任务
    
    [tast resume];
    
}

//开始滑动事件
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"%f",self.myTableView.contentOffset.y);
    
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _sourceArr.count;
    
}

//头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 85;
}

//cell 点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //        NSLog(@"我点击了图片");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self.view endEditing:YES];
    
    BusListViewController *blvc = [[BusListViewController alloc]init];
    
    blvc.nameStr = [NSString stringWithFormat:@"%@路",_textView.text];
    
    blvc.nameidStr = _stopidArr[indexPath.row];
    
    [self.navigationController pushViewController:blvc animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    if (cell == nil) {
        cell = [[FirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.titleLab.text = _stopidArr[indexPath.row];
    cell.contentLab.text = _sourceArr[indexPath.row];
    
    cell.detailLab.text = [NSString stringWithFormat:@"%@ %@, %@, %@",_platenumberArr[indexPath.row],_stopintervalArr[indexPath.row],_timeArr[indexPath.row],_distanceArr[indexPath.row]];
    
    return cell;
}

//添加头部内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 40)];
    header.backgroundColor = [UIColor colorWithRed:238/255.0 green:239/255.0 blue:242/255.0 alpha:1];
    
    NSLog(@"%@%@",_startStr,_stopStr);
    
    self.startLab = [[UILabel alloc]init];
    self.startLab.text = _startStr;
    CGFloat width = [UILabel getWidthWithTitle:self.startLab.text font:self.startLab.font];
    self.startLab.frame = CGRectMake(10, 5, width, 30);
    [header addSubview:_startLab];
    
    _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15 + width, 5, 30, 30)];
    if (width != 0) {
    _titleLab.text = @"到";
    }
    
    [header addSubview:_titleLab];
    
    self.stopLab = [[UILabel alloc]init];
    self.stopLab.text = _stopStr;
    CGFloat width1 = [UILabel getWidthWithTitle:self.stopLab.text font:self.stopLab.font];
    self.stopLab.frame = CGRectMake(40 + width, 5, width1, 30);
    [header addSubview:_stopLab];
    
    UIButton *transformBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 0, 40, 40)];
    [transformBtn addTarget:self action:@selector(transformBtn:) forControlEvents:UIControlEventTouchUpInside];
    [transformBtn setImage:[UIImage imageNamed:@"transform"] forState:0];
    [header addSubview:transformBtn];
   
    return header;
}

- (void)transformBtn:(UIButton *)sender{

    if (_transformBool == NO) {
        [self netWorking:@"1"];
        self.transformBool = YES;
    }else{
        [self netWorking:@"0"];
        self.transformBool = NO;
    }

}

@end
