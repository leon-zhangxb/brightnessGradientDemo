//
//  QRCodeVC.m
//  brightnessGradientDemo
//
//  Created by 张小兵 on 2018/3/3.
//  Copyright © 2018年 leon. All rights reserved.
//

#import "QRCodeVC.h"
#import "JCBrightness.h"

@interface QRCodeVC ()

@end

@implementation QRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addImageView];
    
    [self addNSNotification];
    
    //保存亮度
    [JCBrightness saveDefaultBrightness];
}

//页面出现时的方法
- (void)viewDidAppear:(BOOL)animated
{
    //设置亮度   0.8的亮度差不多了
    [JCBrightness graduallySetBrightness:0.8];
}

//页面消失时的方法
- (void)viewDidDisappear:(BOOL)animated
{
    // 恢复亮度
    [JCBrightness graduallyResumeBrightness];
}

-(void)addImageView{
    UIImageView *qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 233, 233)];
    qrCodeImageView.center = self.view.center;
    qrCodeImageView.image = [UIImage imageNamed:@"erweima.jpeg"];
    
    [self.view addSubview:qrCodeImageView];
}

#pragma mark --添加通知
-(void)addNSNotification{
    
//    UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification;     //程序变成激活状态
//    UIKIT_EXTERN NSString *const UIApplicationWillResignActiveNotification;    //程序将失去激活状态
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willResignActive) name:UIApplicationWillResignActiveNotification object:nil];
    
}

//成为激活状态，调高亮度
-(void)DidBecomeActive{
    [JCBrightness graduallySetBrightness:0.8];
}

//失去激活状态，快速恢复之前的亮度
-(void)willResignActive{
    [JCBrightness fastResumeBrightness];
}


#pragma mark 移除本地所有通知
-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



