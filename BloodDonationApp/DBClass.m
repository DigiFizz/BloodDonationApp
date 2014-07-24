//
//  DBClass.m
//  iamsafe
//
//  Created by Binary Semantics on 5/23/13.
//
//

#import "DBClass.h"
#import "sqlite3.h"
//#import "birthday.h"
//#import "savetrip.h"
#import "DF_AppDelegate.h"

@implementation DBClass

#define DATABASEPATH  @"DATABASEPATH"


-(void)checkAndCreateDatabase{
    
    //databaseName=@"db.sqlite";
    
    
   
   databaseName=@"GoVoix.sqlite";
    NSArray *documentPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir=[documentPaths objectAtIndex:0];
	databasePath=[documentsDir stringByAppendingPathComponent:databaseName];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:databasePath forKey:DATABASEPATH];
    [defaults synchronize];
    [self copyDatabaseAtPath];
    
    //  return databasePath;
    
}


//-(void)checkAndCreateDatabase
//{
//    
//	BOOL success;
//	NSFileManager *fileManager=[NSFileManager defaultManager];
//	success=[fileManager fileExistsAtPath:databasePath];
//	if(success)
//		return;
//	NSString *databasePathFromApp=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:databaseName];
//	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
//    [self copyDatabaseAtPath];
//    
//}

-(void)copyDatabaseAtPath{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    BOOL success;
    databaseName=@"GoVoix.sqlite";
	NSFileManager *fileManager=[NSFileManager defaultManager];
	success =[fileManager fileExistsAtPath:dbPath];
	if (!success)
		
	{
        databasePathFromApp=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:databaseName];
        [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
       
    }
    
       
    
}
-(void)insert:(NSString *)str insert1:(NSString *)str1 insert2:(NSString *)str2 insert3:(NSString *)str3 insert4:(NSString *)str4
{
    
    sqlite3 *database;
    databaseName = @"GoVoix.sqlite";
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
    databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    NSError *error1;
    //  NSString *dbPath = [self getDBPath];
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    if(!success)
    {
        
        success = [fileManager copyItemAtPath:defaultDBPath toPath:databasePath error:&error1];
        
        if (!success)
            
            
            
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error1 localizedDescription]);
    }
    else
    {
        //        //NSlog(@"Database must have existed at the following path: %@", databasePath);
    }
    //    //NSlog(@"Done checking for db file");
    
    
    
    
    //fr  ~/Library/Application Support/iPhone Simulator/
	
	
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access2,k
        // NSString *stmnt=@"jkdtekr";
	    NSString *stmnt=[[NSString alloc]initWithFormat:@"insert into selectgreeting values(\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",str,str1,str2,str3,str4];
		const char *sqlStatement=[stmnt UTF8String];
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
			if (SQLITE_DONE!=sqlite3_step(compiledStatement))
            {
//                UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"INFO"
//                                                           message:@"Duplicate Entry Or Contact No. Not inserted"
//                                                          delegate:self
//                                                 cancelButtonTitle:@"OK"
//                                                 otherButtonTitles:nil];
//                [al show];
            }
			else
            {
//                UIAlertView *al=[[UIAlertView alloc] initWithTitle:@"INFO"
//                                                           message:@"Record added Successfully"
//                                                          delegate:self
//                                                 cancelButtonTitle:@"OK"
//                                                 otherButtonTitles:nil];
//                 [al show];
//                
                
                
            }
            //
		}
		
		sqlite3_reset(compiledStatement);
		
    }
   
    sqlite3_close(database);
}


-(void)post:(NSString *)str post1:(NSString *)str1 post2:(NSString *)str2 post3:(NSString *)str3
{
    
    BOOL responseCode=NO;
    
    NSString *post = [NSString stringWithFormat:@"tag=%@&name=%@&phone=%@&imei=%@",str, str1, str2, str3];
    
    //NSLog(post);
    
    
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:@"http://server.digifizz.in/govoix/greeting/"]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    
    
    //post it
    
    [request setHTTPBody:postData];
    
    
    
    //get response
    
    NSHTTPURLResponse* urlResponse = nil;
    
    NSError *error = [[NSError alloc] init];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    
    //result not really needed unless desired
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    //    NSLog(@"Response Code: %d", [urlResponse statusCode]);
    
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300)
        
    {
        
        NSLog(@"Response: %@", result);
        
        //here you get the response
        
        responseCode = YES;
        
    }

    
}

