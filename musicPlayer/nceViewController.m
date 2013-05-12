//
//  nceViewController.m
//  musicPlayer
//
//  Created by ColdWorks-Ted on 13-3-4.
//  Copyright (c) 2013年 hilen. All rights reserved.
//

#import "nceViewController.h"

@interface nceViewController ()

@end

@implementation nceViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"11111");
    
    [self prepareAudio];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareAudio
{
    NSError *error;
    audioPath = [[NSBundle mainBundle]	pathForResource:@"wakeup" ofType:@"mp3"];
    
    AVAudioPlayer *newPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:audioPath] error:&error];

    musicPlayer = newPlayer;

    [musicPlayer prepareToPlay];

    playBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(play:)];
    pauseBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPause target:self action:@selector(pause)];

    musicPlayer.delegate = self;
    musicPlayer.numberOfLoops = 0;//0播放1次， 1播放2次，  -1无限播放
    musicPlayer.meteringEnabled = YES;
    [self setPlayAudioBackground];
}

- (void)setPlayAudioBackground {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
}

- (void)updateMeters
{
    scrubber.value = (musicPlayer.currentTime / musicPlayer.duration);
}


- (IBAction)scrubbbingDone: (id) sender
{
    [self play:nil];
}
- (IBAction)play:(id)sender
{
    if (musicPlayer) [musicPlayer play];
    [self setBarButton:YES];

    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                             target:self
                                           selector:@selector(updateMeters)
                                           userInfo:nil
                                            repeats:YES];
    scrubber.enabled = YES;
}

- (void)setBarButton: (BOOL) isPlaying
{
    NSMutableArray *items = [NSMutableArray arrayWithArray:audioPlayingToolbar.items];
    
    if ([items count] == 0 || pauseBarButton == nil || playBarButton == nil)
        return;
    
    [items removeObjectAtIndex:0];
    [items insertObject:(isPlaying ? pauseBarButton : playBarButton) atIndex:0];
    
    [audioPlayingToolbar setItems:items animated:NO];
}


- (void)pause
{
    if (musicPlayer) [musicPlayer pause];
    [self setBarButton:NO];
    scrubber.enabled = NO;
}

- (IBAction)scrub: (id) sender
{
    // Pause the player
    [musicPlayer pause];

    // Calculate the new current time
    musicPlayer.currentTime = scrubber.value * musicPlayer.duration;
}

//播放结束时执行的动作
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    NSLog(@"11111111");
}
//解码错误执行的动作
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer*)player error:(NSError *)error{
    NSLog(@"222222");
}
- (void)audioPlayerBeginInteruption:(AVAudioPlayer*)player{
    NSLog(@"333333");
    [player play];
    //处理中断的代码
}
- (void)audioPlayerEndInteruption:(AVAudioPlayer*)player{
    NSLog(@"4444444");

    //处理中断结束的代码
}

@end
