#set heading(outlined: false)

// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("状态、转移和初值必须对应同一计数口径。最小值不可达设正无穷，最大值设负无穷；复杂度按状态数乘转移成本估算。")

#text("训练优先级：A 优先掌握，B 常用进阶，C 拓展储备；不是题目官方难度。每条参考链接用于追溯知识，应用情景和边界由本文重新整理。")

=== #text("DP-01 [A] 状态维度交换：按价值记最小重量") <trick-dp-01>

*问题概述*　#text("背包容量极大，但所有物品价值之和不大，求容量内的最大价值。")

*必要思路*　#text("令 dp[v] 为取得价值 v 的最小重量，初始 dp[0]=0，其余为 INF；每个物品倒序更新价值。最终找 dp[v]≤容量的最大 v。复杂度 O(nΣv)，要求价值为非负整数。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("DP-02 [A] 只记支配其他方案的状态") <trick-dp-02>

*问题概述*　#text("求严格上升子序列长度，直接记所有结尾会出现大量重复状态。")

*必要思路*　#text("同样长度下，末尾更小的方案能接上至少同样多的后续元素，故只保留最小末尾；用 lower_bound 更新 tails，O(n log n)。非降序换 upper_bound；tails 数组本身通常不是原序列中的一条答案。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]。

=== #text("DP-03 [A] 省掉可由守恒关系恢复的维度") <trick-dp-03>

*问题概述*　#text("两种物品共取 i 个，朴素状态同时记录两种数量，复杂度过高。")

*必要思路*　#text("只记一种数量 j，另一种必为 i-j。类似地，总量固定时可省掉一类资源、一个坐标或一个人数。先验证剩余信息足以决定所有后续合法性和代价，不能仅因“相关”就删维。此为状态压缩应用的自行归纳。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("DP-04 [A] 把大量具体历史压成等价类别") <trick-dp-04>

*问题概述*　#text("每天选活动，但不能连续两天选同一种，求最大总收益。")

*必要思路*　#text("未来只关心上一天活动的类别，不关心更早历史，记 dp[i][last] 即可。更一般地，两个历史若对所有未来具有相同合法转移与增量贡献，就能合并。必须能证明这种未来等价，而非凭状态值相近合并。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("DP-05 [A] 贡献提前计算：等待成本") <trick-dp-05>

*问题概述*　#text("数轴上路灯一直产生费用，人在某位置出发，逐个移动并关闭路灯，最小化总费用。")

*必要思路*　#text("按坐标排序。经过的灯顺手关闭不劣，因此已关闭部分形成包含起点的区间；若起点不是灯的位置，插入费用率为 0 的虚拟灯并从该单点初始化。记 dp[l][r][side]。每走 Δ距离，直接加“当前所有未关闭灯的费用率之和×Δ距离”，无需记录累计时间。要求移动时间与距离成正比、费用率非负。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。

=== #text("DP-06 [B] 一次决策给所有未来对象加费用") <trick-dp-06>

*问题概述*　#text("任务按顺序分批，每批增加启动时间 S，目标为各任务完成时间乘权重的总和。")

*必要思路*　#text("启动一次会让全部尚未完成任务多等 S，把 S×剩余权重和立即计入当前决策。这样可省掉“已分多少批”维度。只适用于本次对未来的影响已确定；影响还依赖未来选择时，要保留必要状态。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。

=== #text("DP-07 [A] 区间求和型转移变前缀和") <trick-dp-07>

*问题概述*　#text("每人最多拿 a[i] 颗糖，恰好分配 K 颗的方案数；朴素转移枚举拿多少。")

*必要思路*　#text("dp[i][j]=Σdp[i-1][j-t]，t∈[0,a[i]]。前一层做前缀和，查询 [max(0,j-a[i]),j]，降至 O(nK)。负下标视为 0，取模减法归一化；必须查询完整上一层。")

*实现提示*　#text("例：第 i 类最多取 a[i] 个，求总数恰好 K 的方案数。复杂度 O(nK)，滚动数组 O(K)。所有加减按题目模数处理。")

*伪代码*（需结合题目接口实现）

