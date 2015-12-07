//
//  DataTransfer.h
//  ttttt
//
//  Created by Tamer Alaa on 5/14/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransfer : NSObject
+(NSString*)CategorynameQr;
+(NSString*)ImageQr;
+(float)priceQr;
+(NSString*)shopnameQr;
+(NSString*)dimSizeQr;
+(int)ratingQr;
+(double)longshopQr;
+(double)latshopQr;
+(NSString*)emailQr;
+(NSString*)commentsQr;
+(double)phoneQr;
+(NSString*)websiteurlQr;


+(void)setCategorynameQr:(NSString*)CatnameQR;
+(void)setImagenameQr:(NSString*)ImagenameQR;
+(void)setPriceQr:(float)PriceQR;
+(void)setShopnameQr:(NSString*)ShopnameQR;
+(void)setdimSizeQr:(NSString*)DimSizeQr;
+(void)setemailQr:(NSString*)EmailQr;
+(void)setcommentsQr:(NSString*)CommentsQr;
+(void)setwebsiteurlQr:(NSString*)WebsiteurlQr;
+(void)setphoneQr:(double)PhoneQR;
+(void)setRatingQr:(int)RatingQR;
+(void)setlongshopQr:(double)LongshopQr;
+(void)setlatshopQr:(double)LongshopQr;
@end
