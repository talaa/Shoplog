//
//  CustomDelegate.m
//  MosaicCollectionView
//
//  Created by Ezequiel A Becerra on 2/16/13.
//  Copyright (c) 2013 Betzerra. All rights reserved.
//

#import "CustomDataSource.h"
#import "MosaicData.h"
#import "MosaicCell.h"
#import <dispatch/dispatch.h>
#import "TFHpple.h"
#import <ImageIO/ImageIO.h>
//#import "STTwitterAPIWrapper.h"
@interface CustomDataSource()
-(void)loadFromDisk;
@end

@implementation CustomDataSource
@synthesize _elements,JSONelements;
#pragma mark - Private
/*
-(void)newtwitterauthorize{
    
    //STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIApplicationOnlyWithConsumerKey:@"8OcbEuQWD5LNscOBBP8ww"
                                                                                  //consumerSecret:@"d1SlDEsZGQGG2IJH8QYr4vlKZeUpTOMOfErkgl02tw"];
    
   // [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        
        //NSLog(@"Access granted with %@", bearerToken);
        
       // [twitter getUserTimelineWithScreenName:@"shoplog1" successBlock:^(NSArray *statuses) {
       //NSLog(@"-- statuses: %@", statuses);
            JSONelements=[[NSArray alloc]initWithArray: statuses];
            [self loadFromDisk2];
        } errorBlock:^(NSError *error) {
            NSLog(@"-- error: %@", error);
        }];
        
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error %@", error);
    }];
 
}
<<<<<<< HEAD
  */
=======
/*
>>>>>>> QRCODE
-(void)loadFromDisk{
    //[self newtwitterauthorize];
    _elements = [[NSMutableArray alloc] init];
    dispatch_queue_t backgroundQueue;
    backgroundQueue = dispatch_queue_create("com.springmoon.shoplog.bgqueue", NULL);
   
    
    
    ///The New Part
   // NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
    //NSData *dataurl=[[NSData alloc]init];
    dispatch_async(backgroundQueue, ^{
        NSError *anError = nil;
        //NSURL *feedURL =[NSURL URLWithString:feedname];
        //NSData *dataurl =[NSData dataWithContentsOfURL:feedURL];
        //NSLog(@"The JSON Elements are %@",JSONelements);
        if (JSONelements) {
            
        
    //The JSON Part
    
    
   // NSArray *parsedElements=[NSJSONSerialization JSONObjectWithData:dataurl options:NSJSONReadingAllowFragments error:&anError];
            NSArray *parsedElements=[[NSArray alloc]initWithArray:JSONelements];
            //NSLog(@"The parsed elements are %@",parsedElements);
    //NSLog(@"The elements are :%@",parsedElements);
    for (NSMutableDictionary *aModuleDict in parsedElements){
        NSMutableDictionary *trmpdict=[[NSMutableDictionary alloc]init];
        //The new Part
        NSString *maintext=[aModuleDict objectForKey:@"text" ];
        //NSLog(@"The maintext is %@",maintext);
        NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
        NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
        //NSLog(@"The tweet exis %@",firstetxt);

        //[aModuleDict setObject:firstetxt forKey:@"tweettext"];
        [trmpdict setValue:firstetxt forKey:@"tweettext"];
        
        if ([piecesOfOriginalString count]>1) {
            NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
            [trmpdict setValue:link forKey:@"tweetlink"];
            NSURL *testurl=[[NSURL alloc]initWithString:link];
            //[trmpdict setValue:[self retrieveImageSourceTagsViaRegex:testurl] forKey:@"imagelink"];
            [trmpdict setValue:[self retrieveImageSourceTagsViaHpple:testurl] forKey:@"imagelink"];
        }else {
        [trmpdict setValue:@"MyIcon copy_144" forKey:@"imagelink"];
        
        
        }
    
        if (!_elements) {
            UIAlertView *oops=[[UIAlertView alloc]initWithTitle:@"Oops!" message:NSLocalizedString(@"Error downloading", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [oops show];
        }else{
        MosaicData *aMosaicModule=[[MosaicData alloc]initWithDictionary:trmpdict];
        [_elements addObject:aMosaicModule];
        }
        
    }
            NSLog(@"The error is %@",anError);
        if (anError) {
            UIAlertView *nointernet=[[UIAlertView alloc]initWithTitle:@"OOOPS!" message:NSLocalizedString(@"Error downloading", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [nointernet show];
        }
    
     
     
        }
    });
    
    
}
 
 */
