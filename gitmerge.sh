# 开始
echo "\033[1;42m============================== 开始合并 ==============================\033[0m"

# 当前分支
cb=$(git branch | sed -n '/\* /s///p')
# 目标分支(cb 将被合并到 tb 分支)
tb="dev"
# 错误码
code=1
# 是否开启log (1：开启，0：不开启)
isLog=1
# 描述
msg="$1"
if [[ -z $msg ]];then
  msg="$(date '+%Y-%m-%d %H:%M:%S') 提交优化"
fi
# Git
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git add . \033[0m"
fi
git add .
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git commit -m "$msg" \033[0m"
fi
git commit -m "$msg"
# 拉取当前分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git pull origin "$cb" \033[0m"
fi
git pull origin "$cb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== 拉取远程分支 $cb 错误 \033[0m"
  exit $code
fi
# 提交当前分支
if [ $isLog -eq 1 ];then
  echo "\033[1;32m------------------------------ git push origin "$cb" \033[0m"
fi
git push origin "$cb"
# 检查是否成功
if [ $? -ne 0 ];then
  echo "\033[1;41m============================== 提交远程分支 $cb 错误 \033[0m"
  exit $code
fi
# 当前分支 != 目标分支
if [[ $cb != $tb ]];then
  # 切换到目标分支
  if [ $isLog -eq 1 ];then
    echo "\033[1;32m------------------------------ git checkout "$tb" \033[0m"
  fi
  git checkout "$tb"
  # 检查是否成功
  if [ $? -ne 0 ];then
    echo "\033[1;41m============================== 切换到分支 $tb 错误 \033[0m"
    exit $code
  fi
  # 拉取目标分支
  if [ $isLog -eq 1 ];then
    echo "\033[1;32m------------------------------ git pull origin "$tb" \033[0m"
  fi
  git pull origin "$tb"
  # 检查是否成功
  if [ $? -ne 0 ];then
    echo "\033[1;41m============================== 拉取远程分支 $tb 错误 \033[0m"
    exit $code
  fi
  # 提交当前分支
  if [ $isLog -eq 1 ];then
    echo "\033[1;32m------------------------------ git push origin "$tb" \033[0m"
  fi
  git push origin "$tb"
  # 检查是否成功
  if [ $? -ne 0 ];then
    echo "\033[1;41m============================== 提交远程分支 $tb 错误 \033[0m"
    exit $code
  fi
  # 切回当前分支
  if [ $isLog -eq 1 ];then
    echo "\033[1;32m------------------------------ git checkout "$cb" \033[0m"
  fi
  git checkout "$cb"
fi

# 结束
echo "\033[1;42m============================== 合并成功 ==============================\033[0m"