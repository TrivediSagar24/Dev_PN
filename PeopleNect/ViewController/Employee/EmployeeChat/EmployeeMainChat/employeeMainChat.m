//
//  employeeMainChat.m
//  PeopleNect
//
//  Created by Lokesh Dudhat on 9/12/16.
//  Copyright © 2016 Sagar Trivedi. All rights reserved.
//

#import "employeeMainChat.h"
#import <objc/runtime.h>
#import "JSQMessages.h"
#import <Foundation/NSObject.h>
#import "NSUserDefaults+DemoSettings.h"

@interface employeeMainChat ()
{
    JSQMessage *messageforchat,*loadMoreMessage;
    NSMutableArray *data,*loadmessage,*allUserId;
    NSString *messag ,*dialogId,*imageName,*userType;
    NSTimer  *Timer ;
}

@end

@implementation employeeMainChat
#pragma mark - View LifeCycle -
- (void)viewDidLoad {
    [super viewDidLoad];
    
    userType = @"1";
    
    self.inputToolbar.contentView.textView.pasteDelegate = self;

    loadmessage = [[NSMutableArray alloc]init];
    
    allUserId = [[NSMutableArray alloc]init];
    
    data = [[NSMutableArray alloc]init];

    self.senderId = [[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"];
    
    if (_arrayHistory.count==0) {
        self.senderDisplayName = [_FromEmployerInvite valueForKey:@"DisplyName"];
    }else{
    self.senderDisplayName =  [_arrayHistory valueForKey:@"SenderName"];
    }
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [rightButton setImage:[UIImage imageNamed:@"sent_btn"] forState:UIControlStateNormal];
    
    self.inputToolbar.contentView.rightBarButtonItem = rightButton;
    
    //self.showTypingIndicator = YES;
    
    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    
    //self.showLoadEarlierMessagesHeader =YES;
    
    self.inputToolbar.contentView.leftBarButtonItem = nil;
    
    self.inputToolbar.maximumHeight = 100;
    
    if (![NSUserDefaults incomingAvatarSetting])
    {
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
    }
    
    if (![NSUserDefaults outgoingAvatarSetting]) {
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
        
    }
    
    
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(customAction:)];
    
    [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];
    
    [self receiveMessageWebservice];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:32.0/255.0 green:88.0/255.0 blue:140.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.leftBarButtonItem = [self customNavigationBarButton:@selector(barBackButton) Target:self ];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"dot"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
    style:UIBarButtonItemStylePlain target:self
   action:@selector(RightBarButtonPressed)];
    
    if (self.delegateModal)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                    target:self action:@selector(closePressed:)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = NO;
    
    self.collectionView.collectionViewLayout.springinessEnabled = [NSUserDefaults springinessSetting];
}


#pragma mark - JSQ Menu Actions -
- (void)customAction:(id)sender
{
    NSLog(@"Custom action received! Sender: %@", sender);
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Custom Action", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil) style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)closePressed:(UIBarButtonItem *)sender
{
    [self.delegateModal didDismissJSQDemoViewController:self];
}


#pragma mark - IBAction Send Button -
- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    
    messageforchat = [[JSQMessage alloc] initWithSenderId:senderId senderDisplayName:senderDisplayName date:date text:text];
    
    [self sendMessage:text];

    [data addObject:messageforchat];
    
[JSQSystemSoundPlayer jsq_playMessageSentSound];
[self finishSendingMessageAnimated:YES];
    
}



#pragma mark - CollecitionView DataSource -

- (void)reloadCollecitionView
{
    [self.collectionView reloadData];
}

- (id)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [data objectAtIndex:indexPath.item];
}


- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [data removeObjectAtIndex:indexPath.item];
}


- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesBubbleImageFactory *bubbleFactory = [[JSQMessagesBubbleImageFactory alloc] init];
    JSQMessage *msg = [data objectAtIndex:indexPath.item];
    if ([msg.senderId isEqualToString:self.senderId])
    {
     return [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor colorWithRed:190.0/255.0 green:230.0/255.0 blue:255.0/255.0 alpha:1.0]];
    }
    else
         return [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor colorWithRed:193.0/255.0 green:193.0/255.0 blue:193.0/255.0 alpha:1.0]];
}


- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [data objectAtIndex:indexPath.item];
    
