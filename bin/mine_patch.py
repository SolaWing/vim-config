#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os.path, sys, asyncio
from asyncio.subprocess import PIPE, STDOUT, DEVNULL

patch_plugs = ['base16-vim', 'vim-submode']
bundle_dir  = os.path.expanduser("~/.vim/bundle")
base_url    = "https://github.com/SolaWing"


async def patch(plug):
    d = os.path.join(bundle_dir, plug)
    url = os.path.join(base_url, plug)

    if os.path.isdir(d):

        async def run_process(sh, cwd=d, stdin=DEVNULL, stdout=DEVNULL, stderr=DEVNULL, **d):
            print(f"{plug}:", sh)
            p = await asyncio.create_subprocess_shell(sh, cwd=cwd, stdin=stdin, stdout=stdout, stderr=stderr, **d)
            await p.wait()
            return p

        print(f"begin patch {plug} from {url}")

        await run_process(f"git remote add sw '{url}'")
        p = await run_process(f"git status --porcelain -uno", stdout=PIPE)
        stdout = await p.stdout.read()
        if stdout:
            print(f"{plug} status:\n{stdout.decode('utf8')}")
            while True:
                a = input("will reset to master [y/n]: ")
                if a == 'n': raise asyncio.futures.CancelledError
                if a == 'y': break
        await run_process(f"git checkout master -f && git reset --hard origin/master")


        p: asyncio.subprocess.Process = await run_process("git pull sw master", stdout=PIPE, stderr=STDOUT)
        stdout = (await p.stdout.read()).decode('utf8')
        print(f"end patch {plug}\n{ (stdout) }")


def main():
    loop = asyncio.get_event_loop()  # type: asyncio.AbstractEventLoop
    loop.run_until_complete(asyncio.wait([patch(p) for p in patch_plugs]))


if __name__ == "__main__":
    main()
