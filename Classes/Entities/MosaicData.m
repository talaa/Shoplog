//
//  MosaicData.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/17/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "MosaicData.h"

@implementation MosaicData
@synthesize title, imageFilename,maintext,url;

-(id)initWithDictionary:(NSDictionary *)aDict{
    self = [self init];
    if (self){
        /*
        self.maintext=[aDict objectForKey:@"text"];
        NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
        NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
        //NSString *secondtxt=[piecesOfOriginalString objectAtIndex:1];
        self.title=firstetxt;
        if ([piecesOfOriginalString count]>1) {
            NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
            url=link;
        }
        if (url) {
            NSURL *testurl=[[NSURL alloc]initWithString:url];
            
            self.imageFilename=[self retrieveImageSourceTagsViaRegex:testurl];
        } else {
            self.imageFilename=@"MyIcon copy_144";
        }
        //NSURL *testurl=[[NSURL alloc]initWithString:url];
         
        //self.imageFilename=[self retrieveImageSourceTagsViaRegex:testurl];
         */
        self.imageFilename = [aDict objectForKey:@"imagelink"];
        self.title = [aDict objectForKey:@"tweettext"];
        self.url=[aDict objectForKey:@"tweetlink"];
        self.firstTimeShown = YES;
    }
    return self;
}
/*
- (NSString*)retrieveImageSourceTagsViaRegex:(NSURL *)url1
{
    NSString *string = [NSString stringWithContentsOfURL:url1
                                                encoding:NSUTF8StringEncoding
                                                   error:nil];
    NSMutableArray *imagesarray=[[NSMutableArray alloc]init];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    [regex enumerateMatchesInString:string
                            options:0
                              range:NSMakeRange(0, [string length])
                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                             
                             NSString *src = [string substringWithRange:[result rangeAtIndex:2]];
                             //NSLog(@"img src: %@", src);
                             [imagesarray addObject:src];
                             //NSString *imagesrc=[[NSString alloc]initWithString:src];
                             
                             
                         }];
    //NSLog(@"The List of Images is %@",[imagesarray objectAtIndex:1]);
    return [imagesarray objectAtIndex:0];
}
*/

-(NSString *)description{
    NSString *retVal = [NSString stringWithFormat:@"%@ %@", [super description], self.title];
    return retVal;
}

@end
