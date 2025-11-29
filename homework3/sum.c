#include <stdio.h>

int main() {
    int sum = 0;
    for(int i = 1; i <= 100; i++) {
        sum += i;  // 累加
    }

    printf("Sum(1..100) = %d\n", sum);
    return 0;
}
