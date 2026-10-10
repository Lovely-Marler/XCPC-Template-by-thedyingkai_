#set heading(outlined: false)

// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("默认非负或无符号整数，字长记为 W。ctz/clz 不可传 0，位移量必须小于类型宽度；计数和乘法先扩宽。")

#text("训练优先级：A 优先掌握，B 常用进阶，C 拓展储备；不是题目官方难度。每条参考链接用于追溯知识，应用情景和边界由本文重新整理。")

=== #text("BIT-01 [A] 异或前缀把区间变点对") <trick-bit-01>

*问题概述*　#text("统计异或为 K 的子数组数，枚举所有区间 O(n²)。")

*必要思路*　#text("令 p[0]=0，p[i]=a[1] xor…xor a[i]，条件为 p[l-1]=p[r] xor K。扫描 r，先查询此前前缀次数，再插入 p[r]。初始插入 p[0]；K=0 时若先插入会多计空区间。此为异或消去的自行推导。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("BIT-02 [A] 数对异或和拆成每一位") <trick-bit-02>

*问题概述*　#text("求所有无序数对 a[i] xor a[j] 的总和。")

*必要思路*　#text("第 b 位有 c 个 1、n-c 个 0，贡献 c(n-c)2^b。按位相加，O(nW)，无需枚举数对。若有序则乘 2，求 XOR 后再求和可拆位，但“异或值乘积”等跨位非线性目标不能照套。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-03 [A] 所有子数组的异或值之和") <trick-bit-03>

*问题概述*　#text("数组长 n，求 Σ区间 XOR，不是把所有区间答案再整体 XOR。")

*必要思路*　#text("先得到 n+1 个前缀 XOR，按每一位数 0、1 前缀数，贡献 c0 c1 2^b。每对前缀唯一对应一个非空区间，所以无序配对即可。与“所有区间 XOR 的 XOR”不同，后者是每个元素被包含次数的奇偶。")

*参考*　#link("https://www.luogu.com.cn/article/f3jhcq3e")[#text("洛谷 critnos：位运算技术")]。

=== #text("BIT-04 [A] 所有子集 XOR 的和") <trick-bit-04>

*问题概述*　#text("n 个非负整数，求全部 2^n 个子集的异或值总和。")

*必要思路*　#text("某位只要至少一个元素为 1，就恰在一半子集中为 1：翻转一个该位为 1 的指定元素，配对出相反位值。故 n≥1 时答案为 (所有元素 OR)×2^(n-1)；空子集贡献 0，n=0 答案为 0。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-05 [A] 不用真的做加法：和与异或的进位") <trick-bit-05>

*问题概述*　#text("已知两个非负整数的和 S、异或 X，判断能否构造这两个数。")

*必要思路*　#text("a+b=(a xor b)+2(a and b)，故需 S≥X、S-X 偶数，并令 C=(S-X)/2 满足 C and X=0；可取 a=C、b=C+X。若要求都正或加其他上界，需额外处理。先扩宽类型避免求差与乘法溢出。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-06 [A] 区间 XOR：前缀 0..x 只有四种") <trick-bit-06>

*问题概述*　#text("求连续整数 L..R 的异或，范围可达 10^18。")

*必要思路*　#text("F(x)=0 xor1 xor…xor x，根据 x mod4 分别是 x、1、x+1、0，答案 F(R) xor F(L-1)，定义 F(-1)=0。可将四个连续整数配对证明；x+1 要检查类型上界。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-07 [A] 遍历置位只按 popcount 工作") <trick-bit-07>

*问题概述*　#text("掩码中只有少量有效元素，但逐位扫完整字长。")

*必要思路*　#text("反复 x&=x-1 去掉最低置位；当前位可用 ctz(x) 取得。无符号 x 的 lowbit=x&(-x)，用于枚举每个有效元素。x=0 时停止，避免调用零的 ctz；用 64 位输入就配套 ctzll。")

