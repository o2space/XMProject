//
//  XMNetworkManager.m
//  XMProject
//
//  Created by wukexiu on 16/12/8.
//  Copyright © 2016年 wukexiu. All rights reserved.
//

#import "XMNetworkManager.h"
#import "NetResponse.h"
#import <CoreTelephony/CoreTelephonyDefines.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "XMEncryptTool.h"

@implementation XMNetworkManager

+ (XMNetworkManager *)defaultManager{
    static XMNetworkManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[XMNetworkManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //初始化数据
    }
    return self;
}

- (void)GETWithURL:(NSString *)strURL parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock
{
    [self ConnectWithURL:strURL ConnectType:XMNetworkConnectGET parameters:parameters success:successBlock failure:failureBlock];
}

- (void)POSTWithURL:(NSString *)strURL parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock
{
    [self ConnectWithURL:strURL ConnectType:XMNetworkConnectPOST parameters:parameters success:successBlock failure:failureBlock];
}

- (void)ConnectWithURL:(NSString *)strURL ConnectType:(XMNetworkConnectType)ConnectType parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock
{
    NSURL *nsurl = [NSURL URLWithString:[self packURL:strURL]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:nsurl];
    NSLog(@"url-----%@",[request.URL absoluteString]);
    //如果想要设置网络超时的时间的话，可以使用下面的方法：
    //NSMutableURLRequest *mutableRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    //将需要的信息放入请求头
    [request setValue:@"Bearer Token请替换" forHTTPHeaderField:@"Authorization"];//token
    [request setValue:@"" forHTTPHeaderField:@"Gis-Lng"];//坐标 lng
    [request setValue:@"" forHTTPHeaderField:@"Gis-Lat"];//坐标 lat
    [request setValue:@"" forHTTPHeaderField:@"Version"];//版本
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *parameterDic  = nil;
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        parameterDic = [XMNetworkManager getParametersWithDic:parameters url:strURL];
    }
    NSString *query = [self parseParams:parameterDic];
    //NSLog(@"query:%@",query);
    switch (ConnectType) {
        case XMNetworkConnectGET:
        {
            //设置请求类型
            request.HTTPMethod = @"GET";
            request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:request.URL.query ? @"&%@" : @"?%@", query]];
        }
            break;
        case XMNetworkConnectPOST:
        {
            if (![request valueForHTTPHeaderField:@"Content-Type"] ) {
                [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            }
            //设置请求类型
            request.HTTPMethod = @"POST";
            //把参数放到请求体内
            request.HTTPBody = [query dataUsingEncoding:NSUTF8StringEncoding];
            //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
        }
            break;
        default:
            break;
    }
    NSLog(@"post-header:%@",request.allHTTPHeaderFields);
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 输出返回的状态码，请求成功的话为200
            NSInteger responseCode = [self getResponseCode:response];
            NSLog(@">>>>>>POST/GET>>net work 状态码>>>>ResponseCode:%ld",(long)responseCode);
            
            if (error == nil && responseCode == 200) {//请求成功
                
                NSString* str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@">>>>>>POST/GET>>ResponseData:%@",str);
                
                //NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSError *e = nil;
                id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
                if (e == nil) {
                    NSDictionary *responseDict = (NSDictionary *)responseObject;
                    NetResponse *netResponse = [[NetResponse alloc] initWithDict:responseDict];
                    switch (netResponse.status) {
                        case kServerStateFail:
                        {
                            //清除用户信息
                        }
                        default:
                            break;
                    }
                    successBlock(netResponse);
                }else{
                    NSLog(@">>>>>>POST/GET>>net work failed>>>>error: %@", @"json格式解码错误，返回的数据非json格式");
                    //failureBlock(e);
                }
                
            } else {  //请求失败
                
                NSLog(@">>>>>>POST/GET>>net work failed>>>>responseObject: %@,error: %@", response, error);
                failureBlock(error);
                
            }
        });
    }];
    [dataTask resume];  //开始请求
}

/* 输出http响应的状态码 */
- (NSInteger)getResponseCode:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    return responseStatusCode;
}

- (NSString *)packURL:(NSString *) url
{
    // 测试环境变更
    NSString *baseURL = @"";//请修改api
    return [baseURL stringByAppendingString:url];
}

