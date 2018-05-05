//
//  FirstViewController.m
//  QianMo
//
//  Created by luyang on 2017/8/10.
//  Copyright © 2017年 Myself. All rights reserved.
//

#import "FirstViewController.h"
#import "YYKit.h"
#import "LYAVPlayerView.h"
#import "HomeViewController.h"

#define VideoURL @"http://wvideo.spriteapp.cn/video/2016/0328/56f8ec01d9bfe_wpd.mp4"

static NSString  * const string =@"123";


@interface FirstViewController ()

@property (nonatomic,strong)LYAVPlayerView *playerView;

@end

@implementation FirstViewController

+ (instancetype)sharedInstance{
        
        static id sharedInstance =nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
            sharedInstance =[[self alloc] init];
        });
        return sharedInstance;
        
        
        
    }
    
    
    




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor =[UIColor redColor];
    
    self.string =@"123";
    
    
    
    if (self.playerView && self.playerView.isPlaying) {
        
        return;
        
    }
    
    
    
    self.playerView =[LYAVPlayerView sharedInstance];
    self.playerView.frame =CGRectMake(0, 64,320,200);
  //  self.playerView.delegate =self;
    [self.view addSubview:self.playerView];
    
    [self.playerView setURL:[NSURL URLWithString:VideoURL]];
    [self.playerView play];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
