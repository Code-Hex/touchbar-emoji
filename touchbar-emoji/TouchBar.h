//
//  touchbar.h
//  touchbar-emoji
//
//  Created by codehex on 2018/04/19.
//  Copyright © 2018年 codehex. All rights reserved.
//

#ifndef touchbar_h
#define touchbar_h


#import <AppKit/AppKit.h>

extern void DFRElementSetControlStripPresenceForIdentifier(NSString *, BOOL);
extern void DFRSystemModalShowsCloseBoxWhenFrontMost(BOOL);

@interface NSTouchBarItem ()

+ (void)addSystemTrayItem:(NSTouchBarItem *)item;

@end

@interface NSTouchBar ()

+ (void)presentSystemModalFunctionBar:(NSTouchBar *)touchBar systemTrayItemIdentifier:(NSString *)identifier;

@end

#endif /* touchbar_h */
