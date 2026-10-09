训练时从题面信号定位条目，再核对该条适用条件。编号与各章 Trick 小节一致。

#table(columns: (1fr, 1fr, auto), table.header([题面信号], [优先尝试], [条目]),
[#text("状态多了一维时间、历史费用")], [#text("把对未来已确定的费用提前结算")], [#link(<trick-dp-05>)[#text("DP-05")]、#link(<trick-dp-06>)[#text("DP-06")]],
[#text("容量特别大，但总价值小")], [#text("价值作下标，存最小重量")], [#link(<trick-dp-01>)[#text("DP-01")]],
[#text("状态是“选了哪些”，还记人数")], [#text("人数可能等于集合大小")], [#link(<trick-dp-21>)[#text("DP-21")]],
[#text("转移枚举连续区间、前一层求和")], [#text("前缀和或滑动最值")], [#link(<trick-dp-07>)[#text("DP-07")]、#link(<trick-dp-08>)[#text("DP-08")]],
[#text("转移含平方差或 i、j 乘积")], [#text("展开成直线，检查斜率与查询单调性")], [#link(<trick-dp-27>)[#text("DP-27")]],
[#text("恰好 K 段，去掉次数限制后好做")], [#text("先验证离散凸性，再考虑 WQS")], [#link(<trick-dp-30>)[#text("DP-30")]],
[#text("巨大值域的绝对值 DP")], [#text("分左右两侧，或凸分段线性维护")], [#link(<trick-dp-12>)[#text("DP-12")]、#link(<trick-dp-31>)[#text("DP-31")]],
[#text("网格窄、只与边界相邻")], [#text("轮廓/状压 DP")], [#link(<trick-dp-22>)[#text("DP-22")]],
[#text("位数很多、数字范围极大")], [#text("数位 DP，记录必要性质")], [#link(<trick-dp-23>)[#text("DP-23")]],
[#text("游戏分成互不影响的部分")], [#text("单游戏 SG，再异或")], [#link(<trick-game-06>)[#text("GAME-06")]],
[#text("游戏可以循环、无限行动")], [#text("反图传播胜负平局")], [#link(<trick-game-14>)[#text("GAME-14")]],
[#text("取最后一个者输")], [#text("单独分析反常末局")], [#link(<trick-game-03>)[#text("GAME-03")]],
[#text("树上全点对总和")], [#text("按边或删点后分支算贡献")], [#link(<trick-tree-04>)[#text("TREE-04")]、#link(<trick-tree-20>)[#text("TREE-20")]],
[#text("每个点都作一次根")], [#text("换根消息，前后缀排除一个儿子")], [#link(<trick-tree-07>)[#text("TREE-07")]、#link(<trick-tree-08>)[#text("TREE-08")]],
[#text("每问只有少量关键点")], [#text("虚树或 DFS 序环上距离")], [#link(<trick-tree-12>)[#text("TREE-12")]、#link(<trick-tree-13>)[#text("TREE-13")]],
[#text("任意点到集合最远距离")], [#text("非负权树中的集合直径端点")], [#link(<trick-tree-09>)[#text("TREE-09")]、#link(<trick-tree-10>)[#text("TREE-10")]],
[#text("对所有子数组做 AND / OR / gcd")], [#text("固定端点压缩不同结果")], [#link(<trick-bit-13>)[#text("BIT-13")]、#link(<trick-math-10>)[#text("MATH-10")]],
[#text("所有数对 XOR 总和")], [#text("每位数 0/1 对数")], [#link(<trick-bit-02>)[#text("BIT-02")]],
[#text("任意子集 XOR 是否可达")], [#text("线性基；别和“两原数”混淆")], [#link(<trick-bit-16>)[#text("BIT-16")]、#link(<trick-bit-17>)[#text("BIT-17")]],
[#text("掩码的全部子集之和")], [#text("SOS 高维前缀和")], [#link(<trick-bit-11>)[#text("BIT-11")]],
[#text("没有顺序但多次重复计数")], [#text("固定最小元素、唯一最高点或唯一最后一步")], [#link(<trick-dp-20>)[#text("DP-20")]、#link(<trick-tree-15>)[#text("TREE-15")]],
[#text("区间和等于 K / 整除 m")], [#text("前缀值相等或同余")], [#link(<trick-misc-03>)[#text("MISC-03")]、#link(<trick-math-01>)[#text("MATH-01")]],
[#text("期望是总得分或总数量")], [#text("指示变量逐对象算概率")], [#link(<trick-math-29>)[#text("MATH-29")]],
[#text("求和含 floor(N/i)")], [#text("相同商分块")], [#link(<trick-math-07>)[#text("MATH-07")]],
[#text("模数下公式有除法")], [#text("查 gcd，不能默认费马逆元")], [#link(<trick-math-04>)[#text("MATH-04")]],
[#text("问答只看某个阈值")], [#text("排序激活、离线扫描")], [#link(<trick-misc-08>)[#text("MISC-08")]],
[#text("图上只有删除")], [#text("逆序加入")], [#link(<trick-misc-28>)[#text("MISC-28")]],
[#text("动态加入删除且可撤销")], [#text("对象活跃区间挂时间线段树")], [#link(<trick-misc-29>)[#text("MISC-29")]],
[#text("只有大约 40 个对象")], [#text("折半枚举")], [#link(<trick-misc-24>)[#text("MISC-24")]],
[#text("少数很大，多数很小")], [#text("推导高低频/高低度分治成本")], [#link(<trick-misc-25>)[#text("MISC-25")]、#link(<trick-misc-26>)[#text("MISC-26")]],
[#text("每次全部加一个相同值")], [#text("全局偏移")], [#link(<trick-misc-32>)[#text("MISC-32")]],
[#text("最少相邻交换")], [#text("逆序对或“位置减序号”")], [#link(<trick-misc-11>)[#text("MISC-11")]、#link(<trick-misc-12>)[#text("MISC-12")]],
)

=== 训练顺序

#text("第一轮按“前缀配对 → 贡献统计 → 状态压缩 → 反悔贪心 → 树距离 → SG 基础”过 A 类。能自己推式子、说明适用条件并给一个误用反例，再进入变形题。")

#text("第二轮练 DP 前缀和/单调队列、偏序 DP、点分治、虚树、SOS、线性基、离线扫描和高低分治。每个模型做基本题与变形题，记录触发思路的题面信号。")

#text("第三轮由相应方向最熟悉的队员选择 WQS、Knuth、Slope Trick、连续段 DP、Burnside 深入。复盘重点是错误模型漏了什么信息，以及最小反例。")

=== DP 练习入口

#table(columns: (auto, 1fr), table.header([AtCoder 题目], [训练点]),
[#link("https://atcoder.jp/contests/dp/tasks/dp_d")[#text("D — Knapsack 1")]], [#text("0/1 背包旧层/新层")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_e")[#text("E — Knapsack 2")]], [#text("按价值记最小重量")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_i")[#text("I — Coins")]], [#text("概率分布 DP")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_j")[#text("J — Sushi")]], [#text("等价状态与自环期望")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_k")[#text("K — Stones")]], [#text("胜负态递推")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_l")[#text("L — Deque")]], [#text("当前行动者净胜分")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_m")[#text("M — Candies")]], [#text("前缀和优化有限件数转移")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_n")[#text("N — Slimes")]], [#text("最后合并点的区间 DP")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_o")[#text("O — Matching")]], [#text("集合大小隐含阶段")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_q")[#text("Q — Flowers")]], [#text("偏序与前缀最优值")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_s")[#text("S — Digit Sum")]], [#text("tight 与余数状态")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_u")[#text("U — Grouping")]], [#text("无序集合分组")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_v")[#text("V — Subtree")]], [#text("换根、合成消息、不可随便模除")],
[#link("https://atcoder.jp/contests/dp/tasks/dp_z")[#text("Z — Frog 3")]], [#text("展开平方后维护直线")],
)

=== 常见误用

- #text("“有 max/min”不保证能二分；“次数单调”不保证 WQS 可恢复恰好 K。")
- #text("“独立子游戏”才异或 SG；反常终止、共享资源、玩家规则不同须另建模型。")
- #text("阶梯 Nim 的层号应从不参与游戏的吸收层往上数；允许跳多层时不要套相邻下移结论。")
- #text("直径端点代表最远点需要非负权；按边贡献统计距离和不需要这一条件。")
- #text("子树连续区间是首次进入 DFS 序；LCA 的欧拉序可能包含重复节点。")
- #text("DFS 序相邻关键点成环的距离和是最小连通子树边权和的 两倍。")
- #text("bitset 背包只维护可达；二进制拆物品的最优值等价不自动保证计数等价。")
- #text("能做区间合并只需要结合律，但重叠 Sparse Table 查询还需幂等性；矩阵乘法不能用重叠区间算两遍。")
- #text("正数窗口单调性不能直接移植到含负数数组；XOR 的不同区间结果也不像 AND/OR 那样只有 O(W) 个。")
- #text("同值时更新顺序可能改变严格偏序、最优方案数和端点是否相交。")
- #text("启发式搬迁、懒删除、区间跳过的复杂度要按全程总工作量算，不能只报“单次看起来很快”。")
