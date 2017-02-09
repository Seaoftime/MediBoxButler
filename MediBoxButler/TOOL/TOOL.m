//
//  TOOL.m
//  DataBaseClass
//
//  Created by tianjing on 13-11-18.
//  Copyright (c) 2013年 sky. All rights reserved.
//

#import "TOOL.h"

@implementation TOOL
@synthesize checkRefreshDic;

static TOOL* shardTool;

+ (TOOL *) defaultTool{
    if (!shardTool) {
        shardTool = [[TOOL alloc]init];
        shardTool.checkRefreshDic = [[NSMutableDictionary alloc]init];
        
    }
    return shardTool;
}



+(void)setKey:(NSInteger)key value:(NSInteger)value{
  
    TOOL* ad = [TOOL defaultTool];
    [ad.checkRefreshDic setValue:[NSString stringWithFormat:@"%ld",(long)value] forKey:[NSString stringWithFormat:@"%ld",(long)key]];
 
}

+(BOOL)getKey:(int )key{
    
    TOOL* ad = [TOOL defaultTool];
    
    if (![[ad.checkRefreshDic objectForKey:[NSString stringWithFormat:@"%d",key]] integerValue]) {
        return NO;
    }else{
        return YES;
    }
    
    
    
}






+(NSString*)convertUnixTime:(NSInteger )unixTime timeType:(int)type
{
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    if(type == 1)
        [YMD setDateFormat:@"yyyy-MM-dd HH:mm"];
    else if (type == 2)
        [YMD setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    else if (type ==3)
    {
        [YMD setDateFormat:@"yyyy-MM-dd"];
    }
    else if (type ==0)
    {
        [YMD setDateFormat:@"HH:mm"];
    }
    else
        [YMD setDateFormat:@"MM-dd"];
//    int taskDate = [unixTime integerValue];
    NSDate* confromPostTime = [NSDate dateWithTimeIntervalSince1970:unixTime];
    return  [YMD stringFromDate:confromPostTime];
}

+(NSString*)combinDate:(NSString*)date andTimeToUnixString:(NSString*)time
{
    NSString *combinString;
     NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
//    if([time isEqualToString:@"请选择时间"]||[time isEqualToString:@"无截止日期"])
//    {
//    combinString = [NSString stringWithFormat:@"%@ 23:59",date];
//    }
//    else
//    {
//        combinString = [NSString stringWithFormat:@"%@ %@",date,time];
//    }
     combinString = [NSString stringWithFormat:@"%@",date];
     [YMD setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *destDate= [YMD dateFromString:combinString];
    return [NSString stringWithFormat:@"%ld",(long)[destDate timeIntervalSince1970]];
}

+(NSString* )getEndDateString:(NSInteger )taskTime{
    
    
    NSString* aaa;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    //创建了两个日期对象
    NSDate *date1= [NSDate dateWithTimeIntervalSince1970:taskTime];;
    NSDate *date2=[NSDate date];
    
    NSTimeInterval time=[date1 timeIntervalSinceDate:date2];
    
    
    int days=((int)time)/(3600*24);
        
    if (days == 0) {
         aaa = @"明天到期";
    }else if(days < 0){
        
        aaa = @"已过期";

       
    }else if(days <= 5){
        
      aaa = [NSString stringWithFormat:@"%d天后到期",days];
    }else{
        NSDate* confromPostTime = [NSDate dateWithTimeIntervalSince1970:taskTime];
        aaa = [dateFormatter stringFromDate:confromPostTime];
    }

    return aaa;
    
}

+(NSMutableArray*)sortArray:(NSMutableArray*)tjarray byKey:(NSString*)tjkey
{
    NSSortDescriptor * frequencyDescriptor =
    [[NSSortDescriptor alloc] initWithKey:tjkey
                                ascending:YES] ;
    NSArray * descriptors =
    [NSArray arrayWithObjects:frequencyDescriptor, nil];
    NSArray * sortedArray =
    [tjarray sortedArrayUsingDescriptors:descriptors];
    NSLog(@"tjsorted:%@,count%i",sortedArray,[sortedArray count]);
    [tjarray removeAllObjects];
    NSMutableArray *oneArray = [NSMutableArray arrayWithObjects:[sortedArray objectAtIndex:0], nil];
    for (int i =0; i<([sortedArray count]-1);i++)
    {
        if([[[sortedArray objectAtIndex:i+1]objectForKey:tjkey]isEqualToString:[[sortedArray objectAtIndex:i]objectForKey:tjkey]])
        {
            [oneArray addObject:[sortedArray objectAtIndex:i+1]];
        }
        else
        {
            [tjarray addObject:oneArray];
            oneArray = [NSMutableArray arrayWithObjects:[sortedArray objectAtIndex:i+1], nil];
        }
        if(i == ([sortedArray count]-2))
        {
            [tjarray addObject:oneArray];
        }
    }
    NSLog(@"tjarray:%@",tjarray);
    return tjarray;
}

+(UIImage*)homepageImage
{
    static UIImage *defaultImage = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		UIGraphicsBeginImageContextWithOptions(CGSizeMake(20.f, 14.f), NO, 0.0f);

		[[UIColor whiteColor] setFill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, 20, 2)] fill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 6, 20, 2)] fill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 12, 20, 2)] fill];
