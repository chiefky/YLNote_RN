//
//  YLThreadGCDDispatchIOController.m
//  YLNote
//
//  Created by tangh on 2022/2/26.
//  Copyright © 2022 tangh. All rights reserved.
//

#import "YLThreadGCDDispatchIOController.h"
#import <AFNetworking/AFNetworking.h>
@interface YLThreadGCDDispatchIOController ()

@end

/// <#Description#>
@implementation YLThreadGCDDispatchIOController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - func

/// "异步串行读取文件"
- (void)testGCD_IO_serial {
    dispatch_queue_t queue = dispatch_queue_create("com.myThread.serial", DISPATCH_QUEUE_SERIAL);
    NSString *desktop = @"/Users/tangh/Desktop/";
    
   NSString *path = [desktop stringByAppendingPathComponent:@"简历.docx"];
    /** 文件描述符 */
    dispatch_fd_t fd = open(path.UTF8String, O_RDONLY, 0);
    
    /** 创建一个调度I / O通道，并将其与指定的文件描述符关联 */
    dispatch_io_t io_t = dispatch_io_create(DISPATCH_IO_RANDOM, fd, queue, ^(int error) {
        close(fd);
    });
    
    size_t water = 1024*1024;
    /** 设置一次读取的最小字节大小 */
    dispatch_io_set_low_water(io_t, water);
    /** 设置一次读取的最大字节 */
    dispatch_io_set_high_water(io_t, water);
    long long fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
    NSMutableData *totalData = [[NSMutableData alloc] init];
    /** 进行文件读取 */
    dispatch_io_read(io_t, 0, fileSize, queue, ^(bool done, dispatch_data_t _Nullable data, int error) {
        if (error == 0) {
            size_t len = dispatch_data_get_size(data);
            if (len > 0) {
                [totalData appendData:(NSData *)data];
            }
        }
        
        if (done) {
            NSString *str = [[NSString alloc] initWithData:totalData encoding:NSUTF8StringEncoding];
            NSLog(@"🍎：%@", str);
        }
    });
    
}

/// 异步并行读取文件
- (void)testGCD_IO_concurrent {
    NSString *desktop = @"/Users/tangh/Desktop/";
    
   NSString *path = [desktop stringByAppendingPathComponent:@"QQ20201111-021414.png"];

   dispatch_fd_t fd = open(path.UTF8String, O_RDONLY);
   
   dispatch_queue_t queue = dispatch_queue_create("com.myThread.concurrent", DISPATCH_QUEUE_CONCURRENT);
   dispatch_io_t io = dispatch_io_create(DISPATCH_IO_RANDOM, fd, queue, ^(int error) {
       close(fd);
   });

    /**设置读取的文件大小*/
    off_t currentSize = 0;
    long long fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
    size_t offset = 1024*1024;
   
   dispatch_group_t group = dispatch_group_create();
    NSMutableData *totalData = [[NSMutableData alloc] initWithLength: fileSize];
   for (; currentSize <= fileSize; currentSize += offset) {
       dispatch_group_enter(group);

       dispatch_io_read(io, currentSize, offset, queue, ^(bool done, dispatch_data_t  _Nullable data, int error) {
           if (error == 0) {
               size_t len = dispatch_data_get_size(data);
               if (len > 0) {
                   const void *bytes = NULL;
                   (void)dispatch_data_create_map(data, (const void **)&bytes, &len);
                   [totalData replaceBytesInRange:NSMakeRange(currentSize, len) withBytes:bytes length:len];
               }
           }

           if (done) {
               dispatch_group_leave(group);
           }
       });
   }

   dispatch_group_notify(group, queue, ^{
       NSString *str = [[NSString alloc] initWithData:totalData encoding:NSUTF8StringEncoding];
       NSLog(@"🍓：%@", str);
   });

}

#pragma mark - lazy
- (NSString *)fileName {
    return @"thread_gcd_IO";
}
@end
