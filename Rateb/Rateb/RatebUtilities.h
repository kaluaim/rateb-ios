#import <Foundation/Foundation.h>

@interface RatebUtilities : NSObject
- (NSDate *)retrivenNextRatebFromCurrentSolarHijriDay:(NSInteger)day month:(NSInteger)month andYear:(NSInteger)year;
- (NSString *)monthNameForMonthNumber:(NSInteger)monthNumber andCalendar:(NSCalendar *)calendar;
- (NSInteger)calculateDaysLeftToNextRatebDate:(NSDate *)ratebDate;
- (NSString *)localizeGregorianMonth:(NSInteger)month;
- (NSString *)localizeHijriLunarMonth:(NSInteger)month;
- (NSString *)localizeHijriSolarMonth:(NSInteger)month;
@end
