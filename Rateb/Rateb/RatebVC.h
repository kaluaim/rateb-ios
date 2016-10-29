#import <UIKit/UIKit.h>

@interface RatebVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *remainingToRateb;


// Current Dates
@property (weak, nonatomic) IBOutlet UIView  *viewCurrentDates;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentDates;

// Gregorian
@property (weak, nonatomic) IBOutlet UILabel *currentGDay;
@property (weak, nonatomic) IBOutlet UILabel *currentGMonth;
@property (weak, nonatomic) IBOutlet UILabel *currentGYear;

// Hijri Lunar
@property (weak, nonatomic) IBOutlet UILabel *currentHLDay;
@property (weak, nonatomic) IBOutlet UILabel *currentHLMonth;
@property (weak, nonatomic) IBOutlet UILabel *currentHLYear;

// Hijri Solar
@property (weak, nonatomic) IBOutlet UILabel *currentHSDay;
@property (weak, nonatomic) IBOutlet UILabel *currentHSMonth;
@property (weak, nonatomic) IBOutlet UILabel *currentHSYear;


// Rateb Dates
// Gregorian
@property (weak, nonatomic) IBOutlet UILabel *ratebGDay;
@property (weak, nonatomic) IBOutlet UILabel *ratebGMonth;
@property (weak, nonatomic) IBOutlet UILabel *ratebGYear;

// Hijri Lunar
@property (weak, nonatomic) IBOutlet UILabel *ratebHLDay;
@property (weak, nonatomic) IBOutlet UILabel *ratebHLMonth;
@property (weak, nonatomic) IBOutlet UILabel *ratebHLYear;

// Hijri Solar
@property (weak, nonatomic) IBOutlet UILabel *ratebHSDay;
@property (weak, nonatomic) IBOutlet UILabel *ratebHSMonth;
@property (weak, nonatomic) IBOutlet UILabel *ratebHSYear;

@end

