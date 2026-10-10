#set heading(outlined: false)

// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("状态、转移和初值必须对应同一计数口径。最小值不可达设正无穷，最大值设负无穷；复杂度按状态数乘转移成本估算。")

#text("每条先给明确问题模型，再给必要思路与适用条件。参考链接用于追溯知识，应用情景由本文重新整理。")

=== #text("状态维度交换：按价值记最小重量") <trick-dp-01>

*问题概述*　#text("给定 ")$n$#text(" 件物品，第 ")$i$#text(" 件重量为非负整数 ")$w_i$#text("、价值为非负整数 ")$v_i$#text("，每件至多选一次。背包容量为 ")$C$#text("，允许不装满，求所选物品总重量不超过 ")$C$#text(" 时的最大总价值；适用规模是 ")$C$#text(" 很大而 ")$V= sum  v_i$#text(" 可枚举。")

*必要思路*　#text("令 ")$op("dp")_(v)$#text(" 为取得价值 ")$v$#text(" 的最小重量，初始 ")$op("dp")_(0)=0$#text("，其余为 INF；每个物品倒序更新价值。最终找 ")$op("dp")_(v)≤$#text("容量的最大 ")$v$#text("。复杂度 ")$O(n  sum  v)$#text("，要求价值为非负整数。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("只记录支配其他方案的状态") <trick-dp-02>

*问题概述*　#text("给定长度为 ")$n$#text(" 的可比较数值序列 ")$a$#text("，求满足 ")$i_1<…<i_k$#text(" 且 ")$a_(i_1)<…<a_(i_k)$#text(" 的最大 ")$k$#text("。相等元素不能延长子序列，本条只求长度，不要求直接从最小末尾数组恢复方案。")

*必要思路*　#text("同样长度下，末尾更小的方案能接上至少同样多的后续元素，故只保留最小末尾；用 lower_bound 更新 tails，")$O(n log n)$#text("。非降序换 upper_bound；tails 数组本身通常不是原序列中的一条答案。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]。

=== #text("省掉可由守恒关系恢复的维度") <trick-dp-03>

*问题概述*　#text("进行 ")$n$#text(" 步选择，每一步恰选 ")$A$#text("、")$B$#text(" 两类中的一类，第 ")$i$#text(" 步选择两类的收益分别为 ")$A_i$#text("、")$B_i$#text("。要求最终恰有 ")$K$#text(" 步选 ")$A$#text("，求最大收益；处理完 ")$i$#text(" 步时两类已选次数之和必为 ")$i$#text("。")

*必要思路*　#text("只记一种数量 ")$j$#text("，另一种必为 i-j。类似地，总量固定时可省掉一类资源、一个坐标或一个人数。先验证剩余信息足以决定所有后续合法性和代价，不能仅因“相关”就删维。此为状态压缩应用的自行归纳。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("把大量具体历史压成等价类别") <trick-dp-04>

*问题概述*　#text("给定 ")$n$#text(" 天、")$m$#text(" 类活动及收益 ")$w_(i,j)$#text("，每天必须选择一类活动，且相邻两天不能选择同一类。求 ")$n$#text(" 天总收益的最大值；除这条相邻约束外，收益不依赖历史选择。")

*必要思路*　#text("未来只关心上一天活动的类别，不关心更早历史，记 ")$op("dp")_(i,op("last"))$#text(" 即可。更一般地，两个历史若对所有未来具有相同合法转移与增量贡献，就能合并。必须能证明这种未来等价，而非凭状态值相近合并。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("贡献提前计算：等待成本") <trick-dp-05>

*问题概述*　#text("数轴上有 ")$n$#text(" 盏灯，第 ")$i$#text(" 盏位于 ")$x_i$#text("，未关闭时每单位时间产生非负费用 ")$c_i$#text("。人从坐标 ")$s$#text(" 在时刻 0 出发，以单位速度移动，关闭经过的灯不耗时；所有灯最终必须关闭。求从出发到全部关闭的累计费用 ")$sum  c_i t_i$#text("，其中 ")$t_i$#text(" 是第 ")$i$#text(" 盏灯的关闭时刻。")

*必要思路*　#text("按坐标排序。经过的灯顺手关闭不劣，因此已关闭部分形成包含起点的区间；若起点不是灯的位置，插入费用率为 0 的虚拟灯并从该单点初始化。记 ")$op("dp")_(l,r,op("side"))$#text("。每走 Δ距离，直接加“当前所有未关闭灯的费用率之和")$Δ$#text("距离”，无需记录累计时间。要求移动时间与距离成正比、费用率非负。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。

=== #text("一次决策给所有未来对象加费用") <trick-dp-06>

*问题概述*　#text("给定顺序固定的 ")$n$#text(" 个任务，处理时长 ")$t_i≥0$#text("、权重 ")$f_i≥0$#text("。把任务划分为若干非空连续批次，单机依次处理；每批先耗启动时间 ")$S≥0$#text("，再处理该批任务，同批所有任务的完成时刻均为该批结束时刻。求 ")$sum  f_i C_i$#text(" 的最小值，允许自行决定批次边界。")

*必要思路*　#text("启动一次会让全部尚未完成任务多等 ")$S$#text("，把 ")$S$#text("剩余权重和立即计入当前决策。这样可省掉“已分多少批”维度。只适用于本次对未来的影响已确定；影响还依赖未来选择时，要保留必要状态。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。