+(NSMutableArray *)getdata
{
  
    sqlite3 *database;
  NSString  *databaseName = @"GoVoix.sqlite";
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
 NSString 	*databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    NSMutableArray *selectarray=[[NSMutableArray alloc]init];
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        
        //SQLIte Statement
        //        NSString *sqlStatement_userInfo =[NSString stringWithFormat:@"Select * from selectgreeting where msgname ='%@'",gretingmessage];
        NSString *sqlStatement_userInfo =[NSString stringWithFormat:@"Select * from selectgreeting"];
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, [sqlStatement_userInfo UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                
                NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
                
                NSString *userid = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                userid = [userid stringByReplacingOccurrencesOfString: @"(" withString:@""];
                userid = [userid stringByReplacingOccurrencesOfString: @")" withString:@""];
                userid = [userid stringByReplacingOccurrencesOfString: @"-" withString:@""];
                userid = [userid stringByReplacingOccurrencesOfString: @" " withString:@""];
                //                NSLog(@"userid is = %@",userid);
                [dic setObject:userid forKey:@"gNumber"];
                 NSString *gName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                [dic setObject:gName forKey:@"gName"];
                [selectarray addObject:dic];
                
                
            }
            
            
            
        }
        else
        {
            //            NSLog(@"No Data Found");
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    
    sqlite3_close(database);
    return selectarray;
}


