#import "template/lookup.typ": algorithm-lookup
#import "杂项/Trick/关键词速查.typ": signal-lookup, lookup-training
#import "数据结构/Trick/位运算 Trick.typ": bit-topic, bit-intro
#import "数学/Trick/数学 Trick.typ": math-topic, math-intro
#import "数学/Trick/博弈论 Trick.typ": game-topic, game-intro
#import "图论/Trick/树 Trick.typ": tree-topic, tree-intro
#import "图论/树上常用公式/树上常用公式.typ": tree-formulas-intro, dfs-order-formulas, path-difference-formulas, tree-mo-formulas, changed-root-subtree-formulas, reroot-formulas
#import "动态规划/Trick/DP Trick.typ": dp-topic, dp-intro
#import "杂项/Trick/杂项 Trick.typ": misc-topic, misc-intro
#import "数学/计算几何/计算几何技巧.typ": geom-topic, geom-intro

#let algorithm-entries = (
  (name: "并查集／DSU", function: "连通关系维护（并查集）", chapter: "数据结构与区间查询", target: <book-dsu>),
  (name: "按大小合并", function: "按大小合并", chapter: "数据结构与区间查询", target: <book-variant-001>),
  (name: "带权并查集", function: "带权并查集", chapter: "数据结构与区间查询", target: <book-variant-002>),
  (name: "可撤销并查集", function: "可撤销并查集", chapter: "数据结构与区间查询", target: <book-variant-003>),
  (name: "倍增并查集", function: "倍增并查集", chapter: "数据结构与区间查询", target: <book-variant-004>),
  (name: "树状数组／Fenwick", function: "前缀与区间统计（树状数组）", chapter: "数据结构与区间查询", target: <book-fenwick>),
  (name: "前缀和配对", function: "区间和与同余计数（前缀配对）", chapter: "数据结构与区间查询", target: <book-prefix-pairs>),
  (name: "Sparse Table／ST 表", function: "静态区间查询（稀疏表）", chapter: "数据结构与区间查询", target: <book-sparse>),
  (name: "Disjoint Sparse Table", function: "静态区间查询（稀疏表）", chapter: "数据结构与区间查询", target: <book-sparse>),
  (name: "线段树／Segment Tree", function: "区间修改与查询（线段树）", chapter: "数据结构与区间查询", target: <book-segment>),
  (name: "维护区间和，支持区间加、区间查询", function: "维护区间和，支持区间加、区间查询", chapter: "数据结构与区间查询", target: <book-variant-010>),
  (name: "维护区间最大值，支持区间加、区间查询", function: "维护区间最大值，支持区间加、区间查询", chapter: "数据结构与区间查询", target: <book-variant-011>),
  (name: "维护区间和，支持区间加、区间乘、区间查询", function: "维护区间和，支持区间加、区间乘、区间查询", chapter: "数据结构与区间查询", target: <book-variant-012>),
  (name: "动态开点，维护区间和，支持区间加、区间查询", function: "动态开点，维护区间和，支持区间加、区间查询", chapter: "数据结构与区间查询", target: <book-variant-013>),
  (name: "维护区间 GCD，支持区间加、区间查询", function: "维护区间 GCD，支持区间加、区间查询", chapter: "数据结构与区间查询", target: <book-variant-014>),
  (name: "区间第 k 小", function: "区间第 k 小", chapter: "数据结构与区间查询", target: <book-range-kth>),
  (name: "主席树／可持久化线段树", function: "静态查询：主席树", chapter: "数据结构与区间查询", target: <book-persistent-kth>),
  (name: "整体二分", function: "带修改查询：整体二分", chapter: "数据结构与区间查询", target: <book-parallel-binary>),
  (name: "离线区间统计", function: "离线区间统计", chapter: "数据结构与区间查询", target: <book-offline-range>),
  (name: "区间不同数／离线扫描", function: "不同数查询：离线扫描", chapter: "数据结构与区间查询", target: <book-distinct-scan>),
  (name: "莫队／Mo", function: "可增删贡献：莫队", chapter: "数据结构与区间查询", target: <book-mo>),
  (name: "Hilbert 序莫队", function: "Hilbert 序莫队", chapter: "数据结构与区间查询", target: <book-variant-021>),
  (name: "阈值查询／排序激活", function: "阈值查询（排序激活）", chapter: "数据结构与区间查询", target: <book-threshold-scan>),
  (name: "CDQ 分治／三维偏序", function: "多维偏序计数（CDQ）", chapter: "数据结构与区间查询", target: <book-cdq>),
  (name: "FHQ Treap", function: "有序集合、排名与前后驱（FHQ Treap）", chapter: "数据结构与区间查询", target: <book-treap>),
  (name: "对顶堆／动态中位数", function: "动态中位数（对顶堆）", chapter: "数据结构与区间查询", target: <book-median-heaps>),
  (name: "左偏树／可并堆", function: "可合并优先队列（左偏树）", chapter: "数据结构与区间查询", target: <book-leftist>),
  (name: "李超树／Li Chao Tree", function: "直线最值查询（李超树）", chapter: "数据结构与区间查询", target: <book-li-chao>),
  (name: "权值线段树合并", function: "值域结构合并（权值线段树合并）", chapter: "数据结构与区间查询", target: <book-segment-merge>),
  (name: "01 Trie／二进制字典树", function: "最大异或与全局异或标记（01 Trie）", chapter: "数据结构与区间查询", target: <book-xor-trie>),
  (name: "线性基／XOR Basis", function: "子集异或可达性与排名（线性基）", chapter: "数据结构与区间查询", target: <book-xor-basis>),
  (name: "前缀异或／区间 XOR", function: "区间异或与前缀配对", chapter: "数据结构与区间查询", target: <book-prefix-xor>),
  (name: "按位贡献／异或总和", function: "异或总和的按位贡献", chapter: "数据结构与区间查询", target: <book-xor-contribution>),
  (name: "区间 AND／OR／GCD 状态压缩", function: "AND／OR／GCD 区间结果压缩", chapter: "数据结构与区间查询", target: <book-compressed-intervals>),
  (name: "按位贪心／AND 最优值", function: "按位约束最优值（高位贪心）", chapter: "数据结构与区间查询", target: <book-bit-greedy>),
  (name: "动态位集／Dynamic Bitset", function: "批量集合运算（动态位集）", chapter: "数据结构与区间查询", target: <book-bitset>),
  (name: "双栈聚合队列", function: "滑动队列的结合聚合（双栈）", chapter: "数据结构与区间查询", target: <book-aggregate-queue>),
  (name: "堆的懒删除", function: "带删除的优先队列（懒删除）", chapter: "数据结构与区间查询", target: <book-lazy-heap>),
  (name: "全局加减／偏移量", function: "全局加减维护（偏移量）", chapter: "数据结构与区间查询", target: <book-global-offset>),
  (name: "平方和／矩统计", function: "二次统计量维护（矩与贡献）", chapter: "数据结构与区间查询", target: <book-moments>),
  (name: "高阶差分", function: "批量区间更新（高阶差分）", chapter: "数据结构与区间查询", target: <book-higher-difference>),
  (name: "区间扫描线／端点语义", function: "区间覆盖与端点扫描", chapter: "数据结构与区间查询", target: <book-interval-sweep>),
  (name: "DFS 序／进入退出时间", function: "子树区间与祖先判断（DFS 序）", chapter: "树上问题", target: <book-dfs-order>),
  (name: "LCA／最近公共祖先", function: "最近公共祖先（LCA）", chapter: "树上问题", target: <book-lca>),
  (name: "倍增求 LCA", function: "倍增求 LCA", chapter: "树上问题", target: <book-variant-044>),
  (name: "Tarjan 离线求 LCA", function: "Tarjan 离线求 LCA", chapter: "树上问题", target: <book-variant-045>),
  (name: "树链剖分求 LCA", function: "树链剖分求 LCA", chapter: "树上问题", target: <book-variant-046>),
  (name: "欧拉序与 RMQ 求 LCA", function: "欧拉序与 RMQ 求 LCA", chapter: "树上问题", target: <book-variant-047>),
  (name: "树链剖分／HLD", function: "路径与子树查询（树链剖分）", chapter: "树上问题", target: <book-hld>),
  (name: "树上莫队／进出欧拉序", function: "树上路径离线统计（欧拉序莫队）", chapter: "树上问题", target: <book-tree-mo>),
  (name: "树上点差分／边差分", function: "批量路径更新（树上差分）", chapter: "树上问题", target: <book-tree-difference>),
  (name: "换根 DP／Rerooting", function: "全根统计（换根 DP）", chapter: "树上问题", target: <book-reroot>),
  (name: "树上距离和／按边贡献", function: "全点对距离与分支贡献", chapter: "树上问题", target: <book-tree-distance-sum>),
  (name: "点分治／重心分解", function: "树上距离约束统计（点分治）", chapter: "树上问题", target: <book-centroid>),
  (name: "树直径／点集直径合并", function: "最远点与点集直径", chapter: "树上问题", target: <book-tree-diameter>),
  (name: "虚树／Virtual Tree", function: "少量关键点构树（虚树）", chapter: "树上问题", target: <book-virtual-tree>),
  (name: "树形 DP／连通块计数", function: "树上连通块计数（树形 DP）", chapter: "树上问题", target: <book-tree-connected-dp>),
  (name: "树上背包／依赖背包", function: "树上背包与依赖选择", chapter: "树上问题", target: <book-tree-knapsack>),
  (name: "DSU on Tree／启发式合并", function: "子树集合统计（启发式合并）", chapter: "树上问题", target: <book-dsu-on-tree>),
  (name: "树同构", function: "树同构判定", chapter: "树上问题", target: <book-tree-isomorphism>),
  (name: "Link-Cut Tree／LCT", function: "动态森林路径查询（Link-Cut Tree）", chapter: "树上问题", target: <book-lct>),
  (name: "Euler Tour Tree／ETT", function: "动态森林连通块统计（Euler Tour Tree）", chapter: "树上问题", target: <book-ett>),
  (name: "静态拓扑 Top Tree", function: "单边改权维护直径（静态拓扑 Top Tree）", chapter: "树上问题", target: <book-top-tree>),
  (name: "Prüfer 序列", function: "树的编码与计数（Prüfer 序列）", chapter: "树上问题", target: <book-prufer>),
  (name: "最短路", function: "最短路径", chapter: "图论", target: <book-shortest-path>),
  (name: "Dijkstra", function: "单源非负权：Dijkstra", chapter: "图论", target: <book-dijkstra>),
  (name: "Floyd", function: "全点对：Floyd", chapter: "图论", target: <book-floyd>),
  (name: "线段树优化建图", function: "区间连边（线段树优化建图）", chapter: "图论", target: <book-range-graph>),
  (name: "差分约束", function: "差分不等式可行性（差分约束）", chapter: "图论", target: <book-difference-constraints>),
  (name: "SCC／Tarjan 缩点", function: "有向图强连通分量与缩点（Tarjan）", chapter: "图论", target: <book-scc>),
  (name: "割点／桥／双连通分量", function: "删点删边连通性与双连通分量", chapter: "图论", target: <book-bcc>),
  (name: "割点", function: "割点", chapter: "图论", target: <book-articulation>),
  (name: "桥", function: "桥", chapter: "图论", target: <book-bridge>),
  (name: "边双连通分量", function: "边双连通分量", chapter: "图论", target: <book-edge-bcc>),
  (name: "点双连通分量", function: "点双连通分量", chapter: "图论", target: <book-vertex-bcc>),
  (name: "最小生成树／MST", function: "最小生成树（MST）", chapter: "图论", target: <book-mst>),
  (name: "set 优化 Prim", function: "set 优化 Prim", chapter: "图论", target: <book-variant-076>),
  (name: "堆优化 Prim", function: "堆优化 Prim", chapter: "图论", target: <book-variant-077>),
  (name: "Kruskal", function: "Kruskal", chapter: "图论", target: <book-variant-078>),
  (name: "Borůvka 异或最小生成树", function: "Borůvka 异或最小生成树", chapter: "图论", target: <book-variant-079>),
  (name: "严格次小生成树", function: "严格次小生成树", chapter: "图论", target: <book-variant-080>),
  (name: "Kruskal 重构树", function: "阈值连通性（Kruskal 重构树）", chapter: "图论", target: <book-kruskal-tree>),
  (name: "Matrix Tree／矩阵树定理", function: "生成树计数（矩阵树定理）", chapter: "图论", target: <book-matrix-tree>),
  (name: "2-SAT", function: "二变量逻辑约束（2-SAT）", chapter: "图论", target: <book-two-sat>),
  (name: "支配树／Dominator Tree", function: "必经点与支配关系（支配树）", chapter: "图论", target: <book-dominator>),
  (name: "欧拉路／欧拉回路", function: "一次经过每条边（欧拉路）", chapter: "图论", target: <book-euler-route>),
  (name: "线段树分治／动态连通性", function: "动态连通性（时间线段树与可撤销并查集）", chapter: "图论", target: <book-dynamic-connectivity>),
  (name: "最大匹配", function: "最大匹配", chapter: "图论", target: <book-matching>),
  (name: "二分图匹配", function: "二分图最大匹配", chapter: "图论", target: <book-bipartite-matching>),
  (name: "一般图匹配／Blossom", function: "一般图最大匹配（带花树）", chapter: "图论", target: <book-blossom>),
  (name: "拟阵交／Matroid Intersection", function: "同时满足两类独立约束（拟阵交）", chapter: "图论", target: <book-matroid>),
  (name: "增广框架", function: "增广框架", chapter: "图论", target: <book-variant-091>),
  (name: "划分拟阵与图拟阵", function: "划分拟阵与图拟阵", chapter: "图论", target: <book-variant-092>),
  (name: "功能图／Functional Graph", function: "单出边图上的跳转与环（功能图）", chapter: "图论", target: <book-functional-graph>),
  (name: "基环树／剥叶找环", function: "无向单环结构（基环树）", chapter: "图论", target: <book-unicyclic>),
  (name: "图上邻居加／根号分治", function: "邻居批量更新（高低度根号分治）", chapter: "图论", target: <book-graph-neighbor>),
  (name: "最大流", function: "最大流", chapter: "网络流", target: <book-max-flow>),
  (name: "EK", function: "EK 增广路", chapter: "网络流", target: <book-ek>),
  (name: "Dinic", function: "Dinic 分层增广", chapter: "网络流", target: <book-dinic>),
  (name: "最小割／源汇划分", function: "最小割与划分恢复", chapter: "网络流", target: <book-min-cut>),
  (name: "最小割的最少边数", function: "最小容量后的最少割边", chapter: "网络流", target: <book-min-cut-edges>),
  (name: "最小费用最大流", function: "最小费用最大流", chapter: "网络流", target: <book-min-cost-flow>),
  (name: "SPFA 最小费用最大流", function: "SPFA 最小费用最大流", chapter: "网络流", target: <book-spfa-cost-flow>),
  (name: "势能 Dijkstra 最小费用最大流", function: "势能 Dijkstra 最小费用最大流", chapter: "网络流", target: <book-potential-cost-flow>),
  (name: "有上下界可行流", function: "上下界可行流", chapter: "网络流", target: <book-bounded-flow>),
  (name: "背包／Knapsack", function: "背包选择", chapter: "动态规划", target: <book-knapsack>),
  (name: "bitset 背包", function: "布尔可达性与方案恢复（bitset 背包）", chapter: "动态规划", target: <book-bitset-knapsack>),
  (name: "最长上升子序列／LIS", function: "序列最优值与前驱重建（LIS）", chapter: "动态规划", target: <book-lis>),
  (name: "偏序 DP／同值批量查询", function: "偏序约束下的最优序列", chapter: "动态规划", target: <book-partial-order-dp>),
  (name: "状态压缩／支配状态", function: "状态等价、守恒与支配关系", chapter: "动态规划", target: <book-dp-state>),
  (name: "贡献提前计算", function: "未来成本的提前结算", chapter: "动态规划", target: <book-dp-advance-cost>),
  (name: "DP 前缀和优化", function: "区间求和转移（前缀和）", chapter: "动态规划", target: <book-dp-prefix>),
  (name: "DP 单调队列优化", function: "滑动窗口最优转移（单调队列）", chapter: "动态规划", target: <book-dp-monotone-queue>),
  (name: "绝对值 DP／两侧最值", function: "绝对值与两侧代价转移", chapter: "动态规划", target: <book-dp-two-sides>),
  (name: "区间 DP／环形 DP", function: "区间合并与消除", chapter: "动态规划", target: <book-interval-dp>),
  (name: "Knuth 优化／石子合并", function: "区间切点优化（Knuth）", chapter: "动态规划", target: <book-knuth>),
  (name: "双路径同步 DP", function: "同步多路径状态", chapter: "动态规划", target: <book-synchronous-path-dp>),
  (name: "状压 DP／集合分组", function: "集合分组与子集状态", chapter: "动态规划", target: <book-subset-dp>),
  (name: "轮廓 DP／插头状态", function: "窄网格边界状态（轮廓 DP）", chapter: "动态规划", target: <book-contour-dp>),
  (name: "数位 DP／Digit DP", function: "数字范围计数（数位 DP）", chapter: "动态规划", target: <book-digit-dp>),
  (name: "最优方案计数", function: "最优值与方案数共同维护", chapter: "动态规划", target: <book-optimal-count>),
  (name: "斜率优化／Convex Hull Trick", function: "直线型转移（斜率优化）", chapter: "动态规划", target: <book-cht-dp>),
  (name: "分治优化 DP", function: "决策单调的分治优化", chapter: "动态规划", target: <book-divide-conquer-dp>),
  (name: "WQS 二分／Aliens Trick", function: "恰好 K 次选择（WQS 二分）", chapter: "动态规划", target: <book-wqs>),
  (name: "Slope Trick", function: "凸分段线性代价（Slope Trick）", chapter: "动态规划", target: <book-slope-trick>),
  (name: "连续段 DP", function: "按值插入的连续段状态", chapter: "动态规划", target: <book-continuous-segments-dp>),
  (name: "矩阵加速 DP", function: "有限状态的巨大步数转移（矩阵加速）", chapter: "动态规划", target: <book-matrix-dp>),
  (name: "DAG DP／拓扑序计数", function: "有向无环状态图（DAG DP）", chapter: "动态规划", target: <book-dag-dp>),
  (name: "字符串哈希／String Hash", function: "子串相等性（字符串哈希）", chapter: "字符串", target: <book-string-hash>),
  (name: "KMP／前缀函数", function: "单模式匹配（KMP）", chapter: "字符串", target: <book-kmp>),
  (name: "Z 函数／扩展 KMP", function: "前缀匹配长度（Z 函数）", chapter: "字符串", target: <book-z-function>),
  (name: "AC 自动机／ACAM", function: "多模式匹配（AC 自动机）", chapter: "字符串", target: <book-ac>),
  (name: "Manacher", function: "最长回文半径（Manacher）", chapter: "字符串", target: <book-manacher>),
  (name: "后缀数组／SA／LCP", function: "后缀排序与最长公共前缀（SA／LCP）", chapter: "字符串", target: <book-suffix-array>),
  (name: "后缀自动机／SAM", function: "子串集合与出现次数（SAM）", chapter: "字符串", target: <book-sam>),
  (name: "Lyndon 分解／Duval／最小循环表示", function: "字典序因子分解与最小循环表示（Lyndon）", chapter: "字符串", target: <book-lyndon>),
  (name: "runs／极大周期串", function: "极大周期区间（runs）", chapter: "字符串", target: <book-runs>),
  (name: "Trie／字符串字典树", function: "单词与前缀集合（Trie）", chapter: "字符串", target: <book-string-trie>),
  (name: "快速幂／模乘", function: "模幂与防溢出模乘", chapter: "数论", target: <book-mod-power>),
  (name: "普通快速幂", function: "普通快速幂", chapter: "数论", target: <book-binary-power>),
  (name: "快速乘", function: "快速乘", chapter: "数论", target: <book-variant-140>),
  (name: "龟速乘", function: "龟速乘", chapter: "数论", target: <book-variant-141>),
  (name: "EXGCD／扩展欧几里得", function: "整数线性方程（扩展欧几里得）", chapter: "数论", target: <book-exgcd>),
  (name: "求 a x + b y = c 的解", function: "求 a x + b y = c 的解", chapter: "数论", target: <book-variant-143>),
  (name: "模逆元／模除法／批量逆元", function: "模逆元与模除法", chapter: "数论", target: <book-mod-inverse>),
  (name: "CRT／EXCRT", function: "同余方程组合（EXCRT）", chapter: "数论", target: <book-excrt>),
  (name: "扩展欧拉定理", function: "复合模指数降幂（扩展欧拉）", chapter: "数论", target: <book-extended-euler>),
  (name: "BSGS／EXBSGS", function: "离散对数（扩展 BSGS）", chapter: "数论", target: <book-exbsgs>),
  (name: "线性筛／欧拉筛", function: "质数与积性函数预处理（线性筛）", chapter: "数论", target: <book-linear-sieve>),
  (name: "筛质数", function: "筛质数", chapter: "数论", target: <book-variant-149>),
  (name: "筛积性函数", function: "筛积性函数", chapter: "数论", target: <book-variant-150>),
  (name: "Pollard-Rho／Miller-Rabin", function: "整数分解与质因子指数（Pollard-Rho）", chapter: "数论", target: <book-pollard-rho>),
  (name: "整除分块", function: "整除商的批量求和（整除分块）", chapter: "数论", target: <book-division-block>),
  (name: "因子枚举／倍数贡献", function: "因子与倍数贡献交换", chapter: "数论", target: <book-divisor-contribution>),
  (name: "莫比乌斯反演", function: "互质计数（莫比乌斯反演）", chapter: "数论", target: <book-mobius>),
  (name: "杜教筛", function: "积性函数大范围前缀和（杜教筛）", chapter: "数论", target: <book-dujiao>),
  (name: "Min_25 筛", function: "积性函数大范围求和（Min_25 筛）", chapter: "数论", target: <book-min25>),
  (name: "类欧几里得／floor_sum", function: "线性取整求和（类欧几里得）", chapter: "数论", target: <book-floor-sum>),
  (name: "floor_sum", function: "floor_sum", chapter: "数论", target: <book-variant-158>),
  (name: "高阶类欧（精确值）", function: "高阶类欧（精确值）", chapter: "数论", target: <book-variant-159>),
  (name: "高阶类欧（取模）", function: "高阶类欧（取模）", chapter: "数论", target: <book-variant-160>),
  (name: "矩阵乘法／矩阵快速幂", function: "矩阵运算与快速幂", chapter: "线性代数", target: <book-matrix-power>),
  (name: "矩阵快速幂（独立接口）", function: "旧版矩阵快速幂接口", chapter: "线性代数", target: <book-legacy-matrix-power>),
  (name: "高斯消元／Gauss", function: "线性方程组、行列式与逆矩阵（消元）", chapter: "线性代数", target: <book-linear-system>),
  (name: "行列式／逆矩阵", function: "线性方程组、行列式与逆矩阵（消元）", chapter: "线性代数", target: <book-linear-system>),
  (name: "线性方程组解的分类", function: "高斯消元与解的分类", chapter: "线性代数", target: <book-gauss>),
  (name: "矩阵求逆／唯一解", function: "行列式、逆矩阵与唯一解接口", chapter: "线性代数", target: <book-matrix-inverse>),
  (name: "组合数／Lucas／任意模组合数", function: "组合数计算", chapter: "组合计数", target: <book-combination>),
  (name: "阶乘预处理与批量逆元", function: "阶乘预处理与批量逆元", chapter: "组合计数", target: <book-variant-168>),
  (name: "Lucas 定理", function: "Lucas 定理", chapter: "组合计数", target: <book-variant-169>),
  (name: "任意模数下的组合数", function: "任意模数下的组合数", chapter: "组合计数", target: <book-variant-170>),
  (name: "隔板法／Stars and Bars", function: "分配与有界拆分（隔板法）", chapter: "组合计数", target: <book-stars-bars>),
  (name: "容斥原理／补集计数", function: "非法方案的容斥与补集", chapter: "组合计数", target: <book-inclusion-exclusion>),
  (name: "整数拆分／五边形递推", function: "整数拆分与常见计数序列", chapter: "组合计数", target: <book-combinatorial-numbers>),
  (name: "卡特兰数／Catalan", function: "整数拆分与常见计数序列", chapter: "组合计数", target: <book-combinatorial-numbers>),
  (name: "斯特林数／Stirling", function: "整数拆分与常见计数序列", chapter: "组合计数", target: <book-combinatorial-numbers>),
  (name: "贝尔数／Bell", function: "整数拆分与常见计数序列", chapter: "组合计数", target: <book-combinatorial-numbers>),
  (name: "欧拉数／Eulerian", function: "整数拆分与常见计数序列", chapter: "组合计数", target: <book-combinatorial-numbers>),
  (name: "正整数有序拆分", function: "正整数有序拆分", chapter: "组合计数", target: <book-ordered-partition>),
  (name: "错排／Derangement／排列环计数", function: "排列的固定点、错排与环", chapter: "组合计数", target: <book-permutation-counting>),
  (name: "康托展开", function: "排列排名与还原（康托展开）", chapter: "组合计数", target: <book-cantor>),
  (name: "Burnside／Pólya", function: "对称等价方案计数（Burnside／Pólya）", chapter: "组合计数", target: <book-burnside>),
  (name: "生成函数／OGF／EGF", function: "计数模型的生成函数", chapter: "组合计数", target: <book-generating-function>),
  (name: "概率／期望", function: "概率与期望的基本模型", chapter: "概率与期望", target: <book-probability-basics>),
  (name: "指示变量／期望线性性", function: "总数量与总得分（指示变量）", chapter: "概率与期望", target: <book-indicator-expectation>),
  (name: "尾和公式／几何等待", function: "随机长度与等待次数", chapter: "概率与期望", target: <book-tail-expectation>),
  (name: "概率 DP", function: "随机过程的分布（概率 DP）", chapter: "概率与期望", target: <book-probability-dp>),
  (name: "自环期望 DP", function: "含原地等待的期望方程（自环）", chapter: "概率与期望", target: <book-self-loop-expectation>),
  (name: "SG 函数／Sprague-Grundy／Nim", function: "Nim 与无环游戏的 SG 模型", chapter: "博弈论", target: <book-sg>),
  (name: "反 Nim／Misère Nim", function: "反常终止（反 Nim）", chapter: "博弈论", target: <book-misere-nim>),
  (name: "巴什博弈", function: "固定上限取石子（巴什）", chapter: "博弈论", target: <book-bash>),
  (name: "对称策略／策略偷换", function: "对称应手与策略偷换", chapter: "博弈论", target: <book-symmetric-game>),
  (name: "阶梯 Nim", function: "相邻层下移（阶梯 Nim）", chapter: "博弈论", target: <book-staircase-nim>),
  (name: "Silver Dollar／棋子间隙博弈", function: "受阻棋子移动（Silver Dollar）", chapter: "博弈论", target: <book-silver-dollar>),
  (name: "威佐夫博弈／Wythoff", function: "双堆同步取石子（威佐夫）", chapter: "博弈论", target: <book-wythoff>),
  (name: "Fibonacci Nim", function: "行动上限随步骤变化（Fibonacci Nim）", chapter: "博弈论", target: <book-fibonacci-nim>),
  (name: "有环博弈／胜负平局", function: "可循环的胜负与平局（反图传播）", chapter: "博弈论", target: <book-loopy-game>),
  (name: "有偏博弈／行动者状态", function: "双方规则不同的轮流博弈", chapter: "博弈论", target: <book-player-state>),
  (name: "minimax／得分博弈", function: "得分最大化对抗（minimax）", chapter: "博弈论", target: <book-minimax>),
  (name: "树上删边博弈", function: "树上删边游戏", chapter: "博弈论", target: <book-tree-game>),
  (name: "奇偶策略／博弈规律验证", function: "奇偶势与胜负规律证明", chapter: "博弈论", target: <book-game-invariant>),
  (name: "卷积／Convolution", function: "普通卷积（FFT／NTT）", chapter: "多项式与卷积", target: <book-convolution>),
  (name: "FFT", function: "FFT", chapter: "多项式与卷积", target: <book-fft>),
  (name: "NTT", function: "NTT", chapter: "多项式与卷积", target: <book-ntt>),
  (name: "SOS／Zeta／Möbius／FWT", function: "掩码上的子集和与位运算卷积（Zeta／FWT）", chapter: "多项式与卷积", target: <book-subset-transform>),
  (name: "子集卷积", function: "不相交集合合并（子集卷积）", chapter: "多项式与卷积", target: <book-subset-convolution>),
  (name: "多项式基础运算", function: "多项式基础运算与 NTT 接口", chapter: "多项式与卷积", target: <book-poly-base>),
  (name: "多项式求逆", function: "形式幂级数求逆", chapter: "多项式与卷积", target: <book-poly-inverse>),
  (name: "多项式 ln／exp", function: "形式幂级数对数与指数", chapter: "多项式与卷积", target: <book-poly-log-exp>),
  (name: "多项式 sqrt", function: "形式幂级数平方根", chapter: "多项式与卷积", target: <book-poly-sqrt>),
  (name: "多项式除法", function: "多项式除法与余数", chapter: "多项式与卷积", target: <book-poly-div>),
  (name: "多项式 pow", function: "形式幂级数幂", chapter: "多项式与卷积", target: <book-poly-power>),
  (name: "多点求值／插值", function: "多点求值与插值", chapter: "多项式与卷积", target: <book-multipoint>),
  (name: "拉格朗日插值／Lagrange", function: "单点插值求值（拉格朗日）", chapter: "多项式与卷积", target: <book-lagrange>),
  (name: "Berlekamp-Massey／BM", function: "从前若干项恢复最短递推（BM）", chapter: "线性递推", target: <book-bm>),
  (name: "Bostan-Mori", function: "线性递推第 n 项（Bostan-Mori）", chapter: "线性递推", target: <book-bostan-mori>),
  (name: "几何选型／区域赛样本", function: "读题信号与区域赛样本", chapter: "计算几何", target: <book-geometric-models>),
  (name: "点与直线／叉积／点积／atan2", function: "点线基础与夹角计算", chapter: "计算几何", target: <book-point-line>),
  (name: "线段相交／点在多边形内", function: "线段相交与多边形包含", chapter: "计算几何", target: <book-segments-polygon>),
  (name: "半平面交／HPI", function: "半平面约束交集", chapter: "计算几何", target: <book-half-plane-intersection>),
  (name: "圆相交／公切线／交面积", function: "圆的交点、切线与交面积", chapter: "计算几何", target: <book-circle>),
  (name: "极角排序／开闭半圆／覆盖角宽", function: "圆周方向统计（极角排序与扫描）", chapter: "计算几何", target: <book-polar-scan>),
  (name: "凸包／旋转卡壳／凸多边形点定位", function: "凸包极值与点定位（旋转卡壳）", chapter: "计算几何", target: <book-convex-hull>),
  (name: "鞋带公式／有向面积／面积贡献", function: "多边形面积与面积总和（有向边贡献）", chapter: "计算几何", target: <book-geometric-area>),
  (name: "矩形面积并／扫描线", function: "矩形面积并（扫描线）", chapter: "计算几何", target: <book-rectangle-union>),
  (name: "Minkowski／闵可夫斯基和／差", function: "平移碰撞（闵可夫斯基和／差）", chapter: "计算几何", target: <book-minkowski>),
  (name: "几何概率／重叠面积期望", function: "几何概率与随机重叠面积", chapter: "计算几何", target: <book-geometric-probability>),
  (name: "面积重心／仿射重心", function: "面积重心与随机配重", chapter: "计算几何", target: <book-centroid-area>),
  (name: "仿射变换／行列式与面积", function: "坐标变换后的几何不变量", chapter: "计算几何", target: <book-affine-transform>),
  (name: "格点构造／整点中点", function: "整点中点的可达性与最少步数", chapter: "计算几何", target: <book-lattice-midpoint>),
  (name: "曼哈顿距离／切比雪夫距离／坐标变换", function: "曼哈顿与切比雪夫距离", chapter: "计算几何", target: <book-metric-transform>),
  (name: "三角形不等式／边长判定", function: "三角形边长的可行性", chapter: "计算几何", target: <book-triangle-inequality>),
  (name: "角点／极端点／有限见证集", function: "少量图形覆盖（有限见证集）", chapter: "计算几何", target: <book-finite-geometry>),
  (name: "局部最低平台／谷底", function: "地形局部最低区域", chapter: "计算几何", target: <book-local-minima>),
  (name: "反射／镜面展开／转角周期", function: "镜面反射路径与周期", chapter: "计算几何", target: <book-reflection>),
  (name: "首次碰撞树／平面区域计数", function: "碰撞结构与平面分割", chapter: "计算几何", target: <book-planar-topology>),
  (name: "几何 eps／分数交点／退化处理", function: "数值谓词、精确交点与退化处理", chapter: "计算几何", target: <book-geometry-robustness>),
  (name: "几何反例／代码依赖与复杂度", function: "几何自测与代码依赖", chapter: "计算几何", target: <book-geometry-practice>),
  (name: "高精度／BigInt", function: "带符号大整数运算", chapter: "工具与通用技巧", target: <book-bigint>),
  (name: "i128／宽整数防溢出", function: "宽整数运算与输入输出（i128）", chapter: "工具与通用技巧", target: <book-wide-integer>),
  (name: "置位遍历／popcount／有限位域", function: "位枚举、进位与有限位域", chapter: "工具与通用技巧", target: <book-bit-operations>),
  (name: "归并排序／逆序对", function: "排序与逆序对（归并排序）", chapter: "工具与通用技巧", target: <book-merge-sort>),
  (name: "三分搜索", function: "单峰最优值（三分）", chapter: "工具与通用技巧", target: <book-ternary-search>),
  (name: "折半搜索／Meet in the Middle", function: "指数规模搜索（折半）", chapter: "工具与通用技巧", target: <book-meet-in-middle>),
  (name: "随机指纹", function: "随机集合指纹", chapter: "工具与通用技巧", target: <book-fingerprint>),
  (name: "双指针／滑动窗口／最短达标段", function: "连续区间可行性（双指针与单调队列）", chapter: "工具与通用技巧", target: <book-window>),
  (name: "隐式第 k 小／候选区间拆分", function: "隐式第 k 小与第 k 大", chapter: "工具与通用技巧", target: <book-implicit-order>),
  (name: "二分答案／比例最优", function: "单调判定与比值最优（二分答案）", chapter: "工具与通用技巧", target: <book-binary-answer>),
  (name: "反悔贪心／任务排序", function: "截止时间调度与反悔贪心", chapter: "工具与通用技巧", target: <book-scheduling>),
  (name: "三元组计数／固定中间元素", function: "按中间元素统计三元组", chapter: "工具与通用技巧", target: <book-triple-contribution>),
  (name: "全点对绝对差总和", function: "全点对绝对差总和（排序贡献）", chapter: "工具与通用技巧", target: <book-pair-absolute-difference>),
  (name: "最少交换次数／排列环／同类元素聚拢", function: "最少交换次数", chapter: "工具与通用技巧", target: <book-minimum-swaps>),
  (name: "局部修改／区间反转增量", function: "局部修改的增量维护", chapter: "工具与通用技巧", target: <book-local-change>),
  (name: "区间支配／区间选择", function: "区间选择中的支配删除", chapter: "工具与通用技巧", target: <book-dominated-intervals>),
  (name: "不交叉区间树／层级结构", function: "不交叉区间构树", chapter: "工具与通用技巧", target: <book-interval-tree>),
  (name: "根号分治／高低频成本", function: "高低频分治的总成本", chapter: "工具与通用技巧", target: <book-sqrt-cost>),
  (name: "字典序最小／可行性构造", function: "字典序最小的逐步构造", chapter: "工具与通用技巧", target: <book-lexicographic-construction>),
  (name: "MEX／有效值域", function: "MEX 的有效值域", chapter: "工具与通用技巧", target: <book-mex>),
  (name: "不变量／下界构造", function: "可达性不变量与最优下界构造", chapter: "工具与通用技巧", target: <book-invariant-construction>),
  (name: "稀疏事件／时间跳跃", function: "稀疏事件跳过巨大时间轴", chapter: "工具与通用技巧", target: <book-sparse-events>),
  (name: "对拍／随机测试", function: "随机对拍与回归自测", chapter: "工具与通用技巧", target: <book-stress-test>),
  (name: "单进程函数对拍", function: "单进程函数对拍", chapter: "工具与通用技巧", target: <book-variant-261>),
  (name: "进程对拍", function: "进程对拍", chapter: "工具与通用技巧", target: <book-variant-262>),
)

