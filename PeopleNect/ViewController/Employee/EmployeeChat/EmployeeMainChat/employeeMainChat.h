//
//  employeeMainChat.h
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessagesViewController.h>
#import "GlobalMethods.h"
#import "PN_Constants.h"
#import "employeeChat.h"
@class employeeMainChat;

@protocol JSQDemoViewControllerDelegate <NSObject>


- (void)didDismissJSQDemoViewController:(employeeMainChat *)vc;

@end

@interface employeeMainChat : JSQMessagesViewController

<JSQMessagesCollectionViewDataSource,
JSQMessagesCollectionViewDelegateFlowLayout,
UITextViewDelegate,JSQMessagesComposerTextViewPasteDelegate>


@property (weak, nonatomic) id<JSQDemoViewControllerDelegate> delegateModal;


@property(nonatomic,strong) UIImageView *ProfieImage;
@property(nonatomic,strong) UILabel * userName;
@property(nonatomic,strong) UILabel * userCompanyName;
@property(nonatomic,strong) NSMutableArray *arrayHistory;
@property(nonatomic,strong) NSMutableDictionary *FromEmployerInvite;




@end
