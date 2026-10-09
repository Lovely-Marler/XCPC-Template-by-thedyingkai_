将有向图互相可达的点缩为 SCC，结果为 DAG。`work()` 后读取 `scc[u]`、分量数 `cnt`、大小 `sz[id]`。显式 DFS 栈，主过程时间、空间 $O(n+m)$。

当前编号按逆拓扑序产生，缩点边从大编号指向小编号。`shrink()` 排序去重出边，最坏 $O(n+m log m)$；若重边表示不同方案，须按题意保留重数。

*low 更新*　DFS 树边返回时用子节点 `low`；遇已访问边，仅当目标仍在 Tarjan 栈中才用其 `dfn`。`low[u]==dfn[u]` 时弹栈至 `u`，得到一个 SCC。

缩点 DP 先按 `scc[u]` 合并点权，再按拓扑依赖处理。补成强连通图：已有一个 SCC 时为 0，否则为 `max(零入度分量数,零出度分量数)`。

题目：#link("https://judge.yosupo.jp/problem/scc")[Strongly Connected Components]。