*参考*　#link("https://cp-algorithms.com/algebra/bit-manipulation.html")[#text("CP-Algorithms：位操作")]。

=== #text("BIT-08 [A] 枚举子掩码与 3^n 复杂度") <trick-bit-08>

*问题概述*　#text("需要枚举 S 的所有子集，或对全部集合枚举其子集。")

*必要思路*　#text("从 sub=S 反复 sub=(sub-1)&S。若包含空集，在处理 sub=0 后退出，不能继续下减。一个掩码有 2^popcount(S) 个子集；枚举所有 (S,sub) 总数为 3^n，每位有不在 S、仅在 S、也在 sub 三种。")

*参考*　#link("https://cp-algorithms.com/algebra/all-submasks.html")[#text("CP-Algorithms：子掩码枚举")]。

=== #text("BIT-09 [B] 固定选 k 个：不枚举全部 2^n") <trick-bit-09>

*问题概述*　#text("只需要枚举 n 个元素中恰好选 k 个的集合，全部掩码再筛 popcount 浪费时间。")

*必要思路*　#text("保存递增位置组合 c[0]<…<c[k-1]。从最右找还能增加的位置，加一后把后续位置依次填为最小合法值，再转换成掩码；总生成 C(n,k) 个组合，朴素每次 O(k)。k=0 输出唯一空集，k>n 无解；必要时再学 Gosper 位技巧。")

*参考*　#link("https://cp-algorithms.com/combinatorics/generating_combinations.html")[#text("CP-Algorithms：固定大小组合枚举")]。

=== #text("BIT-10 [B] 超集枚举转补集子集") <trick-bit-10>

*问题概述*　#text("枚举全集 U 中包含 S 的所有掩码，直接测试全部掩码太慢。")

*必要思路*　#text("剩余自由位为 U xor S，枚举其子掩码 T，输出 S or T。U 必须是题目有限位域，不能直接把机器字 ~S 当全集。复杂度 2^(W-popcount(S))；S 不是 U 子集时先判非法。自行推导。")

*参考*　#link("https://cp-algorithms.com/algebra/all-submasks.html")[#text("CP-Algorithms：子掩码枚举")]。

=== #text("BIT-11 [B] SOS：每个集合的全部子集之和") <trick-bit-11>

*问题概述*　#text("对全部掩码 S 求 F[S]=Σ_{T⊆S}f[T]，逐子集枚举为 3^n。")

*必要思路*　#text("按位做高维前缀和：第 b 位为 1 时 F[S]+=F[S xor(1<<b)]，总 O(n2^n)。做超集和时反向传播；若只要找最大子集值，运算改 max。注意是逐位分阶段，不能任意一次遍历就完成全部传播。")

*参考*　#link("https://usaco.guide/plat/dp-sos")[#text("USACO Guide：SOS DP")]。

=== #text("BIT-12 [B] 不相交查询取有限全集补集") <trick-bit-12>

*问题概述*　#text("对每个掩码 S，找与 S 按位不相交的已有掩码 T，求最大权或数量。")

*必要思路*　#text("T and S=0 等价于 T⊆(U xor S)。先按精确掩码聚合，再做 SOS 子集最大值或求和，查询补集位置。全集位数不大才可开 2^W；不存在的最大值用 -INF，不能用 0 混淆负权。")

*参考*　#link("https://usaco.guide/plat/dp-sos")[#text("USACO Guide：SOS DP")]。

=== #text("BIT-13 [B] 固定右端点的 AND/OR 只有少量不同值") <trick-bit-13>

*问题概述*　#text("统计所有子数组 AND/OR，或找某个结果出现次数，O(n²) 太大。")

*必要思路*　#text("保存以 r-1 结尾的不同值与次数，和 a[r] 做 AND/OR 后合并相邻重复值，再加入单点。延长区间时每位只能从 1→0（AND）或 0→1（OR），所以每个右端点仅 O(W) 个值。次数也要聚合。自行推导。")

