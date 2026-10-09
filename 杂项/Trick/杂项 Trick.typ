// Contest lookup notes; explanations are independently synthesized.
#import "../../template/trick-code.typ": trick-code

#text("没有特定算法归属的技巧集中在这里。二分先证明单调，构造先证明可行；不变量只是必要条件时不能据此宣布可达。")

#text("训练优先级：A 优先掌握，B 常用进阶，C 拓展储备；不是题目官方难度。每条参考链接用于追溯知识，应用情景和边界由本文重新整理。")

=== #text("MISC-01 [A] 正难则反：总数减非法数") <trick-misc-01>

*问题概述*　#text("要求某个复杂性质成立的对象数，但违反性质可由很少条件描述。")

*必要思路*　#text("先数全部，再数补集。例如至少一个指定字符出现=全部字符串-完全不出现。多个非法条件有交集时做容斥或重新分类，不能把各非法数直接相加。具体总数与计数域要一致。")

*参考*　#link("https://cp-algorithms.com/combinatorics/inclusion-exclusion.html")[#text("CP-Algorithms：容斥原理")]。

=== #text("MISC-02 [A] 固定中间元素统计三元组") <trick-misc-02>

*问题概述*　#text("数递增三元组 i<j<k 且 a[i]<a[j]<a[k]，三重枚举太慢。")

*必要思路*　#text("固定 j，数左侧严格更小 L[j]、右侧严格更大 R[j]，贡献 L[j]R[j]，两遍扫描配树状数组。左右条件在固定 j 后独立，所以能相乘；若还有 i、k 间约束，必须保留额外信息。自行推导。")

*参考*　#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。

=== #text("MISC-03 [A] 同一个前缀值：计数与长度存不同东西") <trick-misc-03>

*问题概述*　#text("子数组和恰为 K，题目可能求数量、最长或最短，都是前缀查找。")

*必要思路*　#text("p[l-1]=p[r]-K。求数量存出现次数；求最长存最早位置；求最短存最近位置。先查询再插入当前前缀，以免产生空区间。若要求长度至少 L，要只加入已经满足距离的前缀。自行归纳。")

*参考*　#link("https://oi-wiki.org/basic/prefix-sum/")[#text("OI Wiki：前缀和与差分")]。

=== #text("MISC-04 [A] 恰好 K 种=至多 K 种-至多 K-1 种") <trick-misc-04>

*问题概述*　#text("求包含恰好 K 个不同值的子数组数，直接维护“恰好”不好计数。")

*必要思路*　#text("令 F(K) 为至多 K 种的子数组数，用窗口维护最小合法左端 l，每个右端贡献 r-l+1，答案 F(K)-F(K-1)。K=0 时非空子数组答案 0。此减法适用于嵌套阈值条件，不只不同值。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。

=== #text("MISC-05 [A] 双指针成立的关键是合法性单调") <trick-misc-05>

*问题概述*　#text("求和≤K 的子数组数，想用滑动窗口，但数组可能有负数。")

*必要思路*　#text("非负数组扩大右端不会减小和，移左端不会增大和，才可单调推进。负数破坏性质，例如先超界后又合法；应改用前缀顺序统计等方法。先证明移动方向对条件的影响，再写尺取。")

*参考*　#link("https://oi-wiki.org/misc/two-pointer/")[#text("OI Wiki：双指针")]。

=== #text("MISC-06 [B] 负数最短达标段：前缀单调队列") <trick-misc-06>

*问题概述*　#text("求和至少 K 的最短非空子数组，含负数，普通双指针失败。")

*必要思路*　#text("在前缀和 p 上维护递增队列。当前 p[r]-p[front]≥K 时更新长度并弹头；队尾若 p[back]≥p[r] 则被当前更晚且更小的前缀支配，弹尾。每个前缀至多入出一次，O(n)。检查非空，比较差值用宽类型。自行推导。")

*实现提示*　#text("求和至少 K 的最短非空子数组，允许负数；P 是 64 位前缀和。必须先查询再插入当前下标，否则 K<=0 时会误计空区间。O(n)。")

*伪代码*（需结合题目接口实现）

