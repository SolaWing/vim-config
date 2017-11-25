finish

function! ale_linters#swift#parser#GetCommand(buffer) abort
PY << EOF
import vim
def ale_swift_parser_get_command(buf):
    if not buf.name: return ""

    import os, subprocess, re
    def isProjectRoot(directory):
        return os.path.exists(os.path.join(directory, '.git'))

    def pchFileInDir(directory):
        for f in os.listdir(directory):
            if f.endswith('.pch'): return os.path.join(directory, f)

        return None

    def findProjectRootAndPchFile(filename):
        """ return project root or None. if not found"""
        filename = os.path.abspath(filename)
        directory = os.path.dirname(filename)
        pchFile = None
        while directory and directory != '/':
            # try to find a pchFile in parent directory
            if pchFile is None: pchFile = pchFileInDir(directory)
            if isProjectRoot(directory): break
            else: directory = os.path.dirname(directory)
        else:
            return (None, None)

        return (directory, pchFile)

    def additionalFlags(root):
        flagsPath = os.path.join(root, '.flags')
        if os.path.isfile(flagsPath):
            with open(flagsPath) as f:
                return list(filter( bool, (line.strip() for line in f) ))
        return []

    def additionalSwiftFlags(root):
        flagsPath = os.path.join(root, '.swiftflags')
        if os.path.isfile(flagsPath):
            with open(flagsPath) as f:
                return list(filter( bool, (line.strip() for line in f) ))
        return []

    #  headerDirsCacheDict = dict()
    def findAllHeaderDirectory(rootDirectory):
        #  headerDirs = headerDirsCacheDict.get(rootDirectory)
        #  if headerDirs:
            #  return headerDirs

        output = subprocess.check_output(['find', '-H', rootDirectory, '-name', '*.h'],
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
                h = os.path.dirname(h)
                headerDirs.add(h)

        #  headerDirsCacheDict[rootDirectory] = (headerDirs, frameworks)
        return headerDirs, frameworks

    def findAllSwiftFiles(rootDirectory):
        output = subprocess.check_output(['find', '-H', rootDirectory, '-name', '*.swift'],
                                         universal_newlines=True)
        return output.splitlines()

    def escapeSpace( s ):
        return s
        #  return s.replace(' ', r'\ ')

    def FlagsForSwift(filename, **kwargs):
        final_flags = []
        project_root, pchFile = findProjectRootAndPchFile(filename)
        if project_root:
            headers, frameworks = findAllHeaderDirectory(project_root)
            for h in headers:
                final_flags += ['-Xcc', '-I' + escapeSpace(h)]
            for f in frameworks:
                final_flags.append( '-F'+escapeSpace(f) )
            swiftfiles = findAllSwiftFiles(project_root)
            swiftfiles.remove(os.path.abspath(filename))
            final_flags += swiftfiles
            final_flags += additionalSwiftFlags(project_root)

        return final_flags
    flags = FlagsForSwift(buf.name)
    if not flags: return ""

    def quote(arg):
        return '$"{}"'.format( arg.replace("\\", r'\\') )

    return 'swift -frontend -parse -Xfrontend -debug-time-function-bodies - {}'.format(" ".join(map(quote, flags)))

v = ale_swift_parser_get_command(vim.buffers[int(vim.eval("a:buffer"))])
EOF
let g:v = PYEVAL("v")
return g:v
endfunction

call ale#linter#Define('swift', {
\   'name':             'parser',
\   'output_stream':    'stderr',
\   'executable':       'swiftc',
\   'command_callback': 'ale_linters#swift#parser#GetCommand',
\   'callback':         'ale#handlers#HandleGCCFormat',
\   'read_buffer':      1,
\})