*实现提示*　#text("例：统计所有子数组 AND 等于 K 的个数。cur 保存以当前右端点结束的 (AND值,数量)；相同结果在这一链中连续，可相邻合并。O(nW) 时间、O(W) 空间。OR 版本把 & 换成 |。")

*伪代码*（需结合题目接口实现）

#trick-code("cur = empty; answer = 0\nfor x in a:\n  next = [(x, 1)]\n  for (value, count) in cur:\n    y = value & x\n    if next.back.value == y:\n      next.back.count += count\n    else:\n      next.push_back((y, count))\n  cur = next\n  for (value, count) in cur:\n    if value == K: answer += count")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-14 [B] 固定左端点的 AND/OR 可跳变化点") <trick-bit-14>

*问题概述*　#text("要对某起点所有区间结果贡献求和，但结果只会变化 W 次。")

*必要思路*　#text("用稀疏表或区间结构查询 AND/OR，通过单调性二分当前值能保持到的最远右端点，一次处理整段。每个端点最多 O(W) 种结果；XOR 不单调，不能照用变化段方法。自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/sparse-table.html")[#text("CP-Algorithms：Sparse Table")]。

=== #text("BIT-15 [A] 优化 AND 答案：高位试着保留") <trick-bit-15>

*问题概述*　#text("从给定数中选两个或至少 k 个，使它们的按位 AND 最大。")

*必要思路*　#text("从高位到低位试设 cand=ans|(1<<b)，数满足 (a[i]&cand)==cand 的个数；至少 k 个就接受。该集合包含全部已接受位，且数值高位优先，所以贪心成立。若还要求两数和等约束，单纯数个数不够。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-16 [A] 最大 XOR 与可任取子集 XOR 是两种问题") <trick-bit-16>

*问题概述*　#text("求两个现有数的最大异或，或任意子集异或最大，二者题面很像。")

*必要思路*　#text("两个现有数用 01 Trie 高位贪心找反位；任意子集用线性基消元。线性基会生成输入中不存在的组合值，不能代替 Trie 解“恰好两个原数”。有下标限制时查询前只插合法下标。")

*参考*　#link("https://oi-wiki.org/math/linear-algebra/basis/")[#text("OI Wiki：线性基")]。

=== #text("BIT-17 [B] 线性基判可达与计数") <trick-bit-17>

*问题概述*　#text("给 n 个数，问能否选子集异或为 X，有多少这样的子集。")

*必要思路*　#text("将 X 用同一高位基消去，最终为 0 则可达。基秩为 r，每个可达 X 都有 2^(n-r) 个子集映射到它，来自线性映射核维数。空集包含在内；若限制子集大小，单个普通基不够。")

*参考*　#link("https://oi-wiki.org/math/linear-algebra/basis/")[#text("OI Wiki：线性基")]。

=== #text("BIT-18 [B] 全局 XOR 标记不移动 Trie 节点") <trick-bit-18>

*问题概述*　#text("动态数集支持“全部数 xor K”和最大异或查询，逐数修改太慢。")

*必要思路*　#text("维护全局 tag，存底层值 raw=真实值 xor tag；全局修改只 tag xor=K。查询真实 x 的最大异或等价查 raw 与 x xor tag。插入、删除都先翻译坐标；按真实数值排序则需按 tag 的各位解释 Trie 分支。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-19 [A] bitset 背包：布尔状态批量平移") <trick-bit-19>

*问题概述*　#text("若干正整数只能各选一次，判断哪些和可达，容量中等但 n 大。")

*必要思路*　#text("bits[0]=1，每个重量 w 执行 bits|=bits<<w，一次位移并 OR 表示完整旧层的转移，约 O(nV/机器字长)。负重量需平移值域并设计双向位移；求最大价值或精确计数不能直接用布尔 bitset。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("BIT-20 [B] bitset 记录新出现的和以恢复方案") <trick-bit-20>

