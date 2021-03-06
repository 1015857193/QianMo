//
//  ZYCacheHelper.m
//  ZYNetWorking
//
//  Created by allen on 2017/5/2.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "LYCacheHelper.h"
#import <YYKit/YYKit.h>

static NSString *const NetworkResponseCache = @"NetworkResponseCache";
static YYCache *_dataCache;
static YYKVStorage *_diskCache;

@implementation LYCacheHelper


/*
+ (void)initialize
{
    _dataCache = [YYCache cacheWithName:NetworkResponseCache];
    NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    _diskCache  = [[YYKVStorage alloc] initWithPath:downloadDir type: YYKVStorageTypeFile];
    
}
*/



+(instancetype)sharedInstance{
        
        static id sharedInstance =nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            sharedInstance =[[self alloc] init];
        });
        return sharedInstance;
        
        
        
}


- (instancetype )init{

    self =[super init];
    
    if (self) {
        
        _dataCache = [YYCache cacheWithName:NetworkResponseCache];
        NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        
        _diskCache  = [[YYKVStorage alloc] initWithPath:downloadDir type: YYKVStorageTypeFile];
    }
  


    return self;

}



- (void)saveResponseCache:(id)responseCache forKey:(NSString *)key
{
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:responseCache forKey:key withBlock:nil];
}

- (id)getResponseCacheForKey:(NSString *)key
{
    return [_dataCache objectForKey:key];
}

+(void)removeCacheForKey:(NSString *)key
{
    [_dataCache removeObjectForKey:key];
}
+(void)removAllCache
{
    [_dataCache removeAllObjects];
}

+(NSString *)saveFileWithKey:(NSString *)key file:(id)file fileName:(NSString *)fileName
{
    NSLog(@"%@",fileName);
    
    
    [_diskCache saveItemWithKey:key value:file filename:fileName extendedData:nil];
    
    return _diskCache.path;
    
}
+(id)getFileWithKey:(NSString *)key
{
    return  [_diskCache getItemForKey:key];
}
+(NSString *)getFilePath

{
    return _diskCache.path;
}

@end
