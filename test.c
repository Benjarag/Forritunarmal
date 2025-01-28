#include <stdio.h>

int x = 0;

void foo() {
    printf("%d\n", x);  // Use printf to print the value of x
}

void bar() {
    int x = 1;
    foo();  // This will print the global x, not the local x in bar
}

int main() {
    bar();
    return 0;
}