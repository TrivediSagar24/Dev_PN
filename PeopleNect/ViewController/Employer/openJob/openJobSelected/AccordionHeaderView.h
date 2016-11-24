//
//  AccordionHeaderView.h
//  FZAccordionTableViewExample
//


#import "FZAccordionTableView.h"

static const CGFloat kDefaultAccordionHeaderViewHeight = 44.0;

static NSString *const kAccordionHeaderViewReuseIdentifier = @"AccordionHeaderViewReuseIdentifier";

@interface AccordionHeaderView : FZAccordionTableViewHeaderView
@property (strong, nonatomic) IBOutlet UILabel *headerlabel;
@property (strong, nonatomic) IBOutlet UILabel *totalValueLbl;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *OpenJobLbl;
@property (strong, nonatomic) IBOutlet UIImageView *rightArrowImg;
@property (strong, nonatomic) IBOutlet UIImageView *openJobImage;
@end
