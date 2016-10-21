#import "InfoVC.h"

@interface InfoVC ()

@end

@implementation InfoVC

- (IBAction)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goToKaluaim {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://kalua.im"] options:@{} completionHandler:nil];

}

- (IBAction)goToUmmulqura {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ummulqura.org.sa/"] options:@{} completionHandler:nil];
    
}

- (IBAction)goToFouad {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/engineer_fouad"] options:@{} completionHandler:nil];
    
}
@end
