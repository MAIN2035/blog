# Shell入门

## 变量

* 变量分为用户变量与系统变量
* 为变量赋值时“=”号两边不能有空格
* 可在``中写入命令，并将其交给变量引用，也可采用：       变量=$(命令 )     达到相同的效果

```shell
#!/bin/bash  
#头文件，表明此脚本使用bash shell编写
echo "hello,world!" #打印字符串
echo "PATH=$PATH" #$表示变量引用，此处引用的是系统变量
echo "user=$USER"
A=100
echo "A=$A" #打印用户定义的变量
unset#扰乱，就是删除前一个变量的值
echo "A=$A"

RESULT=`ls -l /home`#这个变量引用一个命令ls -l /home
echo $RESULT #打印这个变量（命令运行的结果）
echo ""
MY_DATE=$(date)#这个变量引用一个命令date
echo "data=$MY_DATE"
```

### 环境变量（全局变量）

* 在/etc/profile 文件中定义环境变量`TOMCAT_HOME=/opt/tomcat
  export TOMCAT_HOME`export将 shell 变量输出为环境变量
* 定义环境变量后使用`source /etc/profile`让其生效

```shell
#!/bin/bash
:<<!
注释代码块使用:<<!将要被注释的代码块!
echo "hello,world!"
echo "PATH=$PATH"
echo "user=$USER"
a=100
echo "a=$a"
unset
echo "a=$a"

RESULT=`ls -l /home`
echo $RESULT
echo ""
MY_DATE=$(date)
echo "data=$MY_DATE"
!
echo $TOMCAT_HOME
readonly B=10#静态变量无视unset
unset
echo $B       
```

运行结果：<img src="https://i.loli.net/2020/07/28/ZEUp9VBFqQoKJGW.png" alt="image-20200728224210596"  />



### 预定义变量

```shell
#!/bin/bash

echo $$#当前进程的进程号(PID)
./a.sh & #执行此脚本，后台运行
echo $! #后台运行的进程号
echo $? #上一次执行命令返回的状态（0为正常，否则上一个命令没有正确执行）
~        
```

### 位置参数变量

```shell
#!/bin/bash

echo "$0 $1 $2" #分别对应第 0 1 2个位置参数 ，0对应命令本身，如下图 参数1对应4、参数2对应5 
echo $* #所有位置参数（不包括位置0），将其作为整体对待
echo $@  #所有位置参数（不包括位置0），将其分别对待
echo $#    #所有位置参数个数（不包括位置0）
```

