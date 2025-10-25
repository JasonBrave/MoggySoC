#!/usr/bin/python3

import sys
import pathlib
import argparse

def main():
    parser = argparse.ArgumentParser(
        prog='vivado_filelist.py',
        description='Collect Verilog file list from .f file lists',
        epilog='bruh')
    parser.add_argument('-F', '--flist-rel-filelist', type=str, action='append', help='File list file contains list of Verilog to be parsed, any path is relative to the file list file')
    parser.add_argument('-f', '--flist-rel-pwd', type=str, action='append', help='File list file contains list of Verilog to be parsed, any path is relative to current working directory')

    args = parser.parse_args()

    sv_files = list()
    sv_incdirs = list()
    
    for flist_path in args.flist_rel_filelist:
        flist_file = open(flist_path, 'r')
        path_of_flist = pathlib.Path(flist_path)
        for item in flist_file:
            if item.strip():
                if(item.startswith('+incdir+')):
                    sv_incdirs.append(str(path_of_flist.parent) + '/' + item.removeprefix('+incdir+'))
                else:
                    sv_files.append(str(path_of_flist.parent) + '/' + item)

    print('xvlog -d SYNTHESIS  --work work=sim/xsim.dir/work --sv', end=''); # Workaround for Ibex core
    for svincdir in sv_incdirs:
        print(' -i ' + svincdir.removesuffix('\n'), end='')
    print(' ', end='')

    for svfile in sv_files:
        print(' ' + svfile.removesuffix('\n'), end='')
    print('\n')

if __name__ == '__main__':
    main()
