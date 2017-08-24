//
//  AGREEHomeService.h
//  agreePay
//
//  Created by 范保莹 on 2017/6/7.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGREEHomeService : NSObject

- (void)searchMessage:(NSString *)pageNum andWithAction:(NSString *)action andWithDic:(NSDictionary *)Alldic andUrl:(NSString *)urlStr andSuccess:(void(^)(NSDictionary *dic))success andFailure:(void(^)(int fail))failure;


@end
