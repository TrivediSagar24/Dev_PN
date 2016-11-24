//
//  ViewController.m
//  PeopleNect
//
//  Created by Trivedi Sagar on 26/07/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "ViewController.h"
#import "LCAnimatedPageControl.h"
#import "PN_Constants.h"
#import "employeeViewController.h"
#import "IntroductionCell.h"
#import "employerViewController.h"
#import "subCategoryCtr.h"
#import "employeeLoginCtr.h"
#import "SplashEmployerCtr.h"
#import "SlideNavigationController.h"

@interface ViewController ()
@property (strong, nonatomic) LCAnimatedPageControl *pageControl;

@end

@implementation ViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.pageCollection registerNib:[UINib nibWithNibName:@"IntroductionCell" bundle:nil] forCellWithReuseIdentifier:@"IntroductionCell"];
    
    
    
    /*------  START Custom Page Indicator Controller  ------*/
    
    self.pageControl = [[LCAnimatedPageControl alloc] initWithFrame:CGRectMake(0, 0, _pageIndicator.frame.size.width, _pageIndicator.frame.size.height)];
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.indicatorDiameter = 8.0f;
    self.pageControl.indicatorMargin = 10.0f;
    self.pageControl.indicatorMultiple = 1.4;
    self.pageControl.pageStyle = LCDepthColorPageStyle;
    self.pageControl.pageIndicatorColor = [UIColor lightGrayColor];
    
  
    
    self.pageControl.currentPageIndicatorColor = [UIColor whiteColor];
    self.pageControl.sourceScrollView = self.pageCollection;
    [self.pageControl prepareShow];
    [self.pageIndicator addSubview:_pageControl];
    
    [self.pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    /*------  END Custom Page Indicator Controller  ------*/
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

#pragma mark - Collection Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntroductionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IntroductionCell" forIndexPath:indexPath];
    switch (indexPath.item) {
        case 0:
            cell.imgLogo.image = [UIImage imageNamed:@"page-1"];
            cell.lblDetail.text = @"Tell us what kind of work you can offer";
            break;
        case 1:
            cell.imgLogo.image = [UIImage imageNamed:@"page-2"];
            cell.lblDetail.text = @"Tell us what kind of work you can offer";
            break;
            
        case 2:
            cell.imgLogo.image = [UIImage imageNamed:@"page-3"];
            cell.lblDetail.text = @"Tell us what kind of work you can offer";
            break;
        default:
            break;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.pageCollection.frame.size.width, self.pageCollection.frame.size.height);
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSInteger currentIndex = self.pageCollection.contentOffset.x / self.pageCollection.frame.size.width;
//    self.pageCollection.currentPage = currentIndex;
//    
//}

#pragma mark - IBActions
- (IBAction)btnRegisterClick:(id)sender
{
    employeeViewController *obj_employeeViewController = [self.storyboard  instantiateViewControllerWithIdentifier:@"employeeViewController"];

    [self.navigationController pushViewController:obj_employeeViewController animated:YES ];
    
}

- (IBAction)btnAlreadyClick:(id)sender
{
  
    employeeLoginCtr *obj_employeeLoginCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"employeeLoginCtr"];
    
    [self.navigationController pushViewController:obj_employeeLoginCtr animated:YES];
 
}

- (IBAction)btnProfessionalClick:(id)sender
{
     [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"EmployeeUserId"];
    SplashEmployerCtr *objSplashEmployerCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"SplashEmployerCtr"];

    CATransition* transition = [CATransition animation];
    transition.duration = 0.0;
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    [self.navigationController pushViewController:objSplashEmployerCtr animated:NO];
}
    

- (void)valueChanged:(LCAnimatedPageControl *)sender{
    //    NSLog(@"%d", sender.currentPage);
    [self.pageCollection setContentOffset:CGPointMake(self.pageCollection.frame.size.width * (sender.currentPage + 0), self.pageCollection.contentOffset.y) animated:YES];
}


@end
