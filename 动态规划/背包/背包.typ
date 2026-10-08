`Knapsack(V, exact)` 维护最大价值。`exact=false` 时，`dp[j]` 表示总体积不超过 `j` 的最优值，初始全为零；`exact=true` 时表示总体积恰好等于 `j`，仅 `dp[0]=0`，其余为 `NEG`。允许负价值，允许一种物品数量为零，物品体积必须为正。

- `add01(v,w)`：加入一件物品，容量倒序，时间 $O(V)$。
- `addComplete(v,w)`：加入无限件同类物品，容量正序，时间 $O(V)$。
- `addBoundedBinary(v,w,c)`：把数量拆成 `1,2,4,...,余数`，当成若干 01 物品。先把 `c` 截到 `V/v`，时间 $O(V log(c+1))$。
- `addBoundedQueue(v,w,c)`：按容量模 `v` 的余数分组，每种物品用单调队列做到 $O(V)$。

令容量 `j=r+t*v`，从上一层的 `r+s*v` 转移，需要选 `t-s` 件物品，因而
$ f(r+t v) = t w + max_(max(0,t-c) <= s <= t) (g(r+s v)-s w). $
每个余数组内只需维护一个长度至多 `c+1` 的滑动窗口最大值。代码复制上一层为 `old`，从队头删除过期决策，只把可达状态加入队列；若直接读取正在修改的 `dp`，就会重复使用本类物品。

例如 `Knapsack k(7, true); k.addBoundedQueue(3, 5, 2);` 后，`dp[6]=10`，`dp[7]=NEG`；改成至多容量语义后，`dp[7]=10`。两种多重背包实现可互换，也可和 01、完全背包混用；同一种物品只调用其中一种加入方式。

空间 $O(V)$。价值和内部乘法使用 `i128`，要求有限状态及中间算式的绝对值小于 $2^120$。零体积物品要在外部处理：完全背包中零体积正价值会令答案无界。本板求最大价值，计数背包或“每组恰选一个”的分组背包应另写转移。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/Dynamic-Programming-Talk.pdf")[《浅谈动态规划》PDF 第 29–33 页]；补充单调队列推导与实现。