=== #text("区间求和型转移变前缀和") <trick-dp-07>

*问题概述*　#text("有 ")$n$#text(" 个有编号的人及 ")$K$#text(" 颗不可区分的糖。给第 ")$i$#text(" 人的糖数 ")$x_i$#text(" 必须满足 ")$0≤x_i≤a_i$#text("，所有 ")$a_i$#text("、")$K$#text(" 为非负整数。求满足 ")$sum  x_i=K$#text(" 的分配向量个数，按题目给定模数取模。")

*必要思路*　#text("")$op("dp")_(i,j)= sum  op("dp")_(i-1,j-t)$#text("，")$t∈[0,a_(i)]$#text("。前一层做前缀和，查询 ")$[max(0,j-a_(i)),j]$#text("，降至 ")$O(n K)$#text("。负下标视为 0，取模减法归一化；必须查询完整上一层。")

*实现提示*　#text("例：第 ")$i$#text(" 类最多取 ")$a_(i)$#text(" 个，求总数恰好 ")$K$#text(" 的方案数。复杂度 ")$O(n K)$#text("，滚动数组 ")$O(K)$#text("。所有加减按题目模数处理。")

*伪代码*（需结合题目接口实现）

#trick-code("old[0] = 1; old[1..K] = 0\nfor each limit a:\n  pref[0] = old[0]\n  for j = 1..K: pref[j] = pref[j-1] + old[j]\n  for j = 0..K:\n    new[j] = pref[j]\n    if j-a-1 >= 0: new[j] -= pref[j-a-1]\n  old = new\nanswer = old[K]")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("滑动范围内的最优决策") <trick-dp-08>

*问题概述*　#text("给定初值 ")$op("dp")_0$#text("、数组 ")$c_i$#text("、")$b_i$#text("，以及整数端点 ")$L_i$#text("、")$R_i$#text("；满足 ")$0≤L_i≤R_i<i$#text("，且 ")$L_i$#text("、")$R_i$#text(" 都随 ")$i$#text(" 非降。按 ")$i$#text(" 递增计算 ")$op("dp")_i=c_i+min_(L_i≤j≤R_i)(op("dp")_j+b_j)$#text("，目标是在线性时间内完成全部转移。")

*必要思路*　#text("把 ")$op("dp")_(j)+b_(j)$#text(" 存入单调队列，新决策按值淘汰不可能再优的旧决策，窗口左边界到达时弹出过期项。仅当加入顺序及过期顺序可维护时成立；窗口乱跳不能直接用。该式是单调队列模型的自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/stack_queue_modification.html")[#text("CP-Algorithms：双栈与最小队列")]。

=== #text("多重背包按余数类拆成队列") <trick-dp-09>

*问题概述*　#text("给定 ")$n$#text(" 类物品，第 ")$i$#text(" 类每件重量 ")$w_i>0$#text("、价值 ")$v_i$#text("，可选件数为整数 ")$0…c_i$#text("。背包容量 ")$K$#text("，允许空选及不装满，求重量不超过 ")$K$#text(" 的最大价值；要求每类转移不再枚举所有可选件数。")

*必要思路*　#text("容量写成 ")$r+k w$#text("。在同一余数 ")$r$#text(" 内，转移化为 ")$k v+max(op("dp")_op("old")_(r+t w)-t v)$#text("，")$t∈[k-c,k]$#text("，用滑动最大值队列。每种物品 ")$O$#text("(容量)；读旧层，避免错误复用。")

*实现提示*　#text("例：重量 w>0、价值 ")$v$#text("、最多 ")$c$#text(" 件，容量至多 ")$K$#text("。old 是上一类物品结束后的数组；每个余数单独清空队列。恰好容量模式跳过不可达 old 状态。每类 ")$O(K)$#text("。")

*伪代码*（需结合题目接口实现）

#trick-code("for r = 0..min(w-1, K):\n  deque q = empty  // stores (index, value)\n  for t = 0..floor((K-r)/w):\n    while q not empty and q.front.index < t-c:\n      q.pop_front()\n    if old[r+t*w] is reachable:\n      value = old[r+t*w] - t*v\n      while q not empty and q.back.value <= value:\n        q.pop_back()\n      q.push_back((t, value))\n    new[r+t*w] = -INF\n    if q not empty:\n      new[r+t*w] = t*v + q.front.value")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("背包循环顺序本身就是约束") <trick-dp-10>

*问题概述*　#text("给定物品重量 ")$w_i>0$#text("、价值 ")$v_i$#text(" 和容量 ")$K$#text("，分别考虑每件至多取一次、每类可无限次取、同一组至多取一件三种模型。各模型均求重量不超过 ")$K$#text(" 的最大价值，要求用一维容量数组实现且严格遵守各自使用次数约束。")

*必要思路*　#text("")$0/1$#text(" 背包容量倒序，让右侧读取旧层；完全背包正序，让新状态继续使用当前物品。分组背包读旧组，不能把同组不同物品串起来。若重量为 0，须单独分析，不能机械套循环。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/knapsack.html")[#text("CP-Algorithms：背包")]。

=== #text("计数时区分组合与排列") <trick-dp-11>

