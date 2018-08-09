#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os, subprocess, re
import shutil
import tempfile
import shlex

def ale_swift_parser_get_command(path):
    if not path: return ""

    flags = FlagsForSwift(path).get("flags")
    if not flags: return ""


    def mayReplaceFileList(flags, path):
        """
        :param list flags:
        :param str path:
        """
        try: # replace filelist
            fileListIndex = flags.index("-filelist") + 1
            saveListPath      = _copyFileList(flags[fileListIndex], path) # type: list
            flags[fileListIndex] = saveListPath
        except ValueError:
            pass
        except Exception as e:
            import traceback
            traceback.print_exc()
    mayReplaceFileList(flags, path)

    return 'swift -frontend -c -primary-file - {}'.format(" ".join(map(shlex.quote, flags)))

copyed = set()
def _copyFileList(op, path):
    np = os.path.join( tempfile.gettempdir(), "ale_swift_files_{}".format(hash(path)) )
    if np in copyed: return np
    if os.path.exists(op):
        with open(op) as f:
            files = [ "-" if l == path else l
                     for l in f.read().splitlines() if l ]
            with open(np, "w") as w:
                w.write(os.linesep.join(files))
        copyed.add(np)
        return np
    else:
        echo(f"unexist filelist path: {op}")
        return op

def isProjectRoot(directory):
    return os.path.exists(os.path.join(directory, '.git'))

def additionalSwiftFlags(flagsPath):
    # flagsPath = os.path.join(root, '.swiftflags')
    if flagsPath and os.path.isfile(flagsPath):
        def valid(s):
            return s and not s.startswith('#')
        with open(flagsPath) as f:
            return list(filter( valid, (line.strip() for line in f) ))
    return []

headerDirsCacheDict = dict()
def findAllHeaderDirectory(rootDirectory):
    headerDirs = headerDirsCacheDict.get(rootDirectory)
    if headerDirs:
        return headerDirs

    output = subprocess.check_output(['find', '-L', rootDirectory, '-name', '*.h'],
                                     universal_newlines=True)
    headers = output.splitlines()
    headerDirs = set()
    frameworks = set()
    for h in headers:
        frameworkIndex = h.rfind('.framework')
        if frameworkIndex != -1:
            h = os.path.dirname(h[:frameworkIndex])
            frameworks.add(h)
        else:
            h = os.path.dirname(h)
            headerDirs.add(h)
            # contains more one dir for import with module name
            # don't contains more one module name dir. if need, can specify in .flags
            # conflict with #if_include framework check
            #  h = os.path.dirname(h)
            #  headerDirs.add(h)

    headerDirsCacheDict[rootDirectory] = (headerDirs, frameworks)
    return headerDirs, frameworks

def findAllSwiftFiles(rootDirectory):
    output = subprocess.check_output(['find', '-H', rootDirectory, '-name', '*.swift'],
                                     universal_newlines=True)
    return output.splitlines()


def readFileList(path):
    with open(path) as f:
        return f.read().splitlines()

fileListCache = {}
def filterSwiftArgs(items):
    """
    f: should return True to accept, return number to skip next number flags
    """
    it = iter(items)
    try:
      while True:
        arg = next(it)

        if arg in {"-primary-file"}:
            next(it)
            continue
        if arg in {"-frontend", "-c"}:
            continue
        yield arg
    except StopIteration as e:
        pass

def findSwiftModuleRoot(filename):
    """ return project root or None. if not found"""
    filename = os.path.abspath(filename)
    directory = os.path.dirname(filename)
    flagFile = None
    compileFile = None
    while directory and directory != '/':
        p = os.path.join(directory, ".swiftflags")
        if os.path.isfile(p):
            return (directory, p, compileFile) # prefer use swiftflags file as module root directory

        if compileFile is None:
            p = os.path.join(directory, ".compile")
            if os.path.isfile(p): compileFile = p

        if isProjectRoot(directory): break
        else: directory = os.path.dirname(directory)
    else:
        return (None, flagFile, compileFile)

    return (directory, flagFile, compileFile)

compileFileCache = {}
def CommandForSwiftInCompile(filename, compileFile):
    info = compileFileCache.get(compileFile)
    if info is None:
        info = {}
        compileFileCache[compileFile] = info # cache first to avoid re enter when error

        import json
        with open(compileFile) as f:
            m = json.load(f) # type: list
            info.update( (i["file"],i["command"]) # now not use other argument, like cd
                        for i in m
                        if "file" in i and "command" in i )
    return info.get(filename, "")

def FlagsForSwift(filename, **kwargs):
    filename = os.path.abspath(filename)
    final_flags = []
    project_root, flagFile, compileFile = findSwiftModuleRoot(filename)
    if compileFile:
        command = CommandForSwiftInCompile(filename, compileFile)
        if command:
            flags = shlex.split(command)[1:] # ignore executable
            final_flags = list(filterSwiftArgs(flags))

    if not final_flags and flagFile:
        headers, frameworks = findAllHeaderDirectory(project_root)
        for h in headers:
            final_flags += ['-Xcc', '-I' + h]
        for f in frameworks:
            final_flags.append( '-F' + f )
        swiftfiles = findAllSwiftFiles(project_root)
        final_flags += swiftfiles
        a = additionalSwiftFlags(flagFile)
        if a:
            a = list(filterSwiftArgs(a))
            final_flags += a
        else:
            final_flags += [
                '-sdk', '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/',
                '-target', 'x86_64-apple-ios8.0',
            ]
    if not final_flags:
        final_flags = [
            '-sdk', '/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk/',
            '-target', 'x86_64-apple-ios8.0',
        ]

    return {
        'flags': final_flags,
        'do_cache': True
    }

