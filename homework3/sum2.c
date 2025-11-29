#include <stdio.h>

int main() {
    int N, sum = 0;

    printf("Enter a number: ");
    scanf("%d", &N);

    for(int i = 1; i <= N; i++) {
        sum += i; // 累加
    }

    printf("Sum(1..%d) = %d\n", N, sum);
    return 0;
}