运行结果：![](https://i.loli.net/2020/07/30/QHgrA1v4Y5lCZjT.png)





## 运算符

* 3种书写形式：
  1. `$((运算式))`
  2. `$[运算式]`
  3. `expr m + n` `expr m - n`   注意 expr 运算符间要有空格
       乘,除,取余：`expr \*, /, %`

```shell
#!/bin/bash
#注意运算符前后的空格，必须有哦
A=$((4 + 8))
B=$[4 * 8]
C=`expr 4 \* 8`
echo "$A"
echo "$B"
echo "$C"

```



## 条件判断

* 常用判断条件
  1. 两个整数的比较
     = 字符串比较
     -lt 小于
     -le 小于等于
     -eq 等于
     -gt 大于
     -ge 大于等于-ne 不等于
  2.  按照文件权限进行判断
     -r 有读的权限 [ -r 文件 ]
     -w 有写的权限
     -x 有执行的权限
  3. 按照文件类型进行判断
     -f 文件存在并且是一个常规的文件
     -e 文件存在
     -d 文件存在并是一个目录

```shell
#!/bin/bash
#比较字符串
if [ "b" = "b" ]
then
        echo "Yes"
fi
#比较数值
if [ 4 -eq 4 ]
then
        echo "Yes"
fi
#判断文件
if [ -d /home ]
then#满足条件执行：
        echo "Yes"       
fi #if反过来结尾
```



## 流程控制

* if elif 

```shell
#!/bin/bash

if [ $0 = "./a.sh" ]#注意[ 之间的 ]空格
then
        echo "Yes"
elif [ $1 -eq 4 ]
then
        echo "Yes"
elif [ $2 = "b" ]
then
        echo "Yes"
fi
              
```

运行结果：

![](https://i.loli.net/2020/07/30/PoYBhMnImCUqXJc.png)

* case

```shell
#!/bin/bash
case $1 in
"1")
echo "Yes";;
"2")#位置参数1的值为2时执行
echo "No";;
*)#以上所有条件都不满足则执行
echo "All";;
esac#case反写作结尾                                                                                    
```

运行结果：![](https://i.loli.net/2020/07/30/6OljZLWC3aex4tc.png)

* for

  1. for in

     ```shell
     #!/bin/bash
     
     for i in "$@"
     do
     echo "对单个进行处理=$i"
     done
     echo ""
     for i in "$*"
     do
     echo "作为整体对待=$i"
     done#表示循环结束
     ~           
     ```

     运行结果：![](https://i.loli.net/2020/07/30/zZ9bsm1BAxUaDpg.png)

     

  2. for常规

     ```shell
     #!/bin/bash
     
     SUM=0#赋值运算符前后不能有空格
     for((i=1;i<=10000;i++))#for循环（（））中运算符的空格可有可无
     do
     SUM=$[$SUM+$i]#像这样两个变量与运算符直接有无空格均可
     done
     echo "sum=$SUM"
     ```

     运行结果：![](https://i.loli.net/2020/07/30/V9IDSofWYpbBCx4.png)

* while

```shell
#!/bin/bash

SUM=0
i=0
while [ $i -lt $1 ]#[]内外两边均有空格，需要注意。
do
SUM=$[$SUM+$i]
i=$[$i+1]
done
echo "sum=$SUM"                      
```

运行结果：![](https://i.loli.net/2020/07/30/2aT39NuVMWvfQsw.png)

## 从控制台读入

```shell
#!/bin/bash
read -p "你是一个哈皮（Yes/No）?" WHY#-p即附带提示，WHY保存输入值
echo "$WHY"

read -t 10 -p "你是一个哈皮（Yes/No）?" WHY#-t计时，超过定义的10s即停止输入
echo "$WHY"
```

运行结果：![](https://i.loli.net/2020/07/30/aBqlR1KXzOfinP2.png)

## 函数

* 系统函数

  1. basename [string] [suffix]
     删掉所有的前缀包括最后一个(‘/’)字符,然后将余下的字符串显示出来。
     指定了suffix,basename命令会将指定的后缀也去掉

  2. dirname 
     返回完整路径最后 / 的前面的部分

     

运行结果：![](https://i.loli.net/2020/07/30/dieGZhJHgxpIqoW.png)

* 自定义函数

```
#!/bin/bash
function getSum(){#不用写参数
SUM=$[$2 + $1]
echo "sum=$SUM"
}
getSum $1 $2#方法名后面是传入的参数
~                  
```

运行结果：![](https://i.loli.net/2020/07/30/i6Vl2WEH9ro31qS.png)

## GitHub自动提交远程库实例

shell的内容：

```shell
#!/bin/bash

GITPATH=/home/garfield/文档
ADD=$(git add .)
COMMIT=$(git commit -m "$(date) ")
GITPUSH=$(git push blog master)
cd $GITPATH
$ADD
$COMMIT
$GITPUSH
#!/bin/bash

GITPATH=/home/garfield/文档 #本地仓库路径
ADD=$(git add .) #添加所有文件到暂存区
DATE=$(date +%y%m%d)
GITPUSH=$(git push blog master)#推送到远程库
GITPULL=$(git pull blog master)#同步远程库到本地（防止冲突）
cd $GITPATH
$ADD
git commit -m "$DATE"#提交到版本库并备注时间
$GITPULL
$GITPUSH
~         
~                
```

运行结果![](https://i.loli.net/2020/07/30/v6ble3USd8YIgpk.png)

定时任务内容：

```
*20*** /home/garfield/文档/git_push.sh
```

![](https://i.loli.net/2020/07/30/4okIgw3ZSYuJ7s8.png) 

