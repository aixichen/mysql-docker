#!/bin/sh
#创建文件
mkdir -p /tmp/mysql_back
mkdir -p /tmp/mysql_back/files
mkdir -p /tmp/mysql_back/archives

(
cat <<EOF
{
   "src_dir"            :   "/tmp/mysql_back/archives",
   "access_key"         :   "uaFtHqXKnfRzxwgDlrzfSB8gfGxXnOZkvqZNOPbq",
   "secret_key"         :   "KFn9Wk6V7nkdIEjju8BxsDswCyEN7CkLrRxtGylu",
   "bucket"             :   "home-cluby-cn",
   "zone"               :   "nb",
   "rescan_local"       :   true,
   "skip_path_prefixes" :   ".qshell"
}
EOF
) >/tmp/mysql_back/mysqlbackup2qiniu.txt
#复制文件
cp -r /var/mysql /tmp/mysql_back/files/mysql
#打包文件夹
cd /tmp/mysql_back
tar zcvf archives/mysql-backup-`date +%Y-%m-%d-%H-%M-%S`.tar.gz files/ 
#上传至七牛云
qshell qupload 10 /tmp/mysql_back/mysqlbackup2qiniu.txt
#删除文件
rm -rf /tmp/mysql_back