#trick-code("deque q = empty; best = INF\nfor j = 0..n:\n  while q not empty and P[j]-P[q.front()] >= K:\n    best = min(best, j-q.front()); q.pop_front()\n  while q not empty and P[q.back()] >= P[j]:\n    q.pop_back()\n  q.push_back(j)\nreturn no_solution if best == INF else best")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-07 [A] 区间不同数离线维护最后出现") <trick-misc-07>

*问题概述*　#text("静态数组，多次询问 [l,r] 不同值数量。")

*必要思路*　#text("询问按 r 排序，扫描到 r 时把 a[r] 的上次位置从 1 改 0，当前改 1；树状数组查 l..r。每种值恰留最后一次出现，位于区间就代表该值存在。回答后按询问 ID 还原顺序。自行推导。")

*实现提示*　#text("静态区间不同数个数，询问按右端点排序。BIT 用 1-based 下标，last 默认 0；O((n+q)log n)。同值原位置删除后再标记新位置。")

*伪代码*（需结合题目接口实现）

#trick-code("pos = 0; BIT = zero; last = empty map\nfor query (l,r,id) sorted by r:\n  while pos < r:\n    pos += 1; x = a[pos]\n    if last.get(x,0) != 0: BIT.add(last[x], -1)\n    BIT.add(pos, +1); last[x] = pos\n  answer[id] = BIT.sum(r) - BIT.sum(l-1)")

*参考*　#link("https://cp-algorithms.com/data_structures/fenwick.html")[#text("CP-Algorithms：树状数组")]。

=== #text("MISC-08 [B] 阈值查询变激活顺序") <trick-misc-08>

*问题概述*　#text("许多询问“权值≤X 的点/边中，区间或连通块有多少对象”，在线不好做。")

*必要思路*　#text("把对象按权值、查询按 X 排序，逐步激活所有符合阈值的对象，维护 Fenwick 或 DSU。小于与小于等于决定同权事件先后顺序。需要未来修改历史时，简单一次扫描不再覆盖全部状态。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。

=== #text("MISC-09 [A] 二分答案：检查器可牺牲最优性") <trick-misc-09>

*问题概述*　#text("求最小最大值或最大最小值，直接算最优值很难。")

*必要思路*　#text("改问给定 X 是否可行。只有“X 可行→更宽松阈值可行”的嵌套性成立才可二分；检查器只需判存在，常可贪心，不必同时求最优值。明确整数边界与无解情形，别凭题目出现 max/min 就认定单调。")

*参考*　#link("https://oi-wiki.org/basic/binary/")[#text("OI Wiki：二分")]。

=== #text("MISC-10 [B] 平均/比例最优转判定") <trick-misc-10>

*问题概述*　#text("从合法集合选取元素，最大化 Σa/Σb，且所有合法分母为正。")

*必要思路*　#text("试值 λ，检查是否存在合法选择使 Σ(a-λb)≥0；检查方式由集合约束决定，可排序、DP 或图模型。分母非正会破坏等价，浮点二分需指定误差。恰取 k 项时取变换值最大的 k 项。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-11 [A] 相邻交换次数就是逆序对") <trick-misc-11>

*问题概述*　#text("把一个排列通过相邻交换变成目标顺序，求最少操作。")

*必要思路*　#text("将当前值映射到其目标位置，每次相邻交换至多改变一个逆序，排序过程可恰好消去每个逆序，故最少为逆序数。重复值按同值出现次序稳定匹配到目标位置，否则会引入无谓交换。计数 O(n log n)。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-12 [A] 连续同类元素聚拢：位置减序号") <trick-misc-12>

*问题概述*　#text("选择 k 个相同字符，通过相邻交换使它们连续，求最少代价。")

*必要思路*　#text("其原位置 p[i]，目标为 t+i，代价 Σ|p[i]-i-t|。令 q[i]=p[i]-i，取 q 的中位数，前缀和 O(1) 求每个候选窗口代价。q 的单调性保留；若不同目标字符混杂，不是同一公式。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-13 [A] 排列变换任意交换：看置换环数") <trick-misc-13>

*问题概述*　#text("将一个互异元素排列通过任意两位置交换变成另一个排列，求最少次数。")