*问题概述*　#text("给定互不相同的正整数面额 ")$c_1…c_m$#text("，每种可使用任意非负次数，目标金额 ")$S≥0$#text("。分别求：满足 ")$sum  c_i x_i=S$#text(" 的数量向量个数；面额序列之和为 ")$S$#text(" 的有序序列个数。第二种按元素顺序区分，")$S=0$#text(" 都计唯一空方案。")

*必要思路*　#text("面额在外、金额正序在内，通常得到按面额数量区分的无序组合；金额在外、枚举最后一个面额，得到有序序列。重复面额是否代表不同种类要先定义；面额 0 会破坏有限计数。这里从最后一步分类自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("两种端点代价用两棵最值结构") <trick-dp-12>

*问题概述*　#text("给定任意顺序的坐标 ")$x_1…x_n$#text("、常数增量 ")$c_1…c_n$#text(" 及 ")$op("dp")_0=0$#text("、")$x_0$#text("。对 ")$i≥1$#text("，定义 ")$op("dp")_i=c_i+min_(0≤j<i)(op("dp")_j+|x_i-x_j|)$#text("。求 ")$op("dp")_n$#text("；合法前驱仅由 j<i 决定，坐标可重复，不能先按坐标重新安排计算次序。")

*必要思路*　#text("按 ")$x_j≤x_i$#text(" 和 ")$x_j≥x_i$#text(" 拆开，分别维护 ")$op("dp")_j-x_j$#text(" 的前缀最小值与 ")$op("dp")_j+x_j$#text(" 的后缀最小值。得到两侧最小值后加上 ")$c_i$#text("；坐标离散化并用线段树维护，先查询再插入，")$O(n log n)$#text("。不可达前驱跳过；若增加额外前驱限制，要同步维护。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("二维偏序 DP：同值批量查询") <trick-dp-13>

*问题概述*　#text("给定 ")$n$#text(" 个点 ")$(x_i,y_i)$#text("，每点权重 ")$w_i$#text("。选择一条点序列，使两坐标沿序列都严格递增，收益为所选点权重之和。允许选择空序列，求最大收益；同 ")$x$#text(" 或同 ")$y$#text(" 的两个点不能互相转移。")

*必要思路*　#text("按 ")$x$#text(" 排序，用树状数组维护 ")$y$#text(" 前缀最优值。相同 ")$x$#text(" 的点先全部查询，再统一加入；")$y$#text(" 查询到 ")$op("rank")(y)-1$#text("。否则会在同一 ")$x$#text(" 组内部错误转移。若允许等号，需按实际偏序重新确定顺序。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]；#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。

=== #text("从“最后一次操作”设计区间 DP") <trick-dp-14>

*问题概述*　#text("给定线性排列的 ")$n$#text(" 堆石子，初始第 ")$i$#text(" 堆重量 ")$a_i≥0$#text("。每次只能合并两堆相邻的石子，新堆重量为两者之和，本次费用也等于该和。必须合并成一堆，求所有合并费用之和的最小值。")

*必要思路*　#text("最后一次必把 [l,k] 与 ")$[k+1,r]$#text(" 合并，")$op("dp")_(l,r)=min_k(op("dp")_(l,k)+op("dp")_(k+1,r))+sum(l,r)$#text("。按区间长度递增计算，朴素 ")$O(n^3)$#text("。先固定最后操作，常比枚举第一步清楚。")

*参考*　#link("https://oi-wiki.org/dp/interval/")[#text("OI Wiki：区间 DP")]。

=== #text("环形 DP：复制成链") <trick-dp-15>

*问题概述*　#text("给定环上依次排列的 ")$n$#text(" 堆石子，重量 ")$a_i≥0$#text("，首尾也相邻。每次合并两堆当前相邻的石子，费用为合并后重量，直至只剩一堆。求最小总费用；操作不改变环上的相对次序。")

*必要思路*　#text("复制数组成为长度 2n 的链，计算长度不超过 ")$n$#text(" 的区间，枚举 ")$[i,i+n-1]$#text("。这适用于解能在某个断点线性化的区间模型；要求绕环多次或有全局首尾约束时，复制不是完整解法。")

*参考*　#link("https://oi-wiki.org/dp/interval/")[#text("OI Wiki：区间 DP")]。

=== #text("消除与合并：区间外接长度") <trick-dp-16>

*问题概述*　#text("给定颜色序列 ")$a_1…a_n$#text("。一次操作选择当前序列中一段连续且同色的 ")$k$#text(" 个元素，删除它们并获得 ")$k^2$#text(" 分；删除后左右剩余部分重新相邻。必须删除全部元素，求最大总得分，不能把原来不相邻的同色块直接合并。")

*必要思路*　#text("设 ")$op("dp")_(l,r,k)$#text("：区间 ")$l dots.h r$#text(" 右侧额外连着 ")$k$#text(" 个与 ")$a_(r)$#text(" 同色块。可直接删右端，或先清空中间再把右端并到同色位置。非线性收益使外接长度影响未来，不能提前把每块收益独立结算。")

*参考*　#link("https://www.luogu.com.cn/article/bvovtmzp")[#text("洛谷 LgxTpre：费用提前计算")]。

=== #text("概率 DP：保存分布而非所有过程") <trick-dp-17>

*问题概述*　#text("有 ")$n$#text(" 枚相互独立的硬币，第 ")$i$#text(" 枚出现正面的概率为 ")$p_i∈[0,1]$#text("。每枚恰抛一次，给定整数阈值 ")$0≤K≤n$#text("，求正面总数至少 ")$K$#text(" 的概率；各硬币的概率允许不同。")

