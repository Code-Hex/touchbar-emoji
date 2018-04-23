//
//  AppDelegate.m
//  touchbar-emoji
//
//  Created by codehex on 2018/04/19.
//  Copyright © 2018年 codehex. All rights reserved.
//

#import "AppDelegate.h"
#import "TouchBar.h"

@interface AppDelegate () <NSTouchBarDelegate>

@property (weak) IBOutlet NSWindow *window;
@end

NSTouchBar *_groupTouchBar;

@implementation AppDelegate

static const NSTouchBarItemIdentifier kStripButton = @"codehex.stripbtn";
static const NSTouchBarItemIdentifier kBtn1Identifier = @"codehex.btn1";

- (NSTouchBar *)groupTouchBar {
    if (!_groupTouchBar) {
        NSTouchBar *groupTouchBar = [[NSTouchBar alloc] init];
        groupTouchBar.defaultItemIdentifiers = @[ kBtn1Identifier ];
        //groupTouchBar.defaultItemIdentifiers = @[ kButton1, kButton2 ];
        groupTouchBar.delegate = self;
        _groupTouchBar = groupTouchBar;
    }
    return _groupTouchBar;
}

- (void)osushi:(id)sender {
    NSLog(@"🍣");
}

- (NSTouchBarItem *)touchBar:(NSTouchBar *)touchBar
       makeItemForIdentifier:(NSTouchBarItemIdentifier)identifier
{
    if ([identifier isEqualToString:kBtn1Identifier]) {
        NSCustomTouchBarItem *sushi =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:kBtn1Identifier];
        NSButton *btn = [NSButton buttonWithTitle:@"🍣" target:self action:@selector(osushi:)];
        sushi.view = btn;
        btn.transparent = true;
        return sushi;
    }
    
    if ([identifier isEqualToString:kStripButton]) {
        NSCustomTouchBarItem *beer =
        [[NSCustomTouchBarItem alloc] initWithIdentifier:kStripButton];
        beer.view =
        [NSButton buttonWithTitle:@"🍺" target:self action:@selector(present:)];
        return beer;
    }
    
    return nil;
}


- (void)present:(id)sender {
    NSLog(@"Hello!!");
    [NSTouchBar presentSystemModalFunctionBar:self.groupTouchBar systemTrayItemIdentifier:kStripButton];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    if (@available(macOS 10.12.2, *)) {
        DFRSystemModalShowsCloseBoxWhenFrontMost(YES);
        NSCustomTouchBarItem *beer = [[NSCustomTouchBarItem alloc] initWithIdentifier: kStripButton];
        beer.view = [NSButton buttonWithTitle:@"🍺" target:self action:@selector(present:)];
        [NSTouchBarItem addSystemTrayItem:beer];
        DFRElementSetControlStripPresenceForIdentifier(kStripButton, YES);
    } else {
        [self applicationDoesNotSupport];
    }
}

- (void)applicationDoesNotSupport {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert setMessageText:@"Sorry"];
    [alert setInformativeText:@"Does not support your machine or version"];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