//    if (indexPath.item % 3 == 0)
//    {
//        JSQMessage *messagg = [data objectAtIndex:indexPath.item];
//        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:messagg.date];
//    }
    if (indexPath.item == 0) {
        
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [data objectAtIndex:indexPath.item - 1];
        
        if ([message.date timeIntervalSinceDate:previousMessage.date] / 60 > 1) {
            return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
        }
    }

    return nil;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [data objectAtIndex:indexPath.item - 1];
        JSQMessage *message = [data objectAtIndex:indexPath.item];
        
        if ([message.date timeIntervalSinceDate:previousMessage.date] / 60 > 1) {
            return kJSQMessagesCollectionViewCellLabelHeightDefault;
        }
    }
    
    return 0.0f;
}
- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [data objectAtIndex:indexPath.item];
    
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0)
    {
        JSQMessage *previousMessage = [data objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:message.senderId])
        {
            return nil;
        }
    }
    
    return [[NSAttributedString alloc] initWithString:self.senderDisplayName];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}



- (void)didReceiveMenuWillShowNotification:(NSNotification *)notification
{
    
    UIMenuController *menu = [notification object];
    menu.menuItems = @[ [[UIMenuItem alloc] initWithTitle:@"Custom Action" action:@selector(customAction:)] ];
    
    [super didReceiveMenuWillShowNotification:notification];

}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [data count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    
    JSQMessage *msg = [data objectAtIndex:indexPath.item];
    
    if (!msg.isMediaMessage)
    {
        
        if ([msg.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:89.0/255.0 alpha:1.0];
        }
        else
        {
            cell.textView.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(customAction:)) {
        return YES;
    }
    
    return [super collectionView:collectionView canPerformAction:action forItemAtIndexPath:indexPath withSender:sender];
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(customAction:)) {
        [self customAction:sender];
        return;
    }
    
    [super collectionView:collectionView performAction:action forItemAtIndexPath:indexPath withSender:sender];
}
/*
- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}
 */

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    JSQMessage *currentMessage = [data objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [data  objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

#pragma mark - Compose Text Message -
- (BOOL)composerTextView:(JSQMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender
{
    if ([UIPasteboard generalPasteboard].image) {
        
        JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIPasteboard generalPasteboard].image];
        
        JSQMessage *message = [[JSQMessage alloc] initWithSenderId:self.senderId
                                                 senderDisplayName:self.senderDisplayName
                                                              date:[NSDate date]
                                                             media:item];
        [data addObject:message];
        [self finishSendingMessage];
        return NO;
    }
    return YES;
}

#pragma mark - receiveMessage -
- (void)receiveMessagePressed
{
    self.showTypingIndicator = !self.showTypingIndicator;
    
    [self scrollToBottomAnimated:YES];
    
    JSQMessage *copyMessage = [[data lastObject] copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *userIds = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<data.count; i++)
        {
            JSQMessage *msg = [data objectAtIndex:i];
            
            [userIds addObject:msg.senderId];
            
        }
        [userIds removeObject:self.senderId];
        JSQMessage *newMessage = nil;
        
        id<JSQMessageMediaData> newMediaData = nil;
        
        id newMediaAttachmentCopy = nil;
        
        if (copyMessage.isMediaMessage)
        {
            /**
             *  Last message was a media message
             */
            id<JSQMessageMediaData> copyMediaData = copyMessage.media;
            
            if ([copyMediaData isKindOfClass:[JSQPhotoMediaItem class]]) {
                JSQPhotoMediaItem *photoItemCopy = [((JSQPhotoMediaItem *)copyMediaData) copy];
                photoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [UIImage imageWithCGImage:photoItemCopy.image.CGImage];
                
                /**
                 *  Set image to nil to simulate "downloading" the image
                 *  and show the placeholder view
                 */
                photoItemCopy.image = nil;
                
                newMediaData = photoItemCopy;
            }
            else if ([copyMediaData isKindOfClass:[JSQLocationMediaItem class]]) {
                JSQLocationMediaItem *locationItemCopy = [((JSQLocationMediaItem *)copyMediaData) copy];
                locationItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [locationItemCopy.location copy];
                
                /**
                 *  Set location to nil to simulate "downloading" the location data
                 */
                locationItemCopy.location = nil;
                
                newMediaData = locationItemCopy;
            }
            else if ([copyMediaData isKindOfClass:[JSQVideoMediaItem class]]) {
                JSQVideoMediaItem *videoItemCopy = [((JSQVideoMediaItem *)copyMediaData) copy];
                videoItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [videoItemCopy.fileURL copy];
                
                /**
                 *  Reset video item to simulate "downloading" the video
                 */
                videoItemCopy.fileURL = nil;
                videoItemCopy.isReadyToPlay = NO;
                
                newMediaData = videoItemCopy;
            }
            else if ([copyMediaData isKindOfClass:[JSQAudioMediaItem class]]) {
                JSQAudioMediaItem *audioItemCopy = [((JSQAudioMediaItem *)copyMediaData) copy];
                audioItemCopy.appliesMediaViewMaskAsOutgoing = NO;
                newMediaAttachmentCopy = [audioItemCopy.audioData copy];
                
                /**
                 *  Reset audio item to simulate "downloading" the audio
                 */
                audioItemCopy.audioData = nil;
                
                newMediaData = audioItemCopy;
            }
            else {
                NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
            }
            
            newMessage = [JSQMessage messageWithSenderId:[NSString stringWithFormat:@"Hello"]
                                             displayName:@"Joshi"
                                                    text:copyMessage.text];
        }
        else {
            /**
             *  Last message was a text message
             */
            newMessage = [JSQMessage messageWithSenderId:[NSString stringWithFormat:@"Hello"]
                                             displayName:@"Joshi"
                                                    text:copyMessage.text];
        }
        
        /**
         *  Upon receiving a message, you should:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishReceivingMessage`
         */
        
        // [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        
        //[data addObject:newMessage];
        [self finishReceivingMessageAnimated:YES];
        
        
        if (newMessage.isMediaMessage)
        {
            /**
             *  Simulate "downloading" media
             */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                /**
                 *  Media is "finished downloading", re-display visible cells
                 *
                 *  If media cell is not visible, the next time it is dequeued the view controller will display its new attachment data
                 *
                 *  Reload the specific item, or simply call `reloadData`
                 */
                
                if ([newMediaData isKindOfClass:[JSQPhotoMediaItem class]]) {
                    ((JSQPhotoMediaItem *)newMediaData).image = newMediaAttachmentCopy;
                    [self.collectionView reloadData];
                }
                else if ([newMediaData isKindOfClass:[JSQLocationMediaItem class]]) {
                    [((JSQLocationMediaItem *)newMediaData)setLocation:newMediaAttachmentCopy withCompletionHandler:^{
                        [self.collectionView reloadData];
                    }];
                }
                else if ([newMediaData isKindOfClass:[JSQVideoMediaItem class]]) {
                    ((JSQVideoMediaItem *)newMediaData).fileURL = newMediaAttachmentCopy;
                    ((JSQVideoMediaItem *)newMediaData).isReadyToPlay = YES;
                    [self.collectionView reloadData];
                }
                else if ([newMediaData isKindOfClass:[JSQAudioMediaItem class]]) {
                    ((JSQAudioMediaItem *)newMediaData).audioData = newMediaAttachmentCopy;
                    [self.collectionView reloadData];
                }
                else {
                    NSLog(@"%s error: unrecognized media item", __PRETTY_FUNCTION__);
                }
                
            });
        }
        
    });
}