*必要思路*　#text("")$op("dp")_(j)$#text(" 记当前恰好 ")$j$#text(" 个正面的概率，每枚用 ")$p$#text(" 和 ")$1-p$#text(" 转移。所有排列过程只通过正面数影响答案，因此可合并；一维倒序更新要同时保留原 ")$op("dp")_(j)$#text("。最终按题目阈值求和。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("自环期望移到左边") <trick-dp-18>

*问题概述*　#text("给定有限随机状态过程，终止状态到达后不再行动。非终止状态 ")$s$#text(" 每步耗时 1，以概率 ")$p_s<1$#text(" 留在原状态，以概率 ")$q_(s,t)$#text(" 进入拓扑顺序更早的状态 ")$t$#text("，且 ")$p_s+ sum  q_(s,t)=1$#text("。求从指定状态出发到终止的期望步数。")

*必要思路*　#text("")$E=1+p E+ sum  q_i E_i$#text("，故 ")$E=(1+ sum  q_i E_i)/(1-p)$#text("。先消去自环再递推；")$p=1$#text(" 且无终止机会时，期望可能无穷。有多状态环通常要联立方程，不能只消掉自己的自环。")

*参考*　#link("https://www.luogu.com/article/ms32f221")[#text("洛谷：概率和期望")]。

=== #text("双路径同步：两人的步数其实相同") <trick-dp-19>

*问题概述*　#text("给定 ")$n m$#text(" 网格，每格有收益 ")$w_(x,y)$#text("，部分格子为障碍。两条路径均从 (1,1) 到 (n,m)，每步只向右或向下；一格被一条或两条路径经过都只计一次收益。求两条合法路径收益并集的最大总和，若起终点被阻挡或无路径则报告无解。")

*必要思路*　#text("两人到达坐标都满足 ")$x+y=t$#text("，记 ")$op("dp")_(t,x_(1),x_(2))$#text("，由 ")$t$#text(" 得到两个 ")$y$#text("，四种前一步方向组合转移；位置相同时只加一份收益。四坐标压成三维，障碍与不可达置 -INF。此为同步状态压缩的自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("集合分组：固定最小未分配元素") <trick-dp-20>

*问题概述*　#text("给定 ")$n$#text(" 个有编号对象，以及每个非空子集 ")$T$#text(" 的单组代价 ")$op("cost")_(T)$#text(" 或合法性。把所有对象恰好划分成若干非空、互不相交的合法组，每个对象属于一组，组之间无顺序。求各组代价之和的最小值；计数变形中也必须把同一无序划分只计一次。")

*必要思路*　#text("令 ")$op("dp")_(S)$#text(" 为恰好划分集合 ")$S$#text(" 的最小代价，")$op("dp")_(0)=0$#text("。枚举包含 ")$S$#text(" 中最低位的合法组 ")$T$#text("，转移为 ")$op("dp")_S=min_(T subset.eq S, b in T)(op("cost")_T+op("dp")_(S without T))$#text("，其中 ")$b$#text(" 是固定元素。固定一组的代表元素，使同一无序划分只生成一次；计数版本把最小值改成方案数求和。总枚举量 ")$O(3^n)$#text("。")

*实现提示*　#text("例：把 ")$n$#text(" 个元素划分为若干无序组，")$op("cost")_(T)$#text(" 是单组代价。固定当前集合的最低位所在组，避免按组排列重复计数。朴素 ")$O(3^n)$#text("，只枚举合法组时可减小常数。")

*伪代码*（需结合题目接口实现）

#trick-code("dp[0] = 0; dp[other masks] = INF\nfor nonempty mask in increasing numeric order:\n  bit = mask & (-mask)\n  rest = mask ^ bit\n  enumerate every submask S of rest, including 0:\n    group = S | bit\n    if group is legal and dp[mask ^ group] reachable:\n      dp[mask] = min(dp[mask],\n                     cost[group] + dp[mask ^ group])")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。

=== #text("集合里已经隐含了“第几步”") <trick-dp-21>

*问题概述*　#text("给定 ")$n$#text(" 个人、")$n$#text(" 个任务及布尔矩阵 ")$o k_(i,j)$#text("，表示第 ")$i$#text(" 人能否执行第 ")$j$#text(" 个任务。每人恰分配一个任务，每个任务恰分配一次，求合法双射的个数；人和任务均按编号区分。")

*必要思路*　#text("")$op("dp")_(S)$#text(" 记前 popcount(S) 个人已经分配给集合 ")$S$#text(" 中任务的方案数，下一人由集合大小确定，无需单独记录人数。每个未选任务检查匹配条件，")$O(n 2^n)$#text("。人与任务的顺序须固定。")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。

=== #text("轮廓状态：只记未来可见的边界") <trick-dp-22>

*问题概述*　#text("给定 ")$h w$#text(" 的矩形棋盘，部分格子禁用。用不限数量的 ")$1 2$#text(" 或 ")$2 1$#text(" 骨牌恰好覆盖所有可用格，每格被覆盖一次，骨牌不能穿过禁用格。求铺法数；适用条件是 min(h,w) 足够小，可以枚举边界占用掩码。")

