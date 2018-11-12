//
//  JKEventHandler+XJHandler.h
//  XJWebDemo
//
//  Created by wodun on 2018/5/3.
//  Copyright © 2018年 com.wodun. All rights reserved.
//

#import <JKWKWebViewHandler/JKWKWebViewHandler.h>

@interface JKEventHandler (XJHandler)
-(void)sendInfoToNative:(id)param;
-(void)inviteFriends:(id)param;
@end