*必要思路*　#text("映射到目标位置后，长度 c 的置换环需要且只需 c-1 次交换，总计 n-环数。一次交换最多让环数增 1，是下界；逐环拆开达到下界。相邻交换或交换带权时，该公式不适用。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-14 [B] 截止时间反悔：删掉最长工作") <trick-misc-14>

*问题概述*　#text("每个工作有时长和截止时间，单机可自由排序，求能按期完成的最大工作数。")

*必要思路*　#text("按截止时间升序，加入工作并累计时间；若超过当前截止，弹出已选最长时长。这样同样任务数下尽量保留更短总时间，给未来留空间。目标是任务数且无释放时间，带不同收益时不能照搬。")

*参考*　#link("https://www.luogu.com.cn/article/ip2rnlsd")[#text("洛谷：二叉堆与反悔调度")]。

=== #text("MISC-15 [B] 交换论证推出任务排序比值") <trick-misc-15>

*问题概述*　#text("每个工作耗时 t[i]，权重 w[i]>0，最小化加权完成时间总和。")

*必要思路*　#text("比较相邻 i、j 两种顺序，i在前优于j在前当且仅当 t[i]w[j]≤t[j]w[i]，按 t/w 升序。交叉乘积避免浮点误差，先扩宽。任务有优先依赖或释放时间时，相邻交换可能不合法。")

*参考*　#link("https://cp-algorithms.com/schedules/schedule_one_machine.html")[#text("CP-Algorithms：单机任务调度")]。

=== #text("MISC-16 [A] 扫描线端点顺序就是区间语义") <trick-misc-16>

*问题概述*　#text("统计同时活动的区间数、覆盖长度，端点相同处容易错。")

*必要思路*　#text("闭区间含左右端点，同坐标先加入再查询/删除；半开 [l,r) 在 r 已失效，应先删除再查询。覆盖连续长度时只在相邻坐标间乘活动覆盖状态，孤立端点长度为 0。整数闭区间可变 [l,r+1)，r+1 注意溢出。")

*参考*　#link("https://oi-wiki.org/basic/prefix-sum/")[#text("OI Wiki：前缀和与差分")]。

=== #text("MISC-17 [A] 离散化不能丢掉空隙长度") <trick-misc-17>

*问题概述*　#text("坐标达到 10^18，但只出现少量修改点，想压缩后统计长度/面积。")

*必要思路*　#text("压缩仅保留顺序，原段长度是 x[i+1]-x[i]，不能当成 1。统计整数点时还需区分端点与空隙，或采用半开区间。只做大小比较、排名时压缩为连续编号即可。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-18 [B] 高阶差分：多项式更新降低阶数") <trick-misc-18>

*问题概述*　#text("区间上加线性函数或固定次数多项式，逐位置修改很慢。")

*必要思路*　#text("常数更新用一阶差分两个边界；线性用二阶差分、d 次多项式用 d+1 阶差分，只改 O(d) 个边界附近项，再前缀还原。边界值需按有限差分实际推导，不能只把端点代入一次；在线查询还需相应数据结构。")

*参考*　#link("https://oi-wiki.org/basic/prefix-sum/")[#text("OI Wiki：前缀和与差分")]。

=== #text("MISC-19 [A] 一次交换或修改只影响局部邻接") <trick-misc-19>

*问题概述*　#text("维护相邻元素代价 Σf(a[i],a[i+1])，每次交换两位置，重算全数组太慢。")

*必要思路*　#text("变化只出现在这两个位置的前后相邻边。先收集受影响边编号并去重，减旧贡献、执行交换、加新贡献。相邻位置与相同位置会产生重复边，若不去重会多加多减。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-20 [B] 反转区间只改边界，需对称代价") <trick-misc-20>

*问题概述*　#text("维护 Σ|a[i]-a[i+1]|，支持反转 [l,r] 后求总值。")

*必要思路*　#text("区间内部邻接边仅方向反转，绝对值不变，所以只改 l-1,l 与 r,r+1 两处边界。若 f(x,y)≠f(y,x)，内部贡献并不保持不变，要存正反两种聚合。区间长度 1 和覆盖全数组需跳过不存在边界。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-21 [A] 排序与删除被支配区间要看目标") <trick-misc-21>

*问题概述*　#text("若区间 A 包含 B，能否直接删掉某个区间来简化？")