-(void)receiveMessageWebservice
{
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:[[NSUserDefaults standardUserDefaults]stringForKey:@"EmployerUserID"] forKey:@"sender_id"];
    
    if (_arrayHistory.count==0) {
        [_param setObject:[_FromEmployerInvite valueForKey:@"EmployeeUserID"] forKey:@"receiver_id"];
    }
    else{
        [_param setObject:[_arrayHistory valueForKey:@"SenderId"] forKey:@"receiver_id"];
    }
 
    [_param setObject:@"receiverMessage" forKey:@"methodName"];
    
     [_param setObject:@"1" forKey:@"flag"];
    
    [_param setObject:@"0" forKey:@"latest_msg_id"];
[kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
    for (int i = 0; i<[[responseObject valueForKey:@"data"]count]; i++)
    {
        NSString *date = [[[responseObject valueForKey:@"data"]valueForKey:@"Date"] objectAtIndex:i];
        NSString *time = [[[responseObject valueForKey:@"data"]valueForKey:@"Time"] objectAtIndex:i];
        
        date = [date stringByAppendingString:[NSString stringWithFormat:@" %@",time]];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *Date = [dateFormat dateFromString:date];
        
        loadMoreMessage = [[JSQMessage alloc]initWithSenderId:[[[responseObject valueForKey:@"data"]valueForKey:@"SenderId"] objectAtIndex:i] senderDisplayName:@"name" date:Date text:[[[responseObject valueForKey:@"data"]valueForKey:@"Message"] objectAtIndex:i]];
        
        [loadmessage addObject:loadMoreMessage];
    }

    [data addObjectsFromArray:loadmessage];
    
    NSLog(@"JSQMessage values  %@",data);
    
    [self performSelector:@selector(reloadCollecitionView)  withObject:nil afterDelay:0.3];
    
} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

}];
}