#let book(code) = [
#heading(level: 1, numbering: none, outlined: true)[比赛速查] <contest-lookup>
#text(weight: "bold")[题面信号 → 功能入口]

#signal-lookup
#pagebreak()
#heading(level: 2, numbering: none, outlined: false)[算法名 → 页码索引] <algorithm-index>
#algorithm-lookup(algorithm-entries)
#pagebreak()
// The unnumbered lookup does not consume a chapter number.
#counter(heading).update(0)
= 数据结构与区间查询 <chapter-ds>

== 连通关系维护（并查集） <book-dsu>

=== 按大小合并 <book-variant-001>

#include "数据结构/并查集/按大小合并.typ"

#code("数据结构/并查集/按大小合并.cpp")

=== 带权并查集 <book-variant-002>

#include "数据结构/并查集/带权并查集.typ"

#code("数据结构/并查集/带权并查集.cpp")

=== 可撤销并查集 <book-variant-003>

#include "数据结构/并查集/可撤销并查集.typ"

#code("数据结构/并查集/可撤销并查集.cpp")

=== 倍增并查集 <book-variant-004>

#include "数据结构/并查集/倍增并查集.typ"

#code("数据结构/并查集/倍增并查集.cpp")

#misc-topic("trick-misc-27", level: 4, outlined: false)

