#一键部署hexo
public_path="/public"

#清理静态文件
echo "清理静态文件"
hexo clean

#生成静态文件
echo "生成静态文件"
hexo g

#推送百度搜索
echo "推送百度搜索"
hexo d

#部署到cloudbase
cd public
echo "部署到cloudbase"
tcb hosting deploy . -e vuepress-7g6mefe5ad729c51 -r gz

echo 按任意键继续
read -n 1
echo 继续运行