#pragma mark - Send Message -

-(void)sendMessage:(NSString*)Message{
//    {"sender_id":"","receiver_id":"","msg":"","token":"","methodName":"sendMessage","userType":"0/1(0=Jobseeker,1=Employer)"}
    
    NSMutableDictionary *_param = [[NSMutableDictionary alloc]init];
    
    [_param setObject:@"sendMessage" forKey:@"methodName"];
    
    [_param setObject:userType forKey:@"userType"];
    
    [_param setObject:self.senderId forKey:@"sender_id"];
    
    if (_arrayHistory.count==0) {
        [_param setObject:[_FromEmployerInvite valueForKey:@"EmployeeUserID"] forKey:@"receiver_id"];
    }
    else{
        [_param setObject:[_arrayHistory valueForKey:@"SenderId"] forKey:@"receiver_id"];
        
    }
    [_param setObject:Message forKey:@"msg"];
    
    if (_arrayHistory.count==0) {
        [_param setObject:@"1" forKey:@"token"];

    }else{
    [_param setObject:[_arrayHistory valueForKey:@"token"] forKey:@"token"];
    }
    NSLog(@"param %@",_param);
    
    [kAFClient POST:MAIN_URL parameters:_param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"response sent Object %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
        
    }];
}

#pragma mark - Navigation Bar Back Button -
-(void)barBackButton
{
    for (UIViewController *viewControllrObj in self.navigationController.viewControllers){

        if (_FromEmployerInvite.count>0) {
            if ([viewControllrObj isKindOfClass:[employerInviteForJobVC class]])
            {
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
        else{
            if ([viewControllrObj isKindOfClass:[employeeChat class]])
            {
                [self.navigationController popToViewController:viewControllrObj animated:YES];
            }
        }
    }
}


-(UIBarButtonItem *)customNavigationBarButton:(SEL)selector Target:(UIViewController *)targetView
{
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 7, 25, 25)];
    [button setImage:[UIImage imageNamed:@"arrow-left"] forState:UIControlStateNormal];
    [button addTarget:targetView action:selector forControlEvents:UIControlEventTouchUpInside];
    
    _ProfieImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 36 , 36)];
    
    NSString *imageString;
    if (_arrayHistory.count==0) {
        imageString = [_FromEmployerInvite valueForKey:@"ProfilePic"];
    }
    else{
        imageString = [_arrayHistory valueForKey:@"SenderPic"];
    }
    
    _ProfieImage.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:imageString]]];
    
    _ProfieImage.layer.cornerRadius = _ProfieImage.frame.size.height/2;
    _ProfieImage.layer.masksToBounds = YES;
    
    
    _userName = [[UILabel alloc]initWithFrame:CGRectMake(75, 0, 150, 20)];
    [_userName setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0f]];
    _userName.textColor = [UIColor whiteColor];
    if (_arrayHistory.count==0) {
        _userName.text = [_FromEmployerInvite valueForKey:@"DisplyName"];
    }else{
        _userName.text = [_arrayHistory valueForKey:@"SenderName"];
    }
    
    _userCompanyName = [[UILabel alloc]initWithFrame:CGRectMake(75, 19, 150, 20)];
    _userCompanyName.textColor = [UIColor whiteColor];
    
    
    if (_arrayHistory.count==0) {
        _userCompanyName.text = [_FromEmployerInvite valueForKey:@"employeeCategoryName"];
    }else{
        _userCompanyName.text = [_arrayHistory valueForKey:@"category_name"];
    }
    
     [_userCompanyName setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    UIView * leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 250, 40)];
    
    [leftView addSubview:button];
    [leftView addSubview:_ProfieImage];
    [leftView addSubview:_userName];
    [leftView addSubview:_userCompanyName];
    
    return [[UIBarButtonItem alloc]initWithCustomView:leftView];
}

-(void)RightBarButtonPressed
{
    
}

@end
