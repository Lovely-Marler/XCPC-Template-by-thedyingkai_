`longestIncreasingSubsequence(a, strict)` 返回一条最长子序列在原数组中的 *0 下标*。默认严格递增；`strict=false` 求最长不下降子序列。空输入返回空数组，重复值和负数均可直接处理。

`tail[len-1]` 保存长度为 `len` 的递增子序列所能取得的最小末尾值。末尾越小，后面能够接上的元素越多，因此同长度只需保留最小末尾。严格递增使用 `lower_bound`，不下降使用 `upper_bound`。

`tail` 中的元素来自不同历史时刻，最终的 `tail` 不一定构成原数组的一条子序列。代码在替换末尾前记录 `previous[i]`，再从最长序列的末尾沿前驱重建。例如 `[2,2,1,3]` 的严格 LIS 长度为 `2`，不下降子序列长度为 `3`；两者不能共用相同的二分边界。

时间 $O(n log n)$，空间 $O(n)$。本板不保证返回字典序最小的最优解，也不统计方案数；统计 LIS 个数可在离散化值域上用树状数组维护“最长长度、对应方案数”，并按严格性处理同值元素。

来源：wzj52501，#link("https://github.com/wzj52501/awesome-competitive-olympiad-algorithms/blob/c3685028be8ac258074260f8d8bd825faddc4a76/Lectures/STL-and-Applications.pdf")[《STL 及其应用》最长上升子序列专题]；补充方案重建和严格性开关。说明文字：CC BY-NC-SA 4.0。
