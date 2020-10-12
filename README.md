# rime-table-decompiler

反编译 Rime 的 ``xxx.table.bin`` 二进制词典文件。

## 简介

本项目 Fork 自 [whjiang/rime_table_bin_decompiler]。

相对于原项目，本项目有以下的更改。

+ 修复了在 Linux 系统上的编译错误
+ 更易读的 README
+ 从 Docker 启动

本项目用于简单的反编译 Rime 的 ``xxx.table.bin`` 二进制词典文件，以生成 ``xxx.dict.yaml`` 源纯文本词典文件。

需要注意的是，由于 ``xxx.table.bin`` 二进制词库文件没有元数据信息，所以生成的 ``xxx.dict.yaml`` 源纯文本词典文件的文件头中的元数据信息是根据常见的元数据信息填补进去的，所以可能是错误的，需自行修正。

[whjiang/rime_table_bin_decompiler]: https://github.com/whjiang/rime_table_bin_decompiler

## 从 Docker 运行

### 构建镜像
```Bash
docker build . -t rime_table_decompiler
```

### 运行

反编译二进制词库并标准输出。

```Bash
docker run --rm -v /path/to/xxx.table.bin:/data/xxx.table.bin rime_table_decompiler /data/xxx.table.bin
```

反编译二进制词库并输出到纯文本词库文件中。

```Bash
docker run --rm -v /path/to/xxx.table.bin:/data/xxx.table.bin rime_table_decompiler /data/xxx.table.bin > xxx.dict.yaml
```

**注意将需要反编译的码表 `xxx.table.bin` 挂载进容器。**

## 从源代码编译

### 工具链

+ GNU toolchain
+ Boost
+ CMake

### 步骤

1. ``cd rime-table-decompiler/src``
2. ``mkdir build && cd build``
3. ``cmake ..``
4. ``make``

### 运行

反编译二进制词库并标准输出。

```Bash
./rime-table-decompiler xxx.table.bin
```

反编译二进制词库并输出到纯文本词库文件中。

```Bash
./rime-table-decompiler xxx.table.bin > xxx.dict.yaml
```