*必要思路*　#text("逐行或逐格扫描，只记当前边界哪些格子已被跨边界砖占用；边界后面的历史不再影响未来。复杂度指数应落在较小的宽度上，可先转置网格；涉及连通性时还需记录连接关系，而非仅占用位。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/profile-dynamics.html")[#text("CP-Algorithms：轮廓 DP")]。

=== #text("数位 DP：把区间变两个前缀") <trick-dp-23>

*问题概述*　#text("给定非负整数 ")$L≤R$#text(" 以及判定整数合法性的有限数位状态规则，例如数位和模 ")$m$#text("、相邻数位禁配。求 [L,R] 中合法整数个数，按通常十进制表示判断，不把前导零当作实际数位；整数 0 是否合法由规则明确规定。")

*必要思路*　#text("实现 ")$F(x)$#text(" 统计 ")$0 dots.h x$#text("，答案 ")$F(R)-F(L-1)$#text("。状态保存位置、必要性质、tight 和前导零语义；只有已脱离上界的状态才可跨相同上下文复用。")$L=0$#text(" 时定义 ")$F(-1)=0$#text("。")

*参考*　#link("https://oi-wiki.org/dp/number/")[#text("OI Wiki：数位 DP")]。

=== #text("数位 DP 记录数量与总和") <trick-dp-24>

*问题概述*　#text("给定非负整数 ")$L≤R$#text(" 及有限数位状态规则，求该区间内所有合法整数的数值总和，而非仅求数量。允许要求对指定模数取模；前导零和整数 0 的合法性须与计数版本保持一致。")

*必要思路*　#text("每个状态维护合法前缀数量 ")$c$#text(" 及这些前缀数值之和 ")$s$#text("。十进制接入一位 ")$d$#text(" 后，本次转移对新状态贡献 ")$c'=c, quad s'=10 s+c d$#text("，再将所有合法转移的贡献相加。最终将合法终态的总和汇总即可。无需把完整数值开为状态；若还求平方和，需要额外二阶矩并展开 ")$(10x+d)^2$#text("。")

*参考*　#link("https://oi-wiki.org/dp/number/")[#text("OI Wiki：数位 DP")]。

=== #text("数位上界巨大：用自动机与余数") <trick-dp-25>

*问题概述*　#text("给定十进制上界字符串 ")$N$#text("、有限禁串集合 ")$F$#text("、正整数 ")$m$#text(" 及 ")$0≤r<m$#text("。求 ")$0≤x≤N$#text(" 中满足 ")$x≡r (mod m)$#text("、且通常十进制表示不含 ")$F$#text(" 中任一串的整数个数，答案按给定模数取模；0 的表示固定为单个字符“0”。")

*必要思路*　#text("用字符串自动机状态概括已读前缀对禁串匹配的影响，再与余数、tight、started（是否已有实际数位）组合。尚未 started 的补位零不送入自动机；开始后每位都参与匹配，命中禁串的状态不转移。扫描结束仍未 started 的唯一分支表示整数 0，须按单个字符“0”检查禁串，并检查余数条件。状态量按各维大小相乘估算。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

=== #text("最优值与最优方案数一起维护") <trick-dp-26>

*问题概述*　#text("给定有限有向无环图、起点 ")$s$#text("、终点 ")$t$#text(" 及每条有编号边的代价。按经过的边序列区分路径，求 ")$s$#text(" 到 ")$t$#text(" 的最小总代价以及达到该代价的路径数；不可达时输出无解，平行边视为不同选择。")

*必要思路*　#text("按拓扑序处理状态 (best,cnt)。起点为 (0,1)，其余不可达且计数 0；更优转移覆盖两者，等值转移只累加 cnt。不同有编号边分别产生路径，累计按题目取模。DAG 无环，路径数有限；若扩展到有环图，零权环可能导致最优游走数量无限。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("斜率优化先把式子拆成 i、j 两部分") <trick-dp-27>

*问题概述*　#text("给定前缀量 ")$s_0=0,s_1…s_n$#text("、常数 ")$C$#text(" 和 ")$op("dp")_0=0$#text("。按 ")$i$#text(" 递增计算 ")$op("dp")_i=min_(0≤j<i)(op("dp")_j+(s_i-s_j)^2+C)$#text("，求 ")$op("dp")_n$#text("。")$s_i$#text(" 是否单调必须从输入条件判断，不能在使用单调凸包时额外假设。")

*必要思路*　#text("展开为 ")$s_(i)^2+C+min_j((-2s_(j))s_(i)+op("dp")_(j)+s_(j)^2)$#text("，每个 ")$j$#text(" 是一条直线。斜率和查询点单调时可用单调凸包；否则考虑李超树或可二分查询的凸包。交叉乘积用足够宽整数。")

*参考*　#link("https://oi-wiki.org/dp/opt/slope/")[#text("OI Wiki：斜率优化")]。

=== #text("分治优化：先证明决策单调") <trick-dp-28>

*问题概述*　#text("给定长度 ")$n$#text(" 的序列、可查询的区间代价 cost(l,r) 和整数 ")$1≤K≤n$#text("。将序列恰分成 ")$K$#text(" 个非空连续段，最小化代价之和。已证明固定层 ")$t$#text(" 的最优切点 ")$op("opt")_t(i)$#text(" 随 ")$i$#text(" 非降，要求利用这一性质加速分段 DP。")

