#include <stdio.h>

int main() {
    char ch = 'a';
    for(int i = 0; i < 2; i++) {       // 两行
        for(int j = 0; j < 13; j++) {  // 每行13字符
            printf("%c ", ch);
            ch++;
        }
        printf("\n");
    }
    return 0;
}