#trick-code("old[0] = 1; old[1..K] = 0\nfor each limit a:\n  pref[0] = old[0]\n  for j = 1..K: pref[j] = pref[j-1] + old[j]\n  for j = 0..K:\n    new[j] = pref[j]\n    if j-a-1 >= 0: new[j] -= pref[j-a-1]\n  old = new\nanswer = old[K]")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("DP-08 [B] 滑动范围内的最优决策") <trick-dp-08>

*问题概述*　#text("dp[i]=c[i]+min(dp[j]+b[j])，合法 j 落在随 i 单调移动的区间。")

*必要思路*　#text("把 dp[j]+b[j] 存入单调队列，新决策按值淘汰不可能再优的旧决策，窗口左边界到达时弹出过期项。仅当加入顺序及过期顺序可维护时成立；窗口乱跳不能直接用。该式是单调队列模型的自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/stack_queue_modification.html")[#text("CP-Algorithms：双栈与最小队列")]。

=== #text("DP-09 [B] 多重背包按余数类拆成队列") <trick-dp-09>

*问题概述*　#text("每种物品重量 w、价值 v、最多 c 件，普通枚举件数太慢。")

*必要思路*　#text("容量写成 r+kw。在同一余数 r 内，转移化为 kv+max(dp_old[r+tw]-tv)，t∈[k-c,k]，用滑动最大值队列。每种物品 O(容量)；读旧层，避免错误复用。")

*实现提示*　#text("例：重量 w>0、价值 v、最多 c 件，容量至多 K。old 是上一类物品结束后的数组；每个余数单独清空队列。恰好容量模式跳过不可达 old 状态。每类 O(K)。")

*伪代码*（需结合题目接口实现）

#trick-code("for r = 0..min(w-1, K):\n  deque q = empty  // stores (index, value)\n  for t = 0..floor((K-r)/w):\n    while q not empty and q.front.index < t-c:\n      q.pop_front()\n    if old[r+t*w] is reachable:\n      value = old[r+t*w] - t*v\n      while q not empty and q.back.value <= value:\n        q.pop_back()\n      q.push_back((t, value))\n    new[r+t*w] = -INF\n    if q not empty:\n      new[r+t*w] = t*v + q.front.value")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("DP-10 [A] 背包循环顺序本身就是约束") <trick-dp-10>

*问题概述*　#text("相同的一维转移，为什么有时每件只能用一次，有时可无限次？")

*必要思路*　#text("0/1 背包容量倒序，让右侧读取旧层；完全背包正序，让新状态继续使用当前物品。分组背包读旧组，不能把同组不同物品串起来。若重量为 0，须单独分析，不能机械套循环。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("DP-11 [A] 计数时区分组合与排列") <trick-dp-11>

*问题概述*　#text("若干正整数面额凑出总和 S，求方案数，答案是否考虑选择顺序？")

*必要思路*　#text("面额在外、金额正序在内，通常得到按面额数量区分的无序组合；金额在外、枚举最后一个面额，得到有序序列。重复面额是否代表不同种类要先定义；面额 0 会破坏有限计数。这里从最后一步分类自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("DP-12 [B] 两种端点代价用两棵最值结构") <trick-dp-12>

*问题概述*　#text("dp[i]=min_j(dp[j]+|x[i]-x[j]|)，还要求 j<i；坐标无序。")

*必要思路*　#text("按 x[j]≤x[i] 和 x[j]≥x[i] 拆开，分别维护 dp[j]-x[j] 的前缀最小值与 dp[j]+x[j] 的后缀最小值。离散化加线段树，先查询再插入，O(n log n)。若决策有额外限制，要同步维护。此为绝对值分类的自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("DP-13 [B] 二维偏序 DP：同值批量查询") <trick-dp-13>

*问题概述*　#text("每个点有 (x,y) 和权重，只能从 x、y 都严格更小的点转移。")

*必要思路*　#text("按 x 排序，用树状数组维护 y 前缀最优值。相同 x 的点先全部查询，再统一加入；y 查询到 rank(y)-1。否则会在同一 x 组内部错误转移。若允许等号，需按实际偏序重新确定顺序。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]；#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。

