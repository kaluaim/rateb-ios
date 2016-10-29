#import "DetailDisclosureCell.h"

@implementation DetailDisclosureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _cTitle.lineBreakMode = NSLineBreakByWordWrapping;
    _cTitle.numberOfLines = 0;
    //_cTitle.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    _cDetail.lineBreakMode = NSLineBreakByWordWrapping;
    _cDetail.numberOfLines = 0;
    //_cDetail.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

@end