== 前缀与区间统计（树状数组） <book-fenwick>

#include "数据结构/树状数组/树状数组.typ"

#code("数据结构/树状数组/树状数组.cpp", mode: "full", ignore-main: false)

#bit-topic("trick-bit-22", level: 4, outlined: false)

== 区间和与同余计数（前缀配对） <book-prefix-pairs>

#misc-topic("trick-misc-03", level: 4, outlined: false)

#math-topic("trick-math-01", level: 4, outlined: false)

#math-topic("trick-math-27", level: 4, outlined: false)

#math-topic("trick-math-28", level: 4, outlined: false)

== 静态区间查询（稀疏表） <book-sparse>

#include "数据结构/稀疏表/稀疏表.typ"

#code("数据结构/稀疏表/稀疏表.cpp", parts: ("sparse-table", "disjoint-sparse-table"))

#bit-topic("trick-bit-23", level: 4, outlined: false)

== 区间修改与查询（线段树） <book-segment>

#include "数据结构/线段树/线段树.typ"

=== 维护区间和，支持区间加、区间查询 <book-variant-010>

#code("数据结构/线段树/维护区间和，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

=== 维护区间最大值，支持区间加、区间查询 <book-variant-011>

#code("数据结构/线段树/维护区间最大值，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

=== 维护区间和，支持区间加、区间乘、区间查询 <book-variant-012>

