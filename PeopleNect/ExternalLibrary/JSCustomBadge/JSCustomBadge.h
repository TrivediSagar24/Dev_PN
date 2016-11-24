//
//  JSCustomBadge.h

#import <UIKit/UIKit.h>

@interface JSCustomBadge : UIView

@property (strong, nonatomic) NSString *badgeText;
@property (strong, nonatomic) UIColor *badgeTextColor;
@property (strong, nonatomic) UIColor *badgeInsetColor;
@property (strong, nonatomic) UIColor *badgeFrameColor;

@property (assign, nonatomic) BOOL badgeFrame;
@property (assign, nonatomic) BOOL badgeShining;
@property (assign, nonatomic) BOOL badgeShadow;

@property (assign, nonatomic) CGFloat badgeCornerRoundness;
@property (assign, nonatomic) CGFloat badgeScaleFactor;

+ (JSCustomBadge *)customBadgeWithString:(NSString *)badgeString;

+ (JSCustomBadge *)customBadgeWithString:(NSString *)badgeString
                         withStringColor:(UIColor*)stringColor
                          withInsetColor:(UIColor*)insetColor
                          withBadgeFrame:(BOOL)badgeFrameYesNo
                     withBadgeFrameColor:(UIColor*)frameColor
                               withScale:(CGFloat)scale
                             withShining:(BOOL)shining
                              withShadow:(BOOL)shadow;

// Use to change the badge text after the first rendering
- (void)autoBadgeSizeWithString:(NSString *)badgeString;

@end
