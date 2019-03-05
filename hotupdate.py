import os
import hashlib
import time
import shutil
import subprocess
import sys


def getFileMd5(filename):
    if not os.path.isfile(filename):
        return
    myhash = hashlib.md5()
    f = file(filename, 'rb')
    while True:
        b = f.read(8096)
        if not b:
            break
        myhash.update(b)
    f.close()
    return myhash.hexdigest()


def walk(path):
    xml = ""
    for parent, dirnames, filenames in os.walk(path):
        for filename in filenames:
            pathfile = os.path.join(parent, filename)
            md5 = getFileMd5(pathfile)
            name = pathfile[len(path) + 1:]
            name = name.replace('\\', '/')
            if xml == "":
                xml = "\n\t\t\"%s\" : {\n\t\t\t\"md5\" : \"%s\"\n\t\t}" % (name, md5)
            else:
                xml += ",\n\t\t\"%s\" : {\n\t\t\t\"md5\" : \"%s\"\n\t\t}" % (name, md5)
    return xml


def check():
    f = open("src/app/UtilityTools.lua")
    for line in f:
        if line.find("localVersion") >= 0:
            if line.find("true") >= 0:
                print "fail1:", line
                return False
    f.close()

    f = open("src/app/DefineConfig.lua")
    for line in f:
        if line.find("gt.LoginServer") >= 0 and line.find("--") == -1:
            if line.find("login") == -1 or line.find("xmsgl2017.com") == -1:
                print "fail2:", line
                return False
    f.close()
    return True


def get_svn_revision():
    p = subprocess.Popen('svn info', shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    rev = ""
    for line in p.stdout.readlines():
        if line.find("Last Changed Rev") >= 0:
            rev = line[18:]
    p.wait()
    revision = rev.strip("\r\n")
    print("revision=" + revision)

    return revision


def main():
    url = "http://apps.xmsgl2017.com/szn/hotupdate"
    version = "1.2.8.8"
    app_ver_and = "1.0.7"
    app_ver_ios = "1.0.9"
    app_url_and = "http://pdkzks.xmsgl2017.com/?app=szn&start_type=0"
    app_url_ios = "http://pdkzks.xmsgl2017.com/?app=szn&start_type=0"
    review_ver = "1.0.6"
    revision = get_svn_revision()
    root_path = os.getcwd()
    hot_path = os.path.join(root_path, 'hotupdate')
    hot_res_path = os.path.join(hot_path, 'ver' + version)

    if not check():
        print "check config fail"
        return

    if os.path.exists(hot_path):
        shutil.rmtree(hot_path)
    os.mkdir(hot_path)
    shutil.copytree(os.path.join(root_path, 'res'), os.path.join(hot_res_path, 'res'))

    if sys.platform == 'win32':
        png_path = os.path.join(root_path, './compressPng')
        cmdPng = "CompressPNG.exe -path ../hotupdate/ver" + version + "/res -exclude ExcludeCompressPNG.txt"
        #cmdPng = "CompressPNG.exe -path ./res -exclude ExcludeCompressPNG.txt"
        subprocess.check_call(cmdPng, shell=True, cwd=png_path)

    cmd = "cocos luacompile -s src -d hotupdate/ver" + version + "/src  -e -k 30042d8d1190098e -b klqp --disable-compile"
    subprocess.check_call(cmd, shell=True, cwd=root_path)

    assets = walk(hot_res_path)
    xml = '{' \
          + '\n\t"packageUrl" : "' + url + '/ver' + version + '",' \
          + '\n\t"remoteVersionUrl" : "' + url + '/version.manifest",' \
          + '\n\t"remoteManifestUrl" : "' + url + '/project.manifest",' \
          + '\n\t"version" : "' + version + '",' \
          + '\n\t"engineVersion" : "Cocos2d-x v3.14.1",' \
          + '\n' \
          + '\n\t"assets" : {' \
          + assets \
          + '\n\t},' \
          + '\n\t"searchPaths" : [' \
          + '\n\t]' \
          + '\n}'

    f = file(os.path.join(hot_path, 'project.manifest'), 'w+')
    f.write(xml)
    f.close()
    print 'generate project.manifest finish.'

    xml = '{' \
          + '\n\t"packageUrl" : "' + url + '/ver' + version + '",' \
          + '\n\t"remoteVersionUrl" : "' + url + '/version.manifest",' \
          + '\n\t"remoteManifestUrl" : "' + url + '/project.manifest",' \
          + '\n\t"version" : "' + version + '",' \
          + '\n\t"appVerAnd" : "' + app_ver_and + '",' \
          + '\n\t"appVerIos" : "' + app_ver_ios + '",' \
          + '\n\t"appUrlAnd" : "' + app_url_and + '",' \
          + '\n\t"appUrlIos" : "' + app_url_ios + '",' \
          + '\n\t"reviewVer" : "' + review_ver + '",' \
          + '\n\t"revision" : "' + revision + '",' \
          + '\n\t"engineVersion" : "Cocos2d-x v3.14.1"' \
          + '\n}'
    f = file(os.path.join(hot_path, 'version.manifest'), 'w+')
    f.write(xml)
    f.close()
    print 'generate version.manifest finish.'

    pub_path = os.path.join(root_path, '../../../publish/hotupdate/superz')
    if os.path.exists(pub_path):
        shutil.rmtree(pub_path)
    shutil.copytree(hot_path, pub_path)

    pub_path_pack = os.path.join(root_path, '../../../publish/hotupdate/superz_' + version)
    if os.path.exists(pub_path_pack):
        shutil.rmtree(pub_path_pack)
    shutil.copytree(hot_path, pub_path_pack)


if __name__ == "__main__":
    main()
    os.system("pause")