=== #text("DP-14 [A] 从“最后一次操作”设计区间 DP") <trick-dp-14>

*问题概述*　#text("相邻石堆合并，合并代价是两堆总重量，求合并全部石堆的最小代价。")

*必要思路*　#text("最后一次必把 [l,k] 与 [k+1,r] 合并，dp[l][r]=min_k(dp[l][k]+dp[k+1][r])+sum(l,r)。按区间长度递增计算，朴素 O(n³)。先固定最后操作，常比枚举第一步清楚。")

*参考*　#link("https://oi-wiki.org/dp/interval/")[#text("OI Wiki：区间 DP")]。

=== #text("DP-15 [A] 环形 DP：复制成链") <trick-dp-15>

*问题概述*　#text("环上的石堆、首尾相邻区间操作，答案可在任意断点开始。")

*必要思路*　#text("复制数组成为长度 2n 的链，计算长度不超过 n 的区间，枚举 [i,i+n-1]。这适用于解能在某个断点线性化的区间模型；要求绕环多次或有全局首尾约束时，复制不是完整解法。")

*参考*　#link("https://oi-wiki.org/dp/interval/")[#text("OI Wiki：区间 DP")]。

=== #text("DP-16 [B] 消除与合并：区间外接长度") <trick-dp-16>

*问题概述*　#text("相同颜色块可以合并后一起删除，删除长度 k 的收益为 k²，二维区间状态不够。")

*必要思路*　#text("设 dp[l][r][k]：区间 l..r 右侧额外连着 k 个与 a[r] 同色块。可直接删右端，或先清空中间再把右端并到同色位置。非线性收益使外接长度影响未来，不能提前把每块收益独立结算。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。

=== #text("DP-17 [A] 概率 DP：保存分布而非所有过程") <trick-dp-17>

*问题概述*　#text("抛 n 枚概率不同的硬币，求正面数达到某个阈值的概率。")

*必要思路*　#text("dp[j] 记当前恰好 j 个正面的概率，每枚用 p 和 1-p 转移。所有排列过程只通过正面数影响答案，因此可合并；一维倒序更新要同时保留原 dp[j]。最终按题目阈值求和。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("DP-18 [B] 自环期望移到左边") <trick-dp-18>

*问题概述*　#text("某状态有 p 概率原地停留，其余概率进入更小状态，求完成的期望步数。")

*必要思路*　#text("E=1+pE+Σq_iE_i，故 E=(1+Σq_iE_i)/(1-p)。先消去自环再递推；p=1 且无终止机会时，期望可能无穷。有多状态环通常要联立方程，不能只消掉自己的自环。")

*参考*　#link("https://www.luogu.com/article/ms32f221")[#text("洛谷：概率和期望")]。

=== #text("DP-19 [B] 双路径同步：两人的步数其实相同") <trick-dp-19>

*问题概述*　#text("两个旅行者从网格左上走到右下，每次只能向右或向下，最大化收集收益，同格只计一次。")

*必要思路*　#text("两人到达坐标都满足 x+y=t，记 dp[t][x1][x2]，由 t 得到两个 y，四种前一步方向组合转移；位置相同时只加一份收益。四坐标压成三维，障碍与不可达置 -INF。此为同步状态压缩的自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("DP-20 [B] 集合分组：固定最小未分配元素") <trick-dp-20>

*问题概述*　#text("把 n 个对象划分成若干无序组，每组有预处理好的价值，求最大总价值或方案数。")

*必要思路*　#text("dp[S] 枚举包含 S 中某个固定元素（如最低位）的子集 T，以 T 作为一组，再接 dp[S\\T]。这样每个无序划分只有一种生成顺序，不会因组选取顺序重复计数。常见 O(3^n)。")

*实现提示*　#text("例：把 n 个元素划分为若干无序组，cost[T] 是单组代价。固定当前集合的最低位所在组，避免按组排列重复计数。朴素 O(3^n)，只枚举合法组时可减小常数。")

*伪代码*（需结合题目接口实现）

