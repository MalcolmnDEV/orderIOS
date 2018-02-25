//
//  ShareHelper.m
//
//  Created by Malcolmn Roberts on 2016/02/18.
//  Copyright © 2016 Malcolmn Roberts. All rights reserved.
//


/*
 *  The following are required
 *  Facebook 'FBSDKShareKit' and Apple Social Kit (Can be found in Build Phases/ Link libs)
 */

#import "ShareHelper.h"
@import Social;
#import <FBSDKShareKit/FBSDKShareButton.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@implementation ShareHelper

+ (ShareHelper*)sharedManager
{
    static ShareHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]){
    }
    return self;
}

-(void)openNativeSharing:(ShareObject *)shareObj viewControler:(UIViewController *)vc delegate: (id<ShareHelperDelegate>) delegate
{
    _delegate = delegate;
    
    NSArray *shareArray;
    
    // Here just specify what you want to share
    
    if (shareObj.shareImage)
        shareArray = @[shareObj.body, shareObj.shareImage]; // NB!! some applications only allow 1 item as content
    else
        shareArray = @[shareObj.body];
    
    // Native Activity Controller will display list of all possible sharing options
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:shareArray
                                                                                         applicationActivities:nil];
    
    // Use the copy doc to specify the subject
    
//    [activityViewController setValue:NSLocalizedString(@"share_email_subject", nil) forKey:@"subject"];
    
    [activityViewController setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed,  NSArray *returnedItems, NSError *activityError)
    {
        if ([self.delegate respondsToSelector:@selector(completionWithItemsHandlerReturned:completed:returnedItems:error:)])
            [self.delegate completionWithItemsHandlerReturned:activityType completed:completed returnedItems:returnedItems error:activityError];
    
    }];
    
    [vc presentViewController:activityViewController
                     animated:YES
                   completion:nil];
}

-(void)shareWithFB:(UIViewController *)vc SharingObj:(ShareObject *) obj
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        if (obj.fbSharePhotoContent)
        {
            [FBSDKShareDialog showFromViewController:vc
                                         withContent:obj.fbSharePhotoContent
                                            delegate:self];
        }
        else
        {
            [FBSDKShareDialog showFromViewController:vc
                                         withContent:obj.fbShareLinkContent
                                            delegate:self];
        }
    }
    else
    {
        [self.delegate shareOptionNotAvailable:@"Facebook" body:@"You do not have Facebook installed" AppName:@"Facebook"];
        // Facebook not available on the phone, handle how youd like
    }
}

-(void)shareWithTwitter:(UIViewController *)vc SharingObj:(ShareObject *) obj
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweet setInitialText:[NSString stringWithFormat:@"%@ %@",obj.body, obj.hashTag]];
        [tweet addImage:obj.shareImage];
        
        [tweet setCompletionHandler:^(SLComposeViewControllerResult result)
         {
             if (result == SLComposeViewControllerResultCancelled){
                 //  User cancelled the tweet
             }
             else if (result == SLComposeViewControllerResultDone){
                 // User Sent the tweet
             }
         }];
        [vc presentViewController:tweet animated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(completionWithItemsHandlerReturned:completed:returnedItems:error:)])
                [self.delegate completionWithItemsHandlerReturned:UIActivityTypePostToTwitter completed:YES returnedItems:nil error:nil];
        }];
    }
    else
    {
        [self.delegate shareOptionNotAvailable:@"Twitter" body:@"You do not have Twitter installed" AppName:@"Twitter"];
        //  Twitter not available on the phone ,handle how youd like
    }
}

-(void)shareWithWhatsApp:(UIViewController *)vc SharingObj:(ShareObject *) obj
{
    NSString * urlWhats = [NSString stringWithFormat:@"whatsapp://app"];
    NSURL * whatsappURL = [NSURL URLWithString:[urlWhats stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    
    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL])
    {
        UIImage     * iconImage = obj.shareImage;
        NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
        
        [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
        
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
        _documentInteractionController.UTI = @"net.whatsapp.image";
        _documentInteractionController.delegate = self;
        
        [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:vc.view animated: YES];
    }
    else
    {
        [self.delegate shareOptionNotAvailable:@"Whatsapp" body:@"You do not have Whatsapp installed" AppName:@"whatsapp"];
        // Cannot open whatsapp
    }
}

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    [self.delegate sharer:sharer didCompleteWithResults:results];
}

-(void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    [self.delegate sharerDidCancel:sharer];
}

-(void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    [self.delegate sharer:sharer didFailWithError:error];
}


@end
