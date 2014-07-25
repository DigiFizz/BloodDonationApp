//
//  WebMethod.h
//  BloodDonationApp
//
//  Created by digifizz on 24/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebMethod : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    BOOL areaBool;
    BOOL cityBool;
    BOOL locationBool;
}
@property (nonatomic,strong)NSURLConnection *connection;
@property (nonatomic,strong)NSMutableData *webdata;
@property (nonatomic,strong)NSMutableArray *responceArray;
@property(nonatomic,retain)NSDictionary *parsed;
-(void)requestserver:(NSString *)webservice;

-(NSMutableArray *)GetCity:(NSInteger)str;
+(NSMutableArray *)GetLocation:(NSInteger)cityCode;
+(void) Deviceid:(NSString *)str1 Name:(NSString *)str2 Email:(NSString *)str3 Mobile:(NSInteger)int1 Age:(NSInteger)int2 Gender:(NSString *)str4 Donartype:(NSString *)str5 BloodGroup:(NSString *)str6 DateRecentlyDonated:(NSString *)str7 TypeRecentlyDonated:(NSString *)Str8 State:(NSString *)str9 City:(NSString *)str10   area:(NSString *)str11 pincode:(NSInteger)int3 SMS:(NSInteger)int4 email:(NSInteger)int5 pmcMobile:(NSInteger)int6 pmcNotification:(NSInteger)int7;


@end
