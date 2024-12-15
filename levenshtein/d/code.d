import core.stdc.stdio: printf;
import std.algorithm: min;

nothrow pure @safe
ulong levenshteinDistance(ref string str1, ref string str2) {
    const m = str1.length;
    const n = str2.length;
    auto matrix = new ulong[][](m+1, n+1);

    foreach(i; 0..m+1)
        matrix[i][0] = i;
    foreach(j; 0..n+1)
        matrix[0][j] = j;

    foreach(i; 1..m+1)
        foreach(j; 1..n+1) {
            int cost = str1[i-1] == str2[j-1] ? 0 : 1;
            matrix[i][j] = min(
                    matrix[i-1][j] + 1,
                    matrix[i][j-1] + 1,
                    matrix[i-1][j-1] + cost
                    );
        }
    return matrix[m][n];
}

void main(string[] args) {
    long min_distance = -1;
    int times = 0;
    const len = args.length;
    foreach(i; 1..len)
        foreach(j; 1..len)
            if (i != j) {
                times++;
                auto distance = levenshteinDistance(args[i], args[j]);
                if (min_distance == -1 || distance < min_distance)
                    min_distance = distance;
            }
    printf("times: %d\n", times);
    printf("min_distance: %ld\n", min_distance);
}