+(void)deletegreeting:(NSString *)messagename
{
    
        sqlite3 *database;
    NSString    *databaseName = @"GoVoix.sqlite";
        
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
     NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        
        
        // Open the database from the users filessytem
        if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
        {
            // Setup the SQL Statement and compile it for faster access
            sqlite3_stmt *statement;
           
         
                NSString *sqlstatement;
                //            if([title1 isEqualToString:tit])
                //            {
                sqlstatement = [NSString stringWithFormat:@"delete  from CustomGreeting where title='%@'",messagename];
                if (sqlite3_prepare(database, [sqlstatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
                {
                    NSLog(@"profile deleted ");
                    while(sqlite3_step(statement) == SQLITE_ROW)
                    {
                        // Init the Data Dictionary
                        
                        //                        NSLog(@"all data are deleted");
                    }
                    
                  
                    //  return YES;
                }
                else
                {
                    //                 NSLog(@"deleted to the title");
                }
            
            sqlite3_finalize(statement);
        }
        else
        {
            //        NSLog(@"No Data Found");
        }
        //    [self getdata];
        sqlite3_close(database);
}



+(void)update:(NSString *)msgname grtingname:(NSString *)greeting number:(NSString *)number
{
    sqlite3 *database;
    NSString    *databaseName = @"GoVoix.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        sqlite3_stmt *statement;
        
        
        NSString *sqlstatement;
        //            if([title1 isEqualToString:tit])
        //            {
        sqlstatement = [NSString stringWithFormat:@"UPDATE selectgreeting SET msgname ='%@',greetingname='%@' WHERE  phonenumber='%@'",msgname,greeting,number];
        if (sqlite3_prepare(database, [sqlstatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"profile updated");
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                // Init the Data Dictionary
                
                //                        NSLog(@"all data are deleted");
            }
            
            
            //  return YES;
        }
        else
        {
            //                 NSLog(@"deleted to the title");
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        //        NSLog(@"No Data Found");
    }
    //    [self getdata];
    sqlite3_close(database);
}
+(void)update:(NSString *)msgname greeting:(NSString *)greting
{
    sqlite3 *database;
    NSString    *databaseName = @"GoVoix.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        sqlite3_stmt *statement;
        
        
        NSString *sqlstatement;
        //            if([title1 isEqualToString:tit])
        //            {
        sqlstatement = [NSString stringWithFormat:@"UPDATE selectgreeting SET msgname ='%@' WHERE  greetingname='%@'",msgname,greting];
        if (sqlite3_prepare(database, [sqlstatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"profile updated");
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                // Init the Data Dictionary
                
                //                        NSLog(@"all data are deleted");
            }
            
            
            //  return YES;
        }
        else
        {
            //                 NSLog(@"deleted to the title");
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        //        NSLog(@"No Data Found");
    }
    //    [self getdata];
    sqlite3_close(database);
}

+(void)update:(NSString *)Greetingname messageName:(NSString *)msgname
{
    sqlite3 *database;
    NSString    *databaseName = @"GoVoix.sqlite";
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    
    
    // Open the database from the users filessytem
    if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        // Setup the SQL Statement and compile it for faster access
        sqlite3_stmt *statement;
        
        
        NSString *sqlstatement;
        //            if([title1 isEqualToString:tit])
        //            {
        sqlstatement = [NSString stringWithFormat:@"UPDATE selectgreeting SET greetingname ='%@' WHERE msgname='%@'",Greetingname,msgname];
        if (sqlite3_prepare(database, [sqlstatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            NSLog(@"profile updated");
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                // Init the Data Dictionary
                
                //                        NSLog(@"all data are deleted");
            }
            
            
            //  return YES;
        }
        else
        {
            //                 NSLog(@"deleted to the title");
        }
        
        sqlite3_finalize(statement);
    }
    else
    {
        //        NSLog(@"No Data Found");
    }
    //    [self getdata];
    sqlite3_close(database);
}


-(NSString *)getUserId
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
   
    sqlite3 *database;
	
	  NSString *name,*compname,*compadd,*comphone,*compemail;
    
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from My_Table";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
              
                
                
                name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                compname=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                compadd=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                comphone=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                compemail=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                
                                
                
                
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    return name;
    
    
}

-(NSMutableArray *)getTriId
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    dealerarray =[[NSMutableArray alloc]init];
    newdealerarray =[[NSMutableArray alloc]init];
    NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
    sqlite3 *database;
	
//   DF_AppDelegate *appdelegate = (DF_AppDelegate *) [[UIApplication sharedApplication] delegate];
    
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT * FROM tripid_tbl   ORDER BY dealerdistance";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
           NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
                
             
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:@"dealer_id"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:@"dealer_name"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:@"dealer_address"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:@"latitude"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:@"longitude"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)]forKey:@"dealer_image"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]forKey:@"landline_no"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:@"workshop_number"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:@"emergency_landline"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:@"website_link"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:@"mobile_no"];
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:@"distance"];
                
                ///*************
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:@"city_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)] forKey:@"customer_care_executive"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] forKey:@"dealer_code"];
                 [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)] forKey:@"dealer_id"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)] forKey:@"dealer_type_code"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 17)] forKey:@"location_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 18)]forKey:@"overall_ratings"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 19)]forKey:@"pin"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 20)] forKey:@"prefered_dealer"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 21)] forKey:@"present_user_rating"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 22)] forKey:@"service_manager_email"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 23)] forKey:@"service_manager_no"];
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 24)] forKey:@"state_name"];
                             [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 25)] forKey:@"isactive"];
                               
                               
                
                
                
                
                
                
              //  [DF_AppDelegate.skipdealerarray  addObject:dealerdic];
                
                [dealerarray addObject:dealerdic];
     
                
            }
                
               [newdealerarray addObject:dealerdic];
            
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
             
    
    

    return dealerarray;
    
    
}


#pragma mark -     ---delete user data

-(void)deletedelaerdata
{
    
   
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
       
        
        const char *sqlStatement ="DELETE  FROM My_Table where Id=1 ";
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}



#pragma mark -    ----get dealer data


-(NSMutableArray *)getDealerData:(NSInteger)tag
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    dealerarray =[[NSMutableArray alloc]init];
    newdealerarray =[[NSMutableArray alloc]init];
    NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
    sqlite3 *database;
	
