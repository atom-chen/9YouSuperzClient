set pub_path=../../../publish/client/superz/

rd /S /Q "%pub_path%res"
rd /S /Q "%pub_path%src"

md "%pub_path%res"
md "%pub_path%src"
md "%pub_path%src/app"

xcopy "./res" "%pub_path%res" /e
copy "src\app\DefineConfig.lua" "%pub_path%\src\app"
cocos luacompile -s src -d "%pub_path%src"  -e -k 30042d8d1190098e -b klqp --disable-compile

pause