//附加参数
+ (NSDictionary *)getParametersWithDic:(NSDictionary *)params url:(NSString *)url
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    NSMutableString *tmpStr = [NSMutableString stringWithFormat:@"POST&/%@&",url];
    
    NSString* phoneModel = @"" ;//[YLBUtil getDeviceInfo];
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    //NSString *system = [NSString stringWithFormat:@"%@(%@)",phoneModel, phoneVersion];
    NSDate *date = [NSDate date];
    NSTimeInterval timeinterval = [date timeIntervalSince1970];
    NSString *timeStr = [NSString stringWithFormat:@"%.0lf",timeinterval];
    
    NSString *devicetoken = @"请替换DeviceToken";
    NSString *tokenStr = @"请替换token";
    NSString *authVersionStr = @"请替换版本号";
    
    CTCarrier *carrier;    // 获取运营商信息
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc] init];
    carrier = [netInfo subscriberCellularProvider];
    NSString *mcc = [carrier mobileCountryCode];
    NSString *mnc = [carrier mobileNetworkCode];
    NSString *subscriberInfo = [NSString stringWithFormat:@"{\"mnc\":%@,\"mcc\":%@} ",mnc,mcc];
    
    //[parameters setValue:system forKey:@"system"];
    [parameters setObject:tokenStr forKey:@"auth_key"];
    [parameters setObject:timeStr forKey:@"auth_timestamp"];
    [parameters setObject:authVersionStr forKey:@"auth_version"];
    [parameters setObject:@"ios" forKey:@"client"];
    [parameters setObject:devicetoken forKey:@"uuid"];
    [parameters setObject:subscriberInfo forKey:@"cellinfo"];
    
    NSArray * array = parameters.allKeys;
    NSArray * newArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    NSMutableString * Str1 = [[NSMutableString alloc] init];
    
    for (int i = 0 ; i < newArray.count; i++) {
        [Str1 appendString:[NSString stringWithFormat:@"&%@=%@", newArray[i], parameters[newArray[i]]]];
        
    }
    [Str1 deleteCharactersInRange:NSMakeRange(0, 1)];
    [tmpStr appendString:Str1];
    
    // 字典
    NSMutableDictionary *dic;
    if (params == nil) {
        dic = [NSMutableDictionary new];
    }else{
        dic = [params mutableCopy];
    }
    
    NSString * newSign =[[XMEncryptTool hmacSha256:tmpStr withKey:tokenStr] lowercaseString];
    
    [dic addEntriesFromDictionary:@{
                                    @"auth_key": tokenStr,
                                    @"auth_timestamp": timeStr,
                                    @"auth_version": authVersionStr,
                                    @"auth_signature": newSign,
                                    @"client" : @"ios",
                                    @"uuid" : devicetoken
                                    }];
    
    NSLog(@"加密前-------%@",dic);
    NSError *error = nil;
    NSString *jsonString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *encValues = [XMEncryptTool encryptWithText:jsonString];
    
    NSLog(@"加密后-------%@",@{@"i": encValues});

    return @{@"i":encValues};
}

//把NSDictionary解析NSString字符串
- (NSString *)parseParams:(NSDictionary *)params
{
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString new];
    NSMutableArray *array = [NSMutableArray new];
    //实例化一个key枚举器用来存放dictionary的key
    NSEnumerator *keyEnum = [params keyEnumerator];
    id key;
    while (key = [keyEnum nextObject]) {
        keyValueFormat = [NSString stringWithFormat:@"%@=%@&", key, [params valueForKey:key]];
        [result appendString:keyValueFormat];
        [array addObject:keyValueFormat];
    }
    if (result.length > 0) {
        NSString *last = [result substringFromIndex:result.length-1];
        if ([last isEqualToString:@"&"]) {
            [result deleteCharactersInRange:NSMakeRange([result length] -1, 1)];
        }
    }
    return result;
}


// 文件上传到OSS
-(void)fileUploadWithData: (NSData *)fileData parameters:(id)parameters fileName:(NSString *)fileName mimeType:(NSString *)mimeType success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock{
    
}

// 文件上传到自己服务器
// 以流的方式上传，大小理论上不受限制，但应注意时间
-(void)uploadFileWithUrl:(NSString *)strURL data:(NSData *)fileData success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock{
    // 1.创建url 服务器上传脚本
    NSString *urlString = [self packURL:strURL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    // 3.开始上传   request的body data将被忽略，而由fromData提供
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:fileData     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 输出返回的状态码，请求成功的话为200
        NSInteger responseCode = [self getResponseCode:response];
        NSLog(@">>>>>>POST/GET>>net work 状态码>>>>ResponseCode:%ld",(long)responseCode);
        if (error == nil && responseCode == 200)  {
            NSLog(@"upload success：%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSError *e = nil;
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
            if (e == nil) {
                NSDictionary *responseDict = (NSDictionary *)responseObject;
                NetResponse *netResponse = [[NetResponse alloc] initWithDict:responseDict];
                switch (netResponse.status) {
                    case kServerStateFail:
                    {
                    }
                    default:
                        break;
                }
                successBlock(netResponse);
            }else{
                NSLog(@">>>>>>POST/GET>>net work failed>>>>error: %@", @"json格式解码错误，返回的数据非json格式");
                //failureBlock(e);
            }
        } else {
            NSLog(@"upload error:%@",error);
        }
    }] resume];
}

