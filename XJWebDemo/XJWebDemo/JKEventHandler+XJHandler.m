//
//  JKEventHandler+XJHandler.m
//  XJWebDemo
//
//  Created by wodun on 2018/5/3.
//  Copyright © 2018年 com.wodun. All rights reserved.
//

#import "JKEventHandler+XJHandler.h"

@implementation JKEventHandler (XJHandler)
-(void)sendInfoToNative:(id)param
{
    NSLog(@"1111111");
}
-(void)inviteFriends:(id)param
{
    NSLog(@"%@",param);
}
@end
