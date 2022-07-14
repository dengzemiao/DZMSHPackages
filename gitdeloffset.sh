# 是否有值
if [[ -n $1 ]];then
  # 偏移分支
  nb="$1-new-offset"
  # 错误码
  code=1
  # 是否开启log (1：开启，0：不开启)
  isLog=1
  # 分支列表
  bs=$(git branch)
  # 分支列表是否存在偏移分支
  if [[ "$bs" =~ "$nb" ]];then
    # 移除偏移分支
    if [ $isLog -eq 1 ];then
      echo "\033[1;32m------------------------------ git branch -D "$nb" \033[0m"
    fi
    git branch -D "$nb"
    if [ $? -ne 0 ];then
      echo "\033[1;41m============================== 删除偏移分支 $nb 错误 ==============================\033[0m"
      exit $code
    fi
  fi
fi
