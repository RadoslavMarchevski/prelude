* C++/C IDE setup for emacs
** Install llvm + clang
   [[https://llvm.org/docs/GettingStarted.html][LLVM installation guide]]  (takes few hours)
** Build Rtags
   Follow the installation guide from the git repository : [[https://github.com/Andersbakken/rtags][Andersbakken rtags]]
** Required packages [[http://syamajala.github.io/c-ide.html][C++/C IDE setup]]
rtags
helm-rtags
company-rtags
irony
company-irony
company-irony-c-headers
flycheck-rtags
flycheck-irony
run (irony-install-server)
** Project indexing
rdm > /dev/null 2>&1 &
rdm &
cd /path/to/project/root
cmake . -DCMAKE_EXPORT_COMPILE_COMMANDS=1
rc -J .
