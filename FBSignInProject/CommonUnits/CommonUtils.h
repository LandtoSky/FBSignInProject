//  CommonUtils.h
//  Created by BE

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject {
    
}

@property (nonatomic, strong) NSMutableDictionary *dicAlertContent;

+ (instancetype)shared;



- (BOOL)checkKeyInDic:(NSString *)key inDic:(NSMutableDictionary *)dic;


@end