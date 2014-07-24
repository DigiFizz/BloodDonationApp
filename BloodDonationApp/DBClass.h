//
//  DBClass.h
//  iamsafe
//
//  Created by Binary Semantics on 5/23/13.
//
//

#import <Foundation/Foundation.h>
@interface DBClass : NSObject
{
     NSString *databaseName;
     NSString *databasePath;
    NSMutableArray *dealerarray;
    NSMutableArray *newdealerarray;
    NSString *databasePathFromApp;
}
+(void)update:(NSString *)msgname greeting:(NSString *)greting;
+(void)update:(NSString *)Greetingname messageName:(NSString *)msgname;
+(void)update:(NSString *)msgname grtingname:(NSString *)greeting number:(NSString *)number;
-(void)checkAndCreateDatabase;
-(void)insertAccelData:(NSString *)str;
-(void)insert:(NSString *)str insert1:(NSString *)str1 insert2:(NSString *)str2 insert3:(NSString *)str3 insert4:(NSString *)str4;
-(void)post:(NSString *)str post1:(NSString *)str1 post2:(NSString *)str2 post3:(NSString *)str3;

+(NSMutableArray *)getdata;
+(void)deletegreeting:(NSString *)messagename;
-(void)copyDatabaseAtPath;
-(void)insertoffline:(NSDictionary *)str;
-(NSMutableArray *)getoffline;
//-(NSMutableArray *)getemergencycontact;
//-(NSMutableArray *)getemergencycontactnew;
//-(void)insertEmergencyDetail:(birthday *)str;
-(BOOL)checkcontact:(NSString *)str;
-(void)insertUserId:(NSString *)str;

//-(void)insertripDetail:(savetrip *)str;
-(NSString *)getUserId;
//-(void)insertTripId:(NSString *)str;
-(NSMutableArray *)getTriId;
-(void)insertTripId:(NSDictionary *)str anddistance:(NSString *)dis;
-(void)insertDealerData:(NSDictionary *)str anddistance:(NSString *)dis;
//-(void)insertDealerData:(NSDictionary *)str anddistance:(NSString *)dis;

//DeleteOffLineUsersFromDatabase
-(void)deleteSaveOfflineData :(NSString *)dealerId;

-(NSMutableArray *)getDealerData:(NSInteger)tag;

#pragma mark -  deletedata

-(void)deletedelaerdata;


#pragma mark - dealerhistory

+(void)InsertDealerHistory:(NSDictionary *)str ;
+(void)deletedelaerHistory;
+(void)deleteoffline :(NSString *)dId;
@end