//  DF_AppDelegate *appdelegate = (DF_AppDelegate *) [[UIApplication sharedApplication] delegate];
    
	
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        const char *sqlStatement = NULL ;
//        switch (tag) {
//            case 0:
//    	 sqlStatement = "SELECT * FROM Dealer_Detail   ORDER BY distance";            
//                break;
//                case 1:
//         sqlStatement = "SELECT * FROM Dealer_Detail   where distance <11  ORDER BY distance  ";                   
//                break;
//                case 2:
//                sqlStatement = "SELECT * FROM Dealer_Detail   where distance <21  ORDER BY distance   ";
//                break;
//            default:
//                break;
//        }
        
        
        
        switch (tag) {
            case 0:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT  *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False'    ORDER BY Dummy desc,distance" ;
                break;
            case 1:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False' and distance <11    ORDER BY Dummy desc,distance  ";
                break;
            case 2:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False' and distance <21    ORDER BY Dummy desc,distance  ";
                break;
            case 3:
                sqlStatement = "SELECT *, 1 as Dummy FROM Dealer_Detail   where   prefered_dealer ='True' Union SELECT *,0 as Dummy FROM Dealer_Detail   where  prefered_dealer ='False' and distance <21    ORDER BY Dummy desc,overall_ratings ";
                break;
            default:
                break;
        }
        
        
        
	
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
                
               
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:@"city_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:@"customer_care_executive"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:@"dealer_address"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:@"dealer_code"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:@"dealer_id"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)]forKey:@"dealer_image"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]forKey:@"dealer_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:@"dealer_type_code"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:@"distance"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:@"emergency_landline"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:@"isactive"];
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:@"landline_no"];
                
                ///*************
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:@"latitude"];
                                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 13)] forKey:@"location_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] forKey:@"longitude"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)] forKey:@"mobile_no"];
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 16)] forKey:@"overall_ratings"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 17)] forKey:@"pin"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 18)] forKey:@"prefered_dealer"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 19)]forKey:@"present_user_rating"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 20)]forKey:@"service_manager_email"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 21)] forKey:@"service_manager_no"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 22)] forKey:@"state_name"];
                
            
                
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 23)] forKey:@"website_link"];
                [dealerdic  setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 24)] forKey:@"workshop_number"];
                
                
                
                
                
                
                
                
                
              //  [DF_AppDelegate.skipdealerarray  addObject:dealerdic];
                
                [dealerarray addObject:dealerdic];
                
                
            }
            
            [newdealerarray addObject:dealerdic];
            
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
    
    
    
    return dealerarray;
    
    
}

-(NSMutableArray *)getoffline
{
	NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    dealerarray =[[NSMutableArray alloc]init];
    newdealerarray =[[NSMutableArray alloc]init];
  //  NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
    sqlite3 *database;
	
   // DF_AppDelegate *DF_AppDelegate = (DF_AppDelegate *) [[UIApplication sharedApplication] delegate];
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from SaveOffline";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW)
            {
                NSMutableDictionary *dealerdic =[[NSMutableDictionary alloc]init] ;
                
               
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] forKey:@"DealerId"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)] forKey:@"dealer_name"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] forKey:@"dealer_address"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] forKey:@"latitude"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] forKey:@"longitude"];
                
               
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)]forKey:@"landline_no"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)] forKey:@"workshop_number"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 8)] forKey:@"emergency_landline"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 9)] forKey:@"website_link"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 10)] forKey:@"mobile_no"];
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 11)] forKey:@"location_name"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 12)] forKey:@"prefered_dealer"];
                 [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 14)] forKey:@"city_name"];
                
                // [dealerdic setValue:@"http://121.242.235.227:8090/HyundaiServices/getImage?id=hyundai_icon&=Dealer"  forKey:@"dealer_image"];
                
                [dealerdic setValue:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 15)] forKey:@"dealer_image"];

                 
             
                
                [dealerarray addObject:dealerdic];
             
                
            }
            
          
            
            
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    

   
    
    
    
    return dealerarray;
    
    
}



-(void)insertUserId:(NSString *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"Insert into My_Table values ('%d','%@','%@','%@','%@','%d')",1,@"binary",@"binary",@"binary",@"binary",35];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

-(void)insertAccelData:(NSString *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"Insert into Accelerometer_Table values ('%d','%@','%@','%@')",2,str,str,@"34"];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