#code("数据结构/线段树/维护区间和，支持区间加、区间乘、区间查询.cpp", mode: "full", ignore-main: false)

=== 动态开点，维护区间和，支持区间加、区间查询 <book-variant-013>

#code("数据结构/线段树/动态开点，维护区间和，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

=== 维护区间 GCD，支持区间加、区间查询 <book-variant-014>

#code("数据结构/线段树/维护区间 GCD，支持区间加、区间查询.cpp", mode: "full", ignore-main: false)

#math-topic("trick-math-11", level: 4, outlined: false)

== 区间第 k 小 <book-range-kth>

=== 静态查询：主席树 <book-persistent-kth>

#include "数据结构/主席树/主席树.typ"

#code("数据结构/主席树/主席树.cpp")

=== 带修改查询：整体二分 <book-parallel-binary>

#include "数据结构/整体二分/动态区间第 k 小.typ"

#code("数据结构/整体二分/动态区间第 k 小.cpp")

参见 #link(<trick-misc-22>)[隐式候选集合第 k 小的计数判定]。

== 离线区间统计 <book-offline-range>

=== 不同数查询：离线扫描 <book-distinct-scan>

#include "数据结构/离线扫描/离线扫描.typ"

#code("数据结构/离线扫描/区间不同数.cpp")

#misc-topic("trick-misc-07", level: 4, outlined: false)

=== 可增删贡献：莫队 <book-mo>

#include "数据结构/莫队/莫队.typ"

#code("数据结构/莫队/莫队.cpp")

=== Hilbert 序莫队 <book-variant-021>

#include "数据结构/莫队/Hilbert 序莫队.typ"

#code("数据结构/莫队/Hilbert 序莫队.cpp")

#misc-topic("trick-misc-04", level: 4, outlined: false)

== 阈值查询（排序激活） <book-threshold-scan>

#misc-topic("trick-misc-08", level: 4, outlined: false)

== 多维偏序计数（CDQ） <book-cdq>

#include "数据结构/CDQ 分治/CDQ 三维偏序.typ"

#code("数据结构/CDQ 分治/CDQ 三维偏序.cpp")

== 有序集合、排名与前后驱（FHQ Treap） <book-treap>

#include "数据结构/平衡树/FHQ Treap.typ"

#code("数据结构/平衡树/FHQ Treap.cpp")

== 动态中位数（对顶堆） <book-median-heaps>

#include "数据结构/对顶堆/对顶堆.typ"

#code("数据结构/对顶堆/对顶堆.cpp")

#math-topic("trick-math-25", level: 4, outlined: false)

== 可合并优先队列（左偏树） <book-leftist>

#include "数据结构/可并堆/左偏树.typ"

#code("数据结构/可并堆/左偏树.cpp")

== 直线最值查询（李超树） <book-li-chao>

#include "数据结构/李超树/李超树.typ"

#code("数据结构/李超树/李超树.cpp")

参见 #link(<trick-dp-27>)[斜率优化中的直线建模]。

== 值域结构合并（权值线段树合并） <book-segment-merge>

#include "数据结构/线段树合并/权值线段树合并.typ"

#code("数据结构/线段树合并/权值线段树合并.cpp")

== 最大异或与全局异或标记（01 Trie） <book-xor-trie>

#include "字符串/Trie/01 Trie.typ"

#code("字符串/Trie/01 Trie.cpp", mode: "full", ignore-main: false)

#bit-topic("trick-bit-16", level: 4, outlined: false)

#bit-topic("trick-bit-18", level: 4, outlined: false)

#bit-topic("trick-bit-26", level: 4, outlined: false)

== 子集异或可达性与排名（线性基） <book-xor-basis>

#include "数据结构/线性基/线性基.typ"

#code("数据结构/线性基/线性基.cpp")

#bit-topic("trick-bit-17", level: 4, outlined: false)

== 区间异或与前缀配对 <book-prefix-xor>

#bit-topic("trick-bit-01", level: 4, outlined: false)

#bit-topic("trick-bit-06", level: 4, outlined: false)

== 异或总和的按位贡献 <book-xor-contribution>

#bit-topic("trick-bit-02", level: 4, outlined: false)

#bit-topic("trick-bit-03", level: 4, outlined: false)

#bit-topic("trick-bit-04", level: 4, outlined: false)

== AND／OR／GCD 区间结果压缩 <book-compressed-intervals>

#bit-topic("trick-bit-13", level: 4, outlined: false)

#bit-topic("trick-bit-14", level: 4, outlined: false)

#math-topic("trick-math-10", level: 4, outlined: false)

== 按位约束最优值（高位贪心） <book-bit-greedy>

#bit-topic("trick-bit-15", level: 4, outlined: false)

== 批量集合运算（动态位集） <book-bitset>

#include "数据结构/动态位集/动态位集.typ"

#code("数据结构/动态位集/动态位集.cpp")

#bit-topic("trick-bit-21", level: 4, outlined: false)

参见 #link(<book-bitset-knapsack>)[bitset 背包与方案恢复]。

== 滑动队列的结合聚合（双栈） <book-aggregate-queue>

#misc-topic("trick-misc-30", level: 4, outlined: false)

== 带删除的优先队列（懒删除） <book-lazy-heap>

#misc-topic("trick-misc-31", level: 4, outlined: false)