*必要思路*　#text("覆盖所有给定区间所需的并集时，可删被包含的 B；选尽量多互不重叠区间时，较短 B 可能更好，反而不能删。先证明所有含劣对象的可行方案都能无损替换。删完包含关系后按左端排序，右端才严格单调（同区间去重）。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-22 [B] 第 K 小不必显式列出全部候选") <trick-misc-22>

*问题概述*　#text("所有子数组、数对或乘法表产生海量数值，求第 K 小。")

*必要思路*　#text("二分 X，统计≤X 的候选数 C(X)，找到 C(X)≥K 的最小 X。计数器可在到 K 后截断避免溢出；元素可重复时按多重集计数。若计数仍是二次且无法优化，二分本身并未解决瓶颈。")

*参考*　#link("https://oi-wiki.org/basic/binary/")[#text("OI Wiki：二分")]。

=== #text("MISC-23 [C] 第 K 大用“最大值+区间拆分”") <trick-misc-23>

*问题概述*　#text("所有起点对应一批区间候选，每批能快速找最优者，想依次取出前 K 大。")

*必要思路*　#text("每个候选空间作为一块，把块的最大值和位置放堆；弹出位置 p 后，将该块剩余位置拆成左右两块，再分别求最大并入堆。每个候选恰出一次，常见于前缀和+RMQ。拆分必须覆盖剩余且互不重叠，堆不会自动避免重复。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-24 [B] 折半枚举：两个指数各小一半") <trick-misc-24>

*问题概述*　#text("n≈40，选子集满足总和限制或求最大可行和，2^n 太大。")

*必要思路*　#text("拆两半枚举子集和，排序一半，另一半逐个二分补值；约 O(2^(n/2)log2^(n/2))。要计数就保留频次，求最优需维护支配关系；跨两半还有复杂约束时，不能只留和。")

*参考*　#link("https://oi-wiki.org/search/bidirectional/")[#text("OI Wiki：双向搜索与折半搜索")]。

=== #text("MISC-25 [B] 根号分治：高频与低频分开") <trick-misc-25>

*问题概述*　#text("按值查询某类位置贡献，既有极高频值，也有大量低频值。")

*必要思路*　#text("频率≤B 的值按出现位置暴力，高频值至多 n/B 个，可为每种预处理。写出两侧总成本，如 nB+n²/B，令 B≈√n。数据量和查询数不同应按实际式子选 B，别固定所有问题都取 √n。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-26 [B] 图上高低度分治") <trick-misc-26>

*问题概述*　#text("图上每次给某点所有邻居加值，并查询单点值，遍历邻居代价不稳定。")

*必要思路*　#text("度≤B 的修改直接遍历；度>B 的点只更新懒标记。单点查询加上相邻高点标记；高点≤2m/B 个，预处理高点邻接关系。复杂度约修改 O(B)、查询 O(m/B)，还需计算存储和预处理成本。自行推导。")

*实现提示*　#text("简单无向图中给邻居加值、查询单点。heavyNeighbors[u] 预先存 u 的高点邻居；base 初始化为原值。更新 O(B)，查询 O(m/B)，总预处理 O(n+m)。")

*伪代码*（需结合题目接口实现）

#trick-code("heavy[v] = (degree[v] > B)\nfor every edge (u,v):\n  if heavy[u]: heavyNeighbors[v].push(u)\n  if heavy[v]: heavyNeighbors[u].push(v)\nlazy[all] = 0\nadd_to_neighbors(v, delta):\n  if heavy[v]: lazy[v] += delta\n  else:\n    for u in adj[v]: base[u] += delta\nquery(u):\n  result = base[u]\n  for v in heavyNeighbors[u]: result += lazy[v]\n  return result")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-27 [B] 只操作未处理位置：并查集跳过") <trick-misc-27>

*问题概述*　#text("反复把区间中未染色的位置染色，每点首次染色后不再改变，逐区间遍历超时。")

*必要思路*　#text("维护 next(x) 为不小于 x 的首个未处理位置。处理 x 后让它跳到 next(x+1)，路径压缩后每点仅真正访问一次。要留 n+1 哨兵；若后续允许重新激活或改颜色，此结构不够。")

