#import "RatebWidgetVC.h"
#import <NotificationCenter/NotificationCenter.h>
#import <RatebLib/RatebUtilities.h>

@interface RatebWidgetVC () <NCWidgetProviding>
@property (strong, nonatomic) RatebUtilities *ratebUtilities;
@end

@implementation RatebWidgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _ratebUtilities = [[RatebUtilities alloc] init];
    NSBundle *bundle = [NSBundle mainBundle];
    
    if ([[bundle.bundleURL pathExtension] isEqualToString:@"appex"]) {
        // Peel off two directory levels - MY_APP.app/PlugIns/MY_APP_EXTENSION.appex
        bundle = [NSBundle bundleWithURL:[[bundle.bundleURL URLByDeletingLastPathComponent] URLByDeletingLastPathComponent]];
    }
    
    NSString* ummulquraDatesPath = [bundle pathForResource:@"UmmulquraDates" ofType:@"json"];
    NSString *ummulquraDatesJSON = [[NSString alloc] initWithContentsOfFile:ummulquraDatesPath encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *ummulquraDatesDictionary = [NSJSONSerialization JSONObjectWithData:[ummulquraDatesJSON dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    _ratebUtilities.ummulquraDates = ummulquraDatesDictionary;
    [self updateRateb];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    NSLog(@"====================> widgetPerformUpdateWithCompletionHandler");
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    [self updateRateb];
    completionHandler(NCUpdateResultNewData);
}

- (void)updateRateb {
    NSLog(@"====================> updateRateb");
    NSDateComponents *hijriLunarComponents = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura] components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:[NSDate date]];
    NSDate *nextRatebDate = [_ratebUtilities retrivenNextRatebFromCurrentHijriLunarDay:[hijriLunarComponents day]
                                                                                 month:[hijriLunarComponents month]
                                                                               andYear:[hijriLunarComponents year]];
    [self setupRemainingToRatebDate:nextRatebDate];
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

- (IBAction)openApp {
    NSLog(@"====================> openApp");
    NSURL *url = [NSURL URLWithString:@"rateb://"];
    [self.extensionContext openURL:url completionHandler:nil];
}
@end