*必要思路*　#text("若同一层最优切点 ")$op("opt")_(i)$#text(" 随 ")$i$#text(" 单调，用分治计算中点，并把左右区间候选范围限制在 ")$op("opt")_(op("mid"))$#text(" 两侧，常达每层 ")$O(n log n)$#text("。前一层必须已算完，区间代价查询也要计入复杂度。")

*实现提示*　#text("恰分 ")$t$#text(" 个非空段。调用 ")$op("compute")(t,n,t-1,n-1)$#text("，prev 是完整上一层；最小下标打破平局。只有证明 opt 单调后才能用，每层 ")$O(n log n)$#text(" 次代价查询。")

*伪代码*（需结合题目接口实现）

#trick-code("compute(L, R, optL, optR):\n  if L > R: return\n  mid = floor((L+R)/2)\n  bestValue = INF; bestJ = -1\n  for j = optL..min(optR, mid-1):\n    if prev[j] is unreachable: continue\n    value = prev[j] + cost(j+1, mid)\n    if bestJ == -1 or value < bestValue:\n      bestValue = value; bestJ = j\n  cur[mid] = bestValue\n  assert bestJ != -1  // valid layer must have a cut\n  compute(L, mid-1, optL, bestJ)\n  compute(mid+1, R, bestJ, optR)")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/divide-and-conquer-dp.html")[#text("CP-Algorithms：分治优化 DP")]。

=== #text("Knuth 优化：区间最优切点夹逼") <trick-dp-29>

*问题概述*　#text("给定区间代价 w(l,r)，定义 ")$op("dp")_(l,l)=0$#text("、")$op("dp")_(l,r)=w(l,r)+min_(l≤k<r)(op("dp")_(l,k)+op("dp")_(k+1,r))$#text("。对任意 ")$a≤b≤c≤d$#text("，已知 ")$w(b,c)≤w(a,d)$#text(" 且 ")$w(a,c)+w(b,d)≤w(a,d)+w(b,c)$#text("。求 ")$op("dp")_(1,n)$#text("，要求总复杂度 ")$O(n^2)$#text("，不允许把这两条条件省略为对所有区间 DP 都成立。")

*必要思路*　#text("对标准 ")$op("dp")_(l,r)=w(l,r)+min_k(op("dp")_(l,k)+op("dp")_(k+1,r))$#text("，在满足所需单调性与四边形不等式时，有 ")$op("opt")_(l,r-1)≤op("opt")_(l,r)≤op("opt")_(l+1,r)$#text("。只枚举该范围；不是所有区间 DP 都满足，收益符号变化尤其要重证。")

*参考*　#link("https://oi-wiki.org/dp/opt/quadrangle/")[#text("OI Wiki：四边形不等式优化")]。

=== #text("WQS：把恰好 K 次变成惩罚次数") <trick-dp-30>

*问题概述*　#text("给定一个按选择次数 ")$k$#text(" 分类的优化模型，")$F(k)$#text(" 是恰使用 ")$k$#text(" 次决策的最小原始代价，目标为 ")$F(K)$#text("。已知对任意惩罚 λ 可高效求 ")$min_k(F(k)+λ k)$#text(" 及对应次数；只有额外证明 ")$F$#text(" 的离散凸性或相应强对偶条件时，才要求从惩罚搜索恢复恰好 ")$K$#text(" 次的答案。")

*必要思路*　#text("每选一次加惩罚 λ，求 (代价,次数)，二分 λ 找次数跨越 ")$K$#text(" 的位置。同值时固定选更多或更少，保证实现的次数单调。仅有单调性不足以保证恢复恰好 ")$K$#text(" 的最优解，还需离散凸性或相应模型证明。")

*实现提示*　#text("这里只给惩罚参数搜索框架。check(lambda) 的转移、参数范围和答案恢复都由模型证明；计数会跳跃时，不能任取一个最优解再减 ")$op("lambda")*K$#text("。离散凸模型还须找到 ")$K$#text(" 对应的支撑参数。")

*伪代码*（需结合题目接口实现）

#trick-code("check(lambda):\n  solve unrestricted DP with each chosen part costing lambda\n  compare by (penalized_cost, -part_count)\n  return optimal (penalized_cost, part_count)\n\n// lambda grows -> returned part_count does not increase\n// choose lo,hi that bracket count K, proved from the model\nwhile lo < hi:\n  mid = floor((lo+hi)/2)\n  if check(mid).part_count <= K: hi = mid\n  else: lo = mid+1\n// inspect supporting parameter(s) near lo\n// recover F(K) only after proving strong duality for this model")

*参考*　#link("https://oi-wiki.org/dp/opt/wqs-binary-search/")[#text("OI Wiki：WQS 二分")]。

=== #text("Slope Trick：不枚举巨大整数坐标") <trick-dp-31>

*问题概述*　#text("给定整数序列 ")$a_1…a_n$#text("，选择整数序列 ")$b_1≤…≤b_n$#text("，允许 ")$b_i$#text(" 在整个整数域取值。修改代价为 ")$sum |a_i-b_i|$#text("，求最小代价；本条只求最优值，不要求输出 ")$b$#text("，不能把单调性改成严格递增后原样套用。")

*必要思路*　#text("dp 转移是取前缀最小值再加绝对值，形成凸分段线性函数。用堆维护斜率变化点，可 ")$O(n log n)$#text(" 求最小值。此例可逐个把 ")$a_(i)$#text(" 插入大根堆；若堆顶大于 ")$a_(i)$#text("，加差值并把堆顶替换为 ")$a_(i)$#text("。恢复 ")$b$#text(" 需额外记录。")

