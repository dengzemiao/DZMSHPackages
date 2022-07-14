# 开始
echo "\033[1;42m============================== 开始倒换 ==============================\033[0m"

# 当前分支
cb=$(git branch | sed -n '/\* /s///p')
# 新开分支
nb="$cb-new"
# 是否开启log (1：开启，0：不开启)
isLog=1
# 错误码
code=1
# 切换到新开分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git checkout -b "$nb" \033[0m"
fi
git checkout -b "$nb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== 新开分支 $nb 错误 ==============================\033[0m"
  exit $code
fi
# 移除当前分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git branch -D "$cb" \033[0m"
fi
git branch -D "$cb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== 删除分支 $cb 错误 ==============================\033[0m"
  exit $code
fi
# 重新拉取当前远程分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git checkout origin/"$cb" -b "$cb" \033[0m"
fi
git checkout origin/"$cb" -b "$cb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== 拉取分支 $cb 错误 ==============================\033[0m"
  exit $code
fi
# 将新开分支合并到当前分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git merge "$nb" \033[0m"
fi
git merge "$nb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== $cb 合并分支 $nb 错误 ==============================\033[0m"
  exit $code
fi
# 移除新开分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git branch -D "$nb" \033[0m"
fi
git branch -D "$nb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== 删除分支 $nb 错误 ==============================\033[0m"
  exit $code
fi

# 结束
echo "\033[1;42m============================== 倒换成功（使用 $ sh gitpush.sh 提交代码） ==============================\033[0m"