== 全局加减维护（偏移量） <book-global-offset>

#misc-topic("trick-misc-32", level: 4, outlined: false)

== 二次统计量维护（矩与贡献） <book-moments>

#misc-topic("trick-misc-33", level: 4, outlined: false)

== 批量区间更新（高阶差分） <book-higher-difference>

#misc-topic("trick-misc-18", level: 4, outlined: false)

== 区间覆盖与端点扫描 <book-interval-sweep>

#misc-topic("trick-misc-16", level: 4, outlined: false)

#misc-topic("trick-misc-17", level: 4, outlined: false)

参见 #link(<book-rectangle-union>)[扫描线求矩形面积并]。

#pagebreak()

= 树上问题 <chapter-tree>

#tree-intro

#tree-formulas-intro

== 子树区间与祖先判断（DFS 序） <book-dfs-order>

#dfs-order-formulas

#tree-topic("trick-tree-01", level: 4, outlined: false)

#tree-topic("trick-tree-02", level: 4, outlined: false)

== 最近公共祖先（LCA） <book-lca>

#include "图论/LCA/LCA.typ"

=== 倍增求 LCA <book-variant-044>

#code("图论/LCA/倍增求 LCA.cpp")

=== Tarjan 离线求 LCA <book-variant-045>

#code("图论/LCA/Tarjan 求 LCA.cpp")

=== 树链剖分求 LCA <book-variant-046>

#code("图论/LCA/树链剖分求 LCA.cpp")

=== 欧拉序与 RMQ 求 LCA <book-variant-047>

#code("图论/LCA/RMQ 欧拉序求 LCA.cpp")

#tree-topic("trick-tree-23", level: 4, outlined: false)

== 路径与子树查询（树链剖分） <book-hld>

#include "图论/树链剖分/树链剖分.typ"

#code("图论/树链剖分/树链剖分.cpp")

#changed-root-subtree-formulas

#tree-topic("trick-tree-03", level: 4, outlined: false)

#tree-topic("trick-tree-21", level: 4, outlined: false)

#tree-topic("trick-tree-22", level: 4, outlined: false)

== 树上路径离线统计（欧拉序莫队） <book-tree-mo>

#tree-mo-formulas

参见 #link(<book-mo>)[区间莫队的增删贡献框架]。

== 批量路径更新（树上差分） <book-tree-difference>

#path-difference-formulas

#tree-topic("trick-tree-05", level: 4, outlined: false)

#tree-topic("trick-tree-06", level: 4, outlined: false)

== 全根统计（换根 DP） <book-reroot>

#include "动态规划/树形 DP/换根距离和.typ"

#code("动态规划/树形 DP/换根距离和.cpp", mode: "full")

#reroot-formulas

#tree-topic("trick-tree-07", level: 4, outlined: false)

#tree-topic("trick-tree-08", level: 4, outlined: false)

== 全点对距离与分支贡献 <book-tree-distance-sum>

#tree-topic("trick-tree-04", level: 4, outlined: false)

#tree-topic("trick-tree-20", level: 4, outlined: false)

== 树上距离约束统计（点分治） <book-centroid>

#include "图论/点分治/点分治.typ"

#code("图论/点分治/点分治.cpp", mode: "full", ignore-main: false)

#tree-topic("trick-tree-18", level: 4, outlined: false)

#tree-topic("trick-tree-19", level: 4, outlined: false)

== 最远点与点集直径 <book-tree-diameter>

#tree-topic("trick-tree-09", level: 4, outlined: false)

#tree-topic("trick-tree-10", level: 4, outlined: false)

== 少量关键点构树（虚树） <book-virtual-tree>

#include "图论/虚树/虚树.typ"

#code("图论/虚树/虚树.cpp")

#tree-topic("trick-tree-11", level: 4, outlined: false)

#tree-topic("trick-tree-12", level: 4, outlined: false)

#tree-topic("trick-tree-13", level: 4, outlined: false)

#tree-topic("trick-tree-14", level: 4, outlined: false)

== 树上连通块计数（树形 DP） <book-tree-connected-dp>

#tree-topic("trick-tree-15", level: 4, outlined: false)

== 树上背包与依赖选择 <book-tree-knapsack>

#tree-topic("trick-tree-16", level: 4, outlined: false)

#dp-topic("trick-dp-36", level: 4, outlined: false)

== 子树集合统计（启发式合并） <book-dsu-on-tree>

#tree-topic("trick-tree-17", level: 4, outlined: false)

== 树同构判定 <book-tree-isomorphism>

#tree-topic("trick-tree-24", level: 4, outlined: false)

== 动态森林路径查询（Link-Cut Tree） <book-lct>

#include "数据结构/动态树/Link-Cut Tree.typ"

#code("数据结构/动态树/Link-Cut Tree.cpp")

== 动态森林连通块统计（Euler Tour Tree） <book-ett>

#include "数据结构/动态树/Euler Tour Tree.typ"

#code("数据结构/动态树/Euler Tour Tree.cpp")

== 单边改权维护直径（静态拓扑 Top Tree） <book-top-tree>

#include "数据结构/动态树/Top Tree/静态拓扑 Top Tree.typ"

#code("数据结构/动态树/Top Tree/静态拓扑 Top Tree.cpp")

== 树的编码与计数（Prüfer 序列） <book-prufer>

#include "图论/Prüfer 序列/Prüfer 序列.typ"

#code("图论/Prüfer 序列/Prüfer 序列.cpp", parts: ("heap", "linear"))

#tree-topic("trick-tree-26", level: 4, outlined: false)

#pagebreak()

= 图论 <chapter-graph>

== 最短路径 <book-shortest-path>

=== 单源非负权：Dijkstra <book-dijkstra>

#include "图论/Dijkstra/Dijkstra.typ"

#code("图论/Dijkstra/Dijkstra.cpp", mode: "full", ignore-main: false)

=== 全点对：Floyd <book-floyd>

#include "图论/Floyd/Floyd.typ"

#code("图论/Floyd/Floyd.cpp")

== 区间连边（线段树优化建图） <book-range-graph>

#include "图论/区间建图/线段树优化建图.typ"

#code("图论/区间建图/线段树优化建图.cpp")

== 差分不等式可行性（差分约束） <book-difference-constraints>

#include "图论/差分约束/差分约束.typ"

#code("图论/差分约束/差分约束.cpp")

== 有向图强连通分量与缩点（Tarjan） <book-scc>

#include "图论/连通性问题/连通性问题.typ"

#include "图论/连通性问题/Tarjan SCC 缩点.typ"

#code("图论/连通性问题/Tarjan SCC 缩点.cpp")

== 删点删边连通性与双连通分量 <book-bcc>

#include "图论/连通性问题/割点、桥与双连通分量.typ"

=== 割点 <book-articulation>

#code("图论/连通性问题/Tarjan 求割点.cpp")

=== 桥 <book-bridge>

#code("图论/连通性问题/Tarjan 求割边（桥）.cpp")

=== 边双连通分量 <book-edge-bcc>

#code("图论/连通性问题/eDCC 求边双.cpp")

=== 点双连通分量 <book-vertex-bcc>

#code("图论/连通性问题/vDCC 求点双.cpp")

== 最小生成树（MST） <book-mst>

#include "图论/MST/MST.typ"

=== set 优化 Prim <book-variant-076>

#code("图论/MST/set 优化 Prim.cpp")

=== 堆优化 Prim <book-variant-077>

#code("图论/MST/堆优化 Prim.cpp")

=== Kruskal <book-variant-078>

#code("图论/MST/Kruskal.cpp")

=== Borůvka 异或最小生成树 <book-variant-079>

#include "图论/MST/Boruvka 异或最小生成树.typ"

#code("图论/MST/Boruvka 异或最小生成树.cpp", mode: "full")

=== 严格次小生成树 <book-variant-080>

#include "图论/MST/严格次小生成树.typ"

#code("图论/MST/严格次小生成树.cpp")

== 阈值连通性（Kruskal 重构树） <book-kruskal-tree>

#include "图论/Kruskal 重构树/Kruskal 重构树.typ"

#code("图论/Kruskal 重构树/Kruskal 重构树.cpp")

== 生成树计数（矩阵树定理） <book-matrix-tree>

#include "图论/矩阵树定理/矩阵树定理.typ"

#code("图论/矩阵树定理/矩阵树定理.cpp")

参见 #link(<book-linear-system>)[行列式与高斯消元的接口约定]。

== 二变量逻辑约束（2-SAT） <book-two-sat>

#include "图论/2-SAT/2-SAT.typ"

#code("图论/2-SAT/2-SAT.cpp")

== 必经点与支配关系（支配树） <book-dominator>

#include "图论/支配树/支配树.typ"

#code("图论/支配树/支配树.cpp")

== 一次经过每条边（欧拉路） <book-euler-route>

#include "图论/欧拉路/欧拉路.typ"

#code("图论/欧拉路/欧拉路.cpp")

== 动态连通性（时间线段树与可撤销并查集） <book-dynamic-connectivity>

#include "图论/线段树分治/线段树分治.typ"

#code("图论/线段树分治/线段树分治.cpp")

#misc-topic("trick-misc-28", level: 4, outlined: false)

#misc-topic("trick-misc-29", level: 4, outlined: false)

参见 #link(<book-dsu>)[可撤销并查集]。

== 最大匹配 <book-matching>

=== 二分图最大匹配 <book-bipartite-matching>

#include "图论/二分图匹配/二分图最大匹配.typ"

#code("图论/二分图匹配/二分图最大匹配.cpp")

=== 一般图最大匹配（带花树） <book-blossom>

#include "图论/一般图匹配/一般图最大匹配.typ"

#code("图论/一般图匹配/一般图最大匹配.cpp")

== 同时满足两类独立约束（拟阵交） <book-matroid>

#include "图论/拟阵交/拟阵交.typ"

=== 增广框架 <book-variant-091>

#code("图论/拟阵交/拟阵交.cpp", mode: "full")

=== 划分拟阵与图拟阵 <book-variant-092>

#code("图论/拟阵交/常用拟阵.cpp", parts: ("partition-matroid", "unit-partition-matroid-intersection", "graphic-matroid"))

== 单出边图上的跳转与环（功能图） <book-functional-graph>

#include "图论/功能图/功能图.typ"

#code("图论/功能图/功能图.cpp")

== 无向单环结构（基环树） <book-unicyclic>

#include "图论/基环树/无向基环树.typ"

#code("图论/基环树/无向基环树.cpp")

#tree-topic("trick-tree-25", level: 4, outlined: false)

== 邻居批量更新（高低度根号分治） <book-graph-neighbor>

#include "数据结构/根号分治/图上邻居加.typ"

#code("数据结构/根号分治/图上邻居加.cpp")

#misc-topic("trick-misc-26", level: 4, outlined: false)

参见 #link(<trick-misc-25>)[一般高低频分治的复杂度推导]。

#pagebreak()

= 网络流 <chapter-flow>

#include "图论/网络流/网络流.typ"

== 最大流 <book-max-flow>

=== EK 增广路 <book-ek>

#include "图论/网络流/EK 最大流.typ"

#code("图论/网络流/EK 最大流.cpp")

=== Dinic 分层增广 <book-dinic>

#include "图论/网络流/Dinic 最大流最小割_2.typ"

