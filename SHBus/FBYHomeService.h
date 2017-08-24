//
//  FBYHomeService.h
//  agreePay
//
//  Created by 范保莹 on 2017/4/24.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBYHomeService : NSObject

- (void)searchMessage:(NSString *)pageNum andWithAction:(NSString *)action andWithDic:(NSDictionary *)Alldic andUrl:(NSString *)url andSuccess:(void(^)(NSDictionary *dic))success andFailure:(void(^)(int fail))failure;

@end