-(void)insertTripId:(NSDictionary *)str anddistance:(NSString *)dis
{
    
   
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
      
        
        NSInteger  myint=[dis integerValue];


        query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
               [str valueForKey:@"dealer_id"] ,
               [str valueForKey:@"dealer_name"],
               [str valueForKey:@"dealer_address"],
               [str valueForKey:@"latitude"],
               [str valueForKey:@"longitude"],
               [str valueForKey:@"dealer_image"],
               [str valueForKey:@"landline_no"],
               [str valueForKey:@"workshop_number"],
               [str valueForKey:@"emergency_landline"],
               [str valueForKey:@"website_link"],
               [str valueForKey:@"mobile_no"],
               myint,
               [str valueForKey:@"city_name"],
                              [str valueForKey:@"customer_care_executive"],
                              [str valueForKey:@"dealer_code"],
                                             [str valueForKey:@"dealer_id"],
                                             [str valueForKey:@"dealer_type_code"],
                                             [str valueForKey:@"location_name"],
                                             [str valueForKey:@"overall_ratings"],
                                             [str valueForKey:@"pin"],
                                             [str valueForKey:@"prefered_dealer"],
                                             [str valueForKey:@"present_user_rating"],
                                             [str valueForKey:@"service_manager_email"],
                                             [str valueForKey:@"service_manager_no"],
                [str valueForKey:@"state_name"],
                [str valueForKey:@"isactive"]
               
               
               
               ];
               
        
               
        

         
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}


-(void)insertDealerData:(NSDictionary *)str anddistance:(NSString *)dis
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
       
        
        
        
        NSRange lastComma = [dis rangeOfString:@"," options:NSBackwardsSearch];
        
        if(lastComma.location != NSNotFound)
        {
            
             query=[NSString stringWithFormat:@"Insert into Dealer_Detail values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
                    
                    [str valueForKey:@"city_name"],
                    [str valueForKey:@"customer_care_executive"],
                    [str valueForKey:@"dealer_address"],
                    [str valueForKey:@"dealer_code"],
                    
                    [str valueForKey:@"dealer_id"] ,
                    
                    [str valueForKey:@"dealer_image"],
                    
                    [str valueForKey:@"dealer_name"],
                    [str valueForKey:@"dealer_type_code"],
                    
                    dis,
                    [str valueForKey:@"emergency_landline"],
                    [str valueForKey:@"isactive"],
                    [str valueForKey:@"landline_no"],
                    
                    [str valueForKey:@"latitude"],   [str valueForKey:@"location_name"],
                    [str valueForKey:@"longitude"],
                    [str valueForKey:@"mobile_no"],
                    [str valueForKey:@"overall_ratings"],
                    
                    [str valueForKey:@"pin"],
                    [str valueForKey:@"prefered_dealer"],
                    [str valueForKey:@"present_user_rating"],
                    
                    [str valueForKey:@"service_manager_email"],
                    [str valueForKey:@"service_manager_no"],
                    [str valueForKey:@"state_name"],
                    [str valueForKey:@"website_link"],
                    [str valueForKey:@"workshop_number"] ];
        }
        else
                    {
        query=[NSString stringWithFormat:@"Insert into Dealer_Detail values ('%@','%@','%@','%@','%@','%@','%@','%@','%.3f','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",
               
               [str valueForKey:@"city_name"],
               [str valueForKey:@"customer_care_executive"],
               [str valueForKey:@"dealer_address"],
               [str valueForKey:@"dealer_code"],
               
               [str valueForKey:@"dealer_id"] ,
               
               [str valueForKey:@"dealer_image"],
               
               [str valueForKey:@"dealer_name"],
               [str valueForKey:@"dealer_type_code"],
               
               [dis floatValue],
               [str valueForKey:@"emergency_landline"],
               [str valueForKey:@"isactive"],
               [str valueForKey:@"landline_no"],
               
               [str valueForKey:@"latitude"],   [str valueForKey:@"location_name"],
               [str valueForKey:@"longitude"],
               [str valueForKey:@"mobile_no"],
               [str valueForKey:@"overall_ratings"],
               
               [str valueForKey:@"pin"],
               [str valueForKey:@"prefered_dealer"],
               [str valueForKey:@"present_user_rating"],
               
               [str valueForKey:@"service_manager_email"],
               [str valueForKey:@"service_manager_no"],
               [str valueForKey:@"state_name"],
               [str valueForKey:@"website_link"],
               [str valueForKey:@"workshop_number"] ];
               }
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