#code("图论/网络流/Dinic 最大流最小割.cpp", mode: "full")

== 最小割与划分恢复 <book-min-cut>

#include "图论/网络流/Dinic 最大流最小割_3.typ"

#code("图论/网络流/求最小割的划分_2.cpp", mode: "full")

== 最小容量后的最少割边 <book-min-cut-edges>

#include "图论/网络流/Dinic 最大流最小割_4.typ"

#code("图论/网络流/求最小割的最少边数_3.cpp", mode: "full")

== 最小费用最大流 <book-min-cost-flow>

=== SPFA 最小费用最大流 <book-spfa-cost-flow>

#include "图论/网络流/SPFA 最小费用最大流.typ"

#code("图论/网络流/SPFA 最小费用最大流.cpp")

=== 势能 Dijkstra 最小费用最大流 <book-potential-cost-flow>

#include "图论/网络流/势能 Dijkstra 最小费用最大流.typ"

#code("图论/网络流/势能 Dijkstra 最小费用最大流.cpp")

== 上下界可行流 <book-bounded-flow>

#include "图论/网络流/有上下界可行流.typ"

#code("图论/网络流/有上下界可行流.cpp")

#pagebreak()

= 动态规划 <chapter-dp>

#include "动态规划/动态规划.typ"

#dp-intro

== 背包选择 <book-knapsack>

#include "动态规划/背包/背包.typ"

#code("动态规划/背包/背包.cpp")

#dp-topic("trick-dp-01", level: 4, outlined: false)

#dp-topic("trick-dp-09", level: 4, outlined: false)

#dp-topic("trick-dp-10", level: 4, outlined: false)

#dp-topic("trick-dp-11", level: 4, outlined: false)

参见 #link(<book-tree-knapsack>)[树上背包与依赖选择]。

== 布尔可达性与方案恢复（bitset 背包） <book-bitset-knapsack>

#bit-topic("trick-bit-19", level: 4, outlined: false)

#bit-topic("trick-bit-20", level: 4, outlined: false)

参见 #link(<book-bitset>)[动态位集代码]。

== 序列最优值与前驱重建（LIS） <book-lis>

#include "动态规划/序列 DP/最长上升子序列.typ"

#code("动态规划/序列 DP/最长上升子序列.cpp", mode: "full")

#dp-topic("trick-dp-34", level: 4, outlined: false)

== 偏序约束下的最优序列 <book-partial-order-dp>

#dp-topic("trick-dp-13", level: 4, outlined: false)

参见 #link(<book-cdq>)[多维偏序的 CDQ 实现]。

== 状态等价、守恒与支配关系 <book-dp-state>

#dp-topic("trick-dp-02", level: 4, outlined: false)

#dp-topic("trick-dp-03", level: 4, outlined: false)

#dp-topic("trick-dp-04", level: 4, outlined: false)

== 未来成本的提前结算 <book-dp-advance-cost>

#dp-topic("trick-dp-05", level: 4, outlined: false)

#dp-topic("trick-dp-06", level: 4, outlined: false)

== 区间求和转移（前缀和） <book-dp-prefix>

#dp-topic("trick-dp-07", level: 4, outlined: false)

== 滑动窗口最优转移（单调队列） <book-dp-monotone-queue>

#dp-topic("trick-dp-08", level: 4, outlined: false)

== 绝对值与两侧代价转移 <book-dp-two-sides>

#dp-topic("trick-dp-12", level: 4, outlined: false)

== 区间合并与消除 <book-interval-dp>

#dp-topic("trick-dp-14", level: 4, outlined: false)

#dp-topic("trick-dp-15", level: 4, outlined: false)

#dp-topic("trick-dp-16", level: 4, outlined: false)

== 区间切点优化（Knuth） <book-knuth>

#include "动态规划/区间 DP/Knuth 石子合并.typ"

#code("动态规划/区间 DP/Knuth 石子合并.cpp")

#dp-topic("trick-dp-29", level: 4, outlined: false)

== 同步多路径状态 <book-synchronous-path-dp>

#dp-topic("trick-dp-19", level: 4, outlined: false)

== 集合分组与子集状态 <book-subset-dp>

#dp-topic("trick-dp-20", level: 4, outlined: false)

#dp-topic("trick-dp-21", level: 4, outlined: false)

#bit-topic("trick-bit-08", level: 4, outlined: false)

#bit-topic("trick-bit-09", level: 4, outlined: false)

#bit-topic("trick-bit-10", level: 4, outlined: false)

#bit-topic("trick-bit-24", level: 4, outlined: false)

参见 #link(<book-subset-transform>)[子集和查询的 SOS／Zeta 变换]。

== 窄网格边界状态（轮廓 DP） <book-contour-dp>

#dp-topic("trick-dp-22", level: 4, outlined: false)

== 数字范围计数（数位 DP） <book-digit-dp>

#dp-topic("trick-dp-23", level: 4, outlined: false)

#dp-topic("trick-dp-24", level: 4, outlined: false)

#dp-topic("trick-dp-25", level: 4, outlined: false)

== 最优值与方案数共同维护 <book-optimal-count>

#dp-topic("trick-dp-26", level: 4, outlined: false)

== 直线型转移（斜率优化） <book-cht-dp>

#dp-topic("trick-dp-27", level: 4, outlined: false)

参见 #link(<book-li-chao>)[李超树代码与整数查询范围]。

== 决策单调的分治优化 <book-divide-conquer-dp>

#dp-topic("trick-dp-28", level: 4, outlined: false)

== 恰好 K 次选择（WQS 二分） <book-wqs>

#dp-topic("trick-dp-30", level: 4, outlined: false)

== 凸分段线性代价（Slope Trick） <book-slope-trick>

#dp-topic("trick-dp-31", level: 4, outlined: false)

== 按值插入的连续段状态 <book-continuous-segments-dp>

#dp-topic("trick-dp-32", level: 4, outlined: false)

== 有限状态的巨大步数转移（矩阵加速） <book-matrix-dp>

#dp-topic("trick-dp-33", level: 4, outlined: false)

参见 #link(<book-matrix-power>)[矩阵运算与快速幂]。

参见 #link(<chapter-recurrence>)[线性递推与第 n 项查询]。

== 有向无环状态图（DAG DP） <book-dag-dp>

#dp-topic("trick-dp-35", level: 4, outlined: false)

参见 #link(<book-tree-connected-dp>)[树上连通块 DP]。

参见 #link(<book-reroot>)[全根统计与换根 DP]。

参见 #link(<book-probability-dp>)[概率分布 DP]。

参见 #link(<book-self-loop-expectation>)[自环期望方程]。

#pagebreak()

= 字符串 <chapter-string>

== 子串相等性（字符串哈希） <book-string-hash>

#include "字符串/字符串哈希/字符串哈希.typ"

#code("字符串/字符串哈希/字符串哈希.cpp")

== 单模式匹配（KMP） <book-kmp>

#include "字符串/KMP/KMP.typ"

#code("字符串/KMP/KMP.cpp", mode: "full", ignore-main: false)

== 前缀匹配长度（Z 函数） <book-z-function>

#include "字符串/Z 函数/Z 函数.typ"

#code("字符串/Z 函数/Z 函数.cpp", mode: "full")

== 多模式匹配（AC 自动机） <book-ac>

#include "字符串/ACAM/ACAM.typ"

#code("字符串/ACAM/ACAM.cpp", mode: "full", ignore-main: false)

== 最长回文半径（Manacher） <book-manacher>

#include "字符串/Manacher/Manacher.typ"

#code("字符串/Manacher/Manacher.cpp", mode: "full")

== 后缀排序与最长公共前缀（SA／LCP） <book-suffix-array>

#include "字符串/后缀数组/后缀数组.typ"

#code("字符串/后缀数组/后缀数组.cpp")

== 子串集合与出现次数（SAM） <book-sam>

#include "字符串/SAM/SAM.typ"

#code("字符串/SAM/SAM.cpp", mode: "full", ignore-main: false)

== 字典序因子分解与最小循环表示（Lyndon） <book-lyndon>

#include "字符串/Lyndon 分解/Lyndon 分解.typ"

#code("字符串/Lyndon 分解/Lyndon 分解.cpp")

== 极大周期区间（runs） <book-runs>

#include "字符串/runs/runs.typ"

#code("字符串/runs/runs.cpp")

== 单词与前缀集合（Trie） <book-string-trie>

#include "字符串/Trie/动态开点 Trie.typ"

#code("字符串/Trie/动态开点 Trie.cpp", mode: "full")

参见 #link(<book-xor-trie>)[整数异或查询的 01 Trie]。

#pagebreak()

= 数论 <chapter-number-theory>

#math-intro

== 模幂与防溢出模乘 <book-mod-power>

#include "数学/快速幂/快速幂.typ"

=== 普通快速幂 <book-binary-power>

#code("数学/快速幂/普通快速幂.cpp", mode: "full")

=== 快速乘 <book-variant-140>

#include "数学/快速幂/快速乘.typ"

#code("数学/快速幂/快速乘.cpp", mode: "full")

=== 龟速乘 <book-variant-141>

#include "数学/快速幂/龟速乘.typ"

#code("数学/快速幂/龟速乘.cpp", mode: "full")

== 整数线性方程（扩展欧几里得） <book-exgcd>

=== 求 $a x + b y = c$ 的解 <book-variant-143>

#include "数学/扩展欧几里得/扩展欧几里得.typ"

#code("数学/扩展欧几里得/扩展欧几里得.cpp", mode: "full", ignore-main: false)

#math-topic("trick-math-02", level: 4, outlined: false)

#math-topic("trick-math-03", level: 4, outlined: false)

== 模逆元与模除法 <book-mod-inverse>

#math-topic("trick-math-04", level: 4, outlined: false)

#math-topic("trick-math-05", level: 4, outlined: false)

参见 #link(<book-combination>)[阶乘与批量逆元代码]。

== 同余方程组合（EXCRT） <book-excrt>

#include "数学/EXCRT/EXCRT.typ"

#code("数学/EXCRT/EXCRT.cpp", mode: "full")

#math-topic("trick-math-06", level: 4, outlined: false)

== 复合模指数降幂（扩展欧拉） <book-extended-euler>

#include "数学/扩展欧拉定理/扩展欧拉定理.typ"

#code("数学/扩展欧拉定理/扩展欧拉定理.cpp", mode: "full")

#math-topic("trick-math-35", level: 4, outlined: false)

== 离散对数（扩展 BSGS） <book-exbsgs>

#include "数学/EXBSGS/EXBSGS.typ"

#code("数学/EXBSGS/EXBSGS.cpp", mode: "full")

== 质数与积性函数预处理（线性筛） <book-linear-sieve>

#include "数学/欧拉筛/欧拉筛.typ"

=== 筛质数 <book-variant-149>

#code("数学/欧拉筛/线性筛素数.cpp")

=== 筛积性函数 <book-variant-150>

#code("数学/欧拉筛/线性筛积性函数.cpp")

== 整数分解与质因子指数（Pollard-Rho） <book-pollard-rho>

#include "数学/Pollard-Rho/Pollard-Rho.typ"

#code("数学/Pollard-Rho/Pollard-Rho.cpp", mode: "full", ignore-main: false)

