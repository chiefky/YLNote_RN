//
//  YLBlock.c
//  YLNote
//
//  Created by tangh on 2021/7/31.
//  Copyright © 2021 tangh. All rights reserved.
//

#include "YLBlock.h"
int main() {
    void(^block)(void) = ^{
          printf("YLBlock");
      };
      return 0;
}