*实现提示*　#text("本例是非降序 L1 回归，不是所有 Slope Trick 的通用板。价值和答案用宽整数；")$O(n log n)$#text(" 时间、")$O(n)$#text(" 空间，只求最优值。")

*伪代码*（需结合题目接口实现）

#trick-code("max_heap H = empty\nanswer = 0\nfor x in a:\n  H.push(x)\n  if H.top() > x:\n    answer += H.top() - x\n    H.pop()\n    H.push(x)\nreturn answer")

*参考*　#link("https://usaco.guide/adv/slope-trick")[#text("USACO Guide：Slope Trick")]。

=== #text("连续段 DP：按值插入而非按位置填") <trick-dp-32>

*问题概述*　#text("给定 ")$n$#text(" 个互异整数 ")$a_i$#text(" 和非负预算 ")$B$#text("，把它们各使用一次排成排列 ")$p$#text("。排列代价为 ")$sum _(i=1)^(n-1)|p_i-p_(i+1)|$#text("，求代价不超过 ")$B$#text(" 的排列数；按有序排列计数，反向排列通常视为不同方案。")

*必要思路*　#text("按值排序后从小到大加入元素，状态记录已加入元素形成的连续块数 ")$j$#text("、已确定全局端点数 ")$e∈(0,1,2)$#text(" 和累计代价。相邻值差 Δ 出现时，尚未闭合的边端数为 ")$2j-e$#text("，先增加 ")$(2j-e)Δ$#text(" 的代价。新点可独立成块、接一块或连接两块；还须标记是否作为最终首尾。转移重数按合法开放端数推导，末态只有一块且两个端点已确定，不能把无序块当有序排列少计。")

*参考*　#link("https://www.luogu.com/article/vv9lgu8h")[#text("洛谷 MatrixGroup：连续段 DP")]。

=== #text("有限状态转移用矩阵加速") <trick-dp-33>

*问题概述*　#text("给定 ")$m$#text(" 个有限状态、固定转移计数矩阵 ")$T$#text("、初始状态计数向量 ")$v_0$#text(" 和长度 ")$L$#text("，可达 ")$10^18$#text("。每一步都使用同一个 ")$T$#text("，求 ")$L$#text(" 步后落在指定终止状态集合的路径数，按模数取模；状态转移不随位置变化。")

*必要思路*　#text("采用列向量约定，")$T$#text(" 的第 (to,from) 项是从 from 到 to 的一步转移数，")$v_L=T^L v_0$#text("。用快速幂在 ")$O(m^3 log L)$#text(" 时间计算矩阵幂，再汇总目标状态。最短定长路径可改为 min-plus 半环，但初始值及乘法都要相应改。位置相关转移只有周期等结构存在时才能合成后幂。")

*参考*　#link("https://cp-algorithms.com/algebra/binary-exp.html")[#text("CP-Algorithms：快速幂")]。

=== #text("恢复方案：保留真正的前驱") <trick-dp-34>

*问题概述*　#text("给定 ")$n$#text(" 件物品，重量 ")$w_i≥0$#text("、价值 ")$v_i$#text("，每件至多选择一次，容量 ")$K$#text("。除求最大总价值外，还要输出一组达到最优值的原物品编号，每个编号最多出现一次；使用滚动 DP 时也必须保证重建链指向真实历史状态。")

*必要思路*　#text("每次最优值更新记录来源；滚动数组时不能让前驱引用后来被覆盖的状态，可保留分层前驱或不变节点。LIS 用原位置与 predecessor 链恢复，不能直接输出 tails。计数任务还须规定同值选哪个前驱。")

*参考*　#link("https://cp-algorithms.com/dynamic_programming/longest_increasing_subsequence.html")[#text("CP-Algorithms：最长上升子序列")]。

=== #text("DAG DP：把过程看成有向无环状态图") <trick-dp-35>

*问题概述*　#text("给定有限有向无环图、边权以及起点 ")$s$#text("、终点 ")$t$#text("，求 ")$s$#text(" 到 ")$t$#text(" 的最大路径权重和，不可达时报告无解。边权可为负，合法路径必须沿图中有向边；要求依据拓扑依赖计算状态，而不是仅按节点编号循环。")

*必要思路*　#text("以严格递增或递减的量给状态排序，在拓扑顺序上转移；状态稀疏时用记忆化搜索只访问可达点。记忆化必须区分未计算与值为 0；若操作可回到旧状态，先处理环，不能仍当 DAG。")

*参考*　#link("https://www.luogu.com.cn/article/ki71nw88")[#text("洛谷：DP 题方法总汇")]。

==== #text("延伸：一般 DAG 的拓扑序数量")

*延伸问题*　#text("给定 ")$n$#text(" 个有编号节点的 DAG，统计全部节点排列 π，使每条边 u→v 都满足 ")$u$#text(" 在 ")$v$#text(" 之前。只按节点排列计数，重复边不产生不同方案；本方法要求 ")$n$#text(" 小到可以开 ")$2^n$#text(" 数组，例如 ")$n≤22$#text("。")

