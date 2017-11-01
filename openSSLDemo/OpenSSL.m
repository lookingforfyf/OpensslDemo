//
//  OpenSSL.m
//  openSSLDemo
//
//  Created by 范云飞 on 2017/10/28.
//  Copyright © 2017年 范云飞. All rights reserved.
//

#import "OpenSSL.h"

/* md5加密 */
#include <openssl/md5.h>

/* sha加密 */
#include <openssl/sha.h>

/* base64加密 */
#include <openssl/evp.h>

/* openssl解析X509证书 */
#include <openssl/x509.h>
/* 10000 0000 003965 */

#include <openssl/sm3.h>

@interface OpenSSL ()

@end

@implementation OpenSSL

+ (NSString *)md5FromString:(NSString *)string
{
    unsigned char * inStrg = (unsigned char *) [[string dataUsingEncoding:NSASCIIStringEncoding] bytes];
    unsigned long lngth = [string length];
    unsigned char result[MD5_DIGEST_LENGTH];
    NSMutableString * outStrg = [NSMutableString string];
    
    MD5(inStrg, lngth, result);
    
    unsigned int i;
    for (i = 0; i < MD5_DIGEST_LENGTH; i++)
    {
        [outStrg appendFormat:@"%02x", result[i]];
    }
    return [outStrg copy];
}

+ (NSString *)sha256FromString:(NSString *)string
{
    unsigned char * inStrg = (unsigned char *) [[string dataUsingEncoding:NSASCIIStringEncoding] bytes];
    unsigned long lngth = [string length];
    unsigned char result[SHA256_DIGEST_LENGTH];
    NSMutableString * outStrg = [NSMutableString string];
    
    SHA256_CTX sha256;
    SHA256_Init(&sha256);
    SHA256_Update(&sha256, inStrg, lngth);
    SHA256_Final(result, &sha256);
    
    unsigned int i;
    for (i = 0; i < SHA256_DIGEST_LENGTH; i++)
    {
        [outStrg appendFormat:@"%02x", result[i]];
    }
    return [outStrg copy];
}

+ (NSString *)base64FromString:(NSString *)string
            encodeWithNewlines:(BOOL)encodeWithNewlines
{
    BIO * mem = BIO_new(BIO_s_mem());
    BIO * b64 = BIO_new(BIO_f_base64());
    
    if (!encodeWithNewlines)
    {
        BIO_set_flags(b64, BIO_FLAGS_BASE64_NO_NL);
    }
    mem = BIO_push(b64, mem);
    
    NSData * stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger length = stringData.length;
    void * buffer = (void *) [stringData bytes];
    int bufferSize = (int)MIN(length, INT_MAX);
    
    NSUInteger count = 0;
    
    BOOL error = NO;
    
    while (!error && count < length)
    {
        int result = BIO_write(mem, buffer, bufferSize);
        if (result <= 0)
        {
            error = YES;
        }
        else
        {
            count += result;
            buffer = (void *) [stringData bytes] + count;
            bufferSize = (int)MIN((length - count), INT_MAX);
        }
    }
    
    int flush_result = BIO_flush(mem);
    if (flush_result != 1)
    {
        return nil;
    }
    
    char * base64Pointer;
    NSUInteger base64Length = (NSUInteger) BIO_get_mem_data(mem, &base64Pointer);
    
    NSData * base64data = [NSData dataWithBytesNoCopy:base64Pointer length:base64Length freeWhenDone:NO];
    NSString * base64String = [[NSString alloc] initWithData:base64data encoding:NSUTF8StringEncoding];
    
    BIO_free_all(mem);
    return base64String;
}

@end
