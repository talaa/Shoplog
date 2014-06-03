//
//  DataTransfer.m
//  ttttt
//
//  Created by Tamer Alaa on 5/14/14.
//  Copyright (c) 2014 Tamer Alaa. All rights reserved.
//

#import "DataTransfer.h"
static NSString *defcatqr = @"Shoplog";
static NSString *defimagenameqr = @"Shoplog";
static NSString *defshopname = @"Shoplog";
static NSString *defdimsize = @"Shoplog";
static NSString *defemail = @"Shoplog";
static NSString *defcomments = @"Shoplog";
static NSString *defwebsiteurl = @"Shoplog";
static double defphone = 123456789;
static double deflong = 0;
static double deflat = 0;
static float defprice=0.0;
static int defrating = 10;


@implementation DataTransfer
+(NSString*)CategorynameQr{
    return defcatqr;
}
+(NSString*)ImageQr{
    return defimagenameqr;
}
+(float)priceQr{
    return defprice;
}
+(NSString*)shopnameQr{
    return defshopname;
}
+(NSString*)dimSizeQr{
    return defdimsize;
}
+(int)ratingQr{
    return defrating;
}
+(double)longshopQr{
    return deflong;
}
+(double)latshopQr{
    return deflat;
}
+(NSString*)emailQr{
    return defemail;
}
+(NSString*)commentsQr{
    return defcomments;
}
+(double)phoneQr{
    return defphone;
}
+(NSString*)websiteurlQr{
    return defwebsiteurl;
}


+(void)setCategorynameQr:(NSString*)CatnameQR{
    defcatqr=CatnameQR;
}
+(void)setImagenameQr:(NSString*)ImagenameQR{
    defimagenameqr=ImagenameQR;
}
+(void)setPriceQr:(float)PriceQR{
    defprice=PriceQR;
}
+(void)setShopnameQr:(NSString*)ShopnameQR{
    defshopname=ShopnameQR;
}
+(void)setdimSizeQr:(NSString*)DimSizeQr{
    defdimsize=DimSizeQr;
}
+(void)setemailQr:(NSString*)EmailQr{
    defemail=EmailQr;
}
+(void)setcommentsQr:(NSString*)CommentsQr{
    defcomments=CommentsQr;
}
+(void)setwebsiteurlQr:(NSString*)WebsiteurlQr{
    defwebsiteurl=WebsiteurlQr;
}
+(void)setphoneQr:(double)PhoneQR{
    defphone=PhoneQR;
}
+(void)setRatingQr:(int)RatingQR{
    defrating=RatingQR;
}
+(void)setlongshopQr:(double)LongshopQr{
    deflong=LongshopQr;
}
+(void)setlatshopQr:(double)LatshopQr{
    deflat=LatshopQr;
}
@end
