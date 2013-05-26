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

@interface CustomDataSource()
-(void)loadFromDisk;
@end

@implementation CustomDataSource
@synthesize _elements;
#pragma mark - Private
-(void)loadFromDisk{
    _elements = [[NSMutableArray alloc] init];
    dispatch_queue_t backgroundQueue;
    backgroundQueue = dispatch_queue_create("com.springmoon.shoplog.bgqueue", NULL);
   
    
    
    ///The New Part
    NSString *feedname=@"http://api.twitter.com/1/statuses/user_timeline.json?include_entities=true&include_rts=true&screen_name=shoplog1&count=20";
    //NSData *dataurl=[[NSData alloc]init];
    dispatch_async(backgroundQueue, ^{
        NSError *anError = nil;
        NSURL *feedURL =[NSURL URLWithString:feedname];
        NSData *dataurl =[NSData dataWithContentsOfURL:feedURL];
        if (dataurl) {
            
        
    //The JSON Part
    
    
    NSArray *parsedElements=[NSJSONSerialization JSONObjectWithData:dataurl options:NSJSONReadingAllowFragments
                                                              error:&anError];
    
    //NSLog(@"The elements are :%@",parsedElements);
    for (NSMutableDictionary *aModuleDict in parsedElements){
        NSMutableDictionary *trmpdict=[[NSMutableDictionary alloc]init];
        //MosaicData *aMosaicModule = [[MosaicData alloc] initWithDictionary:aModuleDict];
         //MosaicData *aMosaicModule = [[MosaicData alloc] init];
        //NSLog(@"the Modules is %@",aMosaicModule);
        //[_elements addObject:aMosaicModule];
        //NSLog(@"The First url is :%@",_elements);
        
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
            UIAlertView *oops=[[UIAlertView alloc]initWithTitle:@"Oops!" message:NSLocalizedString(@"Errordownloading", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [oops show];
        }else{
        MosaicData *aMosaicModule=[[MosaicData alloc]initWithDictionary:trmpdict];
        [_elements addObject:aMosaicModule];
        }
        
    }
            NSLog(@"The error is %@",anError);
        if (anError) {
            UIAlertView *nointernet=[[UIAlertView alloc]initWithTitle:@"OOOPS!" message:@"Sorry but you dont have internet connection " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [nointernet show];
        }
    
     
     
        }
    });
    
    
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
                                                                           options:0
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
    NSLog(@"The List of Images is %@",[imagesarray objectAtIndex:3]);
    if ([[imagesarray objectAtIndex:3] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:3]hasSuffix:@"gif"]) {
        return [imagesarray objectAtIndex:3];
    }else if ([[imagesarray objectAtIndex:2] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:2]hasSuffix:@"gif"]){
    return [imagesarray objectAtIndex:2];
    }else if ([[imagesarray objectAtIndex:1] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:1]hasSuffix:@"gif"]){
    return [imagesarray objectAtIndex:1];
    }else if ([[imagesarray objectAtIndex:0] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:0]hasSuffix:@"gif"]){
    return [imagesarray objectAtIndex:0];
    }else
        return @"MyIcon copy_144";

}
 */

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
        CFNumberRef heightNum = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
        if (heightNum != NULL) {
            CFNumberGetValue(heightNum, kCFNumberFloatType, &height);
        }
        
        CFRelease(imageProperties);
    }
    
    NSLog(@"Image dimensions:  %.0f px", height);

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
            if (![src hasSuffix:@"gif"]&&[src hasPrefix:@"http"]&&[self gettingimagedimensions:src]>200) {
                
                //[imagesarray addObject:src];
                return src;
                
            }
            /*
             if (![src hasSuffix:@"gif"]&&[src hasPrefix:@"http"]) {
             
             [imagesarray addObject:src];
             
             }
             */
            //NSLog(@"img src: %@", src);
        }
        return lasthope;
    } else {
        /*
        UIAlertView *nointernet=[[UIAlertView alloc]initWithTitle:@"OOOPS!" message:@"Sorry but you dont have internet connection " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [nointernet show];
         */
        return @"MyIcon copy_144";
    }
    
    
    //The new Method
 
    
    /*
    if ([[imagesarray objectAtIndex:3] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:3]hasSuffix:@"gif"] ) {
        return [imagesarray objectAtIndex:3];
    }else if ([[imagesarray objectAtIndex:2] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:2]hasSuffix:@"gif"]){
        return [imagesarray objectAtIndex:2];
    }else if ([[imagesarray objectAtIndex:1] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:1]hasSuffix:@"gif"]){
        return [imagesarray objectAtIndex:1];
    }else if ([[imagesarray objectAtIndex:0] hasPrefix:@"http"]&& ![[imagesarray objectAtIndex:0]hasSuffix:@"gif"]){
        return [imagesarray objectAtIndex:0];
    }else
        return @"MyIcon copy_144";
     */
    
}

#pragma mark - Public

-(id)init{
    self = [super init];
    if (self){
        [self loadFromDisk];
        
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