#math-topic("trick-math-34", level: 4, outlined: false)

== 整除商的批量求和（整除分块） <book-division-block>

#include "数学/整除分块/整除分块.typ"

#code("数学/整除分块/整除分块.cpp", mode: "full")

#math-topic("trick-math-07", level: 4, outlined: false)

#math-topic("trick-math-08", level: 4, outlined: false)

#math-topic("trick-math-33", level: 4, outlined: false)

== 因子与倍数贡献交换 <book-divisor-contribution>

#math-topic("trick-math-09", level: 4, outlined: false)

#math-topic("trick-math-12", level: 4, outlined: false)

== 互质计数（莫比乌斯反演） <book-mobius>

#include "数学/莫比乌斯反演/莫比乌斯反演.typ"

#math-topic("trick-math-13", level: 4, outlined: false)

== 积性函数大范围前缀和（杜教筛） <book-dujiao>

#include "数学/杜教筛/杜教筛.typ"

#code("数学/杜教筛/杜教筛.cpp")

== 积性函数大范围求和（Min_25 筛） <book-min25>

#include "数学/Min_25 筛/Min_25 筛.typ"

#code("数学/Min_25 筛/Min_25 筛.cpp")

== 线性取整求和（类欧几里得） <book-floor-sum>

=== floor_sum <book-variant-158>

#include "数学/类欧几里得/floor_sum.typ"

#code("数学/类欧几里得/floor_sum.cpp", mode: "full")

=== 高阶类欧（精确值） <book-variant-159>

#include "数学/类欧几里得/高阶类欧.typ"

#code("数学/类欧几里得/高阶类欧.cpp", mode: "full")

=== 高阶类欧（取模） <book-variant-160>

#include "数学/类欧几里得/高阶类欧取模.typ"

#code("数学/类欧几里得/高阶类欧取模.cpp", mode: "full")

#pagebreak()

= 线性代数 <chapter-linear-algebra>

== 矩阵运算与快速幂 <book-matrix-power>

#include "数学/线性代数/矩阵运算.typ"

#code("数学/线性代数/矩阵运算.cpp")

=== 旧版矩阵快速幂接口 <book-legacy-matrix-power>

#code("数学/快速幂/矩阵快速幂.cpp")

参见 #link(<book-matrix-dp>)[有限状态转移的矩阵建模]。

== 线性方程组、行列式与逆矩阵（消元） <book-linear-system>

=== 高斯消元与解的分类 <book-gauss>

#include "数学/线性代数/高斯消元.typ"

#code("数学/线性代数/高斯消元.cpp", mode: "full")

=== 行列式、逆矩阵与唯一解接口 <book-matrix-inverse>

#include "数学/线性代数/线性代数.typ"

#code("数学/线性代数/线性代数.cpp", parts: ("determinant", "inverse", "solve-linear"))

参见 #link(<book-matrix-tree>)[生成树计数的矩阵树定理]。

#pagebreak()

= 组合计数 <chapter-combinatorics>

== 组合数计算 <book-combination>

=== 阶乘预处理与批量逆元 <book-variant-168>

#include "数学/组合数/组合数.typ"

#code("数学/组合数/组合数.cpp", parts: ("comb", "batch-inverse"))

=== Lucas 定理 <book-variant-169>

#include "数学/Lucas/Lucas.typ"

#code("数学/Lucas/Lucas.cpp", mode: "full")

=== 任意模数下的组合数 <book-variant-170>

#include "数学/任意模组合数/任意模组合数.typ"

#code("数学/任意模组合数/任意模组合数.cpp")

#math-topic("trick-math-14", level: 4, outlined: false)

#math-topic("trick-math-18", level: 4, outlined: false)

== 分配与有界拆分（隔板法） <book-stars-bars>

#math-topic("trick-math-15", level: 4, outlined: false)

#math-topic("trick-math-16", level: 4, outlined: false)

== 非法方案的容斥与补集 <book-inclusion-exclusion>

#math-topic("trick-math-17", level: 4, outlined: false)

#misc-topic("trick-misc-01", level: 4, outlined: false)

== 整数拆分与常见计数序列 <book-combinatorial-numbers>

#include "数学/组合计数/组合计数.typ"

#code("数学/组合计数/组合计数.cpp", parts: ("partition-numbers", "common-numbers"))

=== 正整数有序拆分 <book-ordered-partition>

#include "数学/高精度/正整数有序拆分.typ"

#code("数学/高精度/正整数有序拆分.cpp", mode: "full")

#math-topic("trick-math-19", level: 4, outlined: false)

== 排列的固定点、错排与环 <book-permutation-counting>

#math-topic("trick-math-20", level: 4, outlined: false)

#math-topic("trick-math-21", level: 4, outlined: false)

参见 #link(<book-combinatorial-numbers>)[错排数与斯特林数代码]。

== 排列排名与还原（康托展开） <book-cantor>

#include "数学/康托展开/康托展开.typ"

#code("数学/康托展开/康托展开.cpp")

== 对称等价方案计数（Burnside／Pólya） <book-burnside>

#include "数学/Burnside 与 Pólya/Burnside 与 Pólya.typ"

#math-topic("trick-math-22", level: 4, outlined: false)

== 计数模型的生成函数 <book-generating-function>

#include "数学/生成函数/生成函数.typ"

参见 #link(<chapter-polynomial>)[多项式与卷积运算]。

参见 #link(<book-prufer>)[有度数约束的树计数]。

#pagebreak()

= 概率与期望 <chapter-probability>

== 概率与期望的基本模型 <book-probability-basics>

#include "数学/概率与期望/概率与期望.typ"

#math-topic("trick-math-32", level: 4, outlined: false)

== 总数量与总得分（指示变量） <book-indicator-expectation>

#math-topic("trick-math-29", level: 4, outlined: false)

== 随机长度与等待次数 <book-tail-expectation>

#math-topic("trick-math-30", level: 4, outlined: false)

#math-topic("trick-math-31", level: 4, outlined: false)

== 随机过程的分布（概率 DP） <book-probability-dp>

#dp-topic("trick-dp-17", level: 4, outlined: false)

== 含原地等待的期望方程（自环） <book-self-loop-expectation>

#dp-topic("trick-dp-18", level: 4, outlined: false)

参见 #link(<book-linear-system>)[一般线性期望方程的高斯消元]。

参见 #link(<book-geometric-probability>)[随机方向、边界、区域点与重叠面积的几何模型]。

#pagebreak()

= 博弈论 <chapter-game>

#game-intro

== Nim 与无环游戏的 SG 模型 <book-sg>

#include "数学/SG 与 Nim/SG 与 Nim.typ"

#code("数学/SG 与 Nim/SG 与 Nim.cpp", parts: ("nim", "subtraction-game", "dag-sg"))

#game-topic("trick-game-01", level: 4, outlined: false)

#game-topic("trick-game-02", level: 4, outlined: false)

#game-topic("trick-game-05", level: 4, outlined: false)

#game-topic("trick-game-06", level: 4, outlined: false)

#game-topic("trick-game-07", level: 4, outlined: false)

#game-topic("trick-game-08", level: 4, outlined: false)

== 反常终止（反 Nim） <book-misere-nim>

#game-topic("trick-game-03", level: 4, outlined: false)

参见 #link(<book-sg>)[Nim 与反 Nim 的判定接口]。

== 固定上限取石子（巴什） <book-bash>

#game-topic("trick-game-04", level: 4, outlined: false)

== 对称应手与策略偷换 <book-symmetric-game>

#game-topic("trick-game-09", level: 4, outlined: false)

#game-topic("trick-game-19", level: 4, outlined: false)

== 相邻层下移（阶梯 Nim） <book-staircase-nim>

#game-topic("trick-game-10", level: 4, outlined: false)

== 受阻棋子移动（Silver Dollar） <book-silver-dollar>

#game-topic("trick-game-11", level: 4, outlined: false)

== 双堆同步取石子（威佐夫） <book-wythoff>

#game-topic("trick-game-12", level: 4, outlined: false)

== 行动上限随步骤变化（Fibonacci Nim） <book-fibonacci-nim>

#game-topic("trick-game-13", level: 4, outlined: false)

== 可循环的胜负与平局（反图传播） <book-loopy-game>

#game-topic("trick-game-14", level: 4, outlined: false)

== 双方规则不同的轮流博弈 <book-player-state>

#game-topic("trick-game-15", level: 4, outlined: false)

== 得分最大化对抗（minimax） <book-minimax>

#game-topic("trick-game-16", level: 4, outlined: false)

== 树上删边游戏 <book-tree-game>

#game-topic("trick-game-17", level: 4, outlined: false)

== 奇偶势与胜负规律证明 <book-game-invariant>

#game-topic("trick-game-18", level: 4, outlined: false)

#game-topic("trick-game-20", level: 4, outlined: false)

#pagebreak()

= 多项式与卷积 <chapter-polynomial>

== 普通卷积（FFT／NTT） <book-convolution>

=== FFT <book-fft>

#include "数学/FFT/FFT.typ"

#code("数学/FFT/FFT.cpp", mode: "full", ignore-main: false)

=== NTT <book-ntt>

#include "数学/NTT/NTT.typ"

#code("数学/NTT/NTT.cpp", mode: "full", ignore-main: false)

== 掩码上的子集和与位运算卷积（Zeta／FWT） <book-subset-transform>

#include "数学/集合变换/集合变换.typ"

#code("数学/集合变换/集合变换.cpp")

#bit-topic("trick-bit-11", level: 4, outlined: false)

#bit-topic("trick-bit-12", level: 4, outlined: false)

== 不相交集合合并（子集卷积） <book-subset-convolution>

#include "数学/集合变换/子集卷积.typ"

#code("数学/集合变换/子集卷积.cpp")

== 多项式基础运算与 NTT 接口 <book-poly-base>

#include "数学/多项式/多项式基础.typ"

#code("数学/多项式/多项式基础.cpp", mode: "full")

== 形式幂级数求逆 <book-poly-inverse>

#include "数学/多项式/多项式求逆.typ"

#code("数学/多项式/多项式求逆.cpp", mode: "full")

== 形式幂级数对数与指数 <book-poly-log-exp>

#include "数学/多项式/多项式对数与指数.typ"

#code("数学/多项式/多项式对数与指数.cpp", mode: "full")

== 形式幂级数平方根 <book-poly-sqrt>

#include "数学/多项式/多项式平方根.typ"

#code("数学/多项式/多项式平方根.cpp", mode: "full")

== 多项式除法与余数 <book-poly-div>

#include "数学/多项式/多项式除法.typ"

#code("数学/多项式/多项式除法.cpp", mode: "full")

== 形式幂级数幂 <book-poly-power>

#include "数学/多项式/多项式幂.typ"

#code("数学/多项式/多项式幂.cpp", mode: "full")

== 多点求值与插值 <book-multipoint>

#include "数学/多项式/多点求值与插值.typ"

#code("数学/多项式/多点求值与插值.cpp", mode: "full")

== 单点插值求值（拉格朗日） <book-lagrange>

#include "数学/拉格朗日插值/拉格朗日插值.typ"

#code("数学/拉格朗日插值/拉格朗日插值.cpp", mode: "full")

参见 #link(<book-generating-function>)[生成函数计数建模]。

