//
//  WebMethod.m
//  BloodDonationApp
//
//  Created by digifizz on 24/07/14.
//  Copyright (c) 2014 DIZIFIZZ. All rights reserved.
//

#import "WebMethod.h"
#import "AppDelegate.h"
#import "SBJson.h"
@implementation WebMethod
-(void)requestserver:(NSString *)webservice
{
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] init];
    
    [request1 setURL:[NSURL URLWithString:webservice]];
    
    [request1 setHTTPMethod:@"GET"];
    
    //[request1 setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request1 setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
    
    // [request1 setHTTPBody:postData];
    
    // NSLog(@">>>>%@",request1);
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request1 delegate:self];
    
    if(conn)
    {
    }
    else
    {
    }
    
    self.webdata = [[NSMutableData alloc]init];}

#pragma mark -

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    [self.webdata setLength:0];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.webdata appendData:data];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"error");
    
   
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//   NSDictionary *dic=[[NSDictionary alloc]init];
    
    
    
    NSString* oldStr = [[NSString alloc] initWithData:_webdata  encoding:NSUTF8StringEncoding];
    
    
    NSString *finalstr=[oldStr substringToIndex:[oldStr length]-30];
    SBJsonParser *json = [SBJsonParser new];
   _parsed=[json objectWithString:finalstr];
    NSMutableArray *New12=[[NSMutableArray alloc]init];
    New12=[_parsed objectForKey:@"state"];
    AppDelegate *delegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    delegate.statearray=New12;
    
    NSLog(@"%@",delegate.statearray);
//    NSString *keywords=[dic objectForKey:@"keyword"];
    
}






-(NSMutableArray *)GetCity:(NSInteger)str
{
    
//    BOOL responseCode=NO;
    
   
    NSMutableArray *recvCityArray=[[NSMutableArray alloc]init];
    
    NSString *post = [NSString stringWithFormat:@"region_code=%d",str];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://server.digifizz.in/blood_user/city.php"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //post it
    
    [request setHTTPBody:postData];
    
    
    
    //get response
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
//
//    //result not really needed unless desired
//    
   NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if (result==nil)
    {
        
    }
    else
    {
       
        NSLog(@"Response: %@", result);
        SBJsonParser *json = [SBJsonParser new];
        _parsed=[json objectWithString:result];
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
         dic=[json objectWithString:result];
        recvCityArray=[dic objectForKey:@"city"];
     
    }
    
    
    return recvCityArray;
    
}
+(NSMutableArray *)GetLocation:(NSInteger)cityCode
{
    
//    BOOL responseCode=NO;
    
    
    NSMutableArray *recvCityArray=[[NSMutableArray alloc]init];
    
    NSString *post = [NSString stringWithFormat:@"city_code=%d",cityCode];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://server.digifizz.in/blood_user/location.php"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //post it
    
    [request setHTTPBody:postData];
    
    
    
    //get response
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //
    //    //result not really needed unless desired
    //
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if (result==nil)
    {
        
    }
    else
    {
        
        NSDictionary *parseddic=[[NSDictionary alloc]init];
        NSLog(@"Response: %@", result);
        SBJsonParser *json = [SBJsonParser new];
        parseddic=[json objectWithString:result];
        
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//        dic=[json objectWithString:result];
        recvCityArray=[parseddic objectForKey:@"location"];
        
    }
    
    
    return recvCityArray;
    
}


+(void) Deviceid:(NSString *)str1 Name:(NSString *)str2 Email:(NSString *)str3 Mobile:(NSInteger)int1 Age:(NSInteger)int2 Gender:(NSString *)str4 Donartype:(NSString *)str5 BloodGroup:(NSString *)str6 DateRecentlyDonated:(NSString *)str7 TypeRecentlyDonated:(NSString *)Str8 State:(NSString *)str9 City:(NSString *)str10   area:(NSString *)str11 pincode:(NSInteger)int3 SMS:(NSInteger)int4 email:(NSInteger)int5 pmcMobile:(NSInteger)int6 pmcNotification:(NSInteger)int7
{
//    NSMutableArray *recvCityArray=[[NSMutableArray alloc]init];
    
    NSString *post = [NSString stringWithFormat:@"device_id=%@&name=%@&email=%@&mobile=%d&age=%d&sex=%@&donor_type=%@&blood_group=%@&recently_donated_date=%@&recently_donated_type=%@&state=%@&city=%@&area=%@&pincode=%d&pmc_sms=%d&pmc_email=%d&pmc_mobile=%d&pmc_notification=%d",str1,str2,str3,int1,int2,str4,str5,str6,str7,Str8,str9,str10,str11,int3,int4,int5,int6,int7];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://server.digifizz.in/blood_user/"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //post it
    
    [request setHTTPBody:postData];
    
    
    
    //get response
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    //
    //    //result not really needed unless desired
    //
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if (result==nil)
    {
        
    }
    else
    {
        
        NSLog(@"Response: %@", result);
        
        
        
//        SBJsonParser *json = [SBJsonParser new];
//        _parsed=[json objectWithString:result];
//        
//        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
//        dic=[json objectWithString:result];
//        recvCityArray=[dic objectForKey:@"city"];
        
    }
}





@end
