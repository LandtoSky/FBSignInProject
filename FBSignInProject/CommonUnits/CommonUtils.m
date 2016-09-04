//
//  CommonUtils.m
//


#import "CommonUtils.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@implementation CommonUtils

+ (instancetype)shared {
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (BOOL)checkKeyInDic:(NSString *)key inDic:(NSMutableDictionary *)dic {
    BOOL success = NO;
    id obj = dic[key];
    if ( obj != nil ) {
        if ( obj != (id)[NSNull null] ) {
            success = YES;
        }
        else {
            NSLog(@"Warning! %@ section is empty.", key);
        }
    }
    //    else {
    //        NSLog(@"Warning! %@ section is not found.", key);
    //    }
    
    return success;
}
@end
