//
//  SplashEmployerCtr.m
//  PeopleNect
//
//  Created by Apple on 10/08/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//
#import "LCAnimatedPageControl.h"
#import "SplashEmployerCtr.h"
#import "employerViewController.h"
#import "SplashEmployerCell.h"
#import "EmployerLoginCtr.h"



@interface SplashEmployerCtr ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>{
    NSArray *lblArray,*imgArray ;

    }
@end


@implementation SplashEmployerCtr

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*--------Array of label and images ----------*/
    lblArray = [[NSArray alloc]init];
    imgArray = [[NSArray alloc] init];
    
    lblArray = @[@"POST YOUR JOB",@"Search available professionals",@"Ready!Now, let's get the job done" ];
    imgArray = @[@"post_job.png",@"busque_3.png",@"chart.png"];
    
    /*---------Hiding Navigation bar--------*/
    self.navigationController.navigationBarHidden = YES;
    
      /*------  START Custom Page Indicator Controller  ------*/
    self.pageControl = [[LCAnimatedPageControl alloc] initWithFrame:CGRectMake(0, 0, _pageIndicator.frame.size.width, _pageIndicator.frame.size.height)];
    
    self.pageControl.numberOfPages = 3;
    self.pageControl.indicatorDiameter = 8.0f;
    self.pageControl.indicatorMargin = 10.0f;
    self.pageControl.indicatorMultiple = 1.4;
    self.pageControl.pageStyle = LCDepthColorPageStyle;
    self.pageControl.pageIndicatorColor = [UIColor lightGrayColor];
    
    self.pageControl.currentPageIndicatorColor = [UIColor whiteColor];
    self.pageControl.sourceScrollView = self.objCollectionViewCtr;
    [self.pageControl prepareShow];
    [self.pageIndicator addSubview:_pageControl];
    
    [self.pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    /*------  END Custom Page Indicator Controller  ------*/
    
//    employeeSlideNavigation *leftMenu = (employeeSlideNavigation*)[self.storyboard instantiateViewControllerWithIdentifier: @"employeeSlideNavigation"];
//    
//    [SlideNavigationController sharedInstance].leftMenu = leftMenu;
//    [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Collection View Delegates
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SplashEmployerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SplashEmployerCell" forIndexPath:indexPath];
    
  
    cell.lbl.text =[lblArray objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[imgArray objectAtIndex:indexPath.row]];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.objCollectionViewCtr.frame.size.width, self.objCollectionViewCtr.frame.size.height);
}




#pragma  mark - Register
- (IBAction)onClickRegister:(id)sender {
    
    employerViewController *obj_employerViewController = [self.storyboard  instantiateViewControllerWithIdentifier:@"employerViewController"];
    [self.navigationController pushViewController:obj_employerViewController animated:YES];
    
}


- (IBAction)onClickProfessional:(id)sender {
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    ViewController *objViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self.navigationController pushViewController:objViewController animated:YES];
    
    
    
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.4f;
//    transition.type = kCATransitionReveal;
//    transition.subtype = kCATransitionFromBottom;
//    [self.navigationController.view.layer addAnimation:transition
//    forKey:kCATransition];
//    
//    //[self.navigationController popViewControllerAnimated:NO];
//    
//    for (UIViewController *viewControllrObj in self.navigationController.viewControllers)
//    {
//        if ([viewControllrObj isKindOfClass:[ViewController class]])
//        {
//            [self.navigationController popToViewController:viewControllrObj animated:YES];
//        }
//    }
//

}


- (IBAction)onClickRegistered:(id)sender{
    
    EmployerLoginCtr *obj_EmployerLoginCtr= [self.storyboard instantiateViewControllerWithIdentifier:@"EmployerLoginCtr"];
    [self.navigationController pushViewController:obj_EmployerLoginCtr animated:YES];
}


- (void)valueChanged:(LCAnimatedPageControl *)sender{
    //    NSLog(@"%d", sender.currentPage);
    [self.objCollectionViewCtr setContentOffset:CGPointMake(self.objCollectionViewCtr.frame.size.width * (sender.currentPage + 0), self.objCollectionViewCtr.contentOffset.y) animated:YES];
}

@end