#trick-code("dp[0] = 0; dp[other masks] = INF\nfor nonempty mask in increasing numeric order:\n  bit = mask & (-mask)\n  rest = mask ^ bit\n  enumerate every submask S of rest, including 0:\n    group = S | bit\n    if group is legal and dp[mask ^ group] reachable:\n      dp[mask] = min(dp[mask],\n                     cost[group] + dp[mask ^ group])")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。

=== #text("DP-21 [A] 集合里已经隐含了“第几步”") <trick-dp-21>

*问题概述*　#text("n 个任务与 n 个人一一匹配，求合法分配数。")

*必要思路*　#text("dp[S] 记前 popcount(S) 个人已经分配给集合 S 中任务的方案数，下一人由集合大小确定，无需单独记录人数。每个未选任务检查匹配条件，O(n2^n)。人与任务的顺序须固定。")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。

=== #text("DP-22 [B] 轮廓状态：只记未来可见的边界") <trick-dp-22>

*问题概述*　#text("窄网格铺砖，整张棋盘状态太大，但宽度很小。")

*必要思路*　#text("逐行或逐格扫描，只记当前边界哪些格子已被跨边界砖占用；边界后面的历史不再影响未来。复杂度指数应落在较小的宽度上，可先转置网格；涉及连通性时还需记录连接关系，而非仅占用位。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/profile-dynamics.html")[#text("CP-Algorithms：轮廓 DP")]。

=== #text("DP-23 [A] 数位 DP：把区间变两个前缀") <trick-dp-23>

*问题概述*　#text("求 [L,R] 中满足数位和、相邻位限制或余数条件的整数数量。")

*必要思路*　#text("实现 F(x) 统计 0..x，答案 F(R)-F(L-1)。状态保存位置、必要性质、tight 和前导零语义；只有已脱离上界的状态才可跨相同上下文复用。L=0 时定义 F(-1)=0。")

*参考*　#link("https://oi-wiki.org/dp/number/")[#text("OI Wiki：数位 DP")]。

=== #text("DP-24 [B] 数位 DP 记录数量与总和") <trick-dp-24>

*问题概述*　#text("求符合数位限制的所有整数之和，不只求个数。")

*必要思路*　#text("每个状态维护 (cnt,sum)。接下一位 d 时，总和增加 old_sum×base+old_cnt×d；或按位权加 old_cnt×d×base^位置。无需把整个数值再开为状态。算平方和时另存二阶矩，并展开平方。此为线性贡献的自行推导。")

*参考*　#link("https://oi-wiki.org/dp/number/")[#text("OI Wiki：数位 DP")]。

=== #text("DP-25 [B] 数位上界巨大：用自动机与余数") <trick-dp-25>

*问题概述*　#text("禁止若干数位串，求长达数百位的上界内满足约束的整数数目。")

*必要思路*　#text("用字符串自动机状态概括已读前缀对禁串匹配的影响，再与余数、tight 组合。命中禁串的状态不转移；前导零是否参与匹配由题意决定。这是有限历史压缩的应用，状态量需相乘估算。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("DP-26 [A] 最优值与最优方案数一起维护") <trick-dp-26>

*问题概述*　#text("求最短代价及取得该代价的方案数，单独计数会把非最优方案混入。")

*必要思路*　#text("状态保存 (best,cnt)：更优转移覆盖两者，等值转移只累加 cnt。起点 cnt=1，不可达 cnt=0。若有零权环且按游走计数，最优方案可能无限；还要确保不同转移代表不同方案。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("DP-27 [B] 斜率优化先把式子拆成 i、j 两部分") <trick-dp-27>

*问题概述*　#text("dp[i]=min_{j<i}(dp[j]+(s[i]-s[j])²+C)。")

*必要思路*　#text("展开为 s[i]²+C+min_j((-2s[j])s[i]+dp[j]+s[j]²)，每个 j 是一条直线。斜率和查询点单调时可用单调凸包；否则考虑李超树或可二分查询的凸包。交叉乘积用足够宽整数。")

*参考*　#link("https://oi-wiki.org/dp/opt/slope/")[#text("OI Wiki：斜率优化")]。

=== #text("DP-28 [C] 分治优化：先证明决策单调") <trick-dp-28>

*问题概述*　#text("分段 DP：dp[t][i]=min_{j<i}(dp[t-1][j]+cost(j+1,i))，O(kn²) 太慢。")