+(void)deleteoffline :(NSString *)dId
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
     
        query =[NSString  stringWithFormat:@"delete from  saveoffline  where DealerId = %d",[ dId intValue]];
        
        
        
        
      
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);

}

-(void)insertoffline:(NSDictionary *)str
{
   
    NSLog(@"%@",str);
    
    
    NSString *dealerIdString=[str valueForKey:@"dealer_id"];
    
    if([dealerIdString length]<=0)
    {
       dealerIdString= [str valueForKey:@"DealerId"];
    }
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *getImagePath = [documentsDirectory stringByAppendingPathComponent:@"test.png"];

   
    
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
       
        
        
        
        query=[NSString stringWithFormat:@"Insert into SaveOffline values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",dealerIdString ,[str valueForKey:@"dealer_name"],[str valueForKey:@"dealer_address"],[str valueForKey:@"latitude"],[str valueForKey:@"longitude"],[str valueForKey:@"overall_ratings"],[str valueForKey:@"landline_no"],[str valueForKey:@"workshop_number"],[str valueForKey:@"emergency_landline"],[str valueForKey:@"website_link"],[str valueForKey:@"mobile_no"],[str valueForKey:@"location_name"],[str valueForKey:@"prefered_dealer"],[str valueForKey:@"distance"],[str valueForKey:@"city_name"],getImagePath];
        
        
        
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
     //   NSError *eeroor;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            
        
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}




-(BOOL)checkcontact:(NSString *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    
    
 //   NSMutableArray *tripArray=[[NSMutableArray alloc]init];
    sqlite3 *database;
	
    NSString *name;
    
  
    
	// Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
        
        NSString *query=[[NSString alloc]init];
        query=[NSString stringWithFormat:@"select * from Emergency_Tbl where mobile =\"%@\"" ,str];
        
        const char *sqlStatement =[query UTF8String];
        
		
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                
                
                
                name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
             
               
                
                
            }
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    if (!name) {
        
        return NO;
    }
    else
    {
        return YES;
    }
    
    
}


/*

-(void)insertEmergencyDetail:(birthday *)str
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
    
    

	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
     
     //   int myint=[str.uid intValue];
               
   //     NSString *query=[[NSString alloc]init];
          //  DF_AppDelegate *delegate=(DF_AppDelegate *)[[UIApplication sharedApplication]delegate];
        
    }
    
}
*/
#pragma mark - dealerhistory

+(void)InsertDealerHistory:(NSDictionary *)str
{
    
           
   

    
 
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into History_table values ('%@')",str];
        
        
        
        query=[NSString stringWithFormat:@"Insert into History_table values ('%@','%@','%@','%@','%@','%@')",
               [str valueForKey:@"service_date"] ,
               [str valueForKey:@"dealer_name"],
               [str valueForKey:@"service_type"],
               [str valueForKey:@"service_mileage"],
               [str valueForKey:@"dealer_state"],
               [str valueForKey:@"service_amount"] ];
               
               
        
        
        
        
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
           sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}



+(void)deletedelaerHistory
{
    
    
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        NSString *query=[[NSString alloc]init];
        //query=[NSString stringWithFormat:@"Insert into TripId_tbl values ('%@')",str];
        
        
        
        //Insert into Emergency_Tbl values (NULL,'%@','%@','%@','%@','%d')",str.firstname,str.lastname,str.mobile,str.email,myint];
        
        
        const char *sqlStatement ="DELETE  FROM History_table ";
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            sqlite3_step(compiledStatement);
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
    
}

#pragma mark-
#pragma mark-DeleteFromDatabase

-(void)deleteSaveOfflineData :(NSString *)dealerId
{

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *dbPath=[defaults objectForKey:DATABASEPATH];
    sqlite3 *database;
    // Open the database from the users filessytem
	if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        
        NSString *query=[[NSString alloc]init];
        
       query=[NSString stringWithFormat:@"DELETE  FROM SaveOffline where DealerId=%@",dealerId];
        const char *sqlStatement =[query UTF8String];
		sqlite3_stmt *compiledStatement;
        
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            sqlite3_step(compiledStatement);
            
        
        }
		
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
    
}

 @end









