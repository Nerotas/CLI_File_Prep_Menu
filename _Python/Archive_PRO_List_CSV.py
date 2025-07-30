from __future__ import print_function
import os,sys

INPUT = "/stornext/Archive/"


def print_list(pth):
    cats = []
    subcats = []
    for (dirpath, dirnames, filenames) in os.walk(pth):
        #print dirpath+"\n\t", "\n\t".join(dirnames), "\n%d files"%(len(filenames))
        if dirpath == pth:
            cats = dirnames
            for i in cats:
            	full_name = "/stornext/Archive/" + i
            	os.system("ls -R %s > /${DataSource}/5_QC/_TechsFolders/NJE/%s_ProResList.csv" % (full_name,i))
        else:
            subcats.extend(dirnames)
            dirnames[:]=[] # don't walk any further downwards
print_list(INPUT)