*必要思路*　#text("若同一层最优切点 opt[i] 随 i 单调，用分治计算中点，并把左右区间候选范围限制在 opt[mid] 两侧，常达每层 O(n log n)。前一层必须已算完，区间代价查询也要计入复杂度。")

*实现提示*　#text("恰分 t 个非空段。调用 compute(t,n,t-1,n-1)，prev 是完整上一层；最小下标打破平局。只有证明 opt 单调后才能用，每层 O(n log n) 次代价查询。")

*伪代码*（需结合题目接口实现）

#trick-code("compute(L, R, optL, optR):\n  if L > R: return\n  mid = floor((L+R)/2)\n  bestValue = INF; bestJ = -1\n  for j = optL..min(optR, mid-1):\n    if prev[j] is unreachable: continue\n    value = prev[j] + cost(j+1, mid)\n    if bestJ == -1 or value < bestValue:\n      bestValue = value; bestJ = j\n  cur[mid] = bestValue\n  assert bestJ != -1  // valid layer must have a cut\n  compute(L, mid-1, optL, bestJ)\n  compute(mid+1, R, bestJ, optR)")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/divide-and-conquer-dp.html")[#text("CP-Algorithms：分治优化 DP")]。

=== #text("DP-29 [C] Knuth 优化：区间最优切点夹逼") <trick-dp-29>

*问题概述*　#text("区间转移枚举切点 k，怀疑可把 O(n³) 降为 O(n²)。")

*必要思路*　#text("对标准 dp[l][r]=w(l,r)+min_k(dp[l][k]+dp[k+1][r])，在满足所需单调性与四边形不等式时，有 opt[l][r-1]≤opt[l][r]≤opt[l+1][r]。只枚举该范围；不是所有区间 DP 都满足，收益符号变化尤其要重证。")

*参考*　#link("https://oi-wiki.org/dp/opt/quadrangle/")[#text("OI Wiki：四边形不等式优化")]。

=== #text("DP-30 [C] WQS：把恰好 K 次变成惩罚次数") <trick-dp-30>

*问题概述*　#text("恰好选 K 段或做 K 次操作的最优值，次数维度太贵，而不限次数问题很好做。")

*必要思路*　#text("每选一次加惩罚 λ，求 (代价,次数)，二分 λ 找次数跨越 K 的位置。同值时固定选更多或更少，保证实现的次数单调。仅有单调性不足以保证恢复恰好 K 的最优解，还需离散凸性或相应模型证明。")

*实现提示*　#text("这里只给惩罚参数搜索框架。check(lambda) 的转移、参数范围和答案恢复都由模型证明；计数会跳跃时，不能任取一个最优解再减 lambda*K。离散凸模型还须找到 K 对应的支撑参数。")

*伪代码*（需结合题目接口实现）

#trick-code("check(lambda):\n  solve unrestricted DP with each chosen part costing lambda\n  compare by (penalized_cost, -part_count)\n  return optimal (penalized_cost, part_count)\n\n// lambda grows -> returned part_count does not increase\n// choose lo,hi that bracket count K, proved from the model\nwhile lo < hi:\n  mid = floor((lo+hi)/2)\n  if check(mid).part_count <= K: hi = mid\n  else: lo = mid+1\n// inspect supporting parameter(s) near lo\n// recover F(K) only after proving strong duality for this model")

*参考*　#link("https://oi-wiki.org/dp/opt/wqs-binary-search/")[#text("OI Wiki：WQS 二分")]。

=== #text("DP-31 [C] Slope Trick：不枚举巨大整数坐标") <trick-dp-31>

*问题概述*　#text("把 a[i] 修改成非降序 b[i]，最小化 Σ|a[i]-b[i]|，值域巨大。")

*必要思路*　#text("dp 转移是取前缀最小值再加绝对值，形成凸分段线性函数。用堆维护斜率变化点，可 O(n log n) 求最小值。此例可逐个把 a[i] 插入大根堆；若堆顶大于 a[i]，加差值并把堆顶替换为 a[i]。恢复 b 需额外记录。")