// 拼接表单的方式进行上传
- (void)uploadFileDataWithUrl:(NSString *)strURL path:(NSString *)filePath name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock{
    
     NSURLResponse *response = [self getLocalFileResponse:filePath];
     // 文件类型：MIMEType  文件的大小：expectedContentLength  文件名字：suggestedFilename
     NSString *fileType = response.MIMEType;
     
     // 如果没有传入上传后文件名称,采用本地文件名!
    NSString *reName = name;
     if (reName == nil) {
         reName = response.suggestedFilename;
     }
    // 文件内容
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [self uploadFileDataWithUrl:strURL data:fileData name:reName fileName:fileName mimeType:mimeType parameters:parameters success:successBlock failure:failureBlock];
}

- (void)uploadFileDataWithUrl:(NSString *)strURL data:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType parameters:(id)parameters success:(XMSuccessBlock)successBlock failure:(XMFailureBlock)failureBlock{
    // 1.创建url  服务器上传脚本
    NSString *urlString = [self packURL:strURL];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    
    // 2.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 文件上传使用post
    request.HTTPMethod = @"POST";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",@"boundary"];
    NSString *tokenStr = @"请替换";
    NSString *appVersion = @"版本号";
    NSString *author = [NSString stringWithFormat:@"Bearer %@", tokenStr];
    
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
    [request setValue:author forHTTPHeaderField:@"Authorization"];
    [request setValue:appVersion forHTTPHeaderField:@"Version"];
    // 3.拼接表单，大小受MAX_FILE_SIZE限制(2MB)  FilePath:文件流  formName:表单控件名称，应于服务器一致
    NSData* data = [self getHttpBodyWithData:fileData formName:name reName:fileName mimeType:mimeType];//name = @"file"
    request.HTTPBody = data;
    // 根据需要是否提供，非必须,如果不提供，session会自动计算
    [request setValue:[NSString stringWithFormat:@"%lu",data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSDictionary *parameterDic  = nil;
    if ([parameters isKindOfClass:[NSDictionary class]]) {
        parameterDic = [XMNetworkManager getParametersWithDic:parameters url:strURL];
    }
    NSString *query = [self parseParams:parameterDic];
    NSData *fromData = [query dataUsingEncoding:NSUTF8StringEncoding];
   
#if 1
    // 4.1 使用dataTask
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@">>>>>>file/upload>>net work success>>>>responseObject:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NetResponse *netResponse = [[NetResponse alloc] initWithDict:responseDict];
            successBlock(netResponse);
        } else {
            NSLog(@">>>>>>file/upload>>net work failed>>>>error: %@",error);
            failureBlock(error);
        }
        
    }] resume];
#endif
#if 0
    // 4.2 开始上传 使用uploadTask   fromData:可有可无，会被忽略
    [[[NSURLSession sharedSession] uploadTaskWithRequest:request fromData:fromData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@">>>>>>file/upload>>net work success>>>>responseObject:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *responseDict = (NSDictionary *)responseObject;
            NetResponse *netResponse = [[NetResponse alloc] initWithDict:responseDict];
            successBlock(netResponse);
        } else {
            NSLog(@">>>>>>file/upload>>net work failed>>>>error: %@",error);
            failureBlock(error);
        }
    }] resume];
#endif
}

/// fileData:要上传的数据流  formName：表单控件名称  reName：上传后文件名
- (NSData *)getHttpBodyWithData:(NSData *)fileData formName:(NSString *)formName reName:(NSString *)reName mimeType:mimeType
{
    NSMutableData *data = [NSMutableData data];
    
    // 表单拼接
    NSMutableString *headerStrM =[NSMutableString string];
    [headerStrM appendFormat:@"--%@\r\n",@"boundary"];
    // name：表单控件名称  filename：上传文件名
    [headerStrM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",formName,reName];
    [headerStrM appendFormat:@"Content-Type: %@\r\n\r\n",mimeType];
    [data appendData:[headerStrM dataUsingEncoding:NSUTF8StringEncoding]];
    
    [data appendData:fileData];
    
    NSMutableString *footerStrM = [NSMutableString stringWithFormat:@"\r\n--%@--\r\n",@"boundary"];
    [data appendData:[footerStrM  dataUsingEncoding:NSUTF8StringEncoding]];
    return data;
}
/// 获取响应，主要是文件类型和文件名
- (NSURLResponse *)getLocalFileResponse:(NSString *)urlString
{
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    // 本地文件请求
    NSURL *url = [NSURL fileURLWithPath:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    __block NSURLResponse *localResponse = nil;
    // 使用信号量实现NSURLSession同步请求
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        localResponse = response;
        dispatch_semaphore_signal(semaphore);
    }] resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return  localResponse;
}

@end