*参考*　#link("https://cp-algorithms.com/data_structures/disjoint_set_union.html")[#text("CP-Algorithms：并查集应用")]。

=== #text("MISC-28 [A] 只有删除的连通性：倒序变加入") <trick-misc-28>

*问题概述*　#text("图上删边后问连通性，普通并查集无法删边。")

*必要思路*　#text("先把所有待删边去掉建立最终状态，再逆序逐条加入，对应询问在正确时刻回答。重复删同一条边要用次数/有效性处理，否则逆序过早恢复。在线混合增删已不是这条简单套路。")

*参考*　#link("https://cp-algorithms.com/data_structures/disjoint_set_union.html")[#text("CP-Algorithms：并查集应用")]。

=== #text("MISC-29 [B] 对象生存期转时间线段树") <trick-misc-29>

*问题概述*　#text("边或约束有加入与删除，问每个时刻状态，但数据结构支持插入和撤销。")

*必要思路*　#text("求每个对象活跃时间 [l,r)，挂到覆盖这段的时间线段树节点；DFS 入节点加对象，出节点回滚到快照。可回滚 DSU 常用按大小合并并禁路径压缩；一个对象生命周期要正确匹配重加入。")

*实现提示*　#text("先把每次有效加入匹配到下一次删除，生成 [l,r) 并挂到时间线段树。snapshot 记回滚栈长度；DSU 不路径压缩、按大小合并，记录被修改的父亲和大小。重复边需明确按 ID 或出现次数匹配。")

*伪代码*（需结合题目接口实现）

#trick-code("dfs(segment_node):\n  snapshot = history.size()\n  for edge (u,v) stored in this node:\n    unite_by_size(u,v)  // log each actual mutation\n  if this node represents one time t:\n    answer query at t from current DSU\n  else:\n    dfs(left_child); dfs(right_child)\n  while history.size() > snapshot:\n    undo last mutation\n// a lifetime occupies O(log Q) segment nodes\n// DSU find is O(log n) without path compression")

*参考*　#link("https://cp-algorithms.com/data_structures/deleting_in_log_n.html")[#text("CP-Algorithms：离线删除与回滚")]。

=== #text("MISC-30 [B] 双栈队列维护任意结合聚合") <trick-misc-30>

*问题概述*　#text("滑动窗口求 gcd、矩阵乘积等，没有减法，移出左端困难。")

*必要思路*　#text("入栈和出栈各维护前缀聚合，出栈为空就把入栈倒过去。每元素只搬有限次，均摊 O(1) 次合并。非交换运算须让出栈聚合从队首到中间、入栈从中间到队尾，再按顺序合并；不要求逆元。")

*实现提示*　#text("op 是结合运算，e 是单位元。聚合方向覆盖矩阵乘法等非交换运算；空栈聚合取 e。每个元素最多从 in 搬到 out 一次，均摊 O(1) 次 op。")

*伪代码*（需结合题目接口实现）

#trick-code("push(x):\n  in.push((x, op(in.aggregate_or(e), x)))\npop():\n  if out is empty:\n    while in not empty:\n      x = in.pop().value\n      out.push((x, op(x, out.aggregate_or(e))))\n  assert out not empty\n  out.pop()\nquery():\n  return op(out.aggregate_or(e), in.aggregate_or(e))")

*参考*　#link("https://cp-algorithms.com/data_structures/stack_queue_modification.html")[#text("CP-Algorithms：双栈与最小队列")]。

=== #text("MISC-31 [A] 堆删除：用有效版本懒删除") <trick-misc-31>

*问题概述*　#text("维护动态候选最优值，普通优先队列不支持任意删除或修改。")

*必要思路*　#text("每条候选带 ID 与版本，删除/修改只更新该 ID 的有效版本；取堆顶时反复丢弃已失效条目。每条记录只弹一次，可分析总成本。旧条目长期不弹会占内存，必要时定期重建；不能仅按值判断重复对象是否失效。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-32 [A] 全局加减只存一个偏移量") <trick-misc-32>

*问题概述*　#text("集合支持全部元素加 d、插入、删除和最小值查询，逐元素加太慢。")

