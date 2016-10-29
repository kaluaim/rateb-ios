#import "InfoFooterCell.h"

@implementation InfoFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.userInteractionEnabled = NO;
}
@end