-(void)loadFromDisk2{
    //[self newtwitterauthorize];
    _elements = [[NSMutableArray alloc] init];
    dispatch_queue_t backgroundQueue;
    backgroundQueue = dispatch_queue_create("com.springmoon.shoplog.bgqueue", NULL);
    
    
    
    ///The New Part
    //NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
    //NSData *dataurl=[[NSData alloc]init];
    dispatch_async(backgroundQueue, ^{
        NSError *anError = nil;
        //NSURL *feedURL =[NSURL URLWithString:feedname];
       // NSData *dataurl =[NSData dataWithContentsOfURL:feedURL];
        //NSLog(@"The JSON Elements are %@",JSONelements);
        if (JSONelements) {
            
            
            //The JSON Part
            
            
            // NSArray *parsedElements=[NSJSONSerialization JSONObjectWithData:dataurl options:NSJSONReadingAllowFragments error:&anError];
            NSArray *parsedElements=[[NSArray alloc]initWithArray:JSONelements];
            //NSLog(@"The parsed elements are %@",parsedElements);
            //NSLog(@"The elements are :%@",parsedElements);
            for (NSMutableDictionary *aModuleDict in parsedElements){
                NSMutableDictionary *trmpdict=[[NSMutableDictionary alloc]init];
                //The new Part
                NSString *maintext=[aModuleDict objectForKey:@"text" ];
                //NSLog(@"The maintext is %@",maintext);
                NSArray *piecesOfOriginalString = [maintext componentsSeparatedByString:@"http"];
                NSString *firstetxt=[piecesOfOriginalString objectAtIndex:0];
                //NSLog(@"The tweet exis %@",firstetxt);
                
                //[aModuleDict setObject:firstetxt forKey:@"tweettext"];
                [trmpdict setValue:firstetxt forKey:@"tweettext"];
                
                if ([piecesOfOriginalString count]>1) {
                    NSString *link=[@"http" stringByAppendingString:[piecesOfOriginalString objectAtIndex:1]];
                    [trmpdict setValue:link forKey:@"tweetlink"];
                   // NSLog(@"The link is %@",link);
                    NSURL *testurl=[[NSURL alloc]initWithString:link];
                    //[trmpdict setValue:[self retrieveImageSourceTagsViaRegex:testurl] forKey:@"imagelink"];
                    [trmpdict setValue:[self retrieveImageSourceTagsViaHpple:testurl] forKey:@"imagelink"];
                }else {
                    [trmpdict setValue:@"MyIcon copy_144" forKey:@"imagelink"];
                    
                    
                }
                
                if (!_elements) {
                    UIAlertView *oops=[[UIAlertView alloc]initWithTitle:@"Oops!" message:NSLocalizedString(@"Error downloading", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [oops show];
                }else{
                    MosaicData *aMosaicModule=[[MosaicData alloc]initWithDictionary:trmpdict];
                    [_elements addObject:aMosaicModule];
                }
                
            }
            NSLog(@"The error is %@",anError);
            if (anError) {
                UIAlertView *nointernet=[[UIAlertView alloc]initWithTitle:@"OOOPS!" message:NSLocalizedString(@"Error downloading", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [nointernet show];
            }
            
            
            
        }
    });
    
    
}

-(float)gettingimagedimensions:(NSString*)url{
    //NSURL *imageFileURL = [NSURL fileURLWithPath:url];
    NSURL *testfileurl=[NSURL URLWithString:url];
    //CGImageSourceRef imageSource = CGImageSourceCreateWithURL(imageFileURL, NULL);
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)testfileurl, NULL);
    if (imageSource == NULL) {
        // Error loading image
        
        return 0;
    }
    
    CGFloat  height = 0.0f;
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL);
    if (imageProperties != NULL) {
        /*
        CFNumberRef widthNum  = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
        if (widthNum != NULL) {
            CFNumberGetValue(widthNum, kCFNumberFloatType, &width);
        }
        */
        NSNumber *heightNum=CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        
        
        //CFNumberRef heightNum = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        if (heightNum != NULL) {
            height=[heightNum floatValue];
            //CFNumberGetValue(heightNum, kCFNumberFloatType, &height);
        }
        
        CFRelease(imageProperties);
    }
    
    //NSLog(@"Image dimensions:  %.0f px", height);

    return height;

}
- (NSString*)retrieveImageSourceTagsViaHpple:(NSURL *)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    if (data) {
	//NSMutableArray *imagesarray=[[NSMutableArray alloc]init];
    TFHpple *parser = [TFHpple hppleWithHTMLData:data];
    //float savefloat;
    NSString *xpathQueryString = @"//img";
    NSArray *nodes = [parser searchWithXPathQuery:xpathQueryString];
    
        NSString *lasthope=[[NSString alloc]init];
        for (TFHppleElement *element in nodes)
        {
            NSString *src = [element objectForKey:@"src"];
            lasthope=src;
            if (![src hasSuffix:@"gif"]) {
                if ([src hasPrefix:@"http"]) {
                    if ([self gettingimagedimensions:src]>200) {
                         return src;
                    }
                }
                //[imagesarray addObject:src];
               
                
            }
            
            //NSLog(@"img src: %@", src);
        }
        return lasthope;
    } else {
        
        return @"MyIcon copy_144";
    }
    
    
   
 
    
        
}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        //[self loadFromDisk];
       // [self newtwitterauthorize];
        self.thumbnailQueue = [[NSOperationQueue alloc] init];
        self.thumbnailQueue.maxConcurrentOperationCount = 3;
    }
    return self;
}


#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_elements count];
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    MosaicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // load photo images in the background
    __weak CustomDataSource *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        MosaicData *data = [_elements objectAtIndex:indexPath.row];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // then set them via the main queue if the cell is still visible.
            if ([weakSelf.collectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                MosaicCell *mosaicCell = (MosaicCell *)[weakSelf.collectionView cellForItemAtIndexPath:indexPath];
                mosaicCell.mosaicData = data;
            }
        });
    }];
    
    [self.thumbnailQueue addOperation:operation];
    
    float randomWhite = (arc4random() % 40 + 10) / 255.0;
    cell.backgroundColor = [UIColor colorWithWhite:randomWhite alpha:1];
    return cell;
}

@end
