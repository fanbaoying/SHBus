//
//  AGREEHomeService.m
//  agreePay
//
//  Created by 范保莹 on 2017/6/7.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "AGREEHomeService.h"

#import "AFNetworking.h"

@implementation AGREEHomeService
- (void)searchMessage:(NSString *)pageNum andWithAction:(NSString *)action andWithDic:(NSDictionary *)Alldic andUrl:(NSString *)urlStr andSuccess:(void (^)(NSDictionary *))success andFailure:(void (^)(int))failure{
    
//    NSString *urlstr= [NSString stringWithFormat:@"%@%@",AGREENewLJJFuWuURL,url];
    
        NSLog(@"%@----",urlStr);
    
//    NSString *string2 = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
//    NSLog(@"%@----",string2);
    
    //NSURL *urlString = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    //NSString *url = urlString.absoluteString;
    
    //1.创建ADHTTPSESSIONMANGER对象
//    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
//    //2.设置该对象返回类型
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    
//    [manager GET:string2 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = responseObject;
//        success(dic);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}
@end