*问题概述*　#text("用 bitset 背包很快，但仍要找一组物品凑到目标。")

*必要思路*　#text("计算 new=(old<<w)&~old，仅对新出现的和记 (物品编号,前驱和)。每个和首次出现一次，记录总量 O(V)，之后沿前驱恢复；位移前快照须正确。若要最少件数，首次出现不等于最优。此为“每状态只记录一次”的自行推导。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。

=== #text("BIT-21 [B] 二维 0/1 关系压成 bitset") <trick-bit-21>

*问题概述*　#text("统计两点公共邻居数，或做传递闭包，逐个邻居比较太慢。")

*必要思路*　#text("每点邻居压成位集，共同邻居数是 (adj[u]&adj[v]).count()。传递闭包可按 k 阶段，对能达 k 的行 OR reach[k]。仍有 O(n²) 或 O(n³/word) 量级，需估算矩阵内存；不是有位集就变线性。")

*参考*　#link("https://oi-wiki.org/math/bit/")[#text("OI Wiki：位操作")]。

=== #text("BIT-22 [B] 区间中某一位为 1 的个数") <trick-bit-22>

*问题概述*　#text("在 [L,R] 中统计第 b 个二进制位为 1 的整数数目。")

*必要思路*　#text("0..x 中该位周期为 2^(b+1)，每周期后一半为 1：令 m=x+1、h=2^b，数量=(m/(2h))h+max(0,m%(2h)-h)。区间做前缀差。最大位的 2h 与 x+1 可能溢出，必要时用 128 位。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("BIT-23 [B] bitset 小块 RMQ：把单调栈存成掩码") <trick-bit-23>

*问题概述*　#text("静态最值查询很多，希望块内查询 O(1)，又不想写复杂通用 RMQ。")

*必要思路*　#text("在不超过机器字长的小块内，单调栈保存可能成为区间最大值的位置，并为每个右端点保存掩码；移掉 l 之前的位，最低置位位置就是候选最大值。完整块用 ST 表。最值同值弹栈规则必须一致，查询掩码非零再 ctz。")

*参考*　#link("https://www.luogu.com.cn/article/f3jhcq3e")[#text("洛谷 critnos：位运算技术")]。

=== #text("BIT-24 [B] Gray Code：枚举时只改一个元素") <trick-bit-24>

*问题概述*　#text("枚举所有子集时，维护代价很贵，但增删单个元素很便宜。")

*必要思路*　#text("以 g(i)=i xor(i>>1) 的 Gray 顺序枚举，相邻掩码恰差一位；对两个掩码 XOR 后定位该位，执行一次增删更新。总状态仍 2^n，只减少更新成本；n 必须能放入所用整数且可承受枚举量。")

*参考*　#link("https://cp-algorithms.com/algebra/gray-code.html")[#text("CP-Algorithms：Gray Code")]。

=== #text("BIT-25 [A] 有限位域的取反与移位边界") <trick-bit-25>

*问题概述*　#text("掩码求补集或构造全 1，代码在最高位与零输入上错误。")

*必要思路*　#text("使用 unsigned 类型，W 位全集是明确的 U，再做 U xor S。1ULL<<b 仅当 b<64；64 位全 1 用 ~0ULL，不能 (1ULL<<64)-1。GCC 的 ctz/clz 对 0 未定义，C++20 的 countr_zero 等另有定义，不能混淆。")

*参考*　#link("https://cp-algorithms.com/algebra/bit-manipulation.html")[#text("CP-Algorithms：位操作")]。

=== #text("BIT-26 [B] 最高不同位决定 XOR 比较") <trick-bit-26>

*问题概述*　#text("找最大 XOR、比较两个候选异或值，低位信息难组合。")

*必要思路*　#text("若两个候选高于 b 的位相同而 b 位不同，b 位为 1 的异或值一定更大，故从高位决策。Trie 查询可据此贪心；不过存在可行性约束时，所选分支必须含合法候选，不能只看该位有没有 1。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

