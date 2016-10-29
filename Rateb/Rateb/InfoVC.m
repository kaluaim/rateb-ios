#import "InfoVC.h"
#import "DetailDisclosureCell.h"
#import "InfoFooterCell.h"

@interface InfoVC ()

@end

@implementation InfoVC
NSString *const kDetailDisclosureCell   = @"DetailDisclosureCell";
NSString *const kInfoFooterCell         = @"InfoFooterCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:kDetailDisclosureCell bundle:nil] forCellReuseIdentifier:kDetailDisclosureCell];
    [_tableView registerNib:[UINib nibWithNibName:kInfoFooterCell bundle:nil] forCellReuseIdentifier:kInfoFooterCell];
}


#pragma -mark TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return 1;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 4;}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {return NSLocalizedString(@"INFO_SECTION_TITLE", nil);}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailDisclosureCell *detailDisclosureCell;
    InfoFooterCell *infoFooterCell;
    
    @try {
        
        if(indexPath.section == 0) {
            
            switch (indexPath.row) {
                case 0:
                    detailDisclosureCell = [tableView dequeueReusableCellWithIdentifier:kDetailDisclosureCell forIndexPath:indexPath];
                    detailDisclosureCell.cTitle.text = NSLocalizedString(@"INFO_DEVELOPER_TITLE", nil);
                    detailDisclosureCell.cDetail.text = NSLocalizedString(@"INFO_DEVELOPER_DETAIL", nil);
                    return detailDisclosureCell;
                    break;
                    
                case 1:
                    detailDisclosureCell = [tableView dequeueReusableCellWithIdentifier:kDetailDisclosureCell forIndexPath:indexPath];
                    detailDisclosureCell.cTitle.text = NSLocalizedString(@"INFO_SOURCE_TITLE", nil);
                    detailDisclosureCell.cDetail.text = NSLocalizedString(@"INFO_SOURCE_DETAIL", nil);
                    return detailDisclosureCell;
                    break;
                    
                case 2:
                    detailDisclosureCell = [tableView dequeueReusableCellWithIdentifier:kDetailDisclosureCell forIndexPath:indexPath];
                    detailDisclosureCell.cTitle.text = NSLocalizedString(@"INFO_PREPARED_BY_TITLE", nil);
                    detailDisclosureCell.cDetail.text = NSLocalizedString(@"INFO_PREPARED_BY_DETAIL", nil);
                    return detailDisclosureCell;
                    break;
                    
                case 3:
                    infoFooterCell = [tableView dequeueReusableCellWithIdentifier:kInfoFooterCell forIndexPath:indexPath];
                    return infoFooterCell;
                    break;
                    
                default:
                    break;
            }
            
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR: %@", exception);
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0: [self goToKaluaim]; break;
        case 1: [self goToUmmulqura]; break;
        case 2: [self goToFouad]; break;
        default: break;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        return 120;
    }
    
    return 44;
}

- (void)goToKaluaim {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://kalua.im"] options:@{} completionHandler:nil];

}

- (void)goToUmmulqura {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ummulqura.org.sa/"] options:@{} completionHandler:nil];
    
}

- (void)goToFouad {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/engineer_fouad"] options:@{} completionHandler:nil];
    
}
@end