#if 0
		[[UIColor whiteColor] setFill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 1, 20, 2)] fill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 6,  20, 2)] fill];
		[[UIBezierPath bezierPathWithRect:CGRectMake(0, 11, 20, 2)] fill];
#endif
		defaultImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
        
	});
    return defaultImage;
}

+(NSString*)stringWithArray:(NSMutableArray*)array
{
    NSString *toString;
    if(array.count > 0)
    {
        toString = [NSString stringWithFormat:@"%@",[array objectAtIndex:0]];
        for(int i = 1;i <array.count;i++)
        {
            toString = [NSString stringWithFormat:@"%@,%@",toString,[array objectAtIndex:i]];
        }
    }
    return toString;
}

-(NSDate *)dateStartOfWeek:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] ;
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:date options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                        fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

-(NSString* )getDateString:(NSDate *)date{
    
    
    NSString* dateString = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    
    
    return  dateString;
}

-(NSDate* )getStartOfMonth:(NSDate *)date
{
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    [YMD setDateFormat:@"yyyy.MM.dd"];
    [YMD setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSString* a = [YMD stringFromDate:date];
    a = [a substringToIndex:[a length]-2];
    a = [a stringByAppendingString:@"01"];
    
    NSDate* beginningOfMonth = [YMD dateFromString:a];
    
    return beginningOfMonth;
}

//+ (NSString *)timeUptoNowFrom:(int)timestamp
//{
//    int second = 1;
//    int minute = second * 60;
//    int hour   = minute * 60;
//    int day    = hour   * 24;
//    int month  = day    * 30;
//    int year   = month  * 12;
//    
//    NSDate *nowDate = [NSDate date];
//    int nowTimestamp = [nowDate timeIntervalSince1970];
//    int difference = nowTimestamp - timestamp;
//    
//    if (difference >= year) {
//        return [NSString stringWithFormat:@"%d年前",difference/year];
//    } else if (difference >= month) {
//        return [NSString stringWithFormat:@"%d月前",difference/month];
//    } else if (difference >= day) {
//        return [NSString stringWithFormat:@"%d天前",difference/day];
//    } else if (difference >= hour) {
//        return [NSString stringWithFormat:@"%d小时前",difference/hour];
//    } else if (difference >= minute*5) {
//        return [NSString stringWithFormat:@"%d分钟前",difference/minute];
//    } else {
//        return @"刚刚";
//    }
//}
+(NSString *)ttimeUptoNowFrom:(NSInteger)timestamp{
NSDate* date = [NSDate date];
NSTimeInterval now= [date timeIntervalSince1970]*1;
NSInteger today = now / (24*3600);
NSInteger yestoday = timestamp / (24*3600);
NSInteger resault = today - yestoday;
NSString *reaultStr;

if(resault == 0) {
    reaultStr= [NSString stringWithFormat:@"今天"];
}else if (resault == 1) {
    reaultStr = [NSString stringWithFormat:@"昨天"];
}else if (resault == 2) {
    reaultStr = [NSString stringWithFormat:@"前天"];
}else if (resault >= 3 ) {
    reaultStr = [TOOL convertUnixTime:timestamp timeType:5];
}
return reaultStr;
}

//+(NSString *)ttimeUptoNowFrom:(int)timestamp
//{
//    int second = 1;
//    int minute = second * 60;
//    int hour   = minute * 60;
//    int day    = hour   * 24;
//    int month  = day    * 3;
//    //int year   = month  * 12;
//    
//    NSDate *nowDate = [NSDate date];
//    int nowTimestamp = [nowDate timeIntervalSince1970];
//    int difference = nowTimestamp - timestamp;
//    
//    if (difference >= month) {
//        return [TOOL convertUnixTime:timestamp timeType:5];
//    } else if (difference >= day) {
//        return [NSString stringWithFormat:@"%d天前",difference/day];
//    } else if (difference >= hour) {
//        return [NSString stringWithFormat:@"%d小时前",difference/hour];
//    } else if (difference >= minute*5) {
//        return [NSString stringWithFormat:@"%d分钟前",difference/minute];
//    } else {
//        return @"刚刚";
//    }
//}


+(UILabel*)setTitleView:(NSString*)titleTextStr{
    UILabel *titleText = [[UILabel alloc] initWithFrame: CGRectMake(0,10,100,44)];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];//颜色
    titleText.textAlignment = UITextAlignmentCenter;
    [titleText setFont:[UIFont systemFontOfSize:19.0]];
    // [titleText setFont:[UIFont fontWithName:@"Arial-BoldMT" size:22.0]];
    [titleText setText:titleTextStr];
    return titleText;
}
///Users/tianjing/Library/Application Support/iPhone Simulator/7.0.3/Applications/22B94F39-16BE-4E24-B24E-18AB7522F55F/Library/Caches/gongchang.com.SalesManager/fsCachedData
+(NSString*)convertCCMD5Path:(NSString*)picURL
{
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //下载路径
    NSString* downloadPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    const char *str = [picURL UTF8String];
    CC_MD5(str, strlen(str), r);
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    NSString* newDownloadPath = [downloadPath stringByAppendingPathComponent:filename];
    
    return newDownloadPath;
    
    
}

