#!/usr/bin/env osascript -l JavaScript

function run(argv) {
    ObjC.import('stdlib');

    var evt = Application("System Events");
    var oldApp = evt.processes.whose({"frontmost": true })[0].name();
    var iterm = Application("iTerm");
    // select will change order, and object specifier is lazy...
    var session, win, oldWin = iterm.currentWindow();

    selSession:
    do {
        for (var win_idx = 0, win_len = iterm.windows.length; win_idx < win_len; ++win_idx) {
            win = iterm.windows[win_idx]();
            for (var tab_idx = 0, tab_len = win.tabs.length; tab_idx < tab_len; tab_idx++) {
                var tab = win.tabs[tab_idx]();
                for (var session_idx = 0, session_len = tab.sessions.length; session_idx < session_len; session_idx++) {
                    session = tab.sessions[session_idx]();
                    // console.log("iter session:", session, session.profileName())
                    if (session.profileName() == "FZF") {
                        win.select();
                        tab.select();
                        session.select();
                        // console.log("reuse");
                        break selSession;
                    }
                }
            }
        }
        win = iterm.createWindowWithProfile("FZF")();
        // var bounds = win.bounds(); bounds.height = 100; win.bounds = bounds;
        session = win.currentSession;
        // console.log("new session")
    } while (false);

    // console.log(session.profileName())
    var guard = "/tmp/fzfGuard";
    var pwd = $.getenv("PWD");
    iterm.write(session, { text: `cd '${pwd.replace("'", "'\''")}'` });
    iterm.write(session, { text: `export FZF_DEFAULT_OPTS='${$.getenv("FZF_DEFAULT_OPTS").replace("'", "'\''")}'` });
    iterm.write(session, { text: `touch ${guard} && ${argv[0]}; /bin/rm ${guard}`});
    iterm.activate();

    var fm = $.NSFileManager.defaultManager;
    do { delay(0.1); } while (session.exists() && fm.fileExistsAtPath(guard));

    oldWin.select();
    win.visible = false;
    Application(oldApp).activate();
}
