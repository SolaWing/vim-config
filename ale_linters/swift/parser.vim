py3 << EOF
aleCompileFileCache = {}
def ale_swift_parser_get_command(buf):
    if not buf.name: return ""

    import os, subprocess, re
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

    # headerDirsCacheDict = dict()
    def findAllHeaderDirectory(rootDirectory):
        # headerDirs = headerDirsCacheDict.get(rootDirectory)
        # if headerDirs:
        #     return headerDirs

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

        # headerDirsCacheDict[rootDirectory] = (headerDirs, frameworks)
        return headerDirs, frameworks

    def findAllSwiftFiles(rootDirectory):
        output = subprocess.check_output(['find', '-H', rootDirectory, '-name', '*.swift'],
                                         universal_newlines=True)
        return output.splitlines()

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

    def CommandForSwiftInCompile(filename, compileFile):
        info = aleCompileFileCache.get(compileFile)
        if info is None:
            info = {}
            aleCompileFileCache[compileFile] = info # cache first to avoid re enter when error

            import json
            with open(compileFile) as f:
                m = json.load(f) # type: list
                info.update( (i["file"],i["command"]) # now not use other argument, like cd
                            for i in m
                            if "file" in i and "command" in i )
        return info.get(filename, "")

    def filterArgs(f, items):
        """
        f: should return True to accept, return number to skip next number flags
        """
        it = iter(items)
        try:
          while True:
            i = next(it)
            r = f(i)
            if r is True:
                yield i; continue
            if r > 0: # skip number arg, normal will be 1
                [next(it) for _ in range(r)]
        except StopIteration as e:
            pass

    def validFlags(flag):
        if flag in {"-primary-file"}: return 1
        if flag in {"-frontend", "-c"}: return 0
        return True

    def FlagsForSwift(filename, **kwargs):
        filename = os.path.abspath(filename)
        final_flags = []
        project_root, flagFile, compileFile = findSwiftModuleRoot(filename)
        if compileFile:
            command = CommandForSwiftInCompile(filename, compileFile)
            if command:
                import re
                splitBySpaces = re.compile(r"(?:\\ |\S)+")
                flags = splitBySpaces.findall(command)[1:] # ignore executable
                final_flags = list(filterArgs(validFlags, flags))
        if not final_flags and project_root:
            headers, frameworks = findAllHeaderDirectory(project_root)
            for h in headers:
                final_flags += ['-Xcc', '-I' + h]
            for f in frameworks:
                final_flags.append( '-F' + f )
            swiftfiles = findAllSwiftFiles(project_root)
            swiftfiles.remove(filename)
            final_flags += swiftfiles
            a = additionalSwiftFlags(flagFile)
            if a:
                a = list(filterArgs(validFlags, a))
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

    flags = FlagsForSwift(buf.name).get("flags")
    if not flags: return ""

    def quote(arg):
        return '$"{}"'.format( arg.replace("\\", r'\\') )

    return 'swift -frontend -c -primary-file - {}'.format(" ".join(map(quote, flags)))
EOF
function! ale_linters#swift#parser#GetCommand(buffer) abort

py3 << EOF
import vim
v = ale_swift_parser_get_command(vim.buffers[int(vim.eval("a:buffer"))])
EOF

" echom "lint with swift parser"
let g:v = PYEVAL("v")
return g:v

endfunction

call ale#linter#Define('swift', {
\   'name':             'parser',
\   'output_stream':    'stderr',
\   'executable':       'swift',
\   'command_callback': 'ale_linters#swift#parser#GetCommand',
\   'callback':         'ale_linters#swift#swiftpm#Handle',
\   'read_buffer':      1,
\})
