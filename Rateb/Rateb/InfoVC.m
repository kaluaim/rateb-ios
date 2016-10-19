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
@end