*必要思路*　#text("维护 offset，实际值=底层值+offset。插入 x 存 x-offset，整体加只改 offset，查询加回来。需要按阈值删除也先翻译阈值；整体乘负数、截断等操作会改顺序，不能只用偏移。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-33 [B] 平方与乘积统计只存几个矩") <trick-misc-33>

*问题概述*　#text("一批数支持整体加 d，并求平方和；逐个改平方很慢。")

*必要思路*　#text("维护数量 c、和 S、平方和 Q，更新 Q'=Q+2dS+cd²、S'=S+cd，右侧 S 用旧值。由展开 (x+d)² 求和得到。乘法与常数先扩宽；更高次可维护更多矩，但每次更新成本随次数增长。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-34 [A] 排序后的全点对绝对差") <trick-misc-34>

*问题概述*　#text("求 Σ_{i<j}|a[i]-a[j]|，二次枚举不必要。")

*必要思路*　#text("排序后，第 i 项作为较大者贡献 i*a[i]-此前前缀和（下标从 0）。累加即可 O(n log n)。负数和重复值都允许，乘法用宽类型；多维 Manhattan 和可按每个坐标独立做，但 Euclidean 距离不行。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-35 [B] 字典序最小：每一步都带可行性检查") <trick-misc-35>

*问题概述*　#text("构造满足约束的最小字典序字符串或排列，局部选最小字符可能卡死。")

*必要思路*　#text("按位置尝试候选从小到大，选第一个使剩余仍可完成的候选。正确性由首个不同位置比较得到，但检查器必须精确，不能只检查必要条件。约束简单时用剩余数量/上下界，复杂时可能要 DP。自行推导。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-36 [A] MEX 上界很小：忽略过大值") <trick-misc-36>

*问题概述*　#text("动态维护长度 n 的多重集合 MEX，数值可能到 10^18。")

*必要思路*　#text("MEX 必在 0..n，仅维护这 n+1 个值的出现次数及缺失集合。出现次数从 0到1 移除缺失值，从1到0 加回。值大于 n 不影响当前 MEX；若集合大小变化，要用最大可能容量作范围。")

*参考*　#link("https://cp-algorithms.com/sequences/mex.html")[#text("CP-Algorithms：MEX")]。

=== #text("MISC-37 [B] 不交叉区间组成层级树") <trick-misc-37>

*问题概述*　#text("一组区间两两不是包含就是不相交，需要按嵌套关系做 DP 或统计。")

*必要思路*　#text("按左端升序、右端降序排序，用栈保存尚未结束的包含链，父亲是最内层包含它的区间。并列相同区间先定义是否合并，端点接触按区间语义处理。存在交错 l1<l2≤r1<r2 时，简单树模型不成立。")

*参考*　#link("https://www.luogu.com.cn/article/krybn2f5")[#text("洛谷 听取MLE声一片：Trick 总结")]。

=== #text("MISC-38 [A] 不变量：先筛掉根本无法到达") <trick-misc-38>

*问题概述*　#text("操作可以交换、翻转、同时增减，目标状态看上去复杂。")

*必要思路*　#text("先看总和、奇偶、颜色类数量、gcd、置换奇偶等是否每步不变，再用这些量判必要条件。随后必须构造路径或证明充分性；“不变量相同”不自动等于可达。最好写出每个操作对候选量的变化。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-39 [A] 下界加构造：证明最优不靠猜") <trick-misc-39>

*问题概述*　#text("题目要最少操作、最小最大值或最大收益，能构造一个不错方案但不确定最优。")

*必要思路*　#text("找任意方案都必须支付的下界，如逆序数、每条必须经过的边、不可兼容对象数；再构造恰达下界的方案。两者相等才是最优性证明。若构造超下界，继续找更紧下界或优化构造，不能直接宣布最优。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

=== #text("MISC-40 [A] 稀疏事件：跳过巨大时间轴") <trick-misc-40>

*问题概述*　#text("时间可达 10^18，但只有 n 个事件；大部分时刻状态按固定规律变化。")

*必要思路*　#text("排序事件时间，从一个事件跳到下一个，把空档的贡献用长度乘当前速率、等差和或快速幂求出。同一时刻事件统一按题意处理，别让排序任意打破同时性。若状态每步变化且无法聚合，不能直接跳。自行归纳。")

*依据*　自行推导/归纳，理由已写在思路中。