*必要思路*　#text("令 ")$op("pre")_(v)$#text(" 为 ")$v$#text(" 的直接前驱掩码，")$op("dp")_(S)$#text(" 为已经输出节点集合恰为 ")$S$#text(" 的合法前缀数。只有 ")$v$#text("∉")$S$#text(" 且 ")$op("pre")_(v)⊆S$#text(" 才能把 ")$v$#text(" 加到末尾；每个完整排列有唯一前缀链，因此不重不漏。复杂度 ")$O(n 2^n)$#text("，空间 ")$O(2^n)$#text("，一般 DAG 不能仅靠节点数套阶乘或树公式。")

#trick-code("dp[0] = 1; dp[other masks] = 0\nfor S = 0..(1<<n)-1:\n  for v = 0..n-1:\n    if ((S>>v)&1) == 0 and (pre[v]&S) == pre[v]:\n      dp[S|(1<<v)] += dp[S]\nanswer = dp[(1<<n)-1]")

*参考*　#link("https://oi-wiki.org/dp/state/")[#text("OI Wiki：状压 DP")]。

==== #text("延伸：拓扑序什么时候唯一")

*延伸问题*　#text("给定 DAG，判断它是否恰有一种完整节点拓扑序，不需要计算精确数量，")$n$#text("、")$m$#text(" 可以很大。空图 ")$n=0$#text(" 约定有唯一空序列。")

*必要思路*　#text("运行 Kahn 算法。每一步当前剩余图都恰有一个入度 0 节点时，下一节点被强制，故序列唯一；某一步出现两个可选节点，它们之间没有剩余依赖，可以分别作为下一节点，得到两种完整拓扑序。若输入不保证无环，还须检查是否输出全部节点；有环时数量是 0。时间 ")$O(n+m)$#text("。")

*依据*　由定义推导，证明或边界已给出。

==== #text("延伸：有根森林的祖先先行排列数")

*延伸问题*　#text("给定 ")$n$#text(" 点有根森林，将每条边从父亲指向儿子，要求父亲在儿子之前，统计完整节点排列数。不要求 DFS 连续访问同一子树，不允许任意反转部分边方向；节点均有不同编号。")

*必要思路*　#text("设 ")$s_u$#text(" 为含 ")$u$#text(" 的子树大小，答案为 ")$n!/(product_u s_u)$#text("。每棵树的根必须最先，其各儿子合法序列可任意交错；多项式系数与子树方案数相乘，归纳化简得此式。森林相当于补入必须最先的虚根后移除虚根。模数下不可盲目求逆；取质数模且 p>n 时所有因子才都可逆。")

*参考*　#link("https://www.luogu.com.cn/article/7l6qe7u5")[#text("洛谷原创：树的拓扑序计数")]。

==== #text("延伸：互不依赖 DAG 之间的交错")

*延伸问题*　#text("DAG 被分为 ")$k$#text(" 个节点互不相交的分块，分块间没有任何边。第 ")$i$#text(" 块有 ")$n_i$#text(" 个节点、")$c_i$#text(" 种拓扑序，求整个图的拓扑序数；块内不要求是树。")

*必要思路*　#text("先确定每块内部序列，再选择各块占据的全局位置。答案 ")$((sum_i n_i)!)/(product_i n_i!) product_i c_i$#text("，因为交错不改变块内相对顺序。只要存在跨块边，任意交错就不再合法；可按底层无向连通分量分块，而非仅按 SCC 分块。")

*依据*　由定义推导，证明或边界已给出。

=== #text("区间跳过子树：把依赖背包变序列 DP") <trick-dp-36>

*问题概述*　#text("给定有根树，每点 ")$u$#text(" 有非负整数费用 ")$w_u$#text(" 和价值 ")$v_u$#text("。选择一个点集，若选 ")$u$#text(" 则其全部祖先也必须选；允许空集，总费用不得超过 ")$K$#text("。求总价值最大值，目标复杂度为 ")$O(n K)$#text("，不要求容量恰好用满。")

*必要思路*　#text("先做 DFS 前序。处理到 ")$u$#text(" 时，要么付费用选 ")$u$#text(" 并进入下一个位置，要么不选 ")$u$#text("、直接跳到整棵子树后面。子树是连续区间，因而可用位置与预算做 ")$O(n K)$#text(" 转移。仅适用于“不选祖先就必须整棵跳过”的依赖方向。自行推导。")

*实现提示*　#text("前序节点为 ")$op("node")_(0 dots.h n-1)$#text("，")$op("out")_(u)$#text(" 是子树后的首个位置。")$op("dp")_(i,b)$#text(" 表示将要处理位置 ")$i$#text("、已花 ")$b$#text(" 的最大价值。零费用也可用，位置始终增加；")$O(n K)$#text(" 时间与空间。")

*伪代码*（需结合题目接口实现）

#trick-code("dp[0][0] = 0; other states = -INF\nfor i = 0..n-1:\n  u = node[i]\n  for b = 0..K:\n    if dp[i][b] unreachable: continue\n    // skip u and all descendants\n    dp[out[u]][b] = max(dp[out[u]][b], dp[i][b])\n    // choose u, next node may be a child or another subtree\n    if b + weight[u] <= K:\n      dp[i+1][b+weight[u]] = max(\n        dp[i+1][b+weight[u]], dp[i][b] + value[u])\nanswer = max(dp[n][0..K])")

*参考*　#link("https://oi-wiki.org/dp/tree/")[#text("OI Wiki：树形 DP")]。
