//
//  FBYHomeService.m
//  agreePay
//
//  Created by 范保莹 on 2017/4/24.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "FBYHomeService.h"

#import "AFNetworking.h"

@implementation FBYHomeService
- (void)searchMessage:(NSString *)pageNum andWithAction:(NSString *)action andWithDic:(NSDictionary *)Alldic andUrl:(NSString *)url andSuccess:(void (^)(NSDictionary *))success andFailure:(void (^)(int))failure{

//    NSString *urlstr= [NSString stringWithFormat:@"%@%@",AGREENewFuWuURL,url];

//    NSLog(@"%@----",Alldic);
    //1.创建ADHTTPSESSIONMANGER对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];

    //2.设置该对象返回类型
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"x-signature"];
    [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"x-timestamp"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager POST:url parameters:Alldic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject;
        
        success(dic);
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"----返回错误");
//                NSLog(@"网络请求返回错误信息%@",error);
        
    }];

}

@end
