#import "RatebVC.h"
#import <RatebLib/RatebUtilities.h>
#import "MZFormSheetPresentationViewControllerSegue.h"

@interface RatebVC ()
@property (strong, nonatomic) RatebUtilities    *ratebUtilities;
@property (strong, nonatomic) NSCalendar        *calendarGregorian;
@property (strong, nonatomic) NSCalendar        *calendarHijriLunar;
@property (strong, nonatomic) NSCalendar        *calendarHijriSolar;
@property (strong, nonatomic) NSDictionary      *currentHijriSolar;
@property (strong, nonatomic) NSDictionary      *ratebHijriSolar;
@end

@implementation RatebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _ratebUtilities     = [[RatebUtilities alloc] init];
    NSString* ummulquraDatesPath = [[NSBundle mainBundle] pathForResource:@"UmmulquraDates" ofType:@"json"];
    NSString *ummulquraDatesJSON = [[NSString alloc] initWithContentsOfFile:ummulquraDatesPath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *ummulquraDatesDictionary = [NSJSONSerialization JSONObjectWithData:[ummulquraDatesJSON dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    _ratebUtilities.ummulquraDates = ummulquraDatesDictionary;
    _calendarGregorian  = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    _calendarHijriLunar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
    _calendarHijriSolar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierPersian];
    
    // to detect when the application goes into forground
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateRateb) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    _viewCurrentDates.layer.cornerRadius = 10;
    _viewCurrentDates.layer.masksToBounds = YES;
    
    // Hide current dates for iPhone 5s and less
    if (self.view.bounds.size.height < 500) {
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
    NSDateComponents *hijriLunarComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    NSDate *nextRatebDate = [_ratebUtilities retrivenNextRatebFromCurrentHijriLunarDay:[hijriLunarComponents day]
                                                                                 month:[hijriLunarComponents month]
                                                                               andYear:[hijriLunarComponents year]];
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
    
    _currentHijriSolar = [_ratebUtilities retrivenHijriSolarDateForHijriLunarDay:[currentHijriLunarComponents day] month:[currentHijriLunarComponents month] andYear:[currentHijriLunarComponents year]];
    _currentHSDay.text = [NSNumberFormatter localizedStringFromNumber:[_currentHijriSolar objectForKey:kSolarDay] numberStyle:NSNumberFormatterNoStyle];
    _currentHSMonth.text = NSLocalizedString([_currentHijriSolar objectForKey:kSolarMonth], nil);;
    _currentHSYear.text = [NSNumberFormatter localizedStringFromNumber:[_currentHijriSolar objectForKey:kSolarYear] numberStyle:NSNumberFormatterNoStyle];
}

- (void)setupRemainingToRatebDate:(NSDate *)ratebDate {
    NSInteger daysLeftToRateb = [_ratebUtilities calculateDaysLeftToNextRatebDate:ratebDate];

    if (daysLeftToRateb == 0) {
        _remainingToRateb.text = NSLocalizedString(@"RATEB_TODAY", nil);
    } else if (daysLeftToRateb == 1) {
        _remainingToRateb.text = NSLocalizedString(@"RATEB_TOMORROW", nil);
    } else {
        _remainingToRateb.text = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithInteger:daysLeftToRateb] numberStyle:NSNumberFormatterNoStyle];
    }
    
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
    
    _ratebHijriSolar = [_ratebUtilities retrivenHijriSolarDateForHijriLunarDay:[ratebHijriLunarComponents day] month:[ratebHijriLunarComponents month] andYear:[ratebHijriLunarComponents year]];
    _ratebHSDay.text = [NSNumberFormatter localizedStringFromNumber:[_ratebHijriSolar objectForKey:kSolarDay] numberStyle:NSNumberFormatterNoStyle];
    _ratebHSMonth.text = NSLocalizedString([_ratebHijriSolar objectForKey:kSolarMonth], nil);;
    _ratebHSYear.text = [NSNumberFormatter localizedStringFromNumber:[_ratebHijriSolar objectForKey:kSolarYear] numberStyle:NSNumberFormatterNoStyle];
}


#pragma mark- Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"info"]) {
        MZFormSheetPresentationViewControllerSegue *infoSegue = (id)segue;
        infoSegue.formSheetPresentationController.presentationController.shouldApplyBackgroundBlurEffect = NO;
        infoSegue.formSheetPresentationController.contentViewControllerTransitionStyle = MZFormSheetPresentationTransitionStyleFade;
        infoSegue.formSheetPresentationController.contentViewCornerRadius = 10.0f;
        infoSegue.formSheetPresentationController.presentationController.contentViewSize = CGSizeMake(300, 350);
        infoSegue.formSheetPresentationController.presentationController.shouldDismissOnBackgroundViewTap = YES;
    }
}

@end
