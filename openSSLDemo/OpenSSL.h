//
//  OpenSSL.h
//  openSSLDemo
//
//  Created by 范云飞 on 2017/10/28.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OpenSSL : NSObject

+ (NSString *)md5FromString:(NSString *)string;

+ (NSString *)sha256FromString:(NSString *)string;

+ (NSString *)base64FromString:(NSString *)string
            encodeWithNewlines:(BOOL)encodeWithNewlines;

@end
