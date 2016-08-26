
## 緣起

根據這篇「[回覆: 討論這篇「如何讓gcin開機後不多次執行](https://www.ubuntu-tw.org/modules/newbb/viewtopic.php?post_id=354222#forumpost354222)」討論，

寫了兩個簡易的「shell script」，模擬該執行模型，可以幫助了解意會相關的機制。


## 測試步驟

### 啟動「session.sh」

執行

```
$ ./session.sh
```

### 觀察「process session.sh」

執行

```
ps aux | grep session.sh
```

顯示

```
user       1948  0.1  0.2  13136  2836 pts/1    S+   19:22   0:00 bash ./session.sh
user       2112  0.0  0.0  14824   896 pts/19   S+   19:23   0:00 grep --color=auto session.sh
```

執行

``` sh
$ strings /proc/1948/environ | grep XMO
```

顯示

```
XMODIFIERS=@im=gcin
```

### 觀察「process launcher.sh」

執行

``` sh
$ ps aux | grep launcher.sh
```

顯示

```
user       1949  0.0  0.2  13140  2960 pts/1    S+   19:22   0:00 bash ./launcher.sh
user       2269  0.0  0.0  14824  1016 pts/19   S+   19:24   0:00 grep --color=auto launcher.sh
```

執行

``` sh
$ strings /proc/1949/environ | grep XMO
```

顯示

```
XMODIFIERS=@im=ibus
```

### 模擬launcher執行程式

傳送「siginal」，模擬launcher執行程式

執行

```
$ kill -1 1949
```

### 觀察「process gcin」

執行

```
$ ps aux | grep gcin
```

顯示

```
user       1151  0.0  2.7 736560 28072 ?        Sl   19:00   0:01 /usr/bin/gcin
user       2439  0.2  1.9 464744 19784 ?        Ss   19:25   0:00 gcin
user       2566  0.0  0.0  14824   940 pts/19   S+   19:25   0:00 grep --color=auto gcin
```

執行

``` sh
$ strings /proc/2439/environ | grep XMO
```

顯示

```
XMODIFIERS=@im=ibus
```

### 觀察「process gedit」

執行

``` sh
$ ps aux | grep gedit
```

```
user       2406  0.7  4.0 687860 41116 pts/1    Sl+  19:25   0:01 gedit
user       2943  0.0  0.0  14824   936 pts/19   S+   19:27   0:00 grep --color=auto gedit
```

執行

``` sh
$ strings /proc/2406/environ | grep XMO
```

顯示

```
XMODIFIERS=@im=ibus
```