参见 #link(<book-geometric-area>)[有向面积总和转卷积的应用]。

参见 #link(<chapter-recurrence>)[线性递推与 Bostan-Mori]。

#pagebreak()

= 线性递推 <chapter-recurrence>

== 从前若干项恢复最短递推（BM） <book-bm>

#include "数学/线性递推/Berlekamp-Massey.typ"

#code("数学/线性递推/Berlekamp-Massey.cpp")

== 线性递推第 n 项（Bostan-Mori） <book-bostan-mori>

#include "数学/线性递推/Bostan-Mori.typ"

#code("数学/线性递推/Bostan-Mori.cpp", mode: "full")

参见 #link(<book-matrix-power>)[已知有限状态转移的矩阵快速幂]。

参见 #link(<book-poly-base>)[递推求项需要的多项式乘法]。

#pagebreak()

= 计算几何 <chapter-geometry>

#geom-intro

== 读题信号与区域赛样本 <book-geometric-models>

#metadata("功能入口") <geom-map>

#geom-topic("geom-choose-model", level: 4, outlined: false)

#geom-topic("geom-contest-samples", level: 4, outlined: false)

== 点线基础与夹角计算 <book-point-line>

#include "数学/计算几何/点与直线基础.typ"

#code("数学/计算几何/点与直线基础.cpp", mode: "full")

#metadata("功能入口") <geom-angles>

#geom-topic("geom-cross-dot", level: 4, outlined: false)

#geom-topic("geom-angle-functions", level: 4, outlined: false)

#geom-topic("geom-relative-angle", level: 4, outlined: false)

#geom-topic("geom-angle-normalize", level: 4, outlined: false)

== 线段相交与多边形包含 <book-segments-polygon>

#include "数学/计算几何/线段与多边形.typ"

#code("数学/计算几何/线段与多边形.cpp", parts: ("point-in-polygon", "segment-intersection", "segment-in-polygon"))

== 半平面约束交集 <book-half-plane-intersection>

#include "数学/计算几何/半平面交.typ"

#code("数学/计算几何/半平面交.cpp", mode: "full")

== 圆的交点、切线与交面积 <book-circle>

#include "数学/计算几何/圆.typ"

#code("数学/计算几何/圆.cpp", parts: ("circle-base", "intersections", "tangents", "intersection-area"))

#geom-topic("geom-circle-angle", level: 4, outlined: false)

== 圆周方向统计（极角排序与扫描） <book-polar-scan>

#metadata("功能入口") <geom-polar-scan>

#geom-topic("geom-polar-order", level: 4, outlined: false)

#geom-topic("geom-sort-counterexample", level: 4, outlined: false)

#geom-topic("geom-half-plane", level: 4, outlined: false)

#geom-topic("geom-separation", level: 4, outlined: false)

#geom-topic("geom-coverage-width", level: 4, outlined: false)

#geom-topic("geom-angular-events", level: 4, outlined: false)

#geom-topic("geom-origin-triangles", level: 4, outlined: false)

#geom-topic("geom-unbounded-scale", level: 4, outlined: false)

== 凸包极值与点定位（旋转卡壳） <book-convex-hull>

#include "数学/计算几何/凸包与旋转卡壳.typ"

#code("数学/计算几何/凸包与旋转卡壳.cpp", parts: ("convex-hull", "diameter"))

#metadata("功能入口") <geom-convex>

#geom-topic("geom-hull-information", level: 4, outlined: false)

#geom-topic("geom-support", level: 4, outlined: false)

#geom-topic("geom-convex-query", level: 4, outlined: false)

#geom-topic("geom-local-hull", level: 4, outlined: false)

== 多边形面积与面积总和（有向边贡献） <book-geometric-area>

#metadata("功能入口") <geom-area-probability>

#geom-topic("geom-signed-area", level: 4, outlined: false)

#geom-topic("geom-edge-contribution", level: 4, outlined: false)

参见 #link(<book-convolution>)[面积贡献式中的卷积]。

== 矩形面积并（扫描线） <book-rectangle-union>

#include "数学/计算几何/扫描线求矩形面积并/扫描线求矩形面积并.typ"

#code("数学/计算几何/扫描线求矩形面积并/扫描线求矩形面积并.cpp", mode: "full", ignore-main: false)

== 平移碰撞（闵可夫斯基和／差） <book-minkowski>

#metadata("功能入口") <geom-transforms>

#geom-topic("geom-minkowski", level: 4, outlined: false)

#geom-topic("geom-minkowski-merge", level: 4, outlined: false)

== 几何概率与随机重叠面积 <book-geometric-probability>

#geom-topic("geom-probability-measure", level: 4, outlined: false)

#geom-topic("geom-illumination", level: 4, outlined: false)

#geom-topic("geom-overlap-expectation", level: 4, outlined: false)

== 面积重心与随机配重 <book-centroid-area>

#geom-topic("geom-affine-centroid", level: 4, outlined: false)

== 坐标变换后的几何不变量 <book-affine-transform>

#geom-topic("geom-transform-invariants", level: 4, outlined: false)

== 整点中点的可达性与最少步数 <book-lattice-midpoint>

#metadata("功能入口") <geom-discrete-structure>

#geom-topic("geom-midpoint", level: 4, outlined: false)

== 曼哈顿与切比雪夫距离 <book-metric-transform>

#geom-topic("geom-metrics", level: 4, outlined: false)

#math-topic("trick-math-23", level: 4, outlined: false)

#math-topic("trick-math-24", level: 4, outlined: false)

== 三角形边长的可行性 <book-triangle-inequality>

#math-topic("trick-math-26", level: 4, outlined: false)

== 少量图形覆盖（有限见证集） <book-finite-geometry>

#geom-topic("geom-finite-structure", level: 4, outlined: false)

== 地形局部最低区域 <book-local-minima>

#geom-topic("geom-local-minima", level: 4, outlined: false)

== 镜面反射路径与周期 <book-reflection>

#geom-topic("geom-reflection", level: 4, outlined: false)

== 碰撞结构与平面分割 <book-planar-topology>

#geom-topic("geom-topology", level: 4, outlined: false)

== 数值谓词、精确交点与退化处理 <book-geometry-robustness>

#metadata("功能入口") <geom-robustness>

#geom-topic("geom-integer-range", level: 4, outlined: false)

#geom-topic("geom-eps", level: 4, outlined: false)

#geom-topic("geom-exact-intersection", level: 4, outlined: false)

#geom-topic("geom-degeneracy", level: 4, outlined: false)

== 几何自测与代码依赖 <book-geometry-practice>

#metadata("功能入口") <geom-practice>

#geom-topic("geom-self-test", level: 4, outlined: false)

#geom-topic("geom-code-contract", level: 4, outlined: false)

#pagebreak()

= 工具与通用技巧 <chapter-tools>

#misc-intro

#bit-intro

== 带符号大整数运算 <book-bigint>

#include "数学/高精度/高精度.typ"

#code("数学/高精度/高精度加减乘除取余.cpp")

== 宽整数运算与输入输出（i128） <book-wide-integer>

#include "杂项/i128 输入输出重载/i128 输入输出重载.typ"

#code("杂项/i128 输入输出重载/i128 输入输出重载.cpp", mode: "full")

#math-topic("trick-math-36", level: 4, outlined: false)

== 位枚举、进位与有限位域 <book-bit-operations>

#bit-topic("trick-bit-05", level: 4, outlined: false)

#bit-topic("trick-bit-07", level: 4, outlined: false)

#bit-topic("trick-bit-25", level: 4, outlined: false)

== 排序与逆序对（归并排序） <book-merge-sort>

#include "杂项/归并排序/归并排序.typ"

#code("杂项/归并排序/归并排序.cpp")

== 单峰最优值（三分） <book-ternary-search>

#include "杂项/三分/三分.typ"

#code("杂项/三分/三分.cpp", mode: "full", ignore-main: false)

== 指数规模搜索（折半） <book-meet-in-middle>

#include "杂项/折半搜索/折半搜索.typ"

#code("杂项/折半搜索/折半搜索.cpp")

#misc-topic("trick-misc-24", level: 4, outlined: false)

== 随机集合指纹 <book-fingerprint>

#include "杂项/随机指纹/随机指纹.typ"

#code("杂项/随机指纹/随机指纹.cpp")

== 连续区间可行性（双指针与单调队列） <book-window>

#misc-topic("trick-misc-05", level: 4, outlined: false)

#misc-topic("trick-misc-06", level: 4, outlined: false)

== 隐式第 k 小与第 k 大 <book-implicit-order>

#misc-topic("trick-misc-22", level: 4, outlined: false)

#misc-topic("trick-misc-23", level: 4, outlined: false)

== 单调判定与比值最优（二分答案） <book-binary-answer>

#misc-topic("trick-misc-09", level: 4, outlined: false)

#misc-topic("trick-misc-10", level: 4, outlined: false)

== 截止时间调度与反悔贪心 <book-scheduling>

#misc-topic("trick-misc-14", level: 4, outlined: false)

#misc-topic("trick-misc-15", level: 4, outlined: false)

== 按中间元素统计三元组 <book-triple-contribution>

#misc-topic("trick-misc-02", level: 4, outlined: false)

== 全点对绝对差总和（排序贡献） <book-pair-absolute-difference>

#misc-topic("trick-misc-34", level: 4, outlined: false)

== 最少交换次数 <book-minimum-swaps>

#misc-topic("trick-misc-11", level: 3, outlined: true)

#misc-topic("trick-misc-12", level: 3, outlined: true)

#misc-topic("trick-misc-13", level: 3, outlined: true)

参见 #link(<book-merge-sort>)[相邻交换排序需要的逆序对计数]。

== 局部修改的增量维护 <book-local-change>

#misc-topic("trick-misc-19", level: 4, outlined: false)

#misc-topic("trick-misc-20", level: 4, outlined: false)

== 区间选择中的支配删除 <book-dominated-intervals>

#misc-topic("trick-misc-21", level: 4, outlined: false)

== 不交叉区间构树 <book-interval-tree>

#misc-topic("trick-misc-37", level: 4, outlined: false)

== 高低频分治的总成本 <book-sqrt-cost>

#misc-topic("trick-misc-25", level: 4, outlined: false)

参见 #link(<book-graph-neighbor>)[图上高低度邻居更新]。

== 字典序最小的逐步构造 <book-lexicographic-construction>

#misc-topic("trick-misc-35", level: 4, outlined: false)

== MEX 的有效值域 <book-mex>

#misc-topic("trick-misc-36", level: 4, outlined: false)

== 可达性不变量与最优下界构造 <book-invariant-construction>

#misc-topic("trick-misc-38", level: 4, outlined: false)

#misc-topic("trick-misc-39", level: 4, outlined: false)

== 稀疏事件跳过巨大时间轴 <book-sparse-events>

#misc-topic("trick-misc-40", level: 4, outlined: false)

== 随机对拍与回归自测 <book-stress-test>

#include "杂项/对拍/对拍.typ"

=== 单进程函数对拍 <book-variant-261>

#code("杂项/对拍/单进程函数对拍.cpp", mode: "full")

=== 进程对拍 <book-variant-262>

#code("杂项/对拍/进程对拍.cpp", mode: "full", ignore-main: false)

== 训练入口与常见误用 <book-training>

#lookup-training
]
