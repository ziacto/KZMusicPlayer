//
//  nceViewController.h
//  musicPlayer
//
//  Created by ColdWorks-Ted on 13-3-4.
//  Copyright (c) 2013年 hilen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface nceViewController : UIViewController<AVAudioPlayerDelegate>
{
    //音频相关
    AVAudioPlayer *musicPlayer;
    NSString *audioPath;
    NSTimer *timer;
    UIBarButtonItem *playBarButton;
    UIBarButtonItem *pauseBarButton;
    IBOutlet UISlider *scrubber;
    IBOutlet UIToolbar *audioPlayingToolbar;
}


- (IBAction)scrubbbingDone: (id) sender;
- (IBAction)play: (id) sender;
- (IBAction)scrub: (id) sender;


@end
