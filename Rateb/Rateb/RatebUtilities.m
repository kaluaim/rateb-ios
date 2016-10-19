#import "RatebUtilities.h"

@implementation RatebUtilities

- (NSDate *)retrivenNextRatebFromCurrentSolarHijriDay:(NSInteger)day month:(NSInteger)month andYear:(NSInteger)year {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierPersian]];
    [dateComponents setDay:5];
    [dateComponents setMonth:month];
    [dateComponents setYear:year];
    
    if (day > 5) {
        [dateComponents setMonth:month+1];
        if (month == 12) {
            [dateComponents setMonth:1];
            [dateComponents setYear:year+1];
        }
    }
    
    NSDate *ratebDate = [dateComponents date];
    return ratebDate;
}

- (NSString *)monthNameForMonthNumber:(NSInteger)monthNumber andCalendar:(NSCalendar *)calendar {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"AST"]];
    [formatter setCalendar:calendar];
    NSArray *monthNames = [formatter standaloneMonthSymbols];
    NSString *monthName = [monthNames objectAtIndex:(monthNumber - 1)];
    return monthName;
}

- (NSInteger)calculateDaysLeftToNextRatebDate:(NSDate *)ratebDate {
    NSDate * selected = ratebDate;
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [gregorian components: NSCalendarUnitDay
                                           fromDate: [NSDate date]
                                             toDate: selected
                                            options: 0];
    return [dateComponents day];
}

- (NSString *)localizeGregorianMonth:(NSInteger)month {
    
    switch (month) {
        case 1:
            return NSLocalizedString(@"MONTH_GREGORIAN_JANUARY", nil);
            break;
            
        case 2:
            return NSLocalizedString(@"MONTH_GREGORIAN_FEBRUARY", nil);
            break;
            
        case 3:
            return NSLocalizedString(@"MONTH_GREGORIAN_MARCH", nil);
            break;
            
        case 4:
            return NSLocalizedString(@"MONTH_GREGORIAN_APRIL", nil);
            break;
            
        case 5:
            return NSLocalizedString(@"MONTH_GREGORIAN_MAY", nil);
            break;
            
        case 6:
            return NSLocalizedString(@"MONTH_GREGORIAN_JUNE", nil);
            break;
            
        case 7:
            return NSLocalizedString(@"MONTH_GREGORIAN_JULY", nil);
            break;
            
        case 8:
            return NSLocalizedString(@"MONTH_GREGORIAN_AUGUST", nil);
            break;
            
        case 9:
            return NSLocalizedString(@"MONTH_GREGORIAN_SEPTEMBER", nil);
            break;
            
        case 10:
            return NSLocalizedString(@"MONTH_GREGORIAN_OCTOBER", nil);
            break;
            
        case 11:
            return NSLocalizedString(@"MONTH_GREGORIAN_NOVEMBER", nil);
            break;
            
        case 12:
            return NSLocalizedString(@"MONTH_GREGORIAN_DECEMBER", nil);
            break;
            
        default:
            return @"";
            break;
    }
    
}


- (NSString *)localizeHijriLunarMonth:(NSInteger)month {
    
    switch (month) {
        case 1:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_MUHARRAM", nil);
            break;
            
        case 2:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_SAFAR", nil);
            break;
            
        case 3:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RABI_ALAWWAL", nil);
            break;
            
        case 4:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RABI_ALTHANI", nil);
            break;
            
        case 5:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_JUMADA_ALAWWAL", nil);
            break;
            
        case 6:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_JUMAADA_ALAKHIR", nil);
            break;
            
        case 7:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RAJAB", nil);
            break;
            
        case 8:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_SHABAN", nil);
            break;
            
        case 9:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RAMADAN", nil);
            break;
            
        case 10:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_SHAWWAL", nil);
            break;
            
        case 11:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_DHU_ALQIDAH", nil);
            break;
            
        case 12:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_DHU_ALHIJJAH", nil);
            break;
            
        default:
            return @"";
            break;
    }
    
}

- (NSString *)localizeHijriSolarMonth:(NSInteger)month {
    
    switch (month) {
        case 1:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_ARIES", nil);
            break;
            
        case 2:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_TAURUS", nil);
            break;
            
        case 3:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_GEMINI", nil);
            break;
            
        case 4:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_CANCER", nil);
            break;
            
        case 5:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_LEO", nil);
            break;
            
        case 6:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_VIRGO", nil);
            break;
            
        case 7:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_LIBRA", nil);
            break;
            
        case 8:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_SCORPIO", nil);
            break;
            
        case 9:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_SAGITTARIUS", nil);
            break;
            
        case 10:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_CAPRICORN", nil);
            break;
            
        case 11:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_AQUARIUS", nil);
            break;
            
        case 12:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_PISCES", nil);
            break;
            
        default:
            return @"";
            break;
    }
    
}
@end
