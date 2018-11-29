//
//  RegexUtil.m
//  wastenet
//
//  Created by xiangwl on 15/12/14.
//  Copyright (c) 2015年 ddsl. All rights reserved.
/*
 
 正则表达式
 
 */

#import "RegexUtil.h"

BOOL isValid(NSString *validateObj, NSString *regEx)
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES%@", regEx] evaluateWithObject:validateObj];
}

@implementation RegexUtil

//电话号码
+ (BOOL)isValidTelePhone:(NSString *)telephone
{
    if (telephone == nil || telephone.length < 1)
    {
        return NO;
    }
    
    telephone = [telephone stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *regex = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telephone];
    if (!isMatch)
    {
        return [RegexUtil isValidMobileNumber:telephone];
    
    }
    return isMatch;

}

+ (BOOL)isValidMobileNumber:(NSString*)mobileNum
{
    
    if (mobileNum == nil || [mobileNum length] == 0)
    {
        return NO;
        
    }
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^[1][3|4|5|7|8|9]\\d{9}$";
    
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    if (!isMatch)
    {
        return NO;
    
    }
    

    return YES;
    
    /* 手机号
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /* 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,177,182,187,188
     */
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|77[0-8]|8[278])\\d)\\d{7}$";
    
    /* 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    /* 中国电信：China Telecom
     * 133,1349,153,180,189,
     */
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    /* 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    //NSString *PHS    = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    /* 贵州省座机
     区号	地名
     0851	贵阳,清镇,修文,息烽,开阳
     0852	遵义,习水,道真,桐梓,赤水,绥阳,正安,湄潭,凤冈,务川,遵义县,余庆,仁怀
     0853	安顺,紫云,平坝,关岭,镇宁,普定
     0854	都匀,福泉,瓮安,三都,荔波,独山,平塘,罗甸,惠水,龙里,贵定,长顺
     0855	凯里,黄平,施秉,镇远,岑巩,三穗,天柱,锦屏,黎平,从江,榕江,雷山,丹寨,麻江,台江,剑河
     0856	铜仁,玉屏,江口,石阡,思南,印江,德江,沿河,松桃,万山
     0857	毕节,威宁,赫章,纳雍,黔西,大方,金沙,织金
     0858	六盘水,六枝,盘县,水城
     0859	兴义,晴隆,册亨,望谟,安龙,兴仁,贞丰,普安
     */
    NSString *GZ  = @"^085[1-9]\\d{7,8}$";
    
    return ( isValid(mobileNum, MOBILE)
            || isValid(mobileNum, CM)
            || isValid(mobileNum, CU)
            || isValid(mobileNum, CT)
            || isValid(mobileNum, GZ));
}

+ (BOOL)isValidEmail:(NSString *)email
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return isValid(email, emailRegEx);
    
}

+  (BOOL)isValidZipCode:(NSString *)zipCode
{
    NSString *zipCodeRegEx = @"[1-9]\\d{5}(?!\\d)";
    return isValid(zipCode, zipCodeRegEx);
    
}

+(BOOL)isValidPassword:(NSString *)password
{
    //@"\\w{6,20}
    NSString *pwdRegEx = @"\\w{6,20}";
    return isValid(password, pwdRegEx);
    
}



+ (BOOL)validateIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSUInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

@end
