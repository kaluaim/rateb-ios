#import "RatebVC.h"
#import "RatebUtilities.h"

@interface RatebVC ()
@property (strong, nonatomic) RatebUtilities    *ratebUtilities;
@property (strong, nonatomic) NSCalendar        *calendarGregorian;
@property (strong, nonatomic) NSCalendar        *calendarHijriLunar;
@property (strong, nonatomic) NSCalendar        *calendarHijriSolar;
@end

@implementation RatebVC


- (void)viewDidLoad {
    [super viewDidLoad];
    _ratebUtilities     = [[RatebUtilities alloc] init];
    _calendarGregorian  = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _calendarHijriLunar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    _calendarHijriSolar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierPersian];
    
    // to detect when the application goes into forground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRateb) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    _viewCurrentDates.layer.cornerRadius = 10;
    _viewCurrentDates.layer.masksToBounds = YES;
    
    // Hide current dates for iPhone 5s and less
    if (self.view.bounds.size.height < 570) {
        _viewCurrentDates.hidden = YES;
        _labelCurrentDates.hidden = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self updateRateb];
}

- (void)updateRateb {
    [self setupCurrentDates];
    NSDateComponents *hijriSolarComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierPersian] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    NSDate *nextRatebDate = [_ratebUtilities retrivenNextRatebFromCurrentSolarHijriDay:[hijriSolarComponents day]
                                                                                 month:[hijriSolarComponents month]
                                                                               andYear:[hijriSolarComponents year]];
    [self setupRemainingToRatebDate:nextRatebDate];
    [self setupRatebDatesForDate:nextRatebDate];
}

- (void)setupCurrentDates {
    NSDateComponents *currentGregorianComponents = [_calendarGregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    _currentGDay.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[currentGregorianComponents day]] numberStyle:NSNumberFormatterNoStyle];
    _currentGMonth.text = [_ratebUtilities localizeGregorianMonth:[currentGregorianComponents month]];
    _currentGYear.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[currentGregorianComponents year]] numberStyle:NSNumberFormatterNoStyle];
    
    NSDateComponents *currentHijriLunarComponents = [_calendarHijriLunar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    _currentHLDay.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[currentHijriLunarComponents day]] numberStyle:NSNumberFormatterNoStyle];
    _currentHLMonth.text = [_ratebUtilities localizeHijriLunarMonth:[currentHijriLunarComponents month]];
    _currentHLYear.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[currentHijriLunarComponents year]] numberStyle:NSNumberFormatterNoStyle];
    
    NSDateComponents *currentHijriSolarComponents = [_calendarHijriSolar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    _currentHSDay.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[currentHijriSolarComponents day]] numberStyle:NSNumberFormatterNoStyle];
    _currentHSMonth.text = [_ratebUtilities localizeHijriSolarMonth:[currentHijriSolarComponents month]];
    _currentHSYear.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[currentHijriSolarComponents year]] numberStyle:NSNumberFormatterNoStyle];
}

- (void)setupRemainingToRatebDate:(NSDate *)ratebDate {
    NSInteger daysLeftToRateb = [_ratebUtilities calculateDaysLeftToNextRatebDate:ratebDate];
    _remainingToRateb.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:daysLeftToRateb] numberStyle:NSNumberFormatterNoStyle];
}

- (void)setupRatebDatesForDate:(NSDate *)ratebDate {
    NSDateComponents *ratebGregorianComponents = [_calendarGregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:ratebDate];
    _ratebGDay.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[ratebGregorianComponents day]] numberStyle:NSNumberFormatterNoStyle];
    _ratebGMonth.text = [_ratebUtilities localizeGregorianMonth:[ratebGregorianComponents month]];
    _ratebGYear.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[ratebGregorianComponents year]] numberStyle:NSNumberFormatterNoStyle];
    
    NSDateComponents *ratebHijriLunarComponents = [_calendarHijriLunar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:ratebDate];
    _ratebHLDay.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[ratebHijriLunarComponents day]] numberStyle:NSNumberFormatterNoStyle];
    _ratebHLMonth.text = [_ratebUtilities localizeHijriLunarMonth:[ratebHijriLunarComponents month]];
    _ratebHLYear.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[ratebHijriLunarComponents year]] numberStyle:NSNumberFormatterNoStyle];
    
    NSDateComponents *ratebHijriSolarComponents = [_calendarHijriSolar components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:ratebDate];
    _ratebHSDay.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[ratebHijriSolarComponents day]] numberStyle:NSNumberFormatterNoStyle];
    _ratebHSMonth.text = [_ratebUtilities localizeHijriSolarMonth:[ratebHijriSolarComponents month]];
    _ratebHSYear.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:[ratebHijriSolarComponents year]] numberStyle:NSNumberFormatterNoStyle];
}



@end
