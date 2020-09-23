//
//  ViewController.m
//  WidgetDemo
//
//  Created by 陈甸甸 on 2020/9/21.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self acceptNote];
}


- (void)acceptNote
{
    
    __weak typeof(self)weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:@"WidgetAction" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSString *msg = [NSString stringWithFormat:@"点击了%@组件的第%@行",note.object,note.userInfo[@"quote"]];
        if ([note.object isEqualToString:@"Small Widget"]) {
            msg = @"由于小组件不支持Link，只支持widgetURL，所以点击的是一个整体";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:note.object message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        [alertController addAction:sureAction];
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    }];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