*实现提示*　#text("本例是非降序 L1 回归，不是所有 Slope Trick 的通用板。价值和答案用宽整数；O(n log n) 时间、O(n) 空间，只求最优值。")

*伪代码*（需结合题目接口实现）

#trick-code("max_heap H = empty\nanswer = 0\nfor x in a:\n  H.push(x)\n  if H.top() > x:\n    answer += H.top() - x\n    H.pop()\n    H.push(x)\nreturn answer")

*参考*　#link("https://usaco.guide/adv/slope-trick")[#text("USACO Guide：Slope Trick")]。

=== #text("DP-32 [B] 连续段 DP：按值插入而非按位置填") <trick-dp-32>

*问题概述*　#text("给互异的数安排一个排列，费用依赖相邻数值关系，逐个选排列元素会到 2^n 或 n!。")

*必要思路*　#text("按数值排序后依次插入，记录当前已形成的连续段数；新点可独立成段、接一段或连两段。若费用依赖两个全局端点，还需端点状态。转移系数必须按实际空槽数推导，不能只照搬“段数×2”。")

*参考*　#link("https://www.luogu.com/article/vv9lgu8h")[#text("洛谷 MatrixGroup：连续段 DP")]。

=== #text("DP-33 [B] 有限状态转移用矩阵加速") <trick-dp-33>

*问题概述*　#text("长度为 10^18 的序列满足固定局部限制，求总数；每步状态种类很少。")

*必要思路*　#text("把一次转移写成矩阵，快速幂求 T^长度。计数在加乘半环，最短定长路径可换 min-plus 半环；初始向量方向与乘法顺序须一致。位置相关转移只有周期等结构存在时才能一起幂。")

*参考*　#link("https://cp-algorithms.com/algebra/binary-exp.html")[#text("CP-Algorithms：快速幂")]。

=== #text("DP-34 [A] 恢复方案：保留真正的前驱") <trick-dp-34>

*问题概述*　#text("DP 只存最优值，但题目还要求选取的下标或完整方案。")

*必要思路*　#text("每次最优值更新记录来源；滚动数组时不能让前驱引用后来被覆盖的状态，可保留分层前驱或不变节点。LIS 用原位置与 predecessor 链恢复，不能直接输出 tails。计数任务还须规定同值选哪个前驱。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]。

=== #text("DP-35 [B] DAG DP：把过程看成有向无环状态图") <trick-dp-35>

*问题概述*　#text("每次操作都会让资源减少或阶段推进，状态不规则，不好安排数组循环。")

*必要思路*　#text("以严格递增或递减的量给状态排序，在拓扑顺序上转移；状态稀疏时用记忆化搜索只访问可达点。记忆化必须区分未计算与值为 0；若操作可回到旧状态，先处理环，不能仍当 DAG。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("DP-36 [B] 区间跳过子树：把依赖背包变序列 DP") <trick-dp-36>

*问题概述*　#text("选树上的点，选某点必须选它的全部祖先，预算为 K，求最大价值。")

*必要思路*　#text("先做 DFS 前序。处理到 u 时，要么付费用选 u 并进入下一个位置，要么不选 u、直接跳到整棵子树后面。子树是连续区间，因而可用位置与预算做 O(nK) 转移。仅适用于“不选祖先就必须整棵跳过”的依赖方向。自行推导。")

*实现提示*　#text("前序节点为 node[0..n-1]，out[u] 是子树后的首个位置。dp[i][b] 表示将要处理位置 i、已花 b 的最大价值。零费用也可用，位置始终增加；O(nK) 时间与空间。")

*伪代码*（需结合题目接口实现）

#trick-code("dp[0][0] = 0; other states = -INF\nfor i = 0..n-1:\n  u = node[i]\n  for b = 0..K:\n    if dp[i][b] unreachable: continue\n    // skip u and all descendants\n    dp[out[u]][b] = max(dp[out[u]][b], dp[i][b])\n    // choose u, next node may be a child or another subtree\n    if b + weight[u] <= K:\n      dp[i+1][b+weight[u]] = max(\n        dp[i+1][b+weight[u]], dp[i][b] + value[u])\nanswer = max(dp[n][0..K])")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。