+(void)createFileWithName:(NSString*)fileName
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths objectAtIndex:0];
    NSString *filename=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    NSFileManager* fm = [NSFileManager defaultManager];
    [fm createFileAtPath:filename contents:nil attributes:nil];
}
// NSFileManager *fileManager = [NSFileManager defaultManager];
//if (![fileManager fileExistsAtPath:ccmd5Path])
+(NSString*)fullPathWithFileName:(NSString*)fileName
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path=[paths  objectAtIndex:0];
    NSString *fullPath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",fileName]];
    return fullPath;
}
+(UIImage *)scaleImage:(UIImage *)image toHeight:(float)h toWidth:(float)w
{
    UIGraphicsBeginImageContext(CGSizeMake(h,w));
    [image drawInRect:CGRectMake(0, 0, h,w)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


+ (float)getContentSizeHeightForTextView:(UITextView *)textView
{
    NSLog(@"%s %@",__FUNCTION__,textView.text);
    float contentSizeHeight;
    if (IS_IOS7)
    {
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:textView.text];
        textView.attributedText = attrStr;
        NSRange range = NSMakeRange(0, attrStr.length);
        NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];   // 获取该段attributedString的属性字典
        CGSize textSize = [textView.text boundingRectWithSize:CGSizeMake(textView.frame.size.width,20000) // 用于计算文本绘制时占据的矩形块
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                   attributes:dic        // 文字的属性
                                                      context:nil].size;
        contentSizeHeight = textSize.height + 30 -12;
        
        NSLog(@"%s,%@",__FUNCTION__,NSStringFromCGRect([textView.text boundingRectWithSize:CGSizeMake(textView.frame.size.width,20000) // 用于计算文本绘制时占据的矩形块
                                                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                                                attributes:dic        // 文字的属性
                                                                                   context:nil]));
        NSLog(@"%s %@",__FUNCTION__,NSStringFromCGSize(textView.bounds.size));
    }else{
        contentSizeHeight = textView.contentSize.height;
    }
    NSLog(@"%s ,%f",__FUNCTION__,contentSizeHeight);
    return contentSizeHeight;
}




/**
 *  获取字符串大小
 *
 *
 */
+ (CGFloat)getText:(NSString *)text MinHeightWithBoundsWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGFloat textHeight;
    
    textHeight = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height+1;
        
    return textHeight;
}




+(void) minusIconBadgeNumber{
    
    if ([[UIApplication sharedApplication] applicationIconBadgeNumber] >0) [UIApplication sharedApplication].applicationIconBadgeNumber
        -=1;
}

+ (UIBarButtonItem *)getBarButtonItemWithTitle:(NSString *)aTitle  target:(id)aTarget selector:(SEL)aSelector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(10, 20, 50, 44)];
    [btn setTitle:aTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setImage:[UIImage imageNamed:@"返回箭头"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn addTarget:aTarget action:aSelector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}




+(NSInteger)getDateInteger:(NSDate *)date{
    return  (long)[date timeIntervalSince1970];
}

+(NSString* )getDateString:(NSDate *)date{
    NSString* dateString = [NSString stringWithFormat:@"%ld",[self getDateInteger:date]];
    return  dateString;
}















@end
