//
//  CategoryCollectionCollectionViewCell.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 8/1/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UILabel *borderLbl;
@property (strong, nonatomic) IBOutlet UIView *cellView;

@end
