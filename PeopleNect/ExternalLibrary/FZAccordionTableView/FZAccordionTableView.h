//
//  FZAccordionTableView.h
//  FZAccordionTableView

#import <UIKit/UIKit.h>

@interface FZAccordionTableViewHeaderView : UITableViewHeaderFooterView

@end

@interface FZAccordionTableView : UITableView

/*!
 @desc  If set to NO, a max of one section will be open at a time.
 
        If set to YES, any amount of sections can be open at a time.
 
        Use 'sectionsInitiallyOpen' to specify which section should be
        open at the start, otherwise, all sections will be closed at
        the start even if the property is set to YES.
 
        The default value is NO.
 */
@property (nonatomic) BOOL allowMultipleSectionsOpen;

/*!
 @desc  If set to YES, one section will always be open.
 
        If set to NO, all sections can be closed.
 
        Use 'sectionsInitiallyOpen' to specify which section should be
        open at the start, otherwise, all sections will be closed at 
        the start even if the property is set to YES.
 
        The default value is NO.
 */
@property (nonatomic) BOOL keepOneSectionOpen;

/*!
 @desc  Defines which sections should be open the first time the
        table is shown.
 
        Must be set before any data is loaded.
 */
@property (strong, nonatomic, nullable) NSSet <NSNumber *> *initialOpenSections;

/*!
 @desc  Enables the fading of cells for the last two rows of the
        table. The fix can remove some of the animation clunkyness
        that happens at the last table view cells.
    
        The default value is NO.
 */
@property (nonatomic) BOOL enableAnimationFix;

/*!
 @desc  Checks whether the provided section is open.
 
 @param section The section that needs to be checked if it's open.
 
 @returns YES if the section is open, otherwise NO.
 */
- (BOOL)isSectionOpen:(NSInteger)section;

/*!
 @desc  Simulates tapping of the header in the provided section.
 
 @param section The section whose header should be 'tapped.'
 */
- (void)toggleSection:(NSInteger)section;

/*!
 @desc  Finds the section of a header view.
 
 @param headerView The header view whose section must be found.
 
 @returns The section of the header view.
 */
- (NSInteger)sectionForHeaderView:(nonnull UITableViewHeaderFooterView *)headerView;

@end

/*!
 `header` can be `nil` in some of the delegate methods if the header
 is not visible.
 */
@protocol FZAccordionTableViewDelegate <NSObject>

@optional

/*!
 @desc  Implement to respond to which sections can be interacted with.
 
        If NO is returned for a section, the section can neither be opened or closed. 
        It stays in it's initial state no matter what.
 
        Use 'initialOpenSections' to mark a section open from the start.
 
        The default return value is YES.
 */
- (BOOL)tableView:(nonnull FZAccordionTableView *)tableView canInteractWithHeaderAtSection:(NSInteger)section;

- (void)tableView:(nonnull FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(nullable UITableViewHeaderFooterView *)header;
- (void)tableView:(nonnull FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(nullable UITableViewHeaderFooterView *)header;

- (void)tableView:(nonnull FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(nullable UITableViewHeaderFooterView *)header;
- (void)tableView:(nonnull FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(nullable UITableViewHeaderFooterView *)header;

@end
