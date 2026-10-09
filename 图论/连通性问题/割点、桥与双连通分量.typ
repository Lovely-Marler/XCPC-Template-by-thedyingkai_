无向图割点、桥、点双与边双，Tarjan 主体 $O(n+m)$。四份 DFS 使用显式栈。

- `CutEdge` 枚举桥；`EDCC` 的 `dcc[u]` 是唯一边双编号。`add` 每条无向边只调用一次；`EDCC(n,m)` 的 `m` 为实际无向边数。
- `CutDot` 输出 `cut[u]` 与点双点集 `bcc`；`VDCC` 点集在 `dcc`。输入对称邻接表，构造时分配边号，再对每个未访问点 `tarjan(start)`。

平行边保留；自环不贡献割点、桥或通常点双；孤立点单独成点双。桥条件为 `low[v]>dfn[u]`；点双在 `low[v]>=dfn[u]` 时从边栈弹至 `u-v`，取这些边的端点。

*后续建图*　缩每个边双，以桥连接得到桥森林，路径距离等于必经桥数。每个点双新建方点，与其中原点相连得到圆方森林，可处理必经割点。

原图连通且桥树至少两点时，补成边双最少加 `(leaf+1)/2` 条边；已无桥时为 0。删除非根点后，其原连通块变为 `1+满足 low[v]>=dfn[u] 的儿子数` 个块；删除根则为 DFS 儿子数。其他原连通块另计。

题目：#link("https://judge.yosupo.jp/problem/biconnected_components")[点双]、#link("https://judge.yosupo.jp/problem/two_edge_connected_components")[边双]。
