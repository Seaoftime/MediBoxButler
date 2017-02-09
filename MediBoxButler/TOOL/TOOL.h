//
//  TOOL.h
//  DataBaseClass
//
//  Created by tianjing on 13-11-18.
//  Copyright (c) 2013年 sky. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface TOOL : NSObject


@property (nonatomic, strong) NSMutableDictionary* checkRefreshDic;

+ (TOOL *) defaultTool;



+(void)setKey:(NSInteger )key value:(NSInteger )value;

+(BOOL)getKey:(NSInteger)key;



+(NSString* )getEndDateString:(NSInteger )taskTime;
/**
 *  通过unix time 转换成string格式的time
 *
 *  @param unixTime
 *  @param type    type=1，转换的时间为2014-01-23 12:12
                              type=2，转换的时间为2014-01-23 12:12:12
                              type=3，转换的时间为2014-01-23
                              其他，转换的时间为 01-23
 *
 *  @return 字符串时间
 */
+(NSString*)convertUnixTime:(NSInteger )unixTime timeType:(int)type;

+(NSString*)combinDate:(NSString*)date andTimeToUnixString:(NSString*)time;
/**
 *  这个数组由字典组成，按照字典中的key划分不同的小组存在这个数组里面
 *
 *  @param array 由字典组成的数组
 *  @param key   字典中的某个key
 *
 *  @return 分组后的数组
 */

+(NSMutableArray*)sortArray:(NSMutableArray*)array byKey:(NSString*)key;

/**
 *  画三条线的图画
 *
 *  @return
 */

+(UIImage*)homepageImage;

-(NSDate *)dateStartOfWeek:(NSDate *)date;          //获取当前星期的第一天的时间戳



-(NSString* )getDateString:(NSDate *)date;           //获取时间戳

-(NSDate* )getStartOfMonth:(NSDate *)date;          //获取当月第一天

//+ (NSString *)timeUptoNowFrom:(int)timestamp;
/**
 *  navigation 中间的view，即title
 *
 *  @param titleTextStr title的名字
 *
 *  @return
 */
+(UILabel*)setTitleView:(NSString*)titleTextStr;

/**
 *  通过pic的url获得转变后的文件路径，和sdwebimage里面存的路径一致
 *
 *  @param picURL 下载图片的url地址
 *
 *  @return 下载之后的路径名
 */
+(NSString*)convertCCMD5Path:(NSString*)picURL;

/**
 *  将数组转换成string，以逗号（，）隔开
 *
 *  @param array 数组
 *
 *  @return 以，隔开的字符串
 */

+(NSString*)stringWithArray:(NSMutableArray*)array;

/**
 *  用filename当文件名创造一个文件
 *
 *  @param fileName 文件名
 */

+(void)createFileWithName:(NSString*)fileName;

/**
 *  根据文件名找到相应的路径
 *
 *  @param fileName 文件名
 *
 *  @return 相应的路径
 */

+(NSString*)fullPathWithFileName:(NSString*)fileName;

+(NSString *)ttimeUptoNowFrom:(NSInteger)timestamp;

/**
 *  把图片压缩成宽度为w 高为h的
 *
 *  @param image 要压缩的图片
 *  @param h     压缩之后的高度
 *  @param w     压缩之后的宽度
 *
 *  @return 压缩之后的图片
 */

+(UIImage *)scaleImage:(UIImage *)image toHeight:(float)h toWidth:(float)w;

//- (void)defaultReciveSummaryPerson:(NSString *)defaultReciveSummaryPerson BySectionId:(NSString* )sectionId;
//- (NSString* )defaultReciveSummaryPersonbySectionId:(NSString* )sectionID;


+ (float)getContentSizeHeightForTextView:(UITextView *)textView;

+ (CGFloat)getText:(NSString *)text MinHeightWithBoundsWidth:(CGFloat)width fontSize:(CGFloat)fontSize;





+ (BOOL) IsEnableWIFI;

//图标右上角数字-1

+(void) minusIconBadgeNumber;

+ (UIBarButtonItem *)getBarButtonItemWithTitle:(NSString *)aTitle  target:(id)aTarget selector:(SEL)aSelector;






+(NSInteger)getDateInteger:(NSDate *)date;
+(NSString* )getDateString:(NSDate *)date;           //获取时间戳






@end