/*
                            系统常用通知
 //音频
 AVF_EXPORT NSString *const AVAudioSessionInterruptionNotification                           //音频中断出现
 AVF_EXPORT NSString *const AVAudioSessionRouteChangeNotification                            //系统的音频线路发生改变
 AVF_EXPORT NSString *const AVAudioSessionMediaServicesWereLostNotification                  //媒体服务终止
 AVF_EXPORT NSString *const AVAudioSessionMediaServicesWereResetNotification                 //媒体服务重新启动
 
 //视频
 AVF_EXPORT NSString *const AVPlayerItemTimeJumpedNotification                               // 播放时间跳跃
 AVF_EXPORT NSString *const AVPlayerItemDidPlayToEndTimeNotification                         // 播放结束
 AVF_EXPORT NSString *const AVPlayerItemFailedToPlayToEndTimeNotification                    // 没能播放到最后
 AVF_EXPORT NSString *const AVPlayerItemPlaybackStalledNotification                          // 播放抛锚
 AVF_EXPORT NSString *const AVPlayerItemNewAccessLogEntryNotification                        // 添加新的访问日志条目
 AVF_EXPORT NSString *const AVPlayerItemNewErrorLogEntryNotification                         // 添加新的错误日志条目
 
 MP_EXTERN NSString *const MPMediaLibraryDidChangeNotification;                              //媒体库发生改变
 MP_EXTERN NSString *const MPMediaPlaybackIsPreparedToPlayDidChangeNotification           //后台准备播放发生改变
 MP_EXTERN NSString *const MPMoviePlayerScalingModeDidChangeNotification;           //视频缩放填充模式发生改变
 MP_EXTERN NSString *const MPMoviePlayerPlaybackDidFinishNotification;              //媒体播放完成或用户手动退出
 MP_EXTERN NSString *const MPMoviePlayerPlaybackStateDidChangeNotification                   //播放状态改变
 MP_EXTERN NSString *const MPMoviePlayerLoadStateDidChangeNotification                       //媒体网络加载状态改变
 MP_EXTERN NSString *const MPMoviePlayerNowPlayingMovieDidChangeNotification        //当前播放的媒体内容发生改变
 MP_EXTERN NSString *const MPMoviePlayerWillEnterFullscreenNotification                      //将进入全屏
 MP_EXTERN NSString *const MPMoviePlayerDidEnterFullscreenNotification                       //进入全屏后
 MP_EXTERN NSString *const MPMoviePlayerWillExitFullscreenNotification                       //将要退出全屏
 MP_EXTERN NSString *const MPMoviePlayerDidExitFullscreenNotification                        //退出全屏后
 MP_EXTERN NSString *const MPMoviePlayerIsAirPlayVideoActiveDidChangeNotification         //当媒体开始通过AirPlay播放或者结束AirPlay
 MP_EXTERN NSString *const MPMoviePlayerReadyForDisplayDidChangeNotification                 //视频显示状态改变
 MP_EXTERN NSString *const MPMovieMediaTypesAvailableNotification                            //确定了媒体可用类型后
 MP_EXTERN NSString *const MPMovieSourceTypeAvailableNotification                            // 确定了媒体来源后
 MP_EXTERN NSString *const MPMovieDurationAvailableNotification                              //确定了媒体播放时长后
 MP_EXTERN NSString *const MPMovieNaturalSizeAvailableNotification                           //确定了媒体的实际尺寸后
 MP_EXTERN NSString *const MPMoviePlayerThumbnailImageRequestDidFinishNotification         //缩略图请求完成之后
 MP_EXTERN NSString *const MPMoviePlayerTimedMetadataUpdatedNotification                     //同步元数据发生更新
 MP_EXTERN NSString *const MPMoviePlayerContentPreloadDidFinishNotification                  //媒体内容预加载完成
 MP_EXTERN NSString *const MPMusicPlayerControllerPlaybackStateDidChangeNotification;        //播放状态改变
 MP_EXTERN NSString *const MPMusicPlayerControllerNowPlayingItemDidChangeNotification;       //播放内容改变
 MP_EXTERN NSString *const MPMusicPlayerControllerVolumeDidChangeNotification;               //音量发生改变
 
 
 //拍照/录像
 AVF_EXPORT NSString *const AVCaptureDeviceWasConnectedNotification                          //输入设备已连接
 AVF_EXPORT NSString *const AVCaptureDeviceWasDisconnectedNotification                       //输入设备失去连接
 AVF_EXPORT NSString *const AVCaptureDeviceSubjectAreaDidChangeNotification                  //捕获区域发生改变
 AVF_EXPORT NSString *const AVCaptureInputPortFormatDescriptionDidChangeNotification         //输入设备端口描述改变
 AVF_EXPORT NSString *const AVCaptureSessionRuntimeErrorNotification                         //媒体会话运行错误
 AVF_EXPORT NSString *const AVCaptureSessionDidStartRunningNotification                      //媒体会话开始运行
 AVF_EXPORT NSString *const AVCaptureSessionDidStopRunningNotification                       //媒体会话停止运行
 AVF_EXPORT NSString *const AVCaptureSessionWasInterruptedNotification                       //媒体会话中断
 AVF_EXPORT NSString *const AVCaptureSessionInterruptionEndedNotification                    //媒体会话中断停止
 
 //常用视图
 UIKIT_EXTERN NSString *const UITableViewSelectionDidChangeNotification;                     //TableView选中发生改变
 
 UIKIT_EXTERN NSString *const UITextFieldTextDidBeginEditingNotification;                    //TextField开始编辑
 UIKIT_EXTERN NSString *const UITextFieldTextDidEndEditingNotification;                      //TextField发生改变
 UIKIT_EXTERN NSString *const UITextFieldTextDidChangeNotification;                          //TextField结束编辑
 
 UIKIT_EXTERN NSString * const UITextViewTextDidBeginEditingNotification;                    //TextView开始编辑
 UIKIT_EXTERN NSString * const UITextViewTextDidChangeNotification;                          //TextView发生改变
 UIKIT_EXTERN NSString * const UITextViewTextDidEndEditingNotification;                      //TextView结束编辑
 
 UIKIT_EXTERN NSString *const UIWindowDidBecomeVisibleNotification;  //window激活并展示在界面的时候触发
 UIKIT_EXTERN NSString *const UIWindowDidBecomeHiddenNotification;                           //当window隐藏的时候触发
 UIKIT_EXTERN NSString *const UIWindowDidBecomeKeyNotification;      //当window被设置为keyWindow时触发
 UIKIT_EXTERN NSString *const UIWindowDidResignKeyNotification;                   //当window的key位置被取代时触发
 UIKIT_EXTERN NSString *const UIKeyboardWillShowNotification;                                //键盘将弹出
 UIKIT_EXTERN NSString *const UIKeyboardDidShowNotification;                                 //键盘弹出
 UIKIT_EXTERN NSString *const UIKeyboardWillHideNotification;                                //键盘将要隐藏
 UIKIT_EXTERN NSString *const UIKeyboardDidHideNotification;                                 //键盘隐藏
 UIKIT_EXTERN NSString *const UIKeyboardWillChangeFrameNotification                       //键盘frame将发生改变
 UIKIT_EXTERN NSString *const UIKeyboardDidChangeFrameNotification                        //键盘frame发生改变后
 
 
 //日期，时间
 FOUNDATION_EXPORT NSString * const NSCalendarDayChangedNotification                         //日期发生改变
 FOUNDATION_EXPORT NSString * const NSSystemClockDidChangeNotification                       //系统时钟发生改变
 FOUNDATION_EXPORT NSString * const NSSystemTimeZoneDidChangeNotification                    //系统时区发生改变
 
 
 //线程
 FOUNDATION_EXPORT NSString * const NSWillBecomeMultiThreadedNotification;                   //将变成多线程
 FOUNDATION_EXPORT NSString * const NSDidBecomeSingleThreadedNotification;                   //变成了单线程
 FOUNDATION_EXPORT NSString * const NSThreadWillExitNotification;                            //线程退出
 
 
 //程序
 UIKIT_EXTERN NSString *const UIApplicationDidEnterBackgroundNotification                    //程序进入后台
 UIKIT_EXTERN NSString *const UIApplicationWillEnterForegroundNotification                   //程序将进入前台
 UIKIT_EXTERN NSString *const UIApplicationDidFinishLaunchingNotification;                   //程序加载完成
 UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification;                      //程序变成激活状态
 UIKIT_EXTERN NSString *const UIApplicationWillResignActiveNotification;                     //程序将失去激活状态
 UIKIT_EXTERN NSString *const UIApplicationDidReceiveMemoryWarningNotification;              //接收到内存警告
 UIKIT_EXTERN NSString *const UIApplicationWillTerminateNotification;                        //程序将终止
 UIKIT_EXTERN NSString *const UIApplicationSignificantTimeChangeNotification;         //新的一天开始或时区发生变化
 UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarOrientationNotification;       //将改变状态栏方向
 UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarOrientationNotification;        //状态栏方向以改变
 UIKIT_EXTERN NSString *const UIApplicationWillChangeStatusBarFrameNotification;             //将改变状态栏frame
 UIKIT_EXTERN NSString *const UIApplicationDidChangeStatusBarFrameNotification;              //状态栏frame发生改变
 UIKIT_EXTERN NSString *const UIApplicationBackgroundRefreshStatusDidChangeNotification //后台刷新状态改变
 UIKIT_EXTERN NSString *const UIApplicationUserDidTakeScreenshotNotification                 //截屏时触发通知
 
 //硬件设备
 UIKIT_EXTERN NSString *const UIDeviceOrientationDidChangeNotification;                      //设备方向改变
 UIKIT_EXTERN NSString *const UIDeviceBatteryStateDidChangeNotification                      //电池状态改变
 UIKIT_EXTERN NSString *const UIDeviceBatteryLevelDidChangeNotification                      //电池电量改变
 UIKIT_EXTERN NSString *const UIDeviceProximityStateDidChangeNotification                    //距离感应器状态发生改变
 
 //其它
 UIKIT_EXTERN NSString *const UILocalNotificationDefaultSoundName                            //本地通知声音
 
 UIKIT_EXTERN NSString *const UIPasteboardChangedNotification;                               //粘贴板发生改变
 UIKIT_EXTERN NSString *const UIPasteboardRemovedNotification;                               //粘贴板内容移除
 
 FOUNDATION_EXPORT NSString * const NSUserDefaultsDidChangeNotification;               //NSUserDefaults发生改变
 FOUNDATION_EXPORT NSString * const NSBundleDidLoadNotification;                             //bundle加载完成
 */

@